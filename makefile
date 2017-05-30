ALL: blib exec 

#compilation and various flags
EXEC    = petscbench
CLEANFILES  = ${EXEC}
OFILES= ${wildcard ./*.o}
CFLAGS = -O3

###Tuning Parameters###

MPI_NODES=1
GMRES_RESTART=200
KSP_MONITOR=-ksp_monitor_true_residual
RTOL=1e-100
DIVTOL=1e1000
MAX_ITE=20000
PC=none
ATOL=1e-10
MAT=utm300.mtx_300x300_3155nnz


include ${PETSC_DIR}/lib/petsc/conf/variables
include ${PETSC_DIR}/lib/petsc/conf/rules

blib :
	-@echo "BEGINNING TO COMPILE LIBRARIES "
	-@echo "========================================="
	-@${OMAKE}  PETSC_ARCH=${PETSC_ARCH} PETSC_DIR=${PETSC_DIR} ACTION=libfast tree
	-@echo "Completed building libraries"
	-@echo "========================================="

distclean :
	-@echo "Cleaning application and libraries"
	-@echo "========================================="
	-@${OMAKE} PETSC_ARCH=${PETSC_ARCH}  PETSC_DIR=${PETSC_DIR} clean
	-${RM} ${OFILES}
	-@echo "Finised cleaning application and libraries"
	-@echo "========================================="	

exec: hpc_petsc_bench.o
	-@echo "BEGINNING TO COMPILE APPLICATION "
	-@echo "========================================="
	-@${CLINKER} -o ${EXEC} hpc_petsc_bench.o ${PETSC_LIB}
	-@echo "Completed building application"
	-@echo "========================================="

#-ksp_monitor_true_residual -eps_monitor

runa:
	-@${MPIEXEC} -np ${MPI_NODES} ./petscbench -ksp_gmres_restart ${GMRES_RESTART} ${KSP_MONITOR} -ksp_rtol ${RTOL} \
		-ksp_divtol ${DIVTOL} -ksp_max_it ${MAX_ITE} -pc_type ${PC} -ksp_atol ${ATOL} -mfile ${MAT} -log_view

runb:
	./petscbench -ksp_gmres_restart 200 ${KSP_MONITOR} -ksp_rtol 1e-100 -ksp_divtol 1e1000 -ksp_max_it 20000 -pc_type none -ksp_atol 1e-10 -mfile ./utm300.mtx_300x300_3155nnz -log_view

