-- FUNCTION: aerial_lds.generate_tile_index(integer)

-- DROP FUNCTION aerial_lds.generate_tile_index(integer);

CREATE OR REPLACE FUNCTION aerial_lds.generate_tile_index(
	in_tile_scale integer,
	OUT out_index_tile_id character varying,
	OUT out_sheet_code_id character varying,
	OUT out_tile_scale integer,
	OUT out_tile character varying,
	OUT out_row_num integer,
	OUT out_column_num integer,
	OUT out_shape geometry)
    RETURNS SETOF record 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
AS $BODY$
DECLARE
	tile_count integer;
BEGIN
	
	-- Script to create large scale index tile datasets
	-- Retiles the 1:50k Tiles based on an inputted scale		

	tile_count = 50000 / in_tile_scale;	
			
	RETURN QUERY
		--preprepare the 50k tiles, creating a column containing the width and height of the new tiles
		WITH nz_50k AS (
			SELECT 				
				((ST_XMax(shape) - ST_XMin(shape)) / tile_count) as new_tile_width,
				((ST_YMax(shape) - ST_YMin(shape)) / tile_count) as new_tile_height,				
				sheet_code_id,
				shape
			FROM
			aerial_lds.nz_50k_tile_index
		)		
		SELECT 
			concat(nz_50k.sheet_code_id, '_', in_tile_scale, '_', tile.new_tile)::character varying,
			nz_50k.sheet_code_id,
			in_tile_scale,
			tile.new_tile,
			rw,
			col,
			tile.new_geom	
		FROM 
			generate_series(1,tile_count) col
			CROSS JOIN generate_series(1,tile_count) rw			
			CROSS JOIN nz_50k			
			CROSS JOIN LATERAL (
				SELECT
				 	-- Concatenate the row and column together to create a string to identify the tile with
					concat(
						CASE WHEN char_length(rw::character varying) = 1 THEN '0'|| rw::character varying ELSE rw::character varying END,
						CASE WHEN char_length(col::character varying) = 1 THEN '0'|| col::character varying ELSE col::character varying END
					)::character varying as new_tile,

					-- Create a new tile. Its location is determined by the current row and column.	
					ST_Multi(ST_MakeEnvelope( 
						ST_XMin(nz_50k.shape) + (new_tile_width * col),				 
						ST_YMax(nz_50k.shape) - (new_tile_height * rw), 			
						ST_XMin(nz_50k.shape) + (new_tile_width * (col-1)), 				
						ST_YMax(nz_50k.shape) - (new_tile_height * (rw-1)),
						2193						 						 
					)) as new_geom
			) tile;
	
END;
    $BODY$;

ALTER FUNCTION aerial_lds.generate_tile_index(integer)
    OWNER TO postgres;
