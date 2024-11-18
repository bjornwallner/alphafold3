# Copyright 2024 DeepMind Technologies Limited
#
# AlphaFold 3 source code is licensed under CC BY-NC-SA 4.0. To view a copy of
# this license, visit https://creativecommons.org/licenses/by-nc-sa/4.0/
#
# To request access to the AlphaFold 3 model parameters, follow the process set
# out at https://github.com/google-deepmind/alphafold3. You may only use these
# if received directly from Google. Use is subject to terms of use available at
# https://github.com/google-deepmind/alphafold3/blob/main/WEIGHTS_TERMS_OF_USE.md

"""Script for building intermediate data."""

from importlib import resources

import alphafold3.constants.converters
from alphafold3.constants.converters import ccd_pickle_gen
from alphafold3.constants.converters import chemical_component_sets_gen
import share.libcifpp

import sys
def build_data():
  
  cif_path = resources.files(share.libcifpp).joinpath('components.cif')
  out_roots = resources.files(alphafold3.constants.converters)
  for path in out_roots._paths:
    if 'conda' not in str(path):
       out_root=path
    #print(dir(path))
  #  print(path)
  print(out_root)
  #sys.exit()
  ccd_pickle_path = out_root.joinpath('ccd.pickle')
  print(ccd_pickle_path)
  #sys.exit()
  chemical_component_sets_pickle_path = out_root.joinpath(
      'chemical_component_sets.pickle'
  )
  ccd_pickle_gen.main(['', str(cif_path), str(ccd_pickle_path)])
  chemical_component_sets_gen.main(
      ['', str(chemical_component_sets_pickle_path)]
  )
