-- FUNCTION: aerial_lds.generate_tile_index(integer)

-- DROP FUNCTION aerial_lds.generate_tile_index(integer);

CREATE OR REPLACE FUNCTION aerial_lds.generate_tile_index(
	in_tile_scale integer,
	OUT out_index_tile_id character varying,
	OUT out_sheet_code_id character varying,
	OUT out_tile_scale integer,
	OUT out_tile character varying,
	OUT out_shape geometry)
    RETURNS SETOF record 
    LANGUAGE 'plpgsql'

    COST 100
    STABLE 
    ROWS 1000
AS $BODY$
DECLARE
	tile_count integer;
	tile_length integer;
BEGIN
	
	-- Script to create large scale index tile datasets
	-- Retiles the 1:50k Tiles based on an inputted scale	
	
	-- Ensure tile scale is a multiple of 50k
	IF mod(50000,in_tile_scale) != 0 THEN
		RAISE EXCEPTION 'Scale is not a multiple of 50,000 --> %', in_tile_scale
      	USING HINT = 'Check if a whole number is created when diving 50,000 and the inputted scale';
	END IF;
	
	tile_count = 50000 / in_tile_scale;	
	IF tile_count > 99 THEN tile_length = 3; ELSE tile_length = 2; END IF;
				
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
			tile.new_geom	
		FROM 
			generate_series(1,tile_count) col
			CROSS JOIN generate_series(1,tile_count) rw			
			CROSS JOIN nz_50k			
			CROSS JOIN LATERAL (
				SELECT
				 	-- Concatenate the row and column together to create a string to identify the tile with. 
					-- It will be padded with zeros where the character length is less than tile_length.
					concat(
						lpad(rw::character varying, tile_length, '0')::character varying,
						lpad(col::character varying, tile_length, '0')::character varying 
					)::character varying AS new_tile,
				
					-- Create a new tile. Its location is determined by the current row and column.	
					ST_Multi(ST_MakeEnvelope( 
						ST_XMin(nz_50k.shape) + (new_tile_width * col),				 
						ST_YMax(nz_50k.shape) - (new_tile_height * rw), 			
						ST_XMin(nz_50k.shape) + (new_tile_width * (col-1)), 				
						ST_YMax(nz_50k.shape) - (new_tile_height * (rw-1)),
						2193						 						 
					)) AS new_geom
			) tile;
	
END;
    $BODY$;

ALTER FUNCTION aerial_lds.generate_tile_index(integer)
    OWNER TO postgres;
