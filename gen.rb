require_relative "font.rb"
CHARS = [*?T.ord..126,*32..?=.ord]

S = CHARS.map {|n| ("%024b" % FONT[n]).scan(/.{4}/).map {|s| s.chars }.transpose.join }.join.reverse.to_i(2)

# encode font data
data = (0..).lazy.map do |offset|
  s = S + offset * (1 << (CHARS.size * 24))
  a = []
  until s == 0
    n = s % (CHARS.size - 1)
    a << (CHARS - [126])[n]
    s /= CHARS.size - 1
  end
  if (a.pop + 10) % 94 == 5
    a.reverse.pack("C*")
  else
    nil
  end
end.find {|data| data }

# decode test
n = 5
data.bytes{|c|n=n*(CHARS.size-1)+(c+10)%94}
raise unless S == n & ((1 << (CHARS.size * 24)) - 1)

# generate
p [:data, data.size]

code = File.read(File.join(__dir__, "code.rb")).lines.map {|s| s.strip }.join
code = "eval s=%q~#{ code }~"
p [:code, code.size]

siz = (code =~ /#FONT_DATA/) - 9
code = code.sub("SIZ", siz.to_s)
raise unless code[0, siz + 8].bytes.uniq.sort - CHARS == []

code = code.sub("FONT_DATA") { data }

File.write("green-square-quine.rb", code)
p [:total, code.size]
