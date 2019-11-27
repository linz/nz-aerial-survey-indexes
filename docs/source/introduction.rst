.. _introduction:

Introduction
=============================

Purpose
-----------------------------

This document provides detailed metadata (data dictionary) for New Zealand aerial surveys data published on the LINZ Data Service (LDS).

The aerial surveys data includes NZ Imagery Survey Index and NZ Elevation Survey Index.

Background
----------------------------

Over the next decade, the LINZ Topographic Office is working towards its vision of recognising the way location information can help unlock new patterns and knowledge, particularly when it is combined with other types of information. One of our strategic goals is to improve national scale datasets and maximise their opportunities for reuse by a variety of national and regional stakeholders.

Orthoimagery available on the LDS is a result of many different aerial flights spanning many different regions, flown over multiple years, and at different resolutions. As a result, each set of orthoimagery has an index tile dataset which contains metadata specific for that dataset. The NZ Imagery Survey Index data described here provides a single source for all currently available orthoimagery index tiles available on the LDS.

Elevation data available on the LDS is made up of many different regions with separate elevation index tiles including limited metadata. The NZ Elevation Survey Index dataset provides much more information about the elevation surveys in one location.

Description
---------------------------

The NZ Imagery Survey Index dataset provides an index to all orthophoto index tiles found on the LDS. Each record in the dataset provides both a geometry of the maximum extent of the orthophoto index, as well as all attributes found in each index tile. This dataset therefore provides information to assess orthophoto coverage and metadata across the entire country.

The NZ Elevation Survey Index dataset provides an index to all LiDAR derived elevation datasets found on the LDS. Each record in the dataset provides both a geometry of the extent of the elevation survey, as well as useful metadata attributes. The extents are derived from the maximum extent of DEM and DSM coverage and consist of full NZTopo50 1k tiles, even where a tile is only partially covered with data. These extents only provide a rough indication of corresponding point cloud coverage which can be quite different for some elevation surveys.

File format
---------------------------

The dataset consists of vector polygons in NZTM projection.



Definitions
---------------------------

.. table::
   :class: manual

+-------------------+----------------------------------------------------------------------+
| Term              | Description                                                          |
+===================+======================================================================+
| DEM               | Digital Elevation Model. Uniformly spaced bare-earth elevation model,|
|                   | devoid of vegetation and man-made structures.                        |
+-------------------+----------------------------------------------------------------------+
| DSM               | Digital Surface Model. Uniformly spaced elevation model that depicts |
|                   | the highest surface, including vegetation and man-made structures.   |
+-------------------+----------------------------------------------------------------------+
| LDS               | LINZ Data Service                                                    |
+-------------------+----------------------------------------------------------------------+
| LiDAR             | Light Detection And Ranging. Remote sensing method to determine      |
|                   | distance by emitting pulses of light and timing their reflection.    |
+-------------------+----------------------------------------------------------------------+
| NZTopo50 1k tiles | 1:1,000 nominal scale NZTopo50 subtiles, used to spatially reference |
|                   | elevation data.                                                      |
+-------------------+----------------------------------------------------------------------+
| Orthophoto        | An aerial photograph or image geometrically corrected such that the  |
|                   | scale is uniform for measuring distances, and has been adjusted for  |
|                   | topographic relief, lens distortion, or camera tilt.                 |
+-------------------+----------------------------------------------------------------------+


