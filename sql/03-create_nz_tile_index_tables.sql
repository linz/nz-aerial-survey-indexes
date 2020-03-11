-- Deploy aerial_lds: aerial_lds.nz_50k_tile_index to pg

-------------------------------------------------------
-- Create aerial_lds tables
-- Tables:
-- nz_50k_tile_index
-- nz_10k_tile_index
-- nz_5k_tile_index
-- nz_1k_tile_index
------------------------------------------------------
-- Tables
-- NZ 50k Tile Index

CREATE TABLE IF NOT EXISTS aerial_lds.nz_50k_tile_index (
    sheet_code_id character varying(4) PRIMARY KEY,
    topo50_coverage character varying(20) NOT NULL,
    shape geometry(MultiPolygon, 2193) NOT NULL);

DROP INDEX IF EXISTS shx_nz_50k_tile_index;
CREATE INDEX shx_nz_50k_tile_index
ON aerial_lds.nz_50k_tile_index
USING gist (shape);

COMMENT ON TABLE aerial_lds.nz_50k_tile_index IS 'This table holds the extent for the 1:50,000 aerial imagery index tiles.';

COMMENT ON COLUMN aerial_lds.nz_50k_tile_index.sheet_code_id IS 'The unique identifier of the topo50 mapsheet.';
COMMENT ON COLUMN aerial_lds.nz_50k_tile_index.topo50_coverage IS 'Identifies whether existing topo50 mapsheet exists within the extent of the tile.';
COMMENT ON COLUMN aerial_lds.nz_50k_tile_index.shape IS 'The geometry of the feature.';

--
-- NZ 10k Tile Index
--

CREATE TABLE IF NOT EXISTS aerial_lds.nz_10k_tile_index (
    index_tile_id character varying(15) PRIMARY KEY,
    sheet_code_id character varying(4) NOT NULL,
    scale integer,
    tile character varying(4),
    row_number integer,
    column_number integer,
    shape geometry(MultiPolygon, 2193) NOT NULL);

DROP INDEX IF EXISTS shx_nz_10k_tile_index;
CREATE INDEX shx_nz_10k_tile_index
ON aerial_lds.nz_10k_tile_index
USING gist (shape);

COMMENT ON TABLE aerial_lds.nz_10k_tile_index IS 'This table holds the extent for the 1:10,000 aerial imagery index tiles.';

COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.index_tile_id IS 'Unique identifier for the aerial_lds.nz_10k_tile_index table.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.sheet_code_id IS 'The corresponding topo50 mapsheet.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.scale IS 'The map scale of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.tile IS 'The combination of the row and column numbers of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.row_number IS 'The row number of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.column_number IS 'The the column number of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.shape IS 'The geometry of the feature.';

--
-- NZ 5k Tile Index
--

CREATE TABLE IF NOT EXISTS aerial_lds.nz_5k_tile_index (
    index_tile_id character varying(15) PRIMARY KEY,
    sheet_code_id character varying(4) NOT NULL,
    scale integer,
    tile character varying(4),
    row_number integer,
    column_number integer,
    shape geometry(MultiPolygon, 2193) NOT NULL);

DROP INDEX IF EXISTS shx_nz_5k_tile_index;
CREATE INDEX shx_nz_5k_tile_index
ON aerial_lds.nz_5k_tile_index
USING gist (shape);

COMMENT ON TABLE aerial_lds.nz_5k_tile_index IS 'This table holds the extent for the 1:5,000 aerial imagery index tiles.';

COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.index_tile_id IS 'Unique identifier for the aerial_lds.nz_5k_tile_index table.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.sheet_code_id IS 'The corresponding topo50 mapsheet.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.scale IS 'The map scale of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.tile IS 'The combination of the row and column numbers of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.row_number IS 'The row number of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.column_number IS 'The the column number of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.shape IS 'The geometry of the feature.';

--
-- NZ 1k Tile Index
--

CREATE TABLE IF NOT EXISTS aerial_lds.nz_1k_tile_index (
    index_tile_id character varying(15) PRIMARY KEY,
    sheet_code_id character varying(4) NOT NULL,
    scale integer,
    tile character varying(4),
    row_number integer,
    column_number integer,
    shape geometry(MultiPolygon, 2193) NOT NULL);

DROP INDEX IF EXISTS shx_nz_1k_tile_index;
CREATE INDEX shx_nz_1k_tile_index
ON aerial_lds.nz_1k_tile_index
USING gist (shape);

COMMENT ON TABLE aerial_lds.nz_1k_tile_index IS 'This table holds the extent for the 1:1,000 aerial imagery index tiles.';

COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.index_tile_id IS 'Unique identifier for the aerial_lds.nz_1k_tile_index table.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.sheet_code_id IS 'The corresponding topo50 mapsheet.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.scale IS 'The map scale of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.tile IS 'The combination of the row and column numbers of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.row_number IS 'The row number of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.column_number IS 'The the column number of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.shape IS 'The geometry of the feature.';


