
BAZEL_VERSION := "0.12"
BAZEL_DOCKERFILE="https://raw.githubusercontent.com/clnperez/dockerfiles/master/bazel/Dockerfile"
ENVOY_BUILD :=bazel build --copt "-D __linux" @envoy//source/exe:envoy-static
ENVOY_COMMIT=c2baf348055284ac761d94e9a06bc37ebf8a3532


docker-bazel:
	docker build -t bazel:${BAZEL_VERSION} --build-arg BAZEL_RELEASE=${BAZEL_VERSION} ${BAZEL_DOCKERFILE} 

envoy-static:
	${ENVOY_BUILD}

docker-envoy-static: docker-bazel
	docker run -v `pwd`:`pwd` -w `pwd` bazel:${BAZEL_VERSION} ${ENVOY_BUILD}
