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

  py::class_<cppSystem>(m, "cSystem")
    .def(py::init())
    .def("step", &cppSystem::step)
    .def("setDirectory", &cppSystem::setDirectory)
    .def("setTimestepperType", &cppSystem::setTimestepperType)
    .def("setCollisionEnvelopeMargin", &cppSystem::setCollisionEnvelopeMargin)
    .def("addMesh", &cppSystem::addMesh)
    .def("getTwoPhaseScaledMassOperator", &cppSystem::getTwoPhaseScaledMassOperator);

  py::class_<cppRigidBody>(m, "cRigidBody")
    .def(py::init())
    .def("hx", &cppRigidBody::hx)
    .def("hy", &cppRigidBody::hy)
    .def("hz", &cppRigidBody::hz)
    .def("calculate_init", &cppRigidBody::calculate_init)
    .def("prestep", &cppRigidBody::prestep)
    .def("poststep", &cppRigidBody::poststep)
    .def("setConstraints", &cppRigidBody::setConstraints)
    .def("addSpring", &cppRigidBody::addSpring)
    .def("addPrismaticLinksWithSpring", &cppRigidBody::addPrismaticLinksWithSpring)
    .def("addPrismaticLinkX", &cppRigidBody::addPrismaticLinkX)
    .def("setName", &cppRigidBody::setName)
    .def("setPrescribedMotionPoly", &cppRigidBody::setPrescribedMotionPoly)
    .def("setPrescribedMotionSine", &cppRigidBody::setPrescribedMotionSine)
    .def("setPrescribedMotionCustom", &cppRigidBody::setPrescribedMotionCustom)
    .def("getTriangleMeshSDF", &cppRigidBody::getTriangleMeshSDF)
    .def("getTriangleMeshVel", &cppRigidBody::getTriangleMeshVel)
    .def("updateTriangleMeshVisualisationPos", &cppRigidBody::updateTriangleMeshVisualisationPos)
}
