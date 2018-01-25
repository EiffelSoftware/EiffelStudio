note
	description: "Multi column list displaying database table rows."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	information_set: BOOLEAN
			-- Is `table_code' set or are multi-list columns
			-- sufficiently defined?
		do
			Result := table_code_set or else
				(title_list_set and then attribute_list /= Void)
		end

	title_list_set: BOOLEAN
			-- Has a title list been set?

	table_code_set: BOOLEAN
			-- Has a table code been set?
		do
			Result := table_code /= No_code
		end

	has_select_action (action: PROCEDURE [EV_MULTI_COLUMN_LIST_ROW]): BOOLEAN
			-- Does list of actions executed when an item is selected
			-- contain `action'?
		do
			Result := select_actions.has (action)
		end

	has_deselect_action (action: PROCEDURE [EV_MULTI_COLUMN_LIST_ROW]): BOOLEAN
			-- Does list of actions executed when an item is deselected
			-- contain `action'?
		do
			Result := deselect_actions.has (action)
		end

feature -- Access

	index: INTEGER
			-- Position of graphic selected element
			-- in the buffer list.
		do
			if attached selected_item as l_item and then attached {INTEGER_REF} l_item.data as l_int then
				Result := l_int.item
			end
		end

	table_code: INTEGER
			-- Database table code.

	attribute_list: detachable ARRAYED_LIST [INTEGER]
			-- List of table attributes to display in column titles.

feature -- Basic operations

	set_tablecode (tablecode: INTEGER)
			-- Set `tablecode' to `table_code'.
		do
			table_code := tablecode
		end

	set_column_titles (a_title_list: ARRAY [STRING])
			-- Set `a_title_list' to the column title list.
		do
			Precursor (a_title_list)
			title_list_set := True
		ensure then
			title_list_set: title_list_set
		end

	set_attributes (a_list: detachable ARRAYED_LIST [INTEGER])
			-- Set `a_list' to the list of database table attributes to display.
		do
			if a_list /= Void then
				attribute_list := a_list.twin
			else
				attribute_list := Void
			end
		end

	build
			-- Set up the list.
		local
			l_list: like attribute_list
		do
			if table_code /= No_code then
				l_list := attribute_list
				if l_list = Void then
					l_list := tables.obj (table_code).table_description.attribute_code_list
					attribute_list := l_list
				end
				if not title_list_set then
					set_col_titles (l_list)
				end
			end
			disable_multiple_selection
			is_display_ready := True
		end

	refresh (tablerow_list: ARRAYED_LIST [DB_TABLE])
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

	extend_select_actions (action: PROCEDURE [EV_MULTI_COLUMN_LIST_ROW])
			-- Extend list of actions executed when an item is selected.
		do
			select_actions.extend (action)
		end

	extend_deselect_actions (action: PROCEDURE [EV_MULTI_COLUMN_LIST_ROW])
			-- Extend list of actions executed when an item is deselected.
		do
			deselect_actions.extend (action)
		end

	set_value_list_redirector (vlr: DV_VALUE_LIST_REDIRECTOR)
			-- Set a value list redirector `vlr' to redirect
			-- fixed column results from integer string to "explicit" string.
		do
			value_list_redirector := vlr
		end

feature {NONE} -- Implementation

	set_col_titles (l_list: attached like attribute_list)
			-- Set column titles with names of attributes which codes are in `attr_codes_list'.
		local
			ind: INTEGER
			table_descr_l: ARRAYED_LIST [STRING_32]
		do
			table_descr_l := tables.obj (table_code).table_description.description_list
			from
				ind := 1
			until
				ind > l_list.count
			loop
				set_column_title (table_descr_l.i_th (l_list.i_th (ind)), ind)
				ind := ind + 1
			end
		end

	add_to_list (list_item: DB_TABLE; current_i, last_i: INTEGER)
			-- Add `list_item' representation to the list. Select it if
			-- `current_i' = `last_i'.
		local
			it: EV_MULTI_COLUMN_LIST_ROW
			l_list: like attribute_list
		do
			create it
			l_list := attribute_list
			if l_list /= Void then
				if attached value_list_redirector as l_redirector then
					it.fill (l_redirector.redirected_list (list_item.table_description.selected_attribute_list (l_list)))
				else
					it.fill (list_item.table_description.selected_printable_attribute_list (l_list))
				end
			end
			it.set_data (current_i)
			extend (it)
			if current_i = last_i then
				it.enable_select
			end
		end

	value_list_redirector: detachable DV_VALUE_LIST_REDIRECTOR
			-- Value list redirector.

	No_code: INTEGER = 0
			-- No `table_code' has been set yet.

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
