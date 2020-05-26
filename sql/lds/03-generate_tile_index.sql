BEGIN;

------------------------------------------------------------------------------
-- Generates tile indexes of specified scale from the NZ 50k Tile Index
------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION aerial_lds.generate_tile_index (tile_scale integer)
RETURNS TABLE (
    index_tile_id character varying(15),
	sheet_code_id character varying(4),
	scale integer,
	tile character varying(4),
	shape geometry(Polygon,2193)
)
AS $$

DECLARE
    tile_count integer;
    tile_length integer;

BEGIN

    -- Script to create large scale index tile datasets
    -- Retiles the 1:50k Tiles based on an inputted scale
    -- Ensure tile scale is a multiple of 50k
    IF mod(50000, tile_scale) != 0 THEN
        RAISE EXCEPTION 'Scale is not a multiple of 50,000 --> %', tile_scale
            USING HINT = 'Check if a whole number is created when dividing 50,000 by the input scale';
    END IF;

    -- Get the amount of new tiles
    tile_count = 50000 / tile_scale;

    -- Set the length of the tile name segments (row and column).
	-- Used later on when padding the row or column name with zeros.
	-- e.g. '004' or '04'
    IF tile_count > 99 THEN
        tile_length = char_length(tile_count::character varying);
    ELSE
        tile_length = 2;
    END IF;

    RETURN QUERY
    -- Preprepare the 50k tiles, creating a column containing the width and height of the new tiles
    WITH nz_50k_tiles AS (
        SELECT
            (ST_XMax(nz_50k.shape) - ST_XMin(nz_50k.shape)) / tile_count AS new_tile_width,
            (ST_YMax(nz_50k.shape) - ST_YMin(nz_50k.shape)) / tile_count AS new_tile_height,
            nz_50k.sheet_code_id,
            nz_50k.shape
        FROM
            aerial_lds.nz_50k_tile_index nz_50k
    )
    SELECT
        concat(nz_50k_tiles.sheet_code_id, '_', tile_scale, '_', tile.new_tile)::character varying,
        nz_50k_tiles.sheet_code_id,
        tile_scale,
        tile.new_tile,
        tile.new_geom
    FROM
        generate_series(1, tile_count) col
    CROSS JOIN generate_series(1, tile_count) rw
    CROSS JOIN nz_50k_tiles
    CROSS JOIN LATERAL (
        SELECT
            -- Concatenate the row and column together to create a string to identify the tile with.
            -- It will be padded with zeros where the character length is less than tile_length.
            concat(
				lpad(rw::character varying, tile_length, '0')::character varying,
			    lpad(col::character varying, tile_length, '0')::character varying
			)::character varying AS new_tile,
            -- Create a new tile. Its location is determined by the current row and column.
            ST_MakeEnvelope(
				ST_XMin(nz_50k_tiles.shape) + (new_tile_width * col),
				ST_YMax(nz_50k_tiles.shape) - (new_tile_height * rw),
			    ST_XMin(nz_50k_tiles.shape) + (new_tile_width * (col - 1)),
			    ST_YMax(nz_50k_tiles.shape) - (new_tile_height * (rw - 1)),
				2193
			) AS new_geom
	) tile;

END;

$$
LANGUAGE plpgsql STABLE;

COMMIT;
