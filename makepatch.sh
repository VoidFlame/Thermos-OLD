#!/bin/sh
for f in $(find eclipse/Clean -name '*.java'); do 
	srcdir="${f:14:${#f}}"
	clean="eclipse/Clean/$srcdir"
	modified="eclipse/Cauldron/$srcdir"
	DIFF=$(diff -u $clean $modified) 
	#DIFF=$(git diff --minimal --no-prefix --ignore-space-at-eol --ignore-blank-lines --no-index $clean $modified)
	if [ "$DIFF" != "" ] 
	then
		dir="${f:28:${#f}}"
		PATCH="patches/$dir.patch"
		echo "Generating $PATCH"
		mkdir -p "patches/$(dirname "$dir")"
		echo "$DIFF" > $PATCH
		#java makepatch $PATCH
	fi
done
echo "Done!"