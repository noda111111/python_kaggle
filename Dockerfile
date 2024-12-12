# Python 3.9をベース、不要パッケージなし、イメージを使用
FROM python:3.9-slim


# RUN: Dockerfile内でコマンドを実行するための命令

# 最新バージョン取得とYES処理
# build-essential: コンパイルツール（コードをコンピュータ形式に変換）
# libssl-dev: SSL/TLS（安全な通信）のライブラリ
# libffi-dev: 他の言語と連携ライブラリ
# python3-dev: C言語と連携ライブラリ
# rm -rf /var/lib/apt/lists/*: インストール後に不要になったパッケージリストを削除

RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*


# pip（python管理ツール）を最新バージョン
# jupyterや分析や機械学習ライブラリのインストール
RUN pip install --upgrade pip && \
    pip install jupyter pandas numpy matplotlib seaborn scikit-learn statsmodels scipy xgboost lightgbm tensorflow keras nltk spacy openpyxl


# 作業ディレクトリを設定
# コンテナ内のデフォルトの作業ディレクトリを設定。以後のファイル操作やコマンド実行はこのディレクトリで処理
WORKDIR /app


# Jupyter Notebookを起動するための設定。トークンなしでアクセス可能（セキュリティに注意・localでのみ使用すること）
# CMD: コンテナが起動した際に実行されるコマンドを指定
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]

