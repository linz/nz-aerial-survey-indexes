BEGIN;

------------------------------------------------------------------------------
-- Create tile index tables
-- Tables:
-- nz_50k_tile_index
-- nz_10k_tile_index
-- nz_5k_tile_index
-- nz_1k_tile_index
------------------------------------------------------------------------------

-- TABLES
-- NZ 50k Tile Index

CREATE TABLE IF NOT EXISTS aerial_lds.nz_50k_tile_index (
    sheet_code_id character varying(4) PRIMARY KEY,
    topo50_coverage character varying(20) NOT NULL,
    shape geometry(polygon, 2193) NOT NULL
);

CREATE INDEX shx_nz_50k_tile_index
    ON aerial_lds.nz_50k_tile_index USING gist (shape);

COMMENT ON TABLE aerial_lds.nz_50k_tile_index IS
'This table holds the extents for the New Zealand 1:50,000 index tiles.';

COMMENT ON COLUMN aerial_lds.nz_50k_tile_index.sheet_code_id IS
'The unique identifier of the Topo50 mapsheet.';
COMMENT ON COLUMN aerial_lds.nz_50k_tile_index.topo50_coverage IS
'Identifies whether existing Topo50 mapsheet exists within the extent of the '
'tile.';
COMMENT ON COLUMN aerial_lds.nz_50k_tile_index.shape IS
'The geometry of the feature.';

-- NZ 10k Tile Index

CREATE TABLE IF NOT EXISTS aerial_lds.nz_10k_tile_index (
    index_tile_id character varying(15) PRIMARY KEY,
    sheet_code_id character varying(4) NOT NULL,
    scale integer NOT NULL,
    tile character varying(4) NOT NULL,
    shape geometry(polygon, 2193) NOT NULL
);

CREATE INDEX shx_nz_10k_tile_index
    ON aerial_lds.nz_10k_tile_index USING gist (shape);

COMMENT ON TABLE aerial_lds.nz_10k_tile_index IS
'This table holds the extents for the New Zealand 1:10,000 index tiles.';

COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.index_tile_id IS
'Unique identifier for the aerial_lds.nz_10k_tile_index table.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.sheet_code_id IS
'The corresponding Topo50 mapsheet.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.scale IS
'The map scale of the index tiles.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.tile IS
'The combination of the row and column numbers of the index tiles.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.shape IS
'The geometry of the feature.';

-- NZ 5k Tile Index

CREATE TABLE IF NOT EXISTS aerial_lds.nz_5k_tile_index (
    index_tile_id character varying(15) PRIMARY KEY,
    sheet_code_id character varying(4) NOT NULL,
    scale integer NOT NULL,
    tile character varying(4) NOT NULL,
    shape geometry(polygon, 2193) NOT NULL
);

CREATE INDEX shx_nz_5k_tile_index
    ON aerial_lds.nz_5k_tile_index USING gist (shape);

COMMENT ON TABLE aerial_lds.nz_5k_tile_index IS
'This table holds the extents for the New Zealand 1:5,000 index tiles.';

COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.index_tile_id IS
'Unique identifier for the aerial_lds.nz_5k_tile_index table.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.sheet_code_id IS
'The corresponding Topo50 mapsheet.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.scale IS
'The map scale of the index tiles.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.tile IS
'The combination of the row and column numbers of the index tiles.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.shape IS
'The geometry of the feature.';

-- NZ 1k Tile Index

CREATE TABLE IF NOT EXISTS aerial_lds.nz_1k_tile_index (
    index_tile_id character varying(15) PRIMARY KEY,
    sheet_code_id character varying(4) NOT NULL,
    scale integer NOT NULL,
    tile character varying(4) NOT NULL,
    shape geometry(polygon, 2193) NOT NULL
);

CREATE INDEX shx_nz_1k_tile_index
    ON aerial_lds.nz_1k_tile_index USING gist (shape);

COMMENT ON TABLE aerial_lds.nz_1k_tile_index IS
'This table holds the extents for the New Zealand 1:1,000 index tiles.';

COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.index_tile_id IS
'Unique identifier for the aerial_lds.nz_1k_tile_index table.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.sheet_code_id IS
'The corresponding Topo50 mapsheet.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.scale IS
'The map scale of the index tiles.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.tile IS
'The combination of the row and column numbers of the index tiles.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.shape IS
'The geometry of the feature.';

COMMIT;
