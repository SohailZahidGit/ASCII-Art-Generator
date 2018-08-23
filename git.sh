Y=2018
M=6
U=12
L=0
mkdir $Y
cd $Y
mkdir $M
cd $M
for D in {19..30}
do
  DIFF=$((U-L+1))
  R=$(($(($RANDOM%$DIFF))+L))      
  if [ $R != O ] && [ $R != 3 ] && [ $R != 6 ] && [ $R != 9 ] && [ $R != 12 ]
  then
    echo $R
    mkdir $D
    cd $D
    for i in $( eval echo {1..$R} )
    do
      echo "$i on $M/$D/$Y" > commit.md
      export GIT_COMMITTER_DATE="$Y-$M-$D 12:$i:00"
      export GIT_AUTHOR_DATE="$Y-$M-$D 12:$i:00"
      git add commit.md -f
      git commit --date="$Y-$M-$D 12:0$i:00" -m "$i on $M $D $Y"
    done
    cd ../
  fi
done
git push origin master
git rm -rf 20**
git rm -rf 19**
git commit -am "cleanup"
git push origin master