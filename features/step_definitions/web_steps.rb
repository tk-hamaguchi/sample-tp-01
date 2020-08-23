もし('ユーザーがトップページを表示する') do
  visit '/'
end

ならば('{string} が表示されている') do |string|
  expect(page).to have_content string
end
