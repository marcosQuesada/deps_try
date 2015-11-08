#!/usr/bin/env bash
k=0;
CMD=$1
FILE=deps

clone() {
	mkdir -p vendor
	local vcs="$1"
	local pkg="$2"
	local rev="$3"
	local url="$4"

	: ${url:=https://$pkg}
	local target="vendor/$pkg"

	echo -n "$pkg @ $rev: "

	if [ -d "$target" ]; then
		echo -n 'rm old, '
		rm -rf "$target"
	fi

	echo -n 'clone, '
	case "$vcs" in
		git)
			git clone --quiet --no-checkout "$url" "$target"
			( cd "$target" && git checkout --quiet "$rev" && git reset --quiet --hard "$rev" )
			;;
		hg)
			hg clone --quiet --updaterev "$rev" "$url" "$target"
			;;
	esac

	( cd "$target" && rm -rf vendor Godeps/_workspace )

	echo done
}
update() {
	local vcs="$1"
	local pkg="$2"
	local rev="$3"
	local url="$4"
	local target="vendor/$pkg"

	echo -n "$pkg @ $rev: "
	case "$vcs" in
		git)
			( cd "$target" && git checkout --quiet "$rev" && git reset --quiet --hard "$rev" )
			;;
	esac
	echo "\n"
}

# This is correct way to read file.
echo "############# $CMD deps ###################"
while read line;do
        $CMD $line
        ((k++))
done < $FILE
echo "Total number of lines in file: $k"
