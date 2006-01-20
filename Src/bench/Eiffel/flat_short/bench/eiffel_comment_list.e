indexing
	description: "Object that represents a list of comment lines"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMENT_LIST

inherit
	ARRAYED_LIST [EIFFEL_COMMENT_LINE]
		rename
			make as list_make
		end

create
	make

feature{NONE} -- Implementation

	make is
			--
		do
			list_make (2)
		end

feature

	string_list: EIFFEL_COMMENTS is
			-- String list of Current comments
		local
			l_index: INTEGER
		do
			create Result.make
			if not is_empty then
				l_index := index
				from
					start
				until
					after
				loop
					Result.extend (item.content)
					forth
				end
			end
		end

end
