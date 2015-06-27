# $FreeBSD$

PORTNAME= 	imposm3
PORTVERSION=	1.0
CATEGORIES=	misc

USE_GITHUB=	yes
GH_ACCOUNT=	omniscale
GH_PROJECT=	imposm3
GH_COMMIT=	593f252
GH_TAGNAME=	${GH_COMMIT}

LIB_DEPENDS=	libprotobuf.so:${PORTSDIR}/devel/protobuf \
		libleveldb.so:${PORTSDIR}/databases/leveldb \
		libgeos.so:${PORTSDIR}/graphics/geos

BUILD_DEPENDS=	go:${PORTSDIR}/lang/go

MAINTAINER= 	th@skowron.biz
COMMENT=	Imposm3 for FreeBSD

IMPOSM_SRC= 	src/github.com/omniscale

do-build:
	mkdir -p ${WRKSRC}/${IMPOSM_SRC} && ln -fs ${WRKSRC} ${WRKSRC}/${IMPOSM_SRC}/imposm3
	GOPATH=${WRKSRC}:${WRKSRC}/${IMPOSM_SRC}/imposm3/Godeps/_workspace/ CGO_CFLAGS="-I/usr/local/include -ferror-limit=0" CGO_LDFLAGS="-L/usr/local/lib/" go build -o ${WRKSRC}/imposm3 ${WRKSRC}/${IMPOSM_SRC}/imposm3/imposm3.go 

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/imposm3 ${STAGEDIR}${PREFIX}/bin/

.include <bsd.port.mk>
