indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_TOKEN_FEATURE_START

inherit
	EDITOR_TOKEN_TEXT
		redefine
			is_feature_start
		end

create
	make

feature -- Access

	feature_index_in_table: INTEGER

feature -- Status report

	is_feature_start: BOOLEAN is True

feature -- Element change

	set_feature_index_in_table (index: INTEGER) is
		do
			feature_index_in_table := index
		end

end -- class EDITOR_TOKEN_FEATURE_START
