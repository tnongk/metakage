{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    (texlive.combine {
      inherit (texlive) scheme-infraonly 
      tex xetex metafont mfware metapost ; }) ];

  shellHook = ''
    if [ ! -d syotai ]; then
      mkdir syotai
    fi

    if [ ! -f syotai/NotoSansCJKjpRegular.otf ]; then
      echo "NotoSansCJKjp-Regular.otf を取得します…"
      curl -L \
        -o syotai/NotoSansCJKjpRegular.otf \
        https://github.com/notofonts/noto-cjk/raw/refs/heads/main/Sans/OTF/Japanese/NotoSansCJKjp-Regular.otf
    fi
    if [ ! -f syotai/NotoSerifCJKjpRegular.otf ]; then
      echo "NotoSerifCJKjp-Regular.otf を取得します…"
      curl -L \
        -o syotai/NotoSerifCJKjpRegular.otf \
        https://github.com/notofonts/noto-cjk/raw/refs/heads/main/Serif/OTF/Japanese/NotoSerifCJKjp-Regular.otf
    fi
  '';
}