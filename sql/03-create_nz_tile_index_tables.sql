-- Deploy aerial_lds: aerial_lds.nz_50k_tile_index to pg

BEGIN;

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
    sheet_code_id character varying(10) NOT NULL,
    topo50_coverage character varying(20),
    shape geometry(MultiPolygon, 2193) NOT NULL)

DROP INDEX IF EXISTS idx_nz_50k_tile_index_sheet_code_id;
CREATE INDEX idx_nz_50k_tile_index_sheet_code_id ON aerial_lds.nz_50k_tile_index USING btree (sheet_code_id);
DROP INDEX IF EXISTS idx_nz_50k_tile_index_topo50_coverage;
CREATE INDEX idx_nz_50k_tile_index_topo50_coverage ON aerial_lds.nz_50k_tile_index USING btree (topo50_coverage);
DROP INDEX IF EXISTS shx_nz_50k_tile_index;
ON aerial_lds_nz_50k_tile_index
USING gist (shape);
COMMENT ON TABLE aerial_lds.nz_50k_tile_index IS 'This table holds the extent for the 1:50,000 aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_50k_tile_index.sheet_code_id IS 'The unique identifier of the topo50 mapsheet.';
COMMENT ON COLUMN aerial_lds.nz_50k_tile_index.topo50_coverage IS 'Identifies whether existing topo50 mapsheet exists within the extent of the tile.';
COMMENT ON COLUMN aerial_lds.nz_50k_tile_index.shape IS 'The geometry of the feature.';

--
-- NZ 10k Tile Index
--

CREATE TABLE IF NOT EXISTS aerial_lds.nz_10k_tile_index (
    index_tile_id character varying(30) PRIMARY KEY,
    sheet_code_id character varying(10) NOT NULL,
    scale integer,
    tile integer,
    row character varying(10),
    column character varying(10),
    shape geometry(MultiPolygon, 2193) NOT NULL);

DROP_INDEX IF EXISTS idx_nz_10k_tile_index_index_tile_id;
CREATE INDEX idx_nz_10k_tile_index_index_tile_id ON aerial_lds.nz_10k_tile_index USING btree (index_tile_id);
DROP INDEX IF EXISTS idx_nz_10k_tile_index_sheet_code_id;
CREATE INDEX idx_nz_10k_tile_index_sheet_code_id ON aerial_lds.nz_10k_tile_index USING btree (sheet_code_id);
DROP INDEX IF EXISTS idx_nz_10k_tile_index_scale;
CREATE INDEX idx_nz_10k_tile_index_scale ON aerial_lds.nz_10k_tile_index USING btree (scale);
DROP INDEX IF EXISTS idx_nz_10k_tile_index_tile;
CREATE INDEX idx_nz_10k_tile_index_tile ON aerial_lds.nz_10k_tile_index USING btree (tile);
DROP INDEX IF EXISTS idx_nz_10k_tile_index_row;
CREATE INDEX idx_nz_10k_tile_index_row ON aerial_lds.nz_10k_tile_index USING btree (row);
DROP INDEX IF EXISTS idx_nz_10k_tile_index_column;
CREATE INDEX idx_nz_10k_tile_index_column ON aerial_lds.nz_10k_tile_index USING btree (column);
DROP INDEX IF EXISTS shx_nz_10k_tile_index;
ON aerial_lds_nz_10k_tile_index
USING gist (shape);
COMMENT ON TABLE aerial_lds.nz_10k_tile_index IS 'This table holds the extent for the 1:10,000 aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.index_tile_id IS 'Unique identifier for the aerial_lds.nz_10k_tile_index table.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.sheet_code_id IS 'The corresponding topo50 mapsheet.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.scale IS 'The map scale of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.tile IS 'The combination of the row and column numbers of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.row IS 'The row number of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.column IS 'The the column number of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_10k_tile_index.shape IS 'The geometry of the feature.';

--
-- NZ 5k Tile Index
--

CREATE TABLE IF NOT EXISTS aerial_lds.nz_5k_tile_index (
    index_tile_id character varying(30) PRIMARY KEY,
    sheet_code_id character varying(10) NOT NULL,
    scale integer,
    tile integer,
    row character varying(10),
    column character varying(10),
    shape geometry(MultiPolygon, 2193) NOT NULL);

DROP_INDEX IF EXISTS idx_nz_5k_tile_index_index_tile_id;
CREATE INDEX idx_nz_5k_tile_index_index_tile_id ON aerial_lds.nz_5k_tile_index USING btree (index_tile_id);
DROP INDEX IF EXISTS idx_nz_5k_tile_index_sheet_code_id;
CREATE INDEX idx_nz_5k_tile_index_sheet_code_id ON aerial_lds.nz_5k_tile_index USING btree (sheet_code_id);
DROP INDEX IF EXISTS idx_nz_5k_tile_index_scale;
CREATE INDEX idx_nz_5k_tile_index_scale ON aerial_lds.nz_5k_tile_index USING btree (scale);
DROP INDEX IF EXISTS idx_nz_5k_tile_index_tile;
CREATE INDEX idx_nz_5k_tile_index_tile ON aerial_lds.nz_5k_tile_index USING btree (tile);
DROP INDEX IF EXISTS idx_nz_5k_tile_index_row;
CREATE INDEX idx_nz_5k_tile_index_row ON aerial_lds.nz_5k_tile_index USING btree (row);
DROP INDEX IF EXISTS idx_nz_5k_tile_index_column;
CREATE INDEX idx_nz_5k_tile_index_column ON aerial_lds.nz_5k_tile_index USING btree (column);
DROP INDEX IF EXISTS shx_nz_5k_tile_index;
ON aerial_lds_nz_5k_tile_index
USING gist (shape);
COMMENT ON TABLE aerial_lds.nz_5k_tile_index IS 'This table holds the extent for the 1:5,000 aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.index_tile_id IS 'Unique identifier for the aerial_lds.nz_5k_tile_index table.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.sheet_code_id IS 'The corresponding topo50 mapsheet.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.scale IS 'The map scale of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.tile IS 'The combination of the row and column numbers of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.row IS 'The row number of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.column IS 'The the column number of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_5k_tile_index.shape IS 'The geometry of the feature.';

--
-- NZ 1k Tile Index
--

CREATE TABLE IF NOT EXISTS aerial_lds.nz_1k_tile_index (
    index_tile_id character varying(30) PRIMARY KEY,
    sheet_code_id character varying(10) NOT NULL,
    scale integer,
    tile integer,
    row character varying(10),
    column character varying(10),
    shape geometry(MultiPolygon, 2193) NOT NULL);

DROP_INDEX IF EXISTS idx_nz_1k_tile_index_index_tile_id;
CREATE INDEX idx_nz_1k_tile_index_index_tile_id ON aerial_lds.nz_1k_tile_index USING btree (index_tile_id);
DROP INDEX IF EXISTS idx_nz_1k_tile_index_sheet_code_id;
CREATE INDEX idx_nz_1k_tile_index_sheet_code_id ON aerial_lds.nz_1k_tile_index USING btree (sheet_code_id);
DROP INDEX IF EXISTS idx_nz_1k_tile_index_scale;
CREATE INDEX idx_nz_1k_tile_index_scale ON aerial_lds.nz_1k_tile_index USING btree (scale);
DROP INDEX IF EXISTS idx_nz_1k_tile_index_tile;
CREATE INDEX idx_nz_1k_tile_index_tile ON aerial_lds.nz_1k_tile_index USING btree (tile);
DROP INDEX IF EXISTS idx_nz_1k_tile_index_row;
CREATE INDEX idx_nz_1k_tile_index_row ON aerial_lds.nz_1k_tile_index USING btree (row);
DROP INDEX IF EXISTS idx_nz_1k_tile_index_column;
CREATE INDEX idx_nz_1k_tile_index_column ON aerial_lds.nz_1k_tile_index USING btree (column);
DROP INDEX IF EXISTS shx_nz_1k_tile_index;
ON aerial_lds_nz_1k_tile_index
USING gist (shape);
COMMENT ON TABLE aerial_lds.nz_1k_tile_index IS 'This table holds the extent for the 1:1,000 aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.index_tile_id IS 'Unique identifier for the aerial_lds.nz_1k_tile_index table.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.sheet_code_id IS 'The corresponding topo50 mapsheet.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.scale IS 'The map scale of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.tile IS 'The combination of the row and column numbers of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.row IS 'The row number of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.column IS 'The the column number of the aerial imagery index tiles.';
COMMENT ON COLUMN aerial_lds.nz_1k_tile_index.shape IS 'The geometry of the feature.';

COMMIT;

