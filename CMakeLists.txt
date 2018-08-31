cmake_minimum_required (VERSION 3.6)

project(PETScBenchmark)

list (APPEND CMAKE_MODULE_PATH "${PETScBenchmark_SOURCE_DIR}/cmake-modules")

find_package (PETSc REQUIRED)

if(PETSC_FOUND)
    message([STATUS] "PETSC is provided, thus one can use the interface of SMG2S to PETSc.")
endif()

message ([STATUS] "PETSC COMPILER is found as ${PETSC_COMPILER}")

#add_definitions (-std=c++0x)

message ([STATUS] "CPP COMPILER ${PETSC_COMPILER}")

include_directories(${PETSC_INCLUDES})

add_definitions (${PETSC_DEFINITIONS})

add_definitions (-g)

message (STATUS "PETSC_DEFINITIONS ${PETSC_DEFINITIONS}")

message (STATUS "PETSC_LIBRARIES ${PETSC_LIBRARIES}")

set (PETScBenchmark_DEPENDENT_LIBRARIES "${PETSC_LIBRARIES}")

add_executable(petscbench.exe hpc_petsc_bench.c)

target_link_libraries(petscbench.exe ${PETSC_LIBRARIES})

