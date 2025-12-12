# 越影（こゆかげ, metakage）

KAGE 形式を METAFONT 処理して TeX で多様な文字をより簡単に印字

## 概要
これは、[GlyphWiki](https://glyphwiki.org/)で用いられる漢字字形記述形式 KAGE に対するMETAFONTによる字形処理器です（[kamichikoichi/kage-engine](https://github.com/kamichikoichi/kage-engine) の再構築的かつ再解釈的な移植とも言えます）。ただし、部品の引用機能は未完成で、また、各種の線を引くのみであり、止め、はね、払いなども（現状では）ありません。

稀な漢字、（独自の）創作漢字、減字（琴の楽譜で使われる文字）、その他の文字など、符号化や字形化されていない文字を、TeX 文書で印字したり、[DavidFangWJ/open_metafog](https://github.com/DavidFangWJ/open_metafog) 経由で書体形式（ttf, otf等）化するのに役立ちます。

方針としては、（現状では）見た目の細部にはこだわらず、多様な文字を METAFONT や TeX で楽に（簡単に）扱えることに重きを置いています。
kage-engine の移植としては不完全ですが、METAFONT で多くの文字が扱いやすくなることに意義を置いています。

## 成果
用例：左側のNotoは既存の書体（比較用）、右側の2字が越影による字形。

爨は、画数の多い漢字の例として。「TeXの花」は創作漢字。
![](https://github.com/user-attachments/assets/607d8e8a-2737-4252-a312-815c3d8ce9fc)

原文
```a.tex
%xetex
\newwrite\fontfile
\immediate\openout\fontfile=kasigu.mf
\catcode`\^^M=\active \def^^M{ } \catcode`\#=12 \immediate\write\fontfile{
input metakage.mf;
kage(41,"1:12:32:75:22:75:73$1:2:2:75:22:125:22$1:22:32:125:22:125:73$1:2:0:75:35:115:35$1:0:2:75:46:104:46$1:22:23:104:46:104:60$1:0:2:75:60:104:60$2:0:7:60:19:50:23:32:28$1:12:32:32:28:34:73$1:2:0:33:41:64:41$1:2:0:33:56:64:56$1:0:2:140:24:168:24$1:22:32:168:24:166:73$1:0:2:136:41:167:41$1:0:2:136:56:167:56$2:7:8:24:66:25:84:16:92$1:2:2:26:73:178:73$2:22:7:178:73:174:79:162:92$1:0:0:30:92:100:92$1:0:0:63:77:63:124$2:32:7:62:92:50:110:22:123$2:7:8:63:98:77:102:86:111$1:0:0:103:92:170:92$1:0:0:134:77:134:124$2:32:7:133:92:124:109:100:123$2:7:8:134:96:154:104:166:116$1:0:0:18:129:182:129$2:0:7:99:111:69:147:11:164$2:7:0:119:129:148:151:179:157$2:7:8:74:141:73:159:59:167$2:0:7:137:147:130:158:118:169$2:0:7:103:136:102:181:26:188$2:7:8:94:164:140:174:164:185");
kage(42,"1:0:0:12:33:186:33$1:0:0:71:12:71:54$1:0:0:127:12:127:54$2:0:7:66:63:35:90:6:103$1:0:0:39:86:39:166$1:12:13:72:93:72:180$1:2:2:72:93:118:93$1:2:2:72:136:118:136$1:2:2:72:180:118:180$2:0:7:178:67:161:133:105:164$3:0:5:137:64:137:154:185:154");
end
} \catcode`\^^M=5 \catcode`\#=6
\immediate\closeout\fontfile

\font\gtten=["syotai/NotoSansCJKjpRegular.otf"]
\font\kasigu="kasigu"
\vbox{\halign{\vrule height 10pt width 0pt depth 2pt~\hfil#\hfil~\vrule&~\hfil#\hfil~\cr
\gtten Notoゴシック&\gtten 越影\cr\noalign{\hrule}
\gtten 飯盒炊「爨」&{\kasigu\lower1pt\hbox{\char41}}\cr
\gtten \TeX の花&{\kasigu\lower1pt\hbox{\char42}}\cr
}}
\bye
```



## 使い方
対応環境：METAFONTが使える全ての TeX で使えるはずです。（TeX, LuaTeX, XeTeX, pdfTeX, pTeX, 各種LaTeX等）

### 一　kage 形式の文字列を作る
`1:12:32:75:22:75:73$1:2:2:75:22:125:22$1:22:32:125:22:125:73`のような kage 形式の文字列を作ります。
改行を使わず`$`で行を区切ります。現状では、部品引用の記述を含まない必要があります。

kage 形式を作るには[GlyphWiki](https://glyphwiki.org/)の編集画面（投稿直前の画面で得られる）や[字統网 zi.tools](https://zi.tools/?secondary=ids)（「GW」ボタンURLの`#data=`以降）が便利です（ただし字統网では細かい編集はdataに反映されないかも）。

[KAGE engine sample](https://kurgm.github.io/kage-engine/)で確かめられます。

### 二　METAFONT で字形化し、TeXで印字
本企画から`metakage.mf`を取得し、TeX 原文書（ソースファイル）と同じ場所に置きます。

```kasigu.mf
input metakage.mf; kage(41, "1:12:32:75:22:75:73$1:2:2:75:22:125:22"); end
```
のような METAFONT 原文書（例：`kasigu.mf`）を作り、
`\font\kasigu="kasigu" {\kasigu\lower1pt\hbox{\char41}}`
のように TeX から使います。

次のように、TeX 原文の中で書き込み機能を使って`.mf`を作っても良いです（参考：[LaTeX Stack Exchange](https://tex.stackexchange.com/questions/506188/relationship-between-tex-and-metafont-with-parametric-variations)）。
```
\newwrite\fontfile
\immediate\openout\fontfile=kasigu.mf
\catcode`\^^M=\active \def^^M{ } \catcode`\#=12 \immediate\write\fontfile{
input metakage.mf;kage(41,"...");end
} \catcode`\^^M=5 \catcode`\#=6
\immediate\closeout\fontfile
```
更新するときは、pk, tfmを 削除します。

### 将来
部品引用機能ができれば、外部の仕組み（字形編集器など）に頼らず、予め保存した基本部品を組み合わせて造字できるようになります。（より理想的）

（でも、現状でも自由に造字できる環境は一応できました。GlyphWiki の投稿直前画面を使えばいいです。）

## 許諾
kage-engineはGPLですが、越影は、KAGE 形式を（再）解釈して始めから作っているので許諾継承せず、より緩い「マサチューセッツ工科大学式許諾」（MIT許諾）としています。

## やること（参加してください）
- [ ] 引用機能
- [ ] metapost対応（簡単だがまだやっていない）
- [ ] ConTeXt対応（これも簡単にできる）
- [ ] 基本の漢字部品を集める
- [ ] 長い文字列を複数扱うとMETAFONTが記憶容量不足になる？
- [ ] はね、払いなど（やる気無し、作りたい人が作る）
- [ ] うろこ、細部の調整、別書体など（やる気無し、作りたい人が作る）

引用機能を作ろうとして止まっています。
興味のある方はぜひ作ってください。
[利用者:twe](https://glyphwiki.org/wiki/User:twe "利用者:twe")さんの[GlyphWiki:KAGEデータ仕様 - GlyphWiki](https://glyphwiki.org/wiki/GlyphWiki:KAGE%e3%83%87%e3%83%bc%e3%82%bf%e4%bb%95%e6%a7%98)が参考になります。


## 先行や関連の研究

参考文献
- [kamichikoichi/kage-engine](https://github.com/kamichikoichi/kage-engine)
- [GlyphWiki:KAGEデータ仕様 - GlyphWiki](https://glyphwiki.org/wiki/GlyphWiki:KAGE%e3%83%87%e3%83%bc%e3%82%bf%e4%bb%95%e6%a7%98)

関連技術
- [GlyphWiki](https://glyphwiki.org/)
- [字統网 zi.tools](https://zi.tools/?secondary=ids)
- [zr-tex8r/BXglyphwiki](https://github.com/zr-tex8r/BXglyphwiki)、[LaTeX で使える漢字の数を劇的に増やす方法 - マクロツイーター](https://zrbabbler.hatenablog.com/entry/20131017/1382008498)
- [KAGE/engineを勝手に改造した丸ゴシック試作エンジン](http://www.mars.dti.ne.jp/glyph/)
- [kurgm/kage-editor: The graphical KAGE glyph editor](https://github.com/kurgm/kage-editor) 
- [ge9/NazonoMincho: A customized version of Hanazono Mincho](https://github.com/ge9/NazonoMincho)

## TeX & LaTeX アドベントカレンダー 2025
これは [TeX & LaTeX アドベントカレンダー 2025](https://adventar.org/calendars/12019 "TeX ＆ LaTeX Advent Calendar 2025 - Adventar") 10日目の参加企画です。
前の日は、Yarakashi_Kikohshi さんの[“Two \documentclass or \documentstyle commands.” となってしまうファイル名を知りたい](https://qiita.com/Yarakashi_Kikohshi/items/67d3345be06d1e85b572) でした。
次の日は、Kiri Nakuniさんの[(La)TeXで日本語をしよう！ ](https://note.com/light_masuisi/n/n8b41288c558a)です。



