# language:ja

機能: ボードの編集

背景:
  * 下記のユーザーが登録されていること:
    | id | name |
    |  2 | 自分 |
  * 下記のボードが登録されていること:
    | id |      name      | user_id |
    | 21 | 自分のボード１ |       2 |

シナリオ: ユーザーは自分のボードの名前と説明文を編集することができる
  前提 ユーザーがトップページを表示していること

  もし ユーザーが "ボード" メニューをクリックする
  ならば ボード一覧ページが表示されている
  かつ "自分のボード１" が表示されている

  もし "自分のボード１" をクリックする
  ならば ボード[21]の詳細ページが表示されている

  もし ユーザーがボードの編集ボタンをクリックする
  ならば "ボードを編集" モーダルが表示されている

  もし フォームに下記の内容を入力する:
    | フィールドID |     入力値     |
    | board_name   | 編集後の名前   |
    | board_note   | 編集後の説明文 |
  かつ "完了" ボタンをクリックする
  ならば ボード[21]の詳細ページが表示されている
  かつ "編集後の名前" が表示されている
  かつ 通知エリアに "保存しました" が表示されている
  かつ データベースに下記のボードが登録されている:
    | id |     name     |      note      |
    | 21 | 編集後の名前 | 編集後の説明文 |
