indexing
	description: "Multi column list displaying database table rows."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_TABLEROW_MULTILIST

inherit
	EV_MULTI_COLUMN_LIST
		rename
			index as list_index
		redefine
			set_column_titles
		end

	DV_TABLEROW_LIST
		undefine
			default_create,
			is_equal,
			copy
		end

feature -- Status report

	is_display_ready: BOOLEAN
			-- Has the object display been built?

	information_set: BOOLEAN is
			-- Is `table_code' set or are multi-list columns
			-- sufficiently defined?
		do
			Result := table_code_set or else
				(title_list_set and then attribute_list /= Void)
		end

	title_list_set: BOOLEAN
			-- Has a title list been set?

	table_code_set: BOOLEAN is
			-- Has a table code been set?
		do
			Result := table_code /= No_code
		end

	has_select_action (action: PROCEDURE [ANY, TUPLE]): BOOLEAN is
			-- Does list of actions executed when an item is selected
			-- contain `action'?
		do
			Result := select_actions.has (select_actions~wrapper (?, action))
		end

	has_deselect_action (action: PROCEDURE [ANY, TUPLE]): BOOLEAN is
			-- Does list of actions executed when an item is deselected
			-- contain `action'?
		do
			Result := deselect_actions.has (deselect_actions~wrapper (?, action))
		end

feature -- Access

	index: INTEGER is
			-- Position of graphic selected element
			-- in the buffer list.
		local
			tmp: INTEGER_REF
		do
			tmp ?= selected_item.data
			check
				tmp /= Void
			end
			Result := tmp.item
		end 

	table_code: INTEGER
			-- Database table code.

	attribute_list: ARRAYED_LIST [INTEGER]
			-- List of table attributes to display in column titles.

	title_list: ARRAYED_LIST [STRING]
			-- List of column titles.

feature -- Basic operations

	set_tablecode (tablecode: INTEGER) is
			-- Set `tablecode' to `table_code'.
		do
			table_code := tablecode
		end

	set_column_titles (a_title_list: ARRAY [STRING]) is
			-- Set `a_title_list' to the column title list.
		do
			Precursor (a_title_list)
			title_list_set := True 
		ensure then
			title_list_set: title_list_set
		end

	set_attributes (a_list: ARRAYED_LIST [INTEGER]) is
			-- Set `a_list' to the list of database table attributes to display.
		do
			attribute_list := clone (a_list)
		end

	build is
			-- Set up the list.
		do
			if table_code /= No_code then
				if attribute_list = Void then 
					attribute_list := tables.obj (table_code).table_description.attribute_code_list
				end
				if not title_list_set then
					set_col_titles
				end
			end
			disable_multiple_selection
			is_display_ready := True
		end

	refresh (tablerow_list: ARRAYED_LIST [DB_TABLE]) is
			-- Fill the multi_column_list according to `tablerow_list'.
			-- Select current item of `tablerow_list' if any.
		local
			last_index: INTEGER
			col_count, i: INTEGER
		do
			last_index := tablerow_list.index
			wipe_out
			if not tablerow_list.is_empty then
				from
					tablerow_list.start
				until
					tablerow_list.after
				loop
					add_to_list (tablerow_list.item, tablerow_list.index, last_index)
					tablerow_list.forth
				end			
			end
			if is_displayed then
				set_focus
			end
				-- Avoid side-effects.
			tablerow_list.go_i_th (last_index)
			
				-- Enable a nice display.
			from
				col_count := column_count
				i := 1
			until
				i > col_count
			loop
				resize_column_to_content (i)
				i := i + 1
			end
		end

	extend_select_actions (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend list of actions executed when an item is selected.
		do
			select_actions.force_extend (action)
		end

	extend_deselect_actions (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend list of actions executed when an item is deselected.
		do
			deselect_actions.force_extend (action)
		end

	set_value_list_redirector (vlr: DV_VALUE_LIST_REDIRECTOR) is
			-- Set a value list redirector `vlr' to redirect
			-- fixed column results from integer string to "explicit" string.
		do
			value_list_redirector := vlr
		end

feature {NONE} -- Implementation

	set_col_titles is
			-- Set column titles with names of attributes which codes are in `attr_codes_list'.
		local
			ind: INTEGER
			table_descr_l: ARRAYED_LIST [STRING]
		do
			table_descr_l := tables.obj (table_code).table_description.description_list
			from
				ind := 1
			until
				ind > attribute_list.count
			loop
				set_column_title (table_descr_l.i_th (attribute_list.i_th (ind)), ind)
				ind := ind + 1
			end
		end

	add_to_list (list_item: DB_TABLE; current_i, last_i: INTEGER) is
			-- Add `list_item' representation to the list. Select it if
			-- `current_i' = `last_i'.
		local
			it: EV_MULTI_COLUMN_LIST_ROW
		do
			create it
			if value_list_redirector /= Void then
				value_list_redirector.redirect_list (list_item.table_description.selected_attribute_list (attribute_list))
				it.fill (value_list_redirector.redirected_list)
			else
				it.fill (list_item.table_description.selected_printable_attribute_list (attribute_list))
			end
			it.set_data (current_i)
			extend (it)
			if current_i = last_i then
				it.enable_select
			end
		end

	value_list_redirector: DV_VALUE_LIST_REDIRECTOR
			-- Value list redirector.

	No_code: INTEGER is 0;
			-- No `table_code' has been set yet.

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

end -- class DV_TABLEROW_MULTILIST

