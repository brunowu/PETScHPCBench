ALL: blib exec 

#compilation and various flags
EXEC    = slepcbench.exe
CLEANFILES  = ${EXEC}
OFILES= ${wildcard ./*.o}
CFLAGS = -O3

<<<<<<< HEAD
MDIR=./data
###Tuning Parameters###

MPI_NODES=1
ARNOLDI_PRECISION=1e-1
MAT=utm300.mtx_300x300_3155nnz
ARNOLDI_NBEIGEN= 18
ARNOLDI_MONITOR = -eps_monitor_conv
ARNOLDI_NCV = 100
#LOG_VIEW = -log_view

include ${PETSC_DIR}/lib/petsc/conf/variables
include ${PETSC_DIR}/lib/petsc/conf/rules
include ${SLEPC_DIR}/lib/slepc/conf/slepc_common
=======
###Tuning Parameters###

<<<<<<< HEAD
MPI_NODES=1
=======
MPI_NODES=2
>>>>>>> dec8987ed4eb7c503a1985fb0a337e2a43a1c2d7
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
>>>>>>> cc815758c054ca1f180502c9868253ac00ee0233

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

exec: hpc_slepc_bench.o
	-@echo "BEGINNING TO COMPILE APPLICATION "
	-@echo "========================================="
	-@${CLINKER} -o ${EXEC} hpc_slepc_bench.o -L${SLEPC_LIB} -L${SLEPC_DIR}/${PETSC_ARCH}/lib
	-@echo "Completed building application"
	-@echo "========================================="

<<<<<<< HEAD
runa:
	-@${MPIEXEC} -np ${MPI_NODES} ./slepcbench -mfile ${MDIR}/${MAT} ${LOG_VIEW} -eps_ncv ${ARNOLDI_NCV} -eps_type arnoldi -eps_true_residual -eps_largest_imaginary -eps_nev ${ARNOLDI_NBEIGEN} -eps_tol ${ARNOLDI_PRECISION} ${ARNOLDI_MONITOR} -eps_max_it 50 

#runb:
#	./petscbench -ksp_gmres_restart 200 ${KSP_MONITOR} -ksp_rtol 1e-100 -ksp_divtol 1e1000 -ksp_max_it 20000 -pc_type none -ksp_atol 1e-10 -mfile ./utm300.mtx_300x300_3155nnz -log_view
=======
#-ksp_monitor_true_residual -eps_monitor

runa:
	-@${MPIEXEC} -np ${MPI_NODES} ./petscbench -ksp_gmres_restart ${GMRES_RESTART} ${KSP_MONITOR} -ksp_rtol ${RTOL} \
<<<<<<< HEAD
		-ksp_divtol ${DIVTOL} -ksp_max_it ${MAX_ITE} -pc_type ${PC} -ksp_atol ${ATOL} -mfile ${MAT} -log_view

runb:
	./petscbench -ksp_gmres_restart 200 ${KSP_MONITOR} -ksp_rtol 1e-100 -ksp_divtol 1e1000 -ksp_max_it 20000 -pc_type none -ksp_atol 1e-10 -mfile ./utm300.mtx_300x300_3155nnz -log_view
=======
		-ksp_divtol ${DIVTOL} -ksp_max_it ${MAX_ITE} -pc_type ${PC} -ksp_atol ${ATOL} -mfile ${MAT}

#runb:
#	./petscbench -ksp_gmres_restart 200 -ksp_monitor_true_residual -ksp_rtol 1e-100 -ksp_divtol 1e1000 -ksp_max_it 20000 -pc_type none -ksp_atol 1e-10\
#        -mfile ./utm300.mtx_300x300_3155nnz
>>>>>>> dec8987ed4eb7c503a1985fb0a337e2a43a1c2d7
>>>>>>> cc815758c054ca1f180502c9868253ac00ee0233

