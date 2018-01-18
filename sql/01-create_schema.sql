------------------------------------------------------------------------------
-- Create aerial schema and imagery surveys table
------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS aerial;

CREATE TABLE IF NOT EXISTS aerial.imagery_surveys (
      imagery_survey_id serial NOT NULL PRIMARY KEY
    , name text NOT NULL
    , imagery_id integer NOT NULL
    , index_id integer NOT NULL
    , set_order integer NOT NULL
    , gsd_m decimal(6,4)
    , accuracy text
    , supplier text
    , licensor text
    , flown_from date
    , flown_to date
    , shape public.geometry(MultiPolygon, 2193) NOT NULL
);
