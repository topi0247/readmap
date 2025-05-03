# カテゴリ
category_names = [
  "Ruby",
  "Rails",
  "HTML/CSS",
  "JavaScript",
  "TypeScript",
  "React",
  "Next.js",
  "Vue.js",
  "Nuxt.js",
  "Python",
  "PHP",
  "Golang",
  "Laravel",
  "Java",
  "モバイルアプリ",
  "SQL",
  "データベース",
  "クラウド・インフラ",
  "WEB技術",
  "資格・試験",
  "セキュリティ",
  "テスト",
  "キャリア",
  "デザイン",
  "マーケティング",
  "ビジネス",
  "マネジメント",
  "エディタ",
  "その他"
]

created_categories = category_names.map do |name|
  Category.find_or_create_by!(name: name)
end
