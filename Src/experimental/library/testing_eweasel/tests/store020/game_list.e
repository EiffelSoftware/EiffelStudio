indexing
	description: "Storable list that holds 'game_objects'"
	author: "Hubert Cater"
	date: "Date: November 1, 2000"

class
	GAME_LIST [G]

inherit
	LINKED_LIST [G]
		select
			is_equal,
			copy
		end

	STORABLE
		rename
			is_equal as storable_is_equal,
			copy as storable_copy
		export
			{NONE}
				all
			{ANY}
				retrieve_by_name,
				store_by_name,
				general_store
		end

create
	make

end -- class GAME_LIST
