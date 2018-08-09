# From https://github.com/envoyproxy/envoy/blob/master/bazel/README.md -- use latest bazel version
BAZEL_VERSION ?= 0.14.1
BAZEL_DOCKERFILE="https://raw.githubusercontent.com/clnperez/dockerfiles/master/bazel/Dockerfile"
ENVOY_BUILD :=bazel build --copt "-D __linux" @envoy//source/exe:envoy-static

ENVOY_COMMIT=`cat envoy_commit.bzl | cut -d \" -f 2`

DO_GET_EXTENSIONS ?= true

docker-bazel:
	docker build -t bazel:${BAZEL_VERSION} --build-arg BAZEL_RELEASE=${BAZEL_VERSION} ${BAZEL_DOCKERFILE} 

envoy-static:
	${ENVOY_BUILD}

#docker-envoy-static: docker-bazel
docker-envoy-static:
	if ${DO_GET_EXTENSIONS}; then ENVOY_COMMIT=${ENVOY_COMMIT} ./get_extensions.sh; fi
	#docker run -v `pwd`:`pwd` -w `pwd` bazel:${BAZEL_VERSION} ${ENVOY_BUILD}
	docker run -v `pwd`:/root/go/src/github.com/clnperez/envoy-ppc64le -w /root/go/src/github.com/clnperez/envoy-ppc64le bazel:${BAZEL_VERSION} ${ENVOY_BUILD}
