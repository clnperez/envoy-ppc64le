# envoy-ppc64le
Build envoy for Power

##  LUAJIT Restrictions
The luajit compiler has no ppc64le support, so we need to skip that extension when building.

See https://github.com/envoyproxy/envoy/blob/master/bazel/README.md#disabling-extensions
and https://github.com/envoyproxy/envoy/pull/3002 for more info.

### Usage
` bazel build --copt "-D __linux" @envoy//source/exe:envoy-static`  
TODO: Remove the `copt` flag when backward-cpp PR is merged & picked up into envoy.

Note: currently this builds a set commit of envoy. If you want to change it, you have to change the envoy commit in `envoy_commit.bzl`.

### Known issues:
1. profiler not built for gperftools with gcc 5 when run using envoy's bazel build config.
error seen when building envoy: `external/envoy/source/common/profiler/profiler.cc:8:33: fatal error: gperftools/profiler.h: No such file or directory`
The actual issue hasn't been pin-pointed, but running this with a newer gcc (e.g. 6.x on debian stretch) gets me around this one. I think that something is configured in a way that incorrectly sets the library path, and `ucontext.h` isn't found. As a result the program counter is not found when ac_check_header is run by autoconf during the build of gperftools. As a result, `gperftools/profiler.h` isn't put into the sandbox.
I see this in gperftools.dep.log from the envoy build sandbox: `checking how to access the program counter from a struct ucontext... configure: WARNING: Could not find the PC.  Will not try to compile libprofiler... `

2. backward-cpp:  
gcc defines `__linux__` for ppc64le when building with `-std=c++0x`, which the envoy build sets. backward-cpp checks whether `__linux` is defined.
To get around the problem, just define that using bazel's `copt` flag:
`bazel build --copt "-D __linux" @envoy//source/exe:envoy-static`  
PR submitted here: https://github.com/bombela/backward-cpp/pull/104

3. gcc not found in path when building bazel-gazelle:
This is fixed in upstream rules_go, and there is currently a PR open to update rules_go in envoy. If you need to patch earlier rules_go, you can follow the instructions found here: https://github.com/clnperez/envoy-ppc64le/issues/4#issuecomment-411799295 


4. `multiple definition of 'StacktracePowerPCDummyFunction()'`
One project copied code from another, and didn't rename this function. I submitted a patch here: https://github.com/abseil/abseil-cpp/pull/152 and it's been picked up in envoy via https://github.com/envoyproxy/envoy/pull/4034. If you're building older envoy on Power, you can change that file in your sandbox by just replacing StacktracePowerPCDummyFunction with AbslStacktracePowerPCDummyFunction.
