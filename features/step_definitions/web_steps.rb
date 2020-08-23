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
