indexing
	description: "Object that represents an EQL resultset comprised of one or more EQL_RESULT"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_RESULTSET
inherit
	HASH_TABLE [EQL_RESULT [EQL_RESULT_ITEM], STRING]

create
	make
	
end
