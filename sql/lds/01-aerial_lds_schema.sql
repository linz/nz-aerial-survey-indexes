------------------------------------------------------------------------------
-- Create aerial_lds schema and imagery_survey_index and elevation_survey_index tables
------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS aerial_lds;

COMMENT ON SCHEMA aerial_lds IS
'This schema contains datasets related to aerial surveys to be published '
'on the LINZ Data Service.';

-- Create sequence for multiple tables to use
--CREATE SEQUENCE IF NOT EXISTS aerial_lds.surveys_combined_seq MINVALUE 1000;--ONLY FOR POSTGRES 9.5+
CREATE SEQUENCE aerial_lds.surveys_combined_seq MINVALUE 1000;

CREATE TABLE IF NOT EXISTS aerial_lds.imagery_survey_index (
      imagery_survey_id integer DEFAULT nextval('aerial_lds.surveys_combined_seq') PRIMARY KEY
    , name character varying(100) NOT NULL
    , imagery_id integer
    , index_id integer
    , set_order integer
    , ground_sample_distance numeric(6,4)
    , accuracy character varying(100)
    , supplier character varying(80)
    , licensor character varying(250)
    , flown_from date CONSTRAINT imagery_after_first_flight CHECK (flown_from > '1903-12-17')
    , flown_to date CONSTRAINT imagery_survey_completed CHECK (flown_to < now())
    , shape public.geometry(MultiPolygon, 2193) NOT NULL
    , CONSTRAINT imagery_valid_flight_dates CHECK (flown_from <= flown_to)
);

DROP INDEX IF EXISTS aerial_lds.sidx_imagery_survey_index;
CREATE INDEX sidx_imagery_survey_index
    ON aerial_lds.imagery_survey_index
    USING gist (shape);

COMMENT ON TABLE aerial_lds.imagery_survey_index IS
'This table holds the standardised attributes of aerial imagery surveys. '
'These attributes were previously only contained within individual index tile '
'layers with differing column names and data types.';

COMMENT ON COLUMN aerial_lds.imagery_survey_index.imagery_survey_id IS
'Unique identifier for the aerial_lds.imagery_survey_index table.';
COMMENT ON COLUMN aerial_lds.imagery_survey_index.name IS
'The corresponding aerial imagery layer name in the LINZ Data Service.';
COMMENT ON COLUMN aerial_lds.imagery_survey_index.imagery_id IS
'Foreign key to the aerial imagery layer identifier in the LINZ Data '
'Service.';
COMMENT ON COLUMN aerial_lds.imagery_survey_index.index_id IS
'Foreign key to the index tile layer identifier in the LINZ Data Service.';
COMMENT ON COLUMN aerial_lds.imagery_survey_index.set_order IS
'The order that an aerial photograph displays within the NZ Aerial Imagery'
'set. A null value indicates that the aerial photograph is not part of the '
'set.';
COMMENT ON COLUMN aerial_lds.imagery_survey_index.ground_sample_distance IS
'Ground sample distance in metres.';
COMMENT ON COLUMN aerial_lds.imagery_survey_index.accuracy IS
'The overall accuracy of the imagery survey. This may contain aggregated '
'accuracy values if accuracy varied throughout the survey. Refer to the '
'related index tile layer for specific accuracies.';
COMMENT ON COLUMN aerial_lds.imagery_survey_index.supplier IS
'The organisation that supplied the aerial imagery.';
COMMENT ON COLUMN aerial_lds.imagery_survey_index.licensor IS
'The organisation that licenses the aerial imagery.';
COMMENT ON COLUMN aerial_lds.imagery_survey_index.flown_from IS
'The earliest date on which aerial photographs were taken as part of this '
'imagery survey.';
COMMENT ON COLUMN aerial_lds.imagery_survey_index.flown_to IS
'The latest date on which aerial photographs were taken as part of this '
'imagery survey.';
COMMENT ON COLUMN aerial_lds.imagery_survey_index.shape IS
'A dissolved, multipart boundary of the coverage of the imagery survey.';

CREATE TABLE IF NOT EXISTS aerial_lds.elevation_survey_index (
      elevation_survey_id integer DEFAULT nextval('aerial_lds.surveys_combined_seq') PRIMARY KEY
    , name character varying(100) NOT NULL
    , index_id integer
    , dem_id integer
    , dsm_id integer
    , point_cloud_doi character varying(50)
    , point_density character varying(50)
    , vertical_datum character varying(20) NOT NULL
    , horizontal_datum character varying(20) NOT NULL
    , supplier character varying(200) NOT NULL
    , licensor character varying(200) NOT NULL
    , flown_from date CONSTRAINT elevation_after_first_flight CHECK (flown_from > '2000-01-01')
    , flown_to date CONSTRAINT elevation_survey_completed CHECK (flown_to < now())
    , shape public.geometry(MultiPolygon, 2193) NOT NULL
    , CONSTRAINT elevation_valid_flight_dates CHECK (flown_from <= flown_to)
);

DROP INDEX IF EXISTS aerial_lds.sidx_elevation_survey_index;
CREATE INDEX sidx_elevation_survey_index
    ON aerial_lds.elevation_survey_index
    USING gist (shape);

COMMENT ON TABLE aerial_lds.elevation_survey_index IS
'This table holds the standardised attributes of aerial elevation surveys.';

COMMENT ON COLUMN aerial_lds.elevation_survey_index.elevation_survey_id IS
'Unique identifier for the aerial_lds.elevation_survey_index table.';
COMMENT ON COLUMN aerial_lds.elevation_survey_index.name IS
'The corresponding aerial elevation layer name in the LINZ Data Service.';
COMMENT ON COLUMN aerial_lds.elevation_survey_index.index_id IS
'Foreign key to the index tile layer identifier in the LINZ Data Service.';
COMMENT ON COLUMN aerial_lds.elevation_survey_index.dem_id IS
'Foreign key to the DEM layer identifier in the LINZ Data Service.';
COMMENT ON COLUMN aerial_lds.elevation_survey_index.dsm_id IS
'Foreign key to the DSM layer identifier in the LINZ Data Service.';
COMMENT ON COLUMN aerial_lds.elevation_survey_index.point_cloud_doi IS
'Foreign key to the point cloud data identifier in Digital Object Identifyer https://doi.org';
COMMENT ON COLUMN aerial_lds.elevation_survey_index.point_density IS
'The point density of the elevation survey.';
COMMENT ON COLUMN aerial_lds.elevation_survey_index.vertical_datum IS
'The vertical datum of the elevation survey.';
COMMENT ON COLUMN aerial_lds.elevation_survey_index.horizontal_datum IS
'The horizontal datum of the elevation survey.';
COMMENT ON COLUMN aerial_lds.elevation_survey_index.supplier IS
'The organisation that supplied the aerial elevation.';
COMMENT ON COLUMN aerial_lds.elevation_survey_index.licensor IS
'The organisation that licenses the aerial elevation.';
COMMENT ON COLUMN aerial_lds.elevation_survey_index.flown_from IS
'The earliest date on which aerial elevations were taken as part of this '
'elevation survey.';
COMMENT ON COLUMN aerial_lds.elevation_survey_index.flown_to IS
'The latest date on which aerial elevations were taken as part of this '
'elevation survey.';
COMMENT ON COLUMN aerial_lds.elevation_survey_index.shape IS
'A dissolved, multipart boundary of the coverage of the elevation survey.';

