
# Set the paths according to your MathLink Developer Kit location.
# (The paths should not contain whitespaces)

MLINKDIR = /Applications/Mathematica.app/Contents/SystemFiles/Links/MathLink/DeveloperKit

SYS = MacOSX-x86-64
CADDSDIR = ${MLINKDIR}/${SYS}/CompilerAdditions

INCDIR = ${CADDSDIR}
LIBDIR = ${CADDSDIR}

# Modify the following for Python versions other than 2.6
PYTHON_VERSION_MAJOR = 2
PYTHON_VERSION_MINOR = 7


# Depending on your version of OSX the Python framework might be in /Library
# instead of /System/Library (default for later OSX versions)

PYTHONFRAMEWORKDIR=/usr/local/Cellar/python/2.7.13/Frameworks
PYTHONINC=${PYTHONFRAMEWORKDIR}/Python.framework/Versions/${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}/include/python${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}


OPTS = -DPYTHON${PYTHON_VERSION_MAJOR}${PYTHON_VERSION_MINOR}
 
PYTHONIKA = Pythonika
INCLUDES = -I${INCDIR} -I${PYTHONINC}
LIBS = -L${LIBDIR} -lMLi4 -F${PYTHONFRAMEWORKDIR} -framework Python -framework CoreFoundation
MPREP = "${CADDSDIR}/mprep"
MCC = "${CADDSDIR}/mcc"


all : Pythonika


Pythonika: ${PYTHONIKA}.o ${PYTHONIKA}tm.o
	${CXX} ${INCLUDES} ${PYTHONIKA}.o ${PYTHONIKA}tm.o ${LIBS} -o ${PYTHONIKA}


${PYTHONIKA}tm.o: ${PYTHONIKA}.tm
	${MPREP} ${PYTHONIKA}.tm -o ${PYTHONIKA}tm.c
	${CXX} -c ${PYTHONIKA}tm.c ${INCLUDES}

${PYTHONIKA}.o: ${PYTHONIKA}.c
	${CXX} ${OPTS} -c ${PYTHONIKA}.c ${INCLUDES}

clean :
	rm -f ${PYTHONIKA}tm.* ${PYTHONIKA}.o ${PYTHONIKA}
