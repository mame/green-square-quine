set -e

rm -rf self
mkdir self
cd self

ruby ../gen.rb
ruby ../README.md.gen.rb
cp -r ../imgs/ .

git init
git add green-square-quine.rb README.md imgs/
TZ= ruby green-square-quine.rb
ruby ../test.rb > out

git remote add origin ..
git push -u origin master -f
