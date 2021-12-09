#!/bin/sh

rev=$1
if [ "$rev" = "" ]; then
	echo Usage: prog revision
	exit 1
fi

upload_file()
{
	fn=$1
	echo Upload $fn to s3://ise.deliv/....
	aws s3 cp --acl public-read $fn s3://ise.deliv/nightly/$rev/$fn

}

upload_folder()
{
	dn=$1
	for f in $dn/*.msi
	do
		upload_file $f
	done

}

for d in standard enterprise branded
do
	upload_folder $d
done

#up_rev_kind_platform rev standard win64
#up_rev_kind_platform rev standard windows

#up_rev_kind_platform ent enterprise win64
#up_rev_kind_platform ent enterprise windows

#up_rev_kind_platform branded branded win64
#up_rev_kind_platform branded branded windows

