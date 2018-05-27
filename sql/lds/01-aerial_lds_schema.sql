------------------------------------------------------------------------------
-- Create aerial_lds schema and imagery_surveys table
------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS aerial_lds;

COMMENT ON SCHEMA aerial_lds IS
'This schema contains datasets related to aerial imagery to be published '
'on the LINZ Data Service.';

CREATE TABLE IF NOT EXISTS aerial_lds.imagery_surveys (
      imagery_survey_id serial PRIMARY KEY
    , name character varying(100) NOT NULL
    , imagery_id integer
    , index_id integer
    , set_order integer
    , ground_sample_distance numeric(6,4)
    , accuracy character varying(100)
    , supplier character varying(80)
    , licensor character varying(250)
    , flown_from date CONSTRAINT after_first_flight CHECK (flown_from > '1903-12-17')
    , flown_to date CONSTRAINT survey_completed CHECK (flown_to < now())
    , survey_added date NOT NULL
    , imagery_added date
    , imagery_modified date
    , imagery_removed date
    , shape public.geometry(MultiPolygon, 2193) NOT NULL
    , CONSTRAINT valid_flight_dates CHECK (flown_from <= flown_to)
    , CONSTRAINT valid_add_to_modify CHECK (imagery_added <= imagery_modified)
    , CONSTRAINT valid_add_to_remove CHECK (imagery_added <= imagery_removed)
);

DROP INDEX IF EXISTS aerial_lds.sidx_imagery_surveys;
CREATE INDEX sidx_imagery_surveys
    ON aerial_lds.imagery_surveys
    USING gist (shape);

COMMENT ON TABLE aerial_lds.imagery_surveys IS
'This table holds the standardised attributes of aerial imagery surveys. '
'These attributes were previously only contained within individual index tile '
'layers with differing column names and data types.';

COMMENT ON COLUMN aerial_lds.imagery_surveys.imagery_survey_id IS
'Unique identifier for the aerial_lds.imagery_surveys table.';
COMMENT ON COLUMN aerial_lds.imagery_surveys.name IS
'The corresponding aerial imagery layer name in the LINZ Data Service.';
COMMENT ON COLUMN aerial_lds.imagery_surveys.imagery_id IS
'Foreign key to the aerial imagery layer identifier in the LINZ Data '
'Service.';
COMMENT ON COLUMN aerial_lds.imagery_surveys.index_id IS
'Foreign key to the index tile layer identifier in the LINZ Data Service.';
COMMENT ON COLUMN aerial_lds.imagery_surveys.set_order IS
'The order that an aerial photograph displays within the NZ Aerial Imagery'
'set. A null value indicates that the aerial photograph is not part of the '
'set.';
COMMENT ON COLUMN aerial_lds.imagery_surveys.ground_sample_distance IS
'Ground sample distance in metres.';
COMMENT ON COLUMN aerial_lds.imagery_surveys.accuracy IS
'The overall accuracy of the imagery survey. This may contain aggregated '
'accuracy values if accuracy varied throughout the survey. Refer to the '
'related index tile layer for specific accuracies.';
COMMENT ON COLUMN aerial_lds.imagery_surveys.supplier IS
'The organisation that supplied the aerial imagery.';
COMMENT ON COLUMN aerial_lds.imagery_surveys.licensor IS
'The organisation that licenses the aerial imagery.';
COMMENT ON COLUMN aerial_lds.imagery_surveys.flown_from IS
'The earliest date on which aerial photographs were taken as part of this '
'imagery survey.';
COMMENT ON COLUMN aerial_lds.imagery_surveys.flown_to IS
'The latest date on which aerial photographs were taken as part of this '
'imagery survey.';
COMMENT ON COLUMN aerial_lds.imagery_surveys.survey_added IS
'The date that the aerial imagery survey was added to this dataset.';
COMMENT ON COLUMN aerial_lds.imagery_surveys.imagery_added IS
'The date that the aerial imagery was added to the LINZ Data Service.';
COMMENT ON COLUMN aerial_lds.imagery_surveys.imagery_modified IS
'The last time the imagery_id, index_id or set_order were modified.';
COMMENT ON COLUMN aerial_lds.imagery_surveys.imagery_removed IS
'The date that the aerial imagery was removed from the LINZ Data Service.';
COMMENT ON COLUMN aerial_lds.imagery_surveys.shape IS
'A dissolved, multipart boundary of the coverage of the imagery survey.';
