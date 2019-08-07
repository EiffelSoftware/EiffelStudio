note
	description: "Objects that represents a character separated list of types"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_STRING_LIST

inherit
	EV_LIST

	DV_SENSITIVE_STRING
		undefine
			default_create,
			is_equal,
			copy
		end

	DB_TABLES_ACCESS_USE
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature -- Initialization

	make
			-- Create list.
		do
			default_create
			enable_multiple_selection
					-- Default separator is a comma.
			separator := ','
		end

feature -- Access

	separator: CHARACTER
			-- Integer values separator, ',' by default.

	value: STRING_32
			-- List selected values, coded with integers.
			-- and comma-separated.
		local
			lis: DYNAMIC_LIST [EV_LIST_ITEM]
		do
			lis := selected_items
			create Result.make_empty
			from
				lis.start
			until
				lis.after
			loop
				if attached {INTEGER_REF} lis.item.data as l_int then
					Result.append_integer (l_int.item)
				end
				lis.forth
				if not lis.after then
					Result.append_character (separator)
				end
			end
		end

	integer_list: ARRAYED_LIST [INTEGER]
			-- List selected values, coded with integers.
		local
			lis: DYNAMIC_LIST [EV_LIST_ITEM]
		do
			lis := selected_items
			create Result.make (lis.count)
			from
				lis.start
			until
				lis.after
			loop
				if attached {INTEGER_REF} lis.item.data as l_int then
					Result.extend (l_int.item)
				end
				lis.forth
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_locked: BOOLEAN
			-- Is label sensitiveness locked?

feature -- Basic operations

	set_list_separator (a_sep: CHARACTER)
			-- Set `a_sep' to the character to separate
			-- integer values in the string representation.
			-- Default value is comma.
		do
			separator := a_sep
		end

	fill_with_attributes (code: INTEGER)
			-- Fill the list with attributes of table with `code'.
		require
			is_valid_code: is_valid_code (code)
		local
			table_feature_list: ARRAYED_LIST [INTEGER]
			table_descr_list: ARRAYED_LIST [STRING_32]
		do
			table_feature_list := tables.description (code).attribute_code_list
			table_descr_list := tables.description (code).description_list
			wipe_out
			from
				table_feature_list.start
			until
				table_feature_list.after
			loop
				add_choice (table_feature_list.item, table_descr_list.i_th (table_feature_list.item))
				table_feature_list.forth
			end
		end

	add_choice (a_code: INTEGER; a_label: READABLE_STRING_GENERAL)
			-- Add `a_data' to the combo box and enable its selection
			-- with `a_label'.
		require
			label_not_void: a_label /= Void
			label_not_empty: not a_label.is_empty
		local
			new_item: EV_LIST_ITEM
		do
			create new_item.make_with_text (a_label)
			new_item.set_data (a_code)
			extend (new_item)
		end

	set_value (s: READABLE_STRING_GENERAL)
			-- List values to select , coded with integers.
			-- and comma-separated.
		local
			it: detachable EV_LIST_ITEM
			i_beg, i_end, col: INTEGER
		do
			remove_selection
			if not s.is_empty then
				from
					i_beg := 1
				until
					i_beg = 0
				loop
					i_end := s.index_of (separator, i_beg)
					if i_end /= 0 then
						col := s.substring (i_beg, i_end - 1).to_integer
						i_beg := i_end + 1
					else
						col := s.substring (i_beg, s.count).to_integer
						i_beg := i_end
					end
					it := retrieve_item_by_data (col, True)
					if it /= Void then
						it.enable_select
					end
				end
			end
		end

	request_sensitive
			-- Request display sensitive.
		do
			if not is_locked then
				enable_sensitive
			end
		end

	request_insensitive
			-- Request display insensitive.
		do
			if not is_locked then
				disable_sensitive
			end
		end

	lock_sensitiveness
			-- Lock display string sensitiveness.
		do
			is_locked := True
		end

	unlock_sensitiveness
			-- Unlock display string sensitiveness.
		do
			is_locked := False
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
