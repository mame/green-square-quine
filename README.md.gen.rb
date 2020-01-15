s = <<END
# Green-square Quine

![Green-square Quine](https://github.com/mame/green-square-quine/blob/master/ss.png)

END

1970.upto(2007) do |y|
  s << "* [#{ y }](https://github.com/mame?from=#{ y }-01-01&to=#{ y }-12-31)\n"
end

File.write("README.md", s)
