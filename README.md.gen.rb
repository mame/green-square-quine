s = <<END
# Green-square Quine

END

1970.upto(2007) do |y|
  s << "* [#{ y }](https://github.com/mame?from=#{ y }-01-01&to=#{ y }-12-31)\n"
  s << "\n"
  s << "![#{ y }](https://github.com/mame/green-square-quine/blob/master/imgs/#{ y }.png)\n"
  s << "\n"
end

File.write("README.md", s)
