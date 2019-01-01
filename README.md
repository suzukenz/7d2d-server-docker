# 7d2d-server-docker

[7 Days to Die](https://store.steampowered.com/app/251570/7_Days_to_Die/)のゲームサーバーを Docker で簡単に立てる。

## Features

- Google Compute Engine 上に立てるために作成（プリエンプティブにすれば安い！）
- Google Cloud Storage 上へ簡易バックアップ（１世代 Sync するだけ）

## Prerequisites

- Docker (>=v17.09)
- docker-compose

GCE(Debian)上でのインストールを助けるためのスクリプトを用意しています。  
=> `helpers/install-docker-on-gce.sh`

### Compute Engine specs

Google Compute Engine で立てる時の設定  
（あくまで、うちはこれで動いてるよというもの）

- Debian GNU/Linux 9 (stretch)
- ストレージ 20GB (多分 15GB もあれば十分そう)
- vCPUx2 / メモリ 6.0GB
- GCS の読み取り/書き込み権限
- Port 26900/TCP と 26900-26903/UDP の開放

## Usage

1. docker-compose.yml に GCS バックアップ先の設定を書く。

```yaml
GCS_SAVE_URL: gs://seven-days-2d/save
GCS_LOGS_URL: gs://seven-days-2d/logs
```

この辺り。必要に応じて Bucket を作る。  
(\*) Backup 不要な場合は yaml から`gcs-backup`のセクションは全部消して良いです。

2. `7d2d/serverconfig-default.xml`をお好みの設定に書き換える。
3. docker-compose コマンドで起動する。

起動

```bash
cd 7d2d-server-docker/
sudo docker-compose up --build
```

バックグラウンドで実行する場合

```bash
sudo docker-compose up -d
```

停止する場合

```bash
sudo docker-compose down
```

(\*) この時`-v`オプションをつけるとデータも消えます

## Appendix

サーバーの様子を調べたい場合は上記のコマンドで実行中に

```bash
docker exec -it コンテナID bash
cd /7d2d
```

とすればゲームデータのフォルダを見られます。２つある内のどちらのコンテナでも良い。
