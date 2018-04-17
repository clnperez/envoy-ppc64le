workspace(name = "envoy_build_config")

# when updating, re-sync source/extensions/extensions_build_config.bzl
# and remove any exentions (currently only lua)
http_archive(
    name = "envoy",
    strip_prefix="envoy-cef07618939cdaf25fbc3be7646b6fdbbe780f45",
    sha256 ="70aa1a7bb228eb7ebb00944b48cc09336ce89319c23afedd0270f1b964032dfc",
    urls = ["https://github.com/envoyproxy/envoy/archive/cef07618939cdaf25fbc3be7646b6fdbbe780f45.zip"],
)
local_repository(
    name = "envoy_build_config",
    path = "./",
) 

load("@envoy//bazel:repositories.bzl", "envoy_dependencies")
load("@envoy//bazel:cc_configure.bzl", "cc_configure")

envoy_dependencies(
   skip_targets=['luajit']
)

cc_configure()

load("@envoy_api//bazel:repositories.bzl", "api_dependencies")
api_dependencies()

load("@io_bazel_rules_go//go:def.bzl", "go_rules_dependencies", "go_register_toolchains")
load("@com_lyft_protoc_gen_validate//bazel:go_proto_library.bzl", "go_proto_repositories")
go_proto_repositories(shared=0)
go_rules_dependencies()
go_register_toolchains(go_version="host")
