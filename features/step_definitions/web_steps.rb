もし('ユーザーがトップページを表示する') do
  visit '/'
end

ならば('{string} が表示されている') do |string|
  expect(page).to have_content string
end

ならば('画像が {int} 枚表示されている') do |int|
  expect(page).to have_css 'img', count: int
end

ならば('スクリーンショットを撮って {string} に保存する') do |string|
  page.save_screenshot string
end

前提('ユーザーがトップページを表示していること') do
  visit '/'
  expect(page).to have_current_path root_path, ignore_query: true
end

前提('画像が {int} 枚表示されていること') do |int|
  step "画像が #{int} 枚表示されている"
end

もし('ユーザーが {int} 番目のピン留めにマウスオーバーする') do |int|
  find("#main .pin:nth-child(#{int})").hover
end

ならば('{int} 番目のピン留めに {string} ボタンが表示される') do |int, string|
  within "#main .pin:nth-child(#{int}) .card-img-overlay" do
    expect(page).to have_button string
  end
end

もし('{int} 番目のピン留めの {string} ボタンをクリックする') do |int, string|
  within "#main .pin:nth-child(#{int}) .card-img-overlay" do
    click_button string
  end
end

ならば('{string} モーダルが表示されている') do |string|
  expect(page).to have_selector '.modal-title', text: string
end

ならば('{string} リンクが表示されている') do |string|
  expect(page).to have_link string
end

もし('{string} リンクをクリックする') do |string|
  click_link string
end

ならば('表示されている画像は以下のフォルダの画像である') do |doc_string|
  expect_file_paths = Dir.glob(Rails.root.join(doc_string.strip, '*'))
  expect_file_names = expect_file_paths.map { |fp| File.basename(fp) }

  page.all('img').each do |img_tag|
    file_name = File.basename(img_tag[:src])
    expect(expect_file_names).to include file_name
  end
end

もし('フォームに下記の内容を入力する:') do |table|
  table.hashes.each do |row|
    fill_in row['フィールドID'], with: row['入力値']
  end
end

もし('{string} ボタンをクリックする') do |string|
  click_button string
end

ならば('トップページが表示されている') do
  expect(page).to have_current_path root_path, ignore_query: true
end

ならば('通知エリアに {string} が表示されている') do |string|
  within '.alert' do
    expect(page).to have_content string
  end
end

ならば('{string} ボタンが表示されている') do |string|
  expect(page).to have_button string
end

前提('アップロードする画像を下記からダウンロードしておく:') do |doc_string|
  URI.open(doc_string) do |io|
    File.open('tmp/upload.jpg', 'w+b') do |file|
      file.write io.read
    end
  end
end

もし('ユーザーがピンの作成ボタンをクリックする') do
  click_button 'addPinButton'
end

ならば('ピンの作成ページが表示されている') do
  expect(page).to have_current_path new_pin_path, ignore_query: true
end

もし('保存先のボードとして {string} を選択する') do |string|
  select string, from: 'pin[board_id]'
end

もし('事前にダウンロードした画像ファイルをアップロードする') do
  attach_file('pin[image]', 'tmp/upload.jpg', make_visible: true)
end

ならば('ピン[{int}]の詳細ページが表示されている') do |int|
  expect(page).to have_current_path pin_path(id: int), ignore_query: true
end

ならば('アップロードした画像が表示されている') do
  file_name = File.basename(page.find('img')[:src])
  expect('upload.jpg').to include file_name
end

もし('ユーザーが {string} メニューをクリックする') do |string|
  within '.navbar' do
    click_link string
  end
end

ならば('ボード一覧ページが表示されている') do
  expect(page).to have_current_path boards_path, ignore_query: true
end

ならば('{string} が表示されていない') do |string|
  expect(page).not_to have_content string
end

ならば('ボード[{int}]の領域に {string} が表示されている') do |int, string|
  within "#board-#{int}" do
    expect(page).to have_content string
  end
end

もし('{string} をクリックする') do |string|
  click_on string
end

ならば('ボード[{int}]の詳細ページが表示されている') do |int|
  expect(page).to have_current_path board_path(id: int), ignore_query: true
end

ならば('ピン留め[{int}]の画像が表示されている') do |int|
  expect(page).to have_selector "img[src$=\"#{URI.parse(url_for(Pin.find(int).image)).path}\"]"
end
