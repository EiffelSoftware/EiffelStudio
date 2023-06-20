note
	description: "[
			Blob heap item
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_BLOB_ITEM

inherit
	PE_BYTES_ITEM

create
	make

convert
	dump: {READABLE_STRING_8, STRING_8}


end
