note
	description: "Summary description for {CMS_API_OPTIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_API_OPTIONS

inherit
	WSF_API_OPTIONS

create
	make,
	make_from_manifest

convert
	make_from_manifest ({ ARRAY [TUPLE [key: STRING; value: detachable ANY]],
						  ARRAY [TUPLE [STRING_8, ARRAY [TUPLE [STRING_8, STRING_32]]]],
						  ARRAY [TUPLE [STRING_8, ARRAY [TUPLE [STRING_8, STRING_8]]]]
						})

feature {NONE} -- Initialization


end
