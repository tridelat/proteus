#include "pybind11/pybind11.h"
#include "pybind11/stl_bind.h"

#define FORCE_IMPORT_ARRAY
#include "ProtChBody.h"

#if defined(__GNUC__) && !defined(__clang__)
namespace workaround
{
  inline void define_allocators()
  {
    std::allocator<int> a0;
    std::allocator<double> a1;
  }
}
#endif

namespace py = pybind11;
using proteus::RANS2P_base;

PYBIND11_MODULE(cRigidBody, m)
{
  xt::import_numpy();

  py::class_<cppCable>(m, "cCable")
    .def(py::init())
    .def("setFluidVelocityAtNodes", &cppCable::setFluidVelocityAtNodes)
    .def("setFluidAccelerationAtNodes", &cppCable::setFluidAccelerationAtNodes)
    .def("setFluidDensityAtNodes", &cppCable::setFluidDensityAtNodes)
    .def("getNodalPositions", &cppCable::getNodalPositions)
    .def("buildVectors", &cppCable::buildVectors)
    .def("buildNodes", &cppCable::buildNodes)
    .def("buildElements", &cppCable::buildElements)
    .def("buildMesh", &cppCable::buildMesh)
    .def("setDragForce", &cppCable::setDragForce)
    .def("setAddedMassForce", &cppCable::setAddedMassForce)
    .def("applyForces", &cppCable::applyForces)
    .def("addNodestoContactCloud", &cppCable::addNodestoContactCloud)
    .def("setDragCoefficients", &cppCable::setDragCoefficients)
    .def("setAddedMassCoefficients", &cppCable::setAddedMassCoefficients)
    .def("setRestLengthPerElement", &cppCable::setRestLengthPerElement)
    .def("setIyy", &cppCable::setIyy)

  py::class_<cppMultiSegmentedCable>(m, "cMultiSegmentedCable")
    .def(py::init())
    .def("setFluidVelocityAtNodes", &cppMultiSegmentedCable::setFluidVelocityAtNodes)
    .def("setFluidAccelerationAtNodes", &cppMultiSegmentedCable::setFluidAccelerationAtNodes)
    .def("setFluidDensityAtNodes", &cppMultiSegmentedCable::setFluidDensityAtNodes)
    .def("updateDragForces", &cppMultiSegmentedCable::updateDragForces)
    .def("updateAddedMassForces", &cppMultiSegmentedCable::updateAddedMassForces)
    .def("applyForces", &cppMultiSegmentedCable::applyForces)
    .def("getNodalPositions", &cppCable::getNodalPositions)
    .def("buildNodes", &cppCable::buildNodes)
    .def("buildElements", &cppCable::buildElements)
    .def("buildCable", &cppCable::buildCable)
    .def("getForceFairelad", &cppCable::getForceFairlead)
    .def("attachBackNodeToBody", &cppCable::attachBackNodeToBody)
    .def("attachFrontNodeToBody", &cppCable::attachFrontNodeToBody)
    .def("setContactMaterial", &cppCable::setContactMaterial)
    .def("buildNodesCloud", &cppCable::buildNodesCloud)
    .def("getTensionElement", &cppCable::getTensionElement)
}
