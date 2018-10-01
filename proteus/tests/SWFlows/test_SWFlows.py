#!/usr/bin/env python
"""
Test module for SWFlows
"""
import os
import pytest
import tables
import numpy as np

class TestSWFlows(object):

    def setup_method(self,method):
        self._scriptdir = os.path.dirname(__file__)

    def test_solitary(self):
        # call runSWEs
        os.system("parun --SWFlows -f solitary.py -C 'final_time=2 dt_output=1.0 refinement=2'")
        # COMPARE VS SAVED FILES #
        expected_path = 'comparison_files/solitary.h5'
        expected = tables.open_file(os.path.join(self._scriptdir,expected_path))
        actual = tables.open_file('solitary.h5','r')
        assert np.allclose(expected.root.h_t3,actual.root.h_t3,atol=1e-10)
        expected.close()
        actual.close()

    def test_parab1D(self):
        # Call runSWEs
        os.system("parun --SWFlows -f parab1D.py -C 'final_time=100 dt_output=10 refinement=2'")
        # COMPARE VS SAVED FILES #
        expected_path = 'comparison_files/parab1D.h5'
        expected = tables.open_file(os.path.join(self._scriptdir,expected_path))
        actual = tables.open_file('parab1D.h5','r')
        assert np.allclose(expected.root.h_t11,actual.root.h_t11,atol=1e-10)
        expected.close()
        actual.close()

    def test_dam3Bumps(self):
        # Call runSWEs
        os.system("parun --SWFlows -f dam3Bumps.py -C 'final_time=3 dt_output=1 refinement=2'")
        # COMPARE VS SAVED FILES #
        expected_path = 'comparison_files/dam3Bumps.h5'
        expected = tables.open_file(os.path.join(self._scriptdir,expected_path))
        actual = tables.open_file('dam3Bumps.h5','r')
        assert np.allclose(expected.root.h_t4,actual.root.h_t4,atol=1e-10)
        expected.close()
        actual.close()
