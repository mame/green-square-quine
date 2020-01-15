n=t=5;
s[SIZ..-1].bytes{n=n*72+(_1+10)%94};
"eval s=%q\37#{s}\37".bytes{|c|
  24.times{
    t+=2<<0**(_1%6);
    n[(c+11)%95*24+_1]<1||
      `git commit -m q --allow-empty --date=#{
        Time.at(t*43200).strftime"%\106T%T"
      }`
  }
}
#FONT_DATA
