def ispc_cc_library(name, out, ispc_main_source_file, srcs, defines, target_compatible_with = [], **kwargs):
    generted_header_filename = out

    ispc_defines_list = ""
    if len(defines) <= 1:
        ispc_defines_list = " -D".join(defines)
    else:
        ispc_defines_list = "-D" + " -D".join(defines)

    native.genrule(
        name = "%s_ispc_gen" % name,
        srcs = srcs,
        outs = [name + ".o", generted_header_filename],
        cmd = select({
            "@platforms//os:linux": "$(location @ispc_linux_x86_64//:ispc) %s --target=avx2 --target-os=linux --arch=x86-64 --addressing=64 --pic $(locations %s) --header-outfile=$(location %s) -o $(location %s.o)" % (ispc_defines_list, ispc_main_source_file, generted_header_filename, name),
            "@platforms//os:osx": "$(location @ispc_osx_x86_64//:ispc) --target=avx2 --arch=x86-64 $(locations %s) --header-outfile=$(location %s) -o $(location %s.o)" % (ispc_main_source_file, generted_header_filename, name),
            "@platforms//os:windows": "$(location @ispc_windows_x86_64//:ispc) %s --target=avx2 --target-os=windows --arch=x86-64 --addressing=64 $(locations %s) --header-outfile=$(location %s) -o $(location %s.o)" % (ispc_defines_list, ispc_main_source_file, generted_header_filename, name),
        }),
        tools = select({
            "@platforms//os:linux": ["@ispc_linux_x86_64//:ispc"],
            "@platforms//os:osx": ["@ispc_osx_x86_64//:ispc"],
            "@platforms//os:windows": ["@ispc_windows_x86_64//:ispc"],
        }),
        target_compatible_with = target_compatible_with,
    )
    native.cc_library(
        name = name,
        srcs = [name + ".o"],
        hdrs = [name + ".h"],
        defines = defines,
        target_compatible_with = target_compatible_with,
        **kwargs
    )
