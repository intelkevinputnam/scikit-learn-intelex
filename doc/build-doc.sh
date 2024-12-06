#!/bin/bash
#===============================================================================
# Copyright 2021 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#===============================================================================

SAMPLES_DIR=sources/samples

# remove the samples folder if it exists
if [ -d "$SAMPLES_DIR" ]; then rm -Rf $SAMPLES_DIR; fi

# create a samples folder
mkdir $SAMPLES_DIR

# copy jupyter notebooks
cd ..
rsync -a --exclude='doc/$SAMPLES_DIR/daal4py_data_science.ipynb' examples/notebooks/*.ipynb doc/$SAMPLES_DIR

cd doc

source ./set_version.sh #export DOC_VERSION=$(python3 -c "from get_doc_version import get_version; print(get_version())")
export SPHINXPROJ=scikit-learn-intelex
export BUILDDIR=_build
export SOURCEDIR=sources

echo $DOC_VERSION
echo $SPHINXPROJ
echo $BUILDDIR
echo $SOURCEDIR

sphinx-build -b html $SOURCEDIR $BUILDDIR/$SPHINXPROJ/$DOC_VERSION
cp versions.json $BUILDDIR/$SPHINXPROJ
echo "<meta http-equiv=\"refresh\" content=\"0; URL='/$SPHINXPROJ/$DOC_VERSION/'\" / >" >> $BUILDDIR/$SPHINXPROJ/index.html

# to build the docs locally, uncomment the following lines
# cd doc
# make html
