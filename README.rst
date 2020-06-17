==================
NZ Imagery Surveys
==================

.. image:: https://github.com/linz/nz-imagery-surveys/workflows/Build/badge.svg
    :target: https://github.com/linz/nz-imagery-surveys/actions
    :alt: CI Status

.. image:: https://readthedocs.org/projects/nz-imagery-surveys/badge/?version=latest
    :target: https://nz-imagery-surveys.readthedocs.io/en/latest/?badge=latest
    :alt: Documentation Status

.. image:: https://img.shields.io/badge/License-BSD%203--Clause-blue.svg 
    :target: https://github.com/linz/nz-imagery-surveys/blob/master/LICENSE
    :alt: License

Provides the schema and documentation for the Imagery Surveys dataset.

Installation
============

First install the project into the OS data share directory:

.. code-block:: shell

    sudo make install

Then you can load the schema into a target database:

.. code-block:: shell

    nz-aerial-load $DB_NAME

NOTE: the loader script will expect to find SQL scripts under /usr/share/nz-aerial/, if you want them found in a different directory you can set the AERIALSCHEMA_SQLDIR environment variable.

Upgrade
=======

.. code-block:: shell

    sudo make uninstall && make clean && sudo make install

The `nz-aerial-load` script will then upgrade a database schema, by replacing the existing schema. **All data will be lost.**

Testing
=======

Testing uses `pgTAP` via `pg_prove`.

.. code-block:: shell

    make check
