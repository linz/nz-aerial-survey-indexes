# Installs the SQL creation scripts and load script.
# TODO: Create a simple rebuild-aerial $DB_NAME alias that can be used to
# repeatedly reinstall and rebuild the nz-aerial database.

VERSION = dev
REVISION = $(shell test -d .git && git describe --always || echo $(VERSION))

SED = sed

datadir = ${DESTDIR}/usr/share/nz-aerial
bindir = ${DESTDIR}/usr/bin

# List of SQL scripts used for installation
# Includes SQL scripts that are only built during install
SQLSCRIPTS = \
	sql/01-aerial_schema.sql \
	sql/02-aerial_version.sql \
	sql/lds/01-aerial_lds_schema.sql \
	$(END)

# List of scripts built during install
SCRIPTS_built = \
	scripts/nz-aerial-load \
	$(END)

# List of files built from .in files during install
EXTRA_CLEAN = \
	sql/02-aerial_version.sql \
	$(SCRIPTS_built)

.dummy:

# Need install to depend on something for debuild

all: $(SQLSCRIPTS) $(SCRIPTS_built)

# Iterate through .sql.in files and build a .sql version
# with @@VERSION@@ and @@REVISION@@ replaced
%.sql: %.sql.in makefile
	$(SED) -e 's/@@VERSION@@/$(VERSION)/;s|@@REVISION@@|$(REVISION)|' $< > $@

# Replace @@VERSION@@ and @@REVISION@@ in schema load script
scripts/nz-aerial-load: scripts/nz-aerial-load.in
	$(SED) -e 's/@@VERSION@@/$(VERSION)/;s|@@REVISION@@|$(REVISION)|' $< >$@
	chmod +x $@

# Copy scripts to local data directory
# Allow nz-aerial-load to be executed from anywhere
install: $(SQLSCRIPTS) $(SCRIPTS_built)
	mkdir -p ${datadir}/sql
	cp sql/*.sql ${datadir}/sql
	mkdir -p ${datadir}/sql/lds
	cp sql/lds/*.sql ${datadir}/sql/lds
	mkdir -p ${bindir}
	cp $(SCRIPTS_built) ${bindir}

uninstall:
	# Remove the SQL scripts installed locally
	rm -rf ${datadir}

check test: $(SQLSCRIPTS)
	# Build a test database and run unit tests
	export PGDATABASE=nz-aerial-pgtap-db; \
	dropdb --if-exists $$PGDATABASE; \
	createdb $$PGDATABASE; \
	nz-aerial-load nz-aerial-pgtap-db; \
	pg_prove tests/

clean:
	# Remove the files built from .in files during install
	rm -f $(EXTRA_CLEAN)
