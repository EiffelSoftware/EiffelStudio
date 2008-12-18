indexing
	description: "[
		Objects representing a relative path.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_SYSTEM_PATH

inherit
	ANY
		redefine
			is_equal
		end

create
	make_empty, make, make_from_path

feature {NONE} -- Initialization

	make_empty
			-- Initialize `Current' to be empty.
		do
			create items.make (default_names_count)
		ensure
			empty: is_empty
		end

	make (a_items: !FINITE [READABLE_STRING_8])
			-- Initialize `Current' with given items.
			--
			-- `a_items': Items representing relative path.
		require
			a_items_valid: a_items.linear_representation.for_all (agent is_valid_name)
		do
			make_empty
			a_items.linear_representation.do_all (agent items.force)
		end

	make_from_path (a_path: !EQA_SYSTEM_PATH)
			-- Initialize `Current' from given path.
			--
			-- `a_path': Path from which `Current' will create a duplication
		do
			items := a_path.items.twin
		ensure
			equal: Current ~ a_path
		end

feature -- Access

	count: INTEGER
			-- Number of items in `Current'
		do
			Result := items.count
		end

	item alias "[]", infix "@" (i: INTEGER): !READABLE_STRING_8
			-- Item at index `i'
		require
			valid_index: i > 0 and i <= count
		do
			Result := items.i_th (i)
		end

feature {EQA_SYSTEM_PATH} -- Access

	items: !ARRAYED_LIST [like item]
			-- Items representing path

feature -- Status report

	is_empty: BOOLEAN
			-- Number of components representing `Current'.
		do
			Result := items.is_empty
		end

feature -- Query

	is_equal (a_other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := items ~ a_other.items
		end

	is_valid_name (a_name: ?READABLE_STRING_8): BOOLEAN
			-- Is `a_name' a valid path component?
		do
			Result := a_name /= Void and then not a_name.is_empty and then
			          (create {DIRECTORY_NAME}.make).is_directory_name_valid (a_name)
		end

feature -- Element change

	extend (a_item: !READABLE_STRING_8)
			-- Add `a_item' to `items'.
		require
			a_name_valid: is_valid_name (a_item)
		do
			items.force (a_item)
		ensure
			names_count_increased: items.count = old items.count + 1
			names_extended: items.last = a_item
		end

feature {NONE} -- Constants

	default_names_count: INTEGER = 5

end
