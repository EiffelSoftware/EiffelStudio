indexing
	description: "Objects that represents a character separated list of types"
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

	make is
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

	value: STRING is
			-- List selected values, coded with integers.
			-- and comma-separated.
		local
			lis: DYNAMIC_LIST [EV_LIST_ITEM]
			ir: INTEGER_REF
		do
			lis := selected_items
			Result := ""
			from
				lis.start
			until
				lis.after
			loop
				ir ?= lis.item.data
				Result.append (ir.item.out)
				lis.forth
				if not lis.after then
					Result.append_character (separator)
				end
			end
		end

	integer_list: ARRAYED_LIST [INTEGER] is
			-- List selected values, coded with integers.
		local
			lis: DYNAMIC_LIST [EV_LIST_ITEM]
			ir: INTEGER_REF
		do
			lis := selected_items
			create Result.make (lis.count)
			from
				lis.start
			until
				lis.after
			loop
				ir ?= lis.item.data
				Result.extend (ir.item)
				lis.forth
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_locked: BOOLEAN
			-- Is label sensitiveness locked?

feature -- Basic operations

	set_list_separator (a_sep: CHARACTER) is
			-- Set `a_sep' to the character to separate
			-- integer values in the string representation.
			-- Default value is comma.
		do
			separator := a_sep
		end

	fill_with_attributes (code: INTEGER) is
			-- Fill the list with attributes of table with `code'.
		require
			is_valid_code: is_valid_code (code)
		local
			table_feature_list: ARRAYED_LIST [INTEGER]
			table_descr_list: ARRAYED_LIST [STRING]
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

	add_choice (a_code: INTEGER; a_label: STRING) is
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

	set_value (s: STRING) is
			-- List values to select , coded with integers.
			-- and comma-separated.
		local
			it: EV_LIST_ITEM
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
					it := item_by_data (col)
					if it /= Void then
						it.enable_select
					end
				end
			end
		end

	request_sensitive is
			-- Request display sensitive.
		do
			if not is_locked then
				enable_sensitive
			end
		end

	request_insensitive is
			-- Request display insensitive.
		do
			if not is_locked then
				disable_sensitive
			end
		end

	lock_sensitiveness is
			-- Lock display string sensitiveness.
		do
			is_locked := True
		end

	unlock_sensitiveness is
			-- Unlock display string sensitiveness.
		do
			is_locked := False
		end
	
indexing

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Contact: http://contact.eiffel.com
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_STRING_LIST



--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

