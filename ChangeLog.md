# 変更履歴

### 2023/12/29 v1.0
- 高速化

    べーしっ君で倍精度実数の演算ができないので、その部分と周辺(計算の部分を狙い撃ちできない)を通常のBASICで行っていたのだけど、そこが遅かったので倍精度実数の演算部分をMath-Packを使うマシン語(アセンブラ)ルーチンにしてそれを使うようにした。これによりファイル読み込み以外の部分がべーしっ君と演算マシン語ルーチンになったのでstrbuf.binで行ってたべーしっ君と通常BASIC部分での文字列受け渡しが必要なくなったのでstrbuf.binは削除。

### 2023/12/19 v0.2
- すこし高速化

    べーしっ君と通常のBASIC部分との間で文字列変数を共有できない仕様なので、マシン語(アセンブラ)経由で文字列を相互にコピーするようにしてかなりの部分をぺーしっ君対応にした。まだ、演算子(+-*/=)を押した時に倍精度実数の演算で通常のBASICで処理する必要があり、そこでガクンと処理速度が落ちます。(レスポンスが悪くなる)
    これ以上の高速化はこのあたりもマシン語(アセンブラ)にしないとダメかも。

## 2023/12/16 v0.1
符号反転がバグっていたので高速化途中だけど直してリリース。

- 符号反転がただしく動作していなかったのを改修

- 演算結果の表示エリアの縦方向を小さくしてボタンを大きくした

    ほんの少し大きくなっただけだけど少し押しやすくなった。

- 使用している文字フォントを独自のものにした

    PUT KANJIを使ってたけど別画面からCOPYする方がほんの少し速かったのとPUT KANJIがべーしっ君で使えなかったので自前でフォントを用意した。mkfonts/font8.basが8x8のフォントデータ(font8.dat)、mkfonts/font12.basが12x16のフォントデータ(font12.dat)、mkfonts/font16.basが16x16のフォントデータ(font16.dat)を作るプログラムになる。

- MSXべーしっ君使ってすこし高速化(まだまだ足りない)

    べーしっ君対応できる部分はほとんど対応できてると思うけど、まだ遅い。