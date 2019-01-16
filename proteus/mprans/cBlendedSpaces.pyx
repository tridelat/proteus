# A type of -*- python -*- file
import numpy
cimport numpy
from proteus import *
from proteus.Transport import *
from proteus.Transport import OneLevelTransport

cdef extern from "BlendedSpaces.h" namespace "proteus":
    cdef cppclass BlendedSpaces_base:
        void calculateResidual(double dt,
                               double * mesh_trial_ref,
                               double * mesh_grad_trial_ref,
                               double * mesh_dof,
                               int * mesh_l2g,
                               double * dV_ref,
                               double * u_trial_ref,
                               double * u_grad_trial_ref,
                               double * u_test_ref,
                               double * u_grad_test_ref,
                               double * mesh_trial_trace_ref,
                               double * mesh_grad_trial_trace_ref,
                               double * dS_ref,
                               double * u_trial_trace_ref,
                               double * u_grad_trial_trace_ref,
                               double * u_test_trace_ref,
                               double * u_grad_test_trace_ref,
                               double * normal_ref,
                               double * boundaryJac_ref,
                               int nElements_global,
                               int * u_l2g,
                               int * r_l2g,
                               double * elementDiameter,
                               double * u_dof,
                               double * u_dof_old,
                               double * velocity,
                               double * q_u,
                               double * q_grad_u,
                               int offset_u, int stride_u,
                               double * globalResidual,
                               int nExteriorElementBoundaries_global,
                               int * exteriorElementBoundariesArray,
                               int * elementBoundaryElementsArray,
                               int * elementBoundaryLocalElementBoundariesArray,
                               double * ebqe_velocity_ext,
                               int * isDOFBoundary_u,
                               double * ebqe_bc_u_ext,
                               int * isFluxBoundary_u,
                               double * ebqe_bc_flux_u_ext,
                               double * ebqe_phi, double epsFact,
                               double * ebqe_u,
                               double * ebqe_flux,
                               int numDOFs,
                               int NNZ,
                               int * csrRowIndeces_DofLoops,
                               int * csrColumnOffsets_DofLoops,
                               int * csrRowIndeces_CellLoops,
                               int * csrColumnOffsets_CellLoops,
                               int * csrColumnOffsets_eb_CellLoops,
			       double* force,
			       double* alpha_dof,
			       double* aux_test_ref,
			       double* aux_grad_test_ref,
			       double* dLow,
                               double epsilon,
                               int PROBLEM_TYPE,
                               int GALERKIN_SOLUTION,
                               double* galerkin_solution,
                               double* gamma_dof,
                               double * quantDOFs,
                               double * quantDOFs2)
        void calculateJacobian(double dt,
                               double * mesh_trial_ref,
                               double * mesh_grad_trial_ref,
                               double * mesh_dof,
                               int * mesh_l2g,
                               double * dV_ref,
                               double * u_trial_ref,
                               double * u_grad_trial_ref,
                               double * u_test_ref,
                               double * u_grad_test_ref,
                               double * mesh_trial_trace_ref,
                               double * mesh_grad_trial_trace_ref,
                               double * dS_ref,
                               double * u_trial_trace_ref,
                               double * u_grad_trial_trace_ref,
                               double * u_test_trace_ref,
                               double * u_grad_test_trace_ref,
                               double * normal_ref,
                               double * boundaryJac_ref,
                               int nElements_global,
                               int * u_l2g,
                               int * r_l2g,
                               double * elementDiameter,
                               double * u_dof,
                               double * velocity,
                               int * csrRowIndeces_u_u, int * csrColumnOffsets_u_u,
                               double * globalJacobian,
                               int nExteriorElementBoundaries_global,
                               int * exteriorElementBoundariesArray,
                               int * elementBoundaryElementsArray,
                               int * elementBoundaryLocalElementBoundariesArray,
                               double * ebqe_velocity_ext,
                               int * isDOFBoundary_u,
                               double * ebqe_bc_u_ext,
                               int * isFluxBoundary_u,
                               double * ebqe_bc_flux_u_ext,
                               int * csrColumnOffsets_eb_u_u,
                               int numDOFs,
                               int* rowptr,
                               int* colind,
			       double* alpha_dof,
			       double* aux_test_ref,
			       double* aux_grad_test_ref,
			       double* dLow,
			       double epsilon,
                               int GALERKIN_SOLUTION,
                               int PROBLEM_TYPE)
        void calculateMetricsAtEOS(double* mesh_trial_ref,
                                   double* mesh_grad_trial_ref,
                                   double* mesh_dof,
                                   int* mesh_l2g,
                                   double* dV_ref,
                                   double* u_trial_ref,
                                   double* u_grad_trial_ref,
                                   double* u_test_ref,
                                   int nElements_global,
                                   int nElements_owned,
                                   int* u_l2g,
                                   double* elementDiameter,
                                   double* meshSize,
                                   double* nodeDiametersArray,
                                   double epsFactHeaviside,
                                   double* q_uh,
				   double* q_grad_uh,
                                   double* u_exact,
                                   double* gradx_u_exact,
                                   double* grady_u_exact,
                                   int offset_u, int stride_u,
                                   double* global_L2,
                                   double* global_H1,
                                   double* global_L2_Omega1,
                                   double* global_H1_Omega1,
                                   double* global_Omega1,
                                   double* global_L2_Omega2,
                                   double* global_H1_Omega2,
				   double* global_Omega2,
                                   double* global_L2_sH,
                                   double* global_L2_1msH)
        void calculateSmoothnessIndicator(double * mesh_trial_ref,
                                          double * mesh_grad_trial_ref,
                                          double * mesh_dof,
                                          int * mesh_l2g,
                                          double * dV_ref,
                                          double * u_trial_ref,
                                          double * u_grad_trial_ref,
                                          double * u_test_ref,
                                          double * u_grad_test_ref,
                                          double * u_hess_trial_ref,
                                          int nElements_global,
                                          int * u_l2g,
                                          int * r_l2g,
                                          double * u_dof,
                                          int offset_u, int stride_u,
                                          double * is_dof_external,
                                          double * is_dof_internal,
                                          double * num_hi,
                                          double * den_hi,
                                          double * global_hi,
                                          double * element_He,
                                          double* gamma_dof,
					  int numDOFs,
					  int NNZ,
					  int* rowptr,
					  int* colind)
    BlendedSpaces_base * newBlendedSpaces(int nSpaceIn,
                                          int nQuadraturePoints_elementIn,
                                          int nDOF_mesh_trial_elementIn,
                                          int nDOF_trial_elementIn,
                                          int nDOF_test_elementIn,
                                          int nQuadraturePoints_elementBoundaryIn,
                                          int CompKernelFlag)

cdef class cBlendedSpaces_base:
    cdef BlendedSpaces_base * thisptr

    def __cinit__(self,
                  int nSpaceIn,
                  int nQuadraturePoints_elementIn,
                  int nDOF_mesh_trial_elementIn,
                  int nDOF_trial_elementIn,
                  int nDOF_test_elementIn,
                  int nQuadraturePoints_elementBoundaryIn,
                  int CompKernelFlag):
        self.thisptr = newBlendedSpaces(nSpaceIn,
                                        nQuadraturePoints_elementIn,
                                        nDOF_mesh_trial_elementIn,
                                        nDOF_trial_elementIn,
                                        nDOF_test_elementIn,
                                        nQuadraturePoints_elementBoundaryIn,
                                        CompKernelFlag)

    def __dealloc__(self):
        del self.thisptr

    def calculateResidual(self,
                          double dt,
                          numpy.ndarray mesh_trial_ref,
                          numpy.ndarray mesh_grad_trial_ref,
                          numpy.ndarray mesh_dof,
                          numpy.ndarray mesh_l2g,
                          numpy.ndarray dV_ref,
                          numpy.ndarray u_trial_ref,
                          numpy.ndarray u_grad_trial_ref,
                          numpy.ndarray u_test_ref,
                          numpy.ndarray u_grad_test_ref,
                          numpy.ndarray mesh_trial_trace_ref,
                          numpy.ndarray mesh_grad_trial_trace_ref,
                          numpy.ndarray dS_ref,
                          numpy.ndarray u_trial_trace_ref,
                          numpy.ndarray u_grad_trial_trace_ref,
                          numpy.ndarray u_test_trace_ref,
                          numpy.ndarray u_grad_test_trace_ref,
                          numpy.ndarray normal_ref,
                          numpy.ndarray boundaryJac_ref,
                          int nElements_global,
                          numpy.ndarray u_l2g,
                          numpy.ndarray r_l2g,
                          numpy.ndarray elementDiameter,
                          numpy.ndarray u_dof,
                          numpy.ndarray u_dof_old,
                          numpy.ndarray velocity,
                          numpy.ndarray q_u,
                          numpy.ndarray q_grad_u,
                          int offset_u, int stride_u,
                          numpy.ndarray globalResidual,
                          int nExteriorElementBoundaries_global,
                          numpy.ndarray exteriorElementBoundariesArray,
                          numpy.ndarray elementBoundaryElementsArray,
                          numpy.ndarray elementBoundaryLocalElementBoundariesArray,
                          numpy.ndarray ebqe_velocity_ext,
                          numpy.ndarray isDOFBoundary_u,
                          numpy.ndarray ebqe_bc_u_ext,
                          numpy.ndarray isFluxBoundary_u,
                          numpy.ndarray ebqe_bc_flux_u_ext,
                          numpy.ndarray ebqe_phi, double epsFact,
                          numpy.ndarray ebqe_u,
                          numpy.ndarray ebqe_flux,
                          int numDOFs,
                          int NNZ,
                          numpy.ndarray csrRowIndeces_DofLoops,
                          numpy.ndarray csrColumnOffsets_DofLoops,
                          numpy.ndarray csrRowIndeces_CellLoops,
                          numpy.ndarray csrColumnOffsets_CellLoops,
                          numpy.ndarray csrColumnOffsets_eb_CellLoops,
			  numpy.ndarray force,
			  numpy.ndarray alpha_dof,
			  numpy.ndarray aux_test_ref,
			  numpy.ndarray aux_grad_test_ref,
                          numpy.ndarray dLow,
                          double epsilon,
                          int PROBLEM_TYPE,
                          int GALERKIN_SOLUTION,
                          numpy.ndarray galerkin_solution,
                          numpy.ndarray gamma_dof,
                          numpy.ndarray quantDOFs,
                          numpy.ndarray quantDOFs2):
        self.thisptr.calculateResidual(dt,
                                       < double * > mesh_trial_ref.data,
                                       < double * > mesh_grad_trial_ref.data,
                                       < double * > mesh_dof.data,
                                       < int * > mesh_l2g.data,
                                       < double * > dV_ref.data,
                                       < double * > u_trial_ref.data,
                                       < double * > u_grad_trial_ref.data,
                                       < double * > u_test_ref.data,
                                       < double * > u_grad_test_ref.data,
                                       < double * > mesh_trial_trace_ref.data,
                                       < double * > mesh_grad_trial_trace_ref.data,
                                       < double * > dS_ref.data,
                                       < double * > u_trial_trace_ref.data,
                                       < double * > u_grad_trial_trace_ref.data,
                                       < double * > u_test_trace_ref.data,
                                       < double * > u_grad_test_trace_ref.data,
                                       < double * > normal_ref.data,
                                       < double * > boundaryJac_ref.data,
                                       nElements_global,
                                       < int * > u_l2g.data,
                                       < int * > r_l2g.data,
                                       < double * > elementDiameter.data,
                                       < double * > u_dof.data,
                                       < double * > u_dof_old.data,
                                       < double * > velocity.data,
                                       < double * > q_u.data,
                                       < double * > q_grad_u.data,
                                       offset_u, stride_u,
                                       < double * > globalResidual.data,
                                       nExteriorElementBoundaries_global,
                                       < int * > exteriorElementBoundariesArray.data,
                                       < int * > elementBoundaryElementsArray.data,
                                       < int * > elementBoundaryLocalElementBoundariesArray.data,
                                       < double * > ebqe_velocity_ext.data,
                                       < int * > isDOFBoundary_u.data,
                                       < double * > ebqe_bc_u_ext.data,
                                       < int * > isFluxBoundary_u.data,
                                       < double * > ebqe_bc_flux_u_ext.data,
                                       < double * > ebqe_phi.data,
                                       epsFact,
                                       < double * > ebqe_u.data,
                                       < double * > ebqe_flux.data,
                                       numDOFs,
                                       NNZ,
                                       < int * > csrRowIndeces_DofLoops.data,
                                       < int * > csrColumnOffsets_DofLoops.data,
                                       < int * > csrRowIndeces_CellLoops.data,
                                       < int * > csrColumnOffsets_CellLoops.data,
                                       < int * > csrColumnOffsets_eb_CellLoops.data,
				       <double*> force.data,
				       <double*> alpha_dof.data,
				       <double*> aux_test_ref.data,
				       <double*> aux_grad_test_ref.data,
				       <double*> dLow.data,
                                       epsilon,
                                       PROBLEM_TYPE,
                                       GALERKIN_SOLUTION,
                                       <double*> galerkin_solution.data,
                                       <double*> gamma_dof.data,
                                       < double * > quantDOFs.data,
                                       < double * > quantDOFs2.data)
                                       
    def calculateJacobian(self,
                          double dt,
                          numpy.ndarray mesh_trial_ref,
                          numpy.ndarray mesh_grad_trial_ref,
                          numpy.ndarray mesh_dof,
                          numpy.ndarray mesh_l2g,
                          numpy.ndarray dV_ref,
                          numpy.ndarray u_trial_ref,
                          numpy.ndarray u_grad_trial_ref,
                          numpy.ndarray u_test_ref,
                          numpy.ndarray u_grad_test_ref,
                          numpy.ndarray mesh_trial_trace_ref,
                          numpy.ndarray mesh_grad_trial_trace_ref,
                          numpy.ndarray dS_ref,
                          numpy.ndarray u_trial_trace_ref,
                          numpy.ndarray u_grad_trial_trace_ref,
                          numpy.ndarray u_test_trace_ref,
                          numpy.ndarray u_grad_test_trace_ref,
                          numpy.ndarray normal_ref,
                          numpy.ndarray boundaryJac_ref,
                          int nElements_global,
                          numpy.ndarray u_l2g,
                          numpy.ndarray r_l2g,
                          numpy.ndarray elementDiameter,
                          numpy.ndarray u_dof,
                          numpy.ndarray velocity,
                          numpy.ndarray csrRowIndeces_u_u, numpy.ndarray csrColumnOffsets_u_u,
                          globalJacobian,
                          int nExteriorElementBoundaries_global,
                          numpy.ndarray exteriorElementBoundariesArray,
                          numpy.ndarray elementBoundaryElementsArray,
                          numpy.ndarray elementBoundaryLocalElementBoundariesArray,
                          numpy.ndarray ebqe_velocity_ext,
                          numpy.ndarray isDOFBoundary_u,
                          numpy.ndarray ebqe_bc_u_ext,
                          numpy.ndarray isFluxBoundary_u,
                          numpy.ndarray ebqe_bc_flux_u_ext,
                          numpy.ndarray csrColumnOffsets_eb_u_u,
                          int numDOFs,
			  numpy.ndarray alpha_dof,
			  numpy.ndarray aux_test_ref,
			  numpy.ndarray aux_grad_test_ref,
			  numpy.ndarray dLow,
			  double epsilon,
                          int GALERKIN_SOLUTION,
                          int PROBLEM_TYPE):
        cdef numpy.ndarray rowptr, colind, globalJacobian_a
        (rowptr, colind, globalJacobian_a) = globalJacobian.getCSRrepresentation()
        self.thisptr.calculateJacobian(dt,
                                       < double * > mesh_trial_ref.data,
                                       < double * > mesh_grad_trial_ref.data,
                                       < double * > mesh_dof.data,
                                       < int * > mesh_l2g.data,
                                       < double * > dV_ref.data,
                                       < double * > u_trial_ref.data,
                                       < double * > u_grad_trial_ref.data,
                                       < double * > u_test_ref.data,
                                       < double * > u_grad_test_ref.data,
                                       < double * > mesh_trial_trace_ref.data,
                                       < double * > mesh_grad_trial_trace_ref.data,
                                       < double * > dS_ref.data,
                                       < double * > u_trial_trace_ref.data,
                                       < double * > u_grad_trial_trace_ref.data,
                                       < double * > u_test_trace_ref.data,
                                       < double * > u_grad_test_trace_ref.data,
                                       < double * > normal_ref.data,
                                       < double * > boundaryJac_ref.data,
                                       nElements_global,
                                       < int * > u_l2g.data,
                                       < int * > r_l2g.data,
                                       < double * > elementDiameter.data,
                                       < double * > u_dof.data,
                                       < double * > velocity.data,
                                       < int * > csrRowIndeces_u_u.data, < int * > csrColumnOffsets_u_u.data,
                                       < double * > globalJacobian_a.data,
                                       nExteriorElementBoundaries_global,
                                       < int * > exteriorElementBoundariesArray.data,
                                       < int * > elementBoundaryElementsArray.data,
                                       < int * > elementBoundaryLocalElementBoundariesArray.data,
                                       < double * > ebqe_velocity_ext.data,
                                       < int * > isDOFBoundary_u.data,
                                       < double * > ebqe_bc_u_ext.data,
                                       < int * > isFluxBoundary_u.data,
                                       < double * > ebqe_bc_flux_u_ext.data,
                                       < int * > csrColumnOffsets_eb_u_u.data,
                                       numDOFs,
                                       <int*> rowptr.data,
                                       <int*> colind.data,
				       <double*> alpha_dof.data,
			 	       <double*> aux_test_ref.data,
			 	       <double*> aux_grad_test_ref.data,
				       <double*> dLow.data,
				       epsilon,
                                       GALERKIN_SOLUTION,
                                       PROBLEM_TYPE)
    def calculateMetricsAtEOS(self,
                              numpy.ndarray mesh_trial_ref,
                              numpy.ndarray mesh_grad_trial_ref,
                              numpy.ndarray mesh_dof,
                              numpy.ndarray mesh_l2g,
                              numpy.ndarray dV_ref,
                              numpy.ndarray u_trial_ref,
                              numpy.ndarray u_grad_trial_ref,
                              numpy.ndarray u_test_ref,
                              int nElements_global,
                              int nElements_owned,
                              numpy.ndarray u_l2g,
                              numpy.ndarray elementDiameter,
                              numpy.ndarray meshSize,
                              numpy.ndarray nodeDiametersArray,
                              double epsFactHeaviside,
                  	      numpy.ndarray q_uh,
			      numpy.ndarray q_grad_uh,
                              numpy.ndarray u_exact,
                              numpy.ndarray gradx_u_exact,
                              numpy.ndarray grady_u_exact,
                              int offset_u, int stride_u):
        cdef double global_L2
        cdef double global_H1
        cdef double global_L2_Omega1
        cdef double global_H1_Omega1
        cdef double global_Omega1
        cdef double global_L2_Omega2
        cdef double global_H1_Omega2
        cdef double global_Omega2
        cdef double global_L2_sH
        cdef double global_L2_1msH
        self.thisptr.calculateMetricsAtEOS(<double*>mesh_trial_ref.data,
                                           <double*>mesh_grad_trial_ref.data,
                                           <double*>mesh_dof.data,
                                           <int*>mesh_l2g.data,
                                           <double*>dV_ref.data,
                                           <double*>u_trial_ref.data,
                                           <double*>u_grad_trial_ref.data,
                                           <double*>u_test_ref.data,
                                           nElements_global,
                                           nElements_owned,
                                           <int*>u_l2g.data,
                                           <double*>elementDiameter.data,
                                           <double*>meshSize.data,
                                           <double*>nodeDiametersArray.data,
                                           epsFactHeaviside,
                                           <double*>q_uh.data,
					   <double*>q_grad_uh.data,
                                           <double*>u_exact.data,
                                           <double*>gradx_u_exact.data,
                                           <double*>grady_u_exact.data,
                                           offset_u,
                                           stride_u,
                                           &global_L2,
                                           &global_H1,
                                           &global_L2_Omega1,
                                           &global_H1_Omega1,
                                           &global_Omega1,
                                           &global_L2_Omega2,
                                           &global_H1_Omega2,
                                           &global_Omega2,
                                           &global_L2_sH,
                                           &global_L2_1msH)
        return(global_L2,
               global_H1,
               global_L2_Omega1,
               global_H1_Omega1,
               global_Omega1,
               global_L2_Omega2,
               global_H1_Omega2,
               global_Omega2,
               global_L2_sH,
               global_L2_1msH)
    def calculateSmoothnessIndicator(self,
                                     numpy.ndarray mesh_trial_ref,
                                     numpy.ndarray mesh_grad_trial_ref,
                                     numpy.ndarray mesh_dof,
                                     numpy.ndarray mesh_l2g,
                                     numpy.ndarray dV_ref,
                                     numpy.ndarray u_trial_ref,
                                     numpy.ndarray u_grad_trial_ref,
                                     numpy.ndarray u_test_ref,
                                     numpy.ndarray u_grad_test_ref,
                                     numpy.ndarray u_hess_trial_ref,
                                     int nElements_global,
                                     numpy.ndarray u_l2g,
                                     numpy.ndarray r_l2g,
                                     numpy.ndarray u_dof,
                                     int offset_u, int stride_u,
                                     numpy.ndarray is_dof_external,
                                     numpy.ndarray is_dof_internal,
                                     numpy.ndarray num_hi,
                                     numpy.ndarray den_hi,
                                     numpy.ndarray global_hi,
                                     numpy.ndarray element_He,
                                     numpy.ndarray gamma_dof,
				     int numDOFs,
				     int NNZ,
				     numpy.ndarray rowptr,
				     numpy.ndarray colind):
        self.thisptr.calculateSmoothnessIndicator(< double * > mesh_trial_ref.data,
                                                  < double * > mesh_grad_trial_ref.data,
                                                  < double * > mesh_dof.data,
                                                  < int * > mesh_l2g.data,
                                                  < double * > dV_ref.data,
                                                  < double * > u_trial_ref.data,
                                                  < double * > u_grad_trial_ref.data,
                                                  < double * > u_test_ref.data,
                                                  < double * > u_grad_test_ref.data,
                                                  < double * > u_hess_trial_ref.data,
                                                  nElements_global,
                                                  < int * > u_l2g.data,
                                                  < int * > r_l2g.data,
                                                  < double * > u_dof.data,
                                                  offset_u, stride_u,
                                                  < double * > is_dof_external.data,
                                                  < double * > is_dof_internal.data,
                                                  < double * > num_hi.data,
                                                  < double * > den_hi.data,
                                                  < double * > global_hi.data,
                                                  < double * > element_He.data,
                                                  < double * > gamma_dof.data,
					          numDOFs,
					          NNZ,
					          < int* > rowptr.data,
					          < int* > colind.data)
