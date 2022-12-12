before_install export_texlive_install_platform

export_texlive_install_platform() {
    local uarch=$(echo $(uname -m)-$(uname -s))
    [ "${uarch}" = "arm64-Darwin" ] || return 0

    ## auto-detect TeX Live VERSION_NAME
    local detected_version_name
    case "$VERSION_NAME" in
        [0-9][0-9][0-9][0-9])
            detected_version_name=${VERSION_NAME}
            ;;
        [0-9][0-9][0-9][0-9]-*)
            detected_version_name=${VERSION_NAME%-*}
            ;;
        *-[0-9][0-9][0-9][0-9])
            detected_version_name=${VERSION_NAME#*-}
            ;;
        [0-9][0-9][0-9][0-9].*)
            detected_version_name=${VERSION_NAME%.*}
            ;;
    esac

    ## set install-tl -force-platform <platform>
    case "${detected_version_name}" in
        2012|201[7-9])
            export TEXLIVE_INSTALL_PLATFORM=x86_64-darwin
            ;;
        *)
            ;;
    esac
}
