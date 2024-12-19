require 'find'

# Directory to search
root_dir = './'

# Pairs of text to replace
replacements = {
  'Product' => 'Product',
  'product' => 'product',
  'Products' => 'Products',
  'products' => 'products'
}

Find.find(root_dir) do |path|
  next unless path =~ /\.(rb|html|js|yml|json|scss|css)$/ # Only process code files

  content = File.read(path)
  new_content = content.dup

  replacements.each do |old, new_text|
    new_content.gsub!(old, new_text)
  end

  if new_content != content
    File.open(path, 'w') { |file| file.write(new_content) }
    puts "Updated: #{path}"
  end
end
