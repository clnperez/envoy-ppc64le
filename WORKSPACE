workspace(name = "envoy_build_config")

# when updating, re-sync source/extensions/extensions_build_config.bzl
# and remove any exentions (currently only lua)
http_archive(
    name = "envoy",
    strip_prefix="envoy-337b293e4231ef4bab4a0afbce10417f1280f04c",
    sha256 ="ffd622e587f148d4ac70c7242d815a2498b734b119fba05440998fabff2ac0b9",
    urls = ["https://github.com/envoyproxy/envoy/archive/337b293e4231ef4bab4a0afbce10417f1280f04c.zip"],
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
