workspace(name = "envoy_build_config")

# when updating, re-sync source/extensions/extensions_build_config.bzl
# and remove any exentions (currently only lua)
http_archive(
    name = "envoy",
    strip_prefix="envoy-c2baf348055284ac761d94e9a06bc37ebf8a3532",
    sha256 ="f8ffbd5f01f9d3c0b1d2d826e7ca0a80f1a83127392ecd4b7d6cd2e6fe28a006",
    urls = ["https://github.com/envoyproxy/envoy/archive/c2baf348055284ac761d94e9a06bc37ebf8a3532.zip"],
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
