CXX = g++

PYTHON_INCLUDES = $(shell python3-config --includes)

PYBIND11_INCLUDES = $(shell python3 -m pybind11 --includes 2>/dev/null || echo "")

CXXFLAGS = -O3 -Wall -shared -std=c++11 -fPIC $(PYTHON_INCLUDES) $(PYBIND11_INCLUDES)
PYTHON_SUFFIX = $(shell python3-config --extension-suffix)

TARGET = _matrix$(PYTHON_SUFFIX)

MKL_FLAGS = -m64 -I${MKLROOT}/include
MKL_LIBS = -L${MKLROOT}/lib/intel64 -Wl,--no-as-needed -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl

.PHONY: all clean test

all: $(TARGET)

$(TARGET): matrix.cpp
	$(CXX) $(CXXFLAGS) $(MKL_FLAGS) matrix.cpp -o $(TARGET) $(MKL_LIBS)

test: $(TARGET)
	python3 -m pytest test_matrix.py -v

clean:
	rm -rf $(TARGET) __pycache__ .pytest_cache
