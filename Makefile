# From https://github.com/envoyproxy/envoy/blob/master/bazel/README.md -- use latest bazel version
BAZEL_VERSION ?= 0.14.1
BAZEL_DOCKERFILE="https://raw.githubusercontent.com/clnperez/dockerfiles/master/bazel/Dockerfile"
ENVOY_BUILD :=bazel build --copt "-D __linux" @envoy//source/exe:envoy-static

## for now -- don't forget to also update this in WORKSPACE!
ENVOY_COMMIT ?= c2baf348055284ac761d94e9a06bc37ebf8a3532
DO_GET_EXTENSIONS ?= true

docker-bazel:
	docker build -t bazel:${BAZEL_VERSION} --build-arg BAZEL_RELEASE=${BAZEL_VERSION} ${BAZEL_DOCKERFILE} 

envoy-static:
	${ENVOY_BUILD}

#docker-envoy-static: docker-bazel
docker-envoy-static:
	if ${DO_GET_EXTENSIONS}; then ENVOY_COMMIT=${ENVOY_COMMIT} ./get_extensions.sh; fi
	docker run -v `pwd`:`pwd` -w `pwd` bazel:${BAZEL_VERSION} ${ENVOY_BUILD}
