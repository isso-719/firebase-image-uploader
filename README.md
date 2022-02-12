`app.rb` の起動には `credentials.json` と `Firebase Storage の BucketID` が必要です。

`credentials.json` ファイルは `Firebase ホーム > プロジェクトの設定 > サービスアカウント > Firebase Admin SDK > 新しい秘密鍵の生成` で取得できます。

`Firebase Storage の BucketID` は `Firebase ホーム > Storage` の `gs://` に続くドメイン(最後が `appspot.com` で終わるもの) です。
これを取得したら `sample.env` に書き込み、`.env` にリネームしてください。