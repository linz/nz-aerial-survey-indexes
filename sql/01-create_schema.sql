------------------------------------------------------------------------------
-- Create aerial schema and imagery surveys table
------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS aerial;

COMMENT ON SCHEMA aerial IS
'This schema contains datasets related to aerial imagery to be published '
'on the LINZ Data Service.';

CREATE TABLE IF NOT EXISTS aerial.imagery_surveys (
      imagery_survey_id serial NOT NULL PRIMARY KEY
    , name text NOT NULL
    , imagery_id integer NOT NULL
    , index_id integer NOT NULL
    , set_order integer
    , ground_sample_distance decimal(6,4) NOT NULL
    , accuracy text
    , supplier text
    , licensor text
    , flown_from date
    , flown_to date
    , shape public.geometry(MultiPolygon, 2193) NOT NULL
);

ALTER TABLE aerial.imagery_surveys 
   DROP CONSTRAINT IF EXISTS check_date_range_is_valid;
ALTER TABLE aerial.imagery_surveys 
   ADD CONSTRAINT check_date_range_is_valid CHECK (flown_from <= flown_to);

ALTER TABLE aerial.imagery_surveys 
   DROP CONSTRAINT IF EXISTS check_date_is_in_the_past;
ALTER TABLE aerial.imagery_surveys 
   ADD CONSTRAINT check_date_is_in_the_past CHECK (flown_to < now());

ALTER TABLE aerial.imagery_surveys 
   DROP CONSTRAINT IF EXISTS check_date_is_recent;
ALTER TABLE aerial.imagery_surveys 
   ADD CONSTRAINT check_date_is_recent CHECK (flown_from > '1900-01-01');

DROP INDEX IF EXISTS aerial.sidx_imagery_surveys;
CREATE INDEX sidx_imagery_surveys
    ON aerial.imagery_surveys
    USING gist (shape);

COMMENT ON TABLE aerial.imagery_surveys IS
'This table holds the standardised attributes of aerial imagery surveys. '
'These attributes were previously only contained within individual index tile '
'layers with differing column names and data types.';
 
COMMENT ON COLUMN aerial.imagery_surveys.imagery_survey_id IS
'Unique identifier for the aerial.imagery_surveys table.';
COMMENT ON COLUMN aerial.imagery_surveys.name IS
'The corresponding aerial imagery layer name in the LINZ Data Service.';
COMMENT ON COLUMN aerial.imagery_surveys.imagery_id IS
'Foreign key to the aerial imagery layer identifier in the LINZ Data '
'Service.';
COMMENT ON COLUMN aerial.imagery_surveys.index_id IS
'Foreign key to the index tile layer identifier in the LINZ Data Service.';
COMMENT ON COLUMN aerial.imagery_surveys.set_order IS
'The order that an aerial photograph displays within the NZ Aerial Imagery'
'set. A null value indicates that the aerial photograph is not part of the '
'set.';
COMMENT ON COLUMN aerial.imagery_surveys.ground_sample_distance IS
'Ground sample distance in metres.';
COMMENT ON COLUMN aerial.imagery_surveys.accuracy IS
'The overall accuracy of the imagery survey. This may contain aggregated '
'accuracy values if accuracy varied throughout the survey. Refer to the '
'related index tile layer for specific accuracies.';
COMMENT ON COLUMN aerial.imagery_surveys.supplier IS
'The organisation that supplied the aerial imagery.';
COMMENT ON COLUMN aerial.imagery_surveys.licensor IS
'The organisation that licenses the aerial imagery.';
COMMENT ON COLUMN aerial.imagery_surveys.flown_from IS
'The earliest date on which aerial photographs were taken as part of this '
'imagery survey.';
COMMENT ON COLUMN aerial.imagery_surveys.flown_to IS
'The latest date on which aerial photographs were taken as part of this '
'imagery survey.';
COMMENT ON COLUMN aerial.imagery_surveys.shape IS 
'A dissolved, multipart boundary of the coverage of the imagery survey.';
