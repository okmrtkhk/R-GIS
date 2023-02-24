## libraryのインストール

innstall済みのパッケージ

- tidyverse
- sf
- jpmesh

## 無料GISデータベース概要

国土数値情報ダウンロードサービス　https://nlftp.mlit.go.jp/ksj/

- 行政区境界（市町村）を基本に河川、湖沼（一部のダム湖を含む）、道路、鉄道などが基図データとして利用可能
- 解像度が高い（海岸線の堤防なども含む）ので、広域地図として利用する際は簡略化が必要。そのまま使うと重い。全国図をそのままプロットすると普通に５分ぐらいかかる。
- メッシュデータもある。jpmeshパッケージを用いることで緯度経度情報を孵化できる

Natural Earth https://www.naturalearthdata.com

- ３段階の縮尺で利用可能。
- 都道府県レベルの地図が利用可能。ただし、都道府県名称が一部バグがあった。北方領土はロシア領。解像度は荒め。
- 水深データも利用できる。

ESRI 全国市町村界データ　https://www.esrij.com/products/japan-shp/

- ESRIの無料データ。一部の市町村がポリゴンになっておらず、結合できない。解像度は国土数値情報とNatural Earthとの間ぐらい。

e-Stat 統計GIS https://www.e-stat.go.jp/gis/statmap-search?type=2

- 国勢調査の町丁レベルの小地域まで落とせる。行政区界として最小単位？





## 参考になりそうなサイト

sf全般日本語、ラスタデータの取り込みつについても言及あり

https://tsukubar.github.io/r-spatial-guide/simple-feature-for-r.html

メッシュコードを作る、緯度経度をメッシュの中に落とす

https://cran.r-project.org/web/packages/jpmesh/vignettes/usage.html

QGIを用いた生息適地推定（Rでも使えるpackage情報あり）

https://note.com/kinari_iro/n/n73738a08b4a5

GIS全体に関する説明もある。ArcGISでやってることをRでやらせることを主眼としているらしい。なんか重い。

https://rpubs.com/k_takano/r_de_gis_jp_en

ラスタデータの取り扱いなどいろいろ書いてある。親切

https://tmizu23.github.io/R_GIS_tutorial/R_GIS_tutorial2018.9.3.html#425

## 測地系

国土数値情報ダウンロードサービスのデータはJGD2000だったり2011だったり。測地系とEPSGコードは下記サイトを参照にした。

https://tmizu23.hatenablog.com/entry/20091215/1260868350

WGS84 : 4326

JGD2011 : 6668

JGD2000 : 4612

## コーディング

### インポート

```R
sf::read_sf(path, options = "ENCODING=CP932")
```

Shift-JISの場合はoptionが必要

### 