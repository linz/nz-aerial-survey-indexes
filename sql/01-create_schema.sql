------------------------------------------------------------------------------
-- Create aerial schema and imagery surveys table
------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS aerial;

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
