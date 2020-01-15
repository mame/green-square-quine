set -e

rm -rf self
mkdir self
cd self

ruby ../gen.rb
ruby ../README.md.gen.rb
cp ../ss.png .

git init
git add green-square-quine.rb README.md ss.png
TZ= ruby green-square-quine.rb
ruby ../test.rb > out

git remote add origin ..
git push -u origin master -f
