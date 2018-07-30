#!/bin/bash

set -x
curl -fsSL https://raw.githubusercontent.com/envoyproxy/envoy/${ENVOY_COMMIT}/source/extensions/extensions_build_config.bzl -o extensions_build_config.bzl
sed -i '/lua/d' extensions_build_config.bzl
