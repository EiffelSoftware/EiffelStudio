note
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
	make_empty, make, make_from_path,
	make_from_path_object

convert
	make ({ARRAY [STRING_8], ARRAY [READABLE_STRING_8], ARRAY [IMMUTABLE_STRING_8], ARRAY [STRING_32],
		ARRAY [READABLE_STRING_32], ARRAY [IMMUTABLE_STRING_32], ARRAY [READABLE_STRING_GENERAL]})

feature {NONE} -- Initialization

	make_empty
			-- Initialize `Current' to be empty.
		do
			create items.make (default_names_count)
		ensure
			empty: is_empty
		end

	make (a_items: FINITE [READABLE_STRING_GENERAL])
			-- Initialize `Current' with given items.
			--
			-- `a_items': Items representing relative path.
		require
			a_items_attached: a_items /= Void
			a_items_valid: has_valid_names (a_items.linear_representation)
		do
			make_empty
			a_items.linear_representation.do_all (agent extend)
		end

	make_from_path (a_path: EQA_SYSTEM_PATH)
			-- Initialize `Current' from given path.
			--
			-- `a_path': Path from which `Current' will create a duplication
		require
			a_path_attached: a_path /= Void
		do
			items := a_path.items.twin
		ensure
			equal: Current ~ a_path
		end

	make_from_path_object (a_path: PATH)
		do
			make_empty
			extend (a_path.name)
		end

feature -- Access

	count: INTEGER
			-- Number of items in `Current'
		do
			Result := items.count
		end

	item alias "[]", at alias "@" (i: INTEGER): READABLE_STRING_GENERAL
			-- Item at index `i'
		require
			valid_index: i > 0 and i <= count
		do
			Result := items.i_th (i)
		ensure
			result_attached: Result /= Void
			result_valid: is_valid_name (Result)
		end

feature {EQA_SYSTEM_PATH} -- Access

	items: ARRAYED_LIST [READABLE_STRING_GENERAL]
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

	is_valid_name (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_name' a valid path component?
		require
			a_name_attached: a_name /= Void
		do
			Result := a_name /= Void and then not a_name.is_empty
		end

	has_valid_names (a_linear: LINEAR [READABLE_STRING_GENERAL]): BOOLEAN
			-- Items of `a_linear' has valid name as specified by `is_valid_name'
		require
			a_linear_attached: a_linear /= Void
		do
			from
				Result := True
				a_linear.start
			until
				a_linear.after or not Result
			loop
				Result := is_valid_name (a_linear.item)
				a_linear.forth
			end
		end

feature -- Element change

	extend (a_item: READABLE_STRING_GENERAL)
			-- Add `a_item' to `items'.
		require
			a_item_attached: a_item /= Void
			a_name_valid: is_valid_name (a_item)
		do
			items.force (a_item)
		ensure
			names_count_increased: items.count = old items.count + 1
			names_extended: items.last = a_item
		end

feature {NONE} -- Constants

	default_names_count: INTEGER = 5

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
