`
manual test
creates a layer of the four nodes at each corner of each grid rectangle
four each node counts other nodes which intersects
then check cells with four intersects are in the centre, and others on the edge
check number
check grid matches original grid shape
checks for tiles empty geometries, multipart geometries, geom which aren't polygons,
geoms which don't have four sides
check the number of tiles and check number of points made form these tiles
` DROP TABLE IF EXISTS grid_trial_50k;

CREATE TEMPORARY TABLE grid_trial_50k AS (
    SELECT
        row_number() OVER () AS id,
        j.dump_shape AS shape,
        ST_AsText (j.dump_shape
) AS astext,
        vertex
    FROM (
    SELECT
        (ST_DumpPoints (shape)).geom AS dump_shape, (ST_DumpPoints (shape)).path[2] AS vertex, ST_NPoints (shape
) AS npoints
    FROM
        aerial_lds. "nz_50k_tile_index") j
    WHERE
        vertex != npoints
);

ALTER TABLE grid_trial_50k
    ALTER COLUMN shape TYPE geometry(point, 2193);

ALTER TABLE grid_trial_50k
    ADD CONSTRAINT grid_trial_50k_pk PRIMARY KEY (id);

ALTER TABLE grid_trial_50k
    ADD COLUMN intersection_count int NOT NULL DEFAULT 1;

CREATE INDEX sidx_grid_trial_50k_shape ON grid_trial_50k USING gist (shape);

UPDATE
    grid_trial_50k
SET
    intersection_count = subquery.count + 1
FROM (
    SELECT
        pn.id,
        count(*) AS count
    FROM
        grid_trial_50k AS pn,
        grid_trial_50k AS pn2
    WHERE
        pn.id != pn2.id
        AND ST_Intersects (pn.shape, pn2.shape)
    GROUP BY
        pn.id) AS subquery
WHERE
    grid_trial_50k.id = subquery.id;

`make single geom so then can ask if touches or within` DROP TABLE IF EXISTS merged_tiles;

CREATE TEMPORARY TABLE merged_tiles AS
SELECT
    ST_Simplify (ST_Normalize (ST_Union (shape)), 0.1) AS shape
FROM
    aerial_lds. "nz_50k_tile_index";

SELECT
    gt.*
FROM
    grid_trial_50k gt,
    merged_tiles m
WHERE
    ST_Within (gt.shape, m.shape)
    AND gt.intersection_count != 4;

SELECT
    gt.*
FROM
    grid_trial_50k gt,
    merged_tiles m
WHERE
    ST_Touches (gt.shape, m.shape)
    AND gt.intersection_count NOT IN (1, 2, 3);

`get counts for comparing easily`
SELECT
    gt.intersection_count,
    count(*)
FROM
    grid_trial_50k gt
GROUP BY
    gt.intersection_count
ORDER BY
    gt.intersection_count;

`
50k
1;76
2;126
3;210
4;1624
`
SELECT
    *
FROM
    aerial_lds. "nz_50k_tile_index"
WHERE
    ST_IsEmpty (shape);

SELECT
    *
FROM
    aerial_lds. "nz_50k_tile_index"
WHERE
    ST_GeometryType (shape) != 'ST_Polygon';

` check polygons only have five vertices including the duplicate start and end`
SELECT
    *
FROM
    aerial_lds. "nz_50k_tile_index"
WHERE
    ST_NPoints (shape) != 5;

`check there are no multipart geoms`
SELECT
    *
FROM
    aerial_lds. "nz_50k_tile_index"
WHERE
    ST_NumGeometries (shape) != 1;

`
merge the polys and check they have same shape as the original merged 50k which has been thoroughly checked
`
SELECT
    *
FROM
    "merged_tiles"
WHERE
    St_asText (shape) != 'MULTIPOLYGON(((1084000 4830000,1084000 4974000,1108000 4974000,1108000 5010000,1132000 5010000,1132000 5046000,1156000 5046000,1156000 5082000,1180000 5082000,1180000 5118000,1228000 5118000,1228000 5154000,1276000 5154000,1276000 5190000,1324000 5190000,1324000 5226000,1348000 5226000,1348000 5262000,1372000 5262000,1372000 5298000,1420000 5298000,1420000 5334000,1444000 5334000,1444000 5406000,1492000 5406000,1492000 5442000,1516000 5442000,1516000 5514000,1540000 5514000,1540000 5550000,1612000 5550000,1612000 5514000,1708000 5514000,1708000 5478000,1756000 5478000,1756000 5550000,1660000 5550000,1660000 5622000,1636000 5622000,1636000 5658000,1660000 5658000,1660000 5694000,1684000 5694000,1684000 5730000,1708000 5730000,1708000 5766000,1732000 5766000,1732000 5838000,1708000 5838000,1708000 5910000,1684000 5910000,1684000 5946000,1660000 5946000,1660000 6018000,1636000 6018000,1636000 6054000,1588000 6054000,1588000 6090000,1564000 6090000,1564000 6162000,1540000 6162000,1540000 6198000,1564000 6198000,1564000 6234000,1588000 6234000,1588000 6198000,1636000 6198000,1636000 6162000,1708000 6162000,1708000 6126000,1732000 6126000,1732000 6090000,1780000 6090000,1780000 6054000,1804000 6054000,1804000 6018000,1852000 6018000,1852000 5982000,1876000 5982000,1876000 5946000,1900000 5946000,1900000 5874000,1924000 5874000,1924000 5838000,1948000 5838000,1948000 5874000,1996000 5874000,1996000 5838000,2116000 5838000,2116000 5766000,2092000 5766000,2092000 5694000,2068000 5694000,2068000 5658000,2044000 5658000,2044000 5622000,1972000 5622000,1972000 5550000,1948000 5550000,1948000 5514000,1924000 5514000,1924000 5478000,1900000 5478000,1900000 5442000,1876000 5442000,1876000 5406000,1828000 5406000,1828000 5370000,1756000 5370000,1756000 5406000,1732000 5406000,1732000 5370000,1708000 5370000,1708000 5334000,1684000 5334000,1684000 5298000,1660000 5298000,1660000 5226000,1636000 5226000,1636000 5118000,1564000 5118000,1564000 5082000,1540000 5082000,1540000 5046000,1492000 5046000,1492000 4974000,1468000 4974000,1468000 4938000,1444000 4938000,1444000 4902000,1420000 4902000,1420000 4866000,1396000 4866000,1396000 4830000,1348000 4830000,1348000 4794000,1276000 4794000,1276000 4758000,1228000 4758000,1228000 4722000,1156000 4722000,1156000 4794000,1108000 4794000,1108000 4830000,1084000 4830000)),((1492000 6198000,1492000 6234000,1540000 6234000,1540000 6198000,1492000 6198000)))';

SELECT
    count(*)
FROM
    aerial_lds. "nz_50k_tile_index";

` should be 509`
SELECT
    count(*) / 4
FROM
    grid_trial_50k;

` should be 509 as it is all the corners for each shape`
