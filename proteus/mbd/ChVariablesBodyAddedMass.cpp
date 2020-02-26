// =============================================================================
// PROJECT CHRONO - http://projectchrono.org
//
// Copyright (c) 2014 projectchrono.org
// All rights reserved.
//
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file at the top level of the distribution and at
// http://projectchrono.org/license-chrono.txt.
//
// =============================================================================
// Authors: Tristan de Lataillade
// =============================================================================

#include "ChVariablesBodyAddedMass.h"

namespace chrono {

// Register into the object factory, to enable run-time dynamic creation and persistence
CH_FACTORY_REGISTER(ChVariablesBodyAddedMass)

ChVariablesBodyAddedMass::ChVariablesBodyAddedMass() : ndof(6) {
    Maddedmass = ChMatrixDynamic<>(ndof, ndof);
    Maddedmass.setIdentity();
    Mmass = ChMatrixDynamic<>(ndof, ndof);
    Mmass.setIdentity();
    Mfullmass = ChMatrixDynamic<>(ndof, ndof);
    Mfullmass.setIdentity();
    inv_Mfullmass = ChMatrixDynamic<>(ndof, ndof);
    inv_Mfullmass.setIdentity();
}

ChVariablesBodyAddedMass& ChVariablesBodyAddedMass::operator=(const ChVariablesBodyAddedMass& other) {
    if (&other == this)
        return *this;

    // copy parent class data
    ChVariablesBodyOwnMass::operator=(other);

    // copy class data
    Mmass = other.Mmass;
    Maddedmass = other.Maddedmass;
    Mfullmass = other.Mfullmass;
    inv_Mfullmass = other.inv_Mfullmass;
    return *this;
}

void ChVariablesBodyAddedMass::SetMfullmass(ChMatrixDynamic<>& Mfullmass_in) {
  GetLog() << "M" << GetMfullmass() << "\n";
  GetLog() << "inv_M" << GetInvMfullmass() << "\n";
    assert(Mfullmass_in.GetRows() == Get_ndof());
    assert(Mfullmass_in.GetColumns() == Get_ndof());
    GetMfullmass() = Mfullmass_in;
    GetInvMfullmass() = Mfullmass_in.inverse();
    GetLog() << "M_in" << Mfullmass_in << "\n";
    GetLog() << "M" << GetMfullmass() << "\n";
    GetLog() << "inv_M" << GetInvMfullmass() << "\n";
}

  // Set the inertia matrix
  // void ChVariablesBodyAddedMass::SetBodyInertia(const ChMatrix33<>& minertia) {
  //   ChVariablesBodyOwnMass::SetBodyInertia(minertia);
  //   GetLog() << "JUST SET " << ChVariablesBodyOwnMass::GetBodyInertia();
  //   GetLog() << "JUST SET 2 " << GetBodyInertia();
  // }

  // // Set the mass associated with translation of body
  // void ChVariablesBodyAddedMass::SetBodyMass(const double mmass) {
  //   ChVariablesBodyOwnMass::SetBodyMass(mmass);
  // }
// /// Set the inertia matrix
// void ChVariablesBodyAddedMass::SetBodyInertia(const ChMatrix33<>& minertia) {
//     ChVariablesBodyOwnMass::SetBodyInertia(minertia);
//     /// Add inertia to mass matrix
//     ChMatrix33<>& bodyinertia = ChVariablesBodyOwnMass::GetBodyInertia();
//     for (int i = 0; i < 3; i++) {
//         for (int j = 0; j < 3; j++) {
//             Mmass(3 + i, 3 + j) = bodyinertia(i, j);
//         }
//     }
//     Mfullmass = Mmass + Maddedmass;
// }


// /// Set the mass associated with translation of body
// void ChVariablesBodyAddedMass::SetBodyMass(const double mmass) {
//     /// Value of mass as double
//     ChVariablesBodyOwnMass::SetBodyMass(mmass);
//     /// Value of mass in mass matrix
//     Mmass(0, 0) = mmass;
//     Mmass(1, 1) = mmass;
//     Mmass(2, 2) = mmass;
//     /// rebuild full mass matrix
//     Mfullmass = Mmass + Maddedmass;
// }

// /// Set the added mass matrix of the body (6x6)
// void ChVariablesBodyAddedMass::SetBodyAddedMass(ChMatrixDynamic<>& Maddedmass_in) {
//     assert(Maddedmass_in.GetRows() == Get_ndof());
//     assert(Maddedmass_in.GetColums() == Get_ndof());
//     Maddedmass.CopyFromMatrix(Maddedmass_in);
//     /// rebuild full mass matrix
//     Mfullmass = Mmass + Maddedmass;
// }

// Computes the product of the inverse mass matrix by a
// vector, and set in result: result = [invMb]*vect
void ChVariablesBodyAddedMass::Compute_invMb_v(ChVectorRef result, const ChVectorConstRef vect) const {
    assert(vect.size() == Get_ndof());
    assert(result.size() == Get_ndof());
    result = inv_Mfullmass * vect;
}

// Computes the product of the inverse mass matrix by a
// vector, and increment result: result += [invMb]*vect
void ChVariablesBodyAddedMass::Compute_inc_invMb_v(ChVectorRef result, const ChVectorConstRef vect) const {
    assert(vect.size() == Get_ndof());
    assert(result.size() == Get_ndof());
    result += inv_Mfullmass * vect;
}

// Computes the product of the mass matrix by a
// vector, and set in result: result = [Mb]*vect
void ChVariablesBodyAddedMass::Compute_inc_Mb_v(ChVectorRef result, const ChVectorConstRef vect) const {
    assert(vect.size() == Get_ndof());
    assert(result.size() == Get_ndof());
    result += Mfullmass * vect;
}

// Computes the product of the corresponding block in the
// system matrix (ie. the mass matrix) by 'vect', scale by c_a, and add to 'result'.
// NOTE: the 'vect' and 'result' vectors must already have
// the size of the total variables&constraints in the system; the procedure
// will use the ChVariable offsets (that must be already updated) to know the
// indexes in result and vect.
void ChVariablesBodyAddedMass::MultiplyAndAdd(ChVectorRef result,
    const ChVectorConstRef vect,
    const double c_a) const {
    ChMatrixDynamic<> tot = ChMatrixDynamic<>(6, 1);
    tot(0, 0) = vect(this->offset+0);
    tot(1, 0) = vect(this->offset+1);
    tot(2, 0) = vect(this->offset+2);
    tot(3, 0) = vect(this->offset+3);
    tot(4, 0) = vect(this->offset+4);
    tot(5, 0) = vect(this->offset+5);
    tot = Mfullmass*tot*c_a;
    result(this->offset+0) = tot(1, 0);
    result(this->offset+1) = tot(2, 0);
    result(this->offset+2) = tot(3, 0);
    result(this->offset+3) = tot(4, 0);
    result(this->offset+4) = tot(5, 0);
    result(this->offset+5) = tot(6, 0);
}

// Add the diagonal of the mass matrix scaled by c_a to 'result'.
// NOTE: the 'result' vector must already have the size of system unknowns, ie
// the size of the total variables&constraints in the system; the procedure
// will use the ChVariable offset (that must be already updated) as index.
void ChVariablesBodyAddedMass::DiagonalAdd(ChVectorRef result, const double c_a) const {
    assert(result.GetColumns() == 1);
    for (int i = 0; i < Get_ndof(); i++) {
        result(this->offset + i) += c_a * Mfullmass(i, i);
    }
}

// Build the mass matrix (for these variables) scaled by c_a, storing
// it in 'storage' sparse matrix, at given column/row offset.
// Note, most iterative solvers don't need to know mass matrix explicitly.
// Optimized: doesn't fill unneeded elements except mass and 3x3 inertia.
void ChVariablesBodyAddedMass::Build_M(ChSparseMatrix& storage, int insrow, int inscol, const double c_a) {
    for (int row = 0; row < Get_ndof(); ++row)
        for (int col = 0; col < Get_ndof(); ++col)
            storage.SetElement(insrow + row, inscol + col, c_a * Mfullmass(row, col));
}

}  // end namespace chrono
