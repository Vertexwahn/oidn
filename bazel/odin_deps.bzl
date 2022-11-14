## Copyright 2018-2021 Intel Corporation
## SPDX-License-Identifier: Apache-2.0

## DISCLAIMER: Bazel support is community-based. The maintainers do not
## use Bazel internally. The Bazel build can have security risks or
## optimization gaps.

"""External dependencies for odin."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def odin_deps():
    """Fetches dependencies of odin."""

    maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
        ],
        sha256 = "74d544d96f4a5bb630d465ca8bbcfe231e3594e5aae57e1edbf17a6eb3ca2506",
    )

    #maybe(
    #    http_archive,
    #    name = "mkl_dnn_v1",
    #    build_file = "//bazel/third_party/mkl_dnn:mkldnn_v1.BUILD",
    #    sha256 = "5369f7b2f0b52b40890da50c0632c3a5d1082d98325d0f2bff125d19d0dcaa1d",
    #    strip_prefix = "oneDNN-1.6.4",
    #    urls = [
    #        "https://storage.googleapis.com/mirror.tensorflow.org/github.com/oneapi-src/oneDNN/archive/v1.6.4.tar.gz",
    #        "https://github.com/oneapi-src/oneDNN/archive/v1.6.4.tar.gz",
    #    ],
    #)

    # Does not work
    maybe(
        http_archive,
        name = "mkl_dnn_v1",
        build_file = "//bazel/third_party/mkl_dnn:mkldnn_v1.BUILD",
        sha256 = "dc2b9bc851cd8d5a6c4622f7dc215bdb6b32349962875f8bf55cceed45a4c449",
        strip_prefix = "oneDNN-2.7.1",
        urls = [
            "https://github.com/oneapi-src/oneDNN/archive/refs/tags/v2.7.1.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "oneTBB",
        urls = [
            "https://github.com/oneapi-src/oneTBB/archive/f2af74732ba7b303f23a2f453051a52a63560a75.zip",
        ],
        strip_prefix = "oneTBB-f2af74732ba7b303f23a2f453051a52a63560a75",
        sha256 = "bed8a9ca62c8b4a20e9d51e9090a06fc6402287ace8ef5e830d0f306af2ddcd7",
    )
