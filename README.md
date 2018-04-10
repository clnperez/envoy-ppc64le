# envoy-ppc64le
Build envoy for Power

##  LUAJIT Restrictions
Right now, we need to compile only the core extensions for Power. The luajit compiler has no ppc64le support.

See https://github.com/envoyproxy/envoy/blob/master/bazel/README.md#disabling-extensions
and https://github.com/envoyproxy/envoy/pull/3002 for more info.
