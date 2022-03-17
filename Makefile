# $FreeBSD$

PORTNAME=	chiapos
DISTVERSION=	1.0.9
CATEGORIES=	finance python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}
DISTFILES=	${DISTNAME}${EXTRACT_SUFX}

MAINTAINER=	risner@stdio.com
COMMENT=	Chia proof of space plotting, proving, and verifying (wraps C++)

LICENSE=	APACHE20 BSD2CLAUSE MIT
LICENSE_COMB=	multi
LICENSE_FILE_APACHE20=	${WRKSRC}/LICENSE
LICENSE_FILE_BSD2CLAUSE=	${WRKSRC}/lib/FiniteStateEntropy/LICENSE
LICENSE_FILE_MIT=	${WRKSRC}/MIT-LICENSES
LICENSE_DISTFILES_APACHE20=	${DISTNAME}${EXTRACT_SUFX}
LICENSE_DISTFILES_BSD2CLAUSE=	${DISTNAME}${EXTRACT_SUFX}
LICENSE_DISTFILES_MIT=		${DISTNAME}${EXTRACT_SUFX} ${DISTFILE_c} \
				${DISTFILE_g}

BUILD_DEPENDS=	${PYTHON_PKGNAMEPREFIX}setuptools_scm>=3.5.0:devel/py-setuptools_scm@${PY_FLAVOR} \
		${PYTHON_SITELIBDIR}/pybind11:devel/py-pybind11@${PY_FLAVOR}
TEST_DEPENDS=	mypy:devel/py-mypy@${PY_FLAVOR} \
		flake8:devel/py-flake8@${PY_FLAVOR} \
		py.test:devel/py-pytest@${PY_FLAVOR}

USES=		python:3.7+
USE_GITHUB=	nodefault
GH_TUPLE=	jarro2783:cxxopts:302302b30839505703d37fb82f536c53cf9172fa:c/src-ext/cxxopts \
		gulrak:filesystem:4e21ab305794f5309a1454b4ae82ab9a0f5e0d25:g/src-ext/gulrak
USE_PYTHON=	autoplist concurrent distutils

PYDISTUTILS_INSTALLARGS+=	--skip-build

post-extract:
# Remove extraneous unused files to prevent confusion
	@${RM} ${WRKSRC}/lib/FiniteStateEntropy/fetch-content-CMakeLists.txt
	@${RM} ${WRKSRC}/pyproject.toml
# Concatenate the MIT licenses
	@( ${ECHO_MSG} "uint128_t license:"; \
		${CAT} ${WRKSRC}/uint128_t/LICENSE; \
		${ECHO_MSG} ""; ${ECHO_MSG} ""; \
		${ECHO_MSG} "cxxopts license:"; \
		${CAT} ${WRKSRC}/src-ext/cxxopts/LICENSE; \
		${ECHO_MSG} ""; ${ECHO_MSG} ""; \
		${ECHO_MSG} "gulrak license:"; \
		${CAT} ${WRKSRC}/src-ext/gulrak/LICENSE ) \
			> ${WRKSRC}/MIT-LICENSES

do-test: stage
	@(cd ${WRKSRC}; ${LOCALBASE}/bin/py.test ./tests -s -v)

.include <bsd.port.mk>
