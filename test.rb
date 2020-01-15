require_relative "font.rb"

times = IO.popen("git log --pretty=format:%at master") do |io|
  io.map {|s| Time.at(s.chomp.to_i) }.reverse
end

offset = Time.new(1970, 1, 5).to_i
H = {}
C = []
times.each do |t|
  y = H[t.year] ||= (0..53).map { "......." }
  v, w = t.strftime("%V").to_i, t.wday
  y[v][w] = "#"

  i = (t.to_i - offset) / 86400
  C[i / 7 / 4] ||= 0
  C[i / 7 / 4] |= 1 << (23 - (i / 7 % 4 + i % 7 * 4))
end
H.each do |year, s|
  puts year, s.map {|l| "  " + l.reverse }
end

src = "green-square-quine.rb"
F = FONT.invert
answer = File.exist?(src) ? File.read(src) : File.read(File.join("self", src))
raise unless answer == (0...answer.size).map {|i| F[C[i] || 0].chr }.join
puts "Test OK"
