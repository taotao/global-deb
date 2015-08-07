NAME=global
VERSION=6.5
DEBVERSION=1

ARCHIVE=${NAME}-${VERSION}.tar.gz
ORIG_ARCHIVE=${NAME}_${VERSION}.orig.tar.gz

STAGING_DIR=${NAME}-${VERSION}

FILES=\
	${STAGING_DIR}/debian/changelog \
	${STAGING_DIR}/debian/compat \
	${STAGING_DIR}/debian/control \
	${STAGING_DIR}/debian/copyright \
	${STAGING_DIR}/debian/rules \
	${STAGING_DIR}/debian/source/format

.PHONY: all clean deb untar

all: deb

clean:
	rm -rf ${ORIG_ARCHIVE} ${STAGING_DIR} ${NAME}_${VERSION}-${DEBVERSION}* ${NAME}*.deb

${ORIG_ARCHIVE}: ${ARCHIVE}
	cp $< $@

untar: ${ARCHIVE}
	tar zxf $<

${STAGING_DIR}/debian/%: debian/%
	mkdir -p $(dir $@)
	cp $< $@

deb: ${ORIG_ARCHIVE} untar ${FILES}
	cd ${STAGING_DIR} && debuild -us -uc
