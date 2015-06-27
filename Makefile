# $FreeBSD$

PORTNAME= 	imposm3
PORTVERSION=	1.0
CATEGORIES=	misc

MAINTAINER= 	th@skowron.biz
COMMENT=	Imposm3 for FreeBSD

LICENSE= 	APACHE20

BUILD_DEPENDS=	go:${PORTSDIR}/lang/go
LIB_DEPENDS=	libprotobuf.so:${PORTSDIR}/devel/protobuf \
		libleveldb.so:${PORTSDIR}/databases/leveldb \
		libgeos.so:${PORTSDIR}/graphics/geos

USE_GITHUB=	yes
GH_ACCOUNT=	omniscale
GH_PROJECT=	imposm3
GH_COMMIT=	593f252
GH_TAGNAME=	${GH_COMMIT}

IMPOSM_SRC= 	src/github.com/omniscale

do-build:
	${MKDIR} ${WRKSRC}/${IMPOSM_SRC} && ${LN} -fs ${WRKSRC} ${WRKSRC}/${IMPOSM_SRC}/imposm3
	GOPATH=${WRKSRC}:${WRKSRC}/${IMPOSM_SRC}/imposm3/Godeps/_workspace/ CGO_CFLAGS="-I${PREFIX}/include -ferror-limit=0" CGO_LDFLAGS="-L${PREFIX}/lib/" go build -o ${WRKSRC}/imposm3 ${WRKSRC}/${IMPOSM_SRC}/imposm3/imposm3.go

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/imposm3 ${STAGEDIR}${PREFIX}/bin/

.include <bsd.port.mk>
