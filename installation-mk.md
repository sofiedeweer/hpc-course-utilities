# Installation of dependencies: mk modules

### 1. What are mk modules?

[mk modules](https://github.com/elauksap/mk) bundle a set of scientific libraries compiled under the same toolchain. Once installed, they provide the command module, that has several subcommands:
- `module load`: loads the requested module. This creates a set of environment variables storing relevant paths for that library (e.g. `mkEigenPrefix`, `mkEigenInc`, ...). Use  `export | grep "mk "`  to obtain a list
- `module list`: shows a list of currently loaded modules
- `module avail`: shows a list of all available modules (loaded or not)

### 2. Install on a native linux distribution

If you have a computer with a linux operating system, you can install mk modules directly. Otherwise, skip to step 3.
1. download the [latest release](https://github.com/elauksap/mk/releases)
2. extract it:
```bash
sudo tar xzvf mk-version.tar.gz -C /
```
3. modify your `~/.bashrc` file by adding
```bash
# mk.
export mkPrefix=/u/sw/
source ${mkPrefix}/etc/profile
module load gcc-glibc
# module load <module_name> for any other needed module
```

### 3. Install using Docker

For computers running on Mac or Windows, you can obtain mk modules through a Docker image:

1. install Docker following the instruction on the [official guide](https://docs.docker.com/get-docker/)
2. pull the Docker imagee:
```bash
sudo docker pull elauksap/mk
```
3. whenever needed, start and connect to the Docker container with
```bash
sudo docker run -it elauksap/mk
```
4. to share a folder between the Docker container and the host,
```bash
mkdir ~/shared-folder
sudo docker run -it -v ~/shared-folder:/root/shared-folder elauskap/mk
```
The files and folders within `~/shared-folder` on the host will be made available at `/root/shared-folder` within the container.

### 4. Test the installation

1. Create a file `test-installation.cpp` with content:
```cpp
#include <Eigen/Eigen>
#include <iostream>
int main(int argc, char** argv)
  {
    std::cout << "Successfully included Eigen." << std::endl;
    return 0;
  }
```

2. make sure the Eigen module is loaded: `module load eigen`

3. compile and run the test:
```bash
g++ -I ${mkEigenInc} test-installation.cpp -o test-installation
./test-installation
```
