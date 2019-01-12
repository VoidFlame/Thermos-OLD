#!/bin/sh
for f in $(find eclipse/Clean -name '*.java'); do 
	dir="${f:14:${#f}}"
	clean="eclipse/Clean/$dir"
	modified="eclipse/Cauldron/$dir"
	DIFF=$(diff -u $clean $modified) 
	#DIFF=$(git diff --minimal --no-prefix --ignore-space-at-eol --ignore-blank-lines --no-index $clean $modified)
	if [ "$DIFF" != "" ] 
	then
		PATCH="patches/test/$dir.patch"
		echo "Generating $PATCH"
		mkdir -p "patches/test/$(dirname "$dir")"
		echo "$DIFF" > $PATCH
		#java makepatch $PATCH
	fi
done
echo "Done!"