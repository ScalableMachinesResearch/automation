set -ex
LOC=`pwd`
git clone https://github.com/ScalableMachinesResearch/hpctoolkit.git &
git clone https://github.com/ScalableMachinesResearch/hpctoolkit-externals.git  &
wget https://github.com/ScalableMachinesResearch/viewer-linux/raw/master/released/hpcviewer-linux.gtk.x86_64.tgz  &
wget https://github.com/ScalableMachinesResearch/viewer-linux/raw/master/released/hpctraceviewer-linux.gtk.x86_64.tgz &
wait
cd $LOC/hpctoolkit-externals/
rm -rf BUILD
mkdir BUILD
cd BUILD
../configure --prefix=$LOC/hpctoolkit-externals-install
make -j
make install
cd $LOC/hpctoolkit
rm -rf BUILD BUILD_OPT
mkdir BUILD BUILD_OPT
cd BUILD
../configure --with-externals=$LOC/hpctoolkit-externals-install --prefix=$LOC/hpctoolkit-install  --enable-develop
make -j
make install
cd $LOC/hpctoolkit/BUILD_OPT
../configure --with-externals=$LOC/hpctoolkit-externals-install --prefix=$LOC/hpctoolkit-opt-install 
make -j
make install
#Uncomment below of the viewer 
#cd $LOC
#tar zxvf hpctraceviewer-linux.gtk.x86_64.tgz
#tar zxvf hpcviewer-linux.gtk.x86_64.tgz
#cd $LOC/hpctraceviewer
#./install $LOC/hpctraceviewer-install
#cd $LOC/hpcviewer
#./install $LOC/hpcviewer-install
echo "Add $LOC/hpctoolkit-opt-install to your PATH"
