indexing
	description: "window popped up to carry out a select query"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	SELECT_WINDOW

inherit
	EV_TITLED_WINDOW
		rename initialize as ev_t_window_initialize
		end

	MY_DB_INFO
		undefine
			default_create
		end

		-- Inherit DB_SHARED to have an access to the Database Manager
	DB_SHARED
		undefine
			default_create
		end
		
create
	make_window,
	make_with_table

feature -- Initialization

	make_window (appli: APPLICATION) is
			-- Initialize Current
		require
			not_void: appli /= Void
		local
		do
			default_create
			application := appli
			close_actions.extend (~destroy)
			make_combo_box -- Create combo_boxes.
			create_widgets
		ensure
			application_set: appli = application
		end

	make_with_table (appli: APPLICATION; table: EV_COMBO_BOX) is
			-- Creation without display.
		require
			not_void: appli /= Void and then table /= Void
		local
		do
			application := appli
			make_combo_box -- Create combo_boxes.
			tables_cb := table
		ensure
			application_set: appli = application
			combo_boxes_made
			table_set: tables_cb = table
		end

	create_widgets is
			-- Design of the window including popup buttons.
		require
			combo_boxes_made: combo_boxes_made
		local
			v0: EV_VERTICAL_BOX
			h0 : EV_HORIZONTAL_BOX
			b1: EV_BUTTON
			cell : EV_CELL
			lab : EV_LABEL
		do
			create v0
			extend (v0)

			create cell
			cell.set_minimum_height (10)
			v0.extend (cell)

			create h0
			h0.set_border_width (5)
			create cell
			h0.extend (cell)
			create cell
			create lab.make_with_text ("Table:")
			lab.align_text_left
			cell.extend (lab)
			cell.set_minimum_width (100)
			h0.extend (cell)
			create cell
			create lab.make_with_text ("Attribute:")
			lab.align_text_left
			cell.extend (lab)
			cell.set_minimum_width (100)
			h0.extend (cell)
			v0.extend (h0)		

			create h0
			h0.set_border_width (5)
			create cell
			h0.extend (cell)
			tables_cb.set_minimum_width (100)
			h0.extend (tables_cb)
			active_rows_cb.set_minimum_width (100)
			h0.extend (active_rows_cb)
			v0.extend (h0)					
			
			create h0
			h0.set_border_width (5)
			create cell
			h0.extend (cell)
			create b1.make_with_text_and_action ("Go!", ~launch_query)
			b1.set_minimum_size (50, 20)
			h0.extend (b1)	
			h0.disable_item_expand (b1)
			create cell
			cell.set_minimum_width (5)
			h0.extend (cell)
			h0.disable_item_expand (cell)
			create b1.make_with_text_and_action ("Close", ~destroy)
			b1.set_minimum_size (50, 20)
			h0.extend (b1)	
			h0.disable_item_expand (b1)
			create cell
			cell.set_minimum_width (5)
			h0.extend (cell)
			h0.disable_item_expand (cell)
			create b1.make_with_text_and_action ("Exit", application~destroy_windows)
			b1.set_minimum_size (50, 20)
			h0.extend (b1)	
			h0.disable_item_expand (b1)
			v0.extend (h0)
			v0.disable_item_expand (h0)		
		end

feature

	launch_query is
			-- Commit the query according to the combo_boxes selections.
		require
			combo_boxes_not_empty: tables_cb.selected_item /= Void and then active_rows_cb.selected_item /= Void
			appli_not_void: application /= Void
		local
			query_text : STRING
			result_item_object : DB_TABLE
			result_list : ARRAYED_LIST [DB_TABLE] -- Like result_item_object.
			titles_array : ARRAY [STRING]
		do
			query_text := "select " + active_rows_cb.selected_item.text + " from " 
				+ tables_cb.selected_item.text
			if active_rows_cb.selected_item.text.is_equal ("*") then
				titles_array := convert_into_array (active_rows_cb)
			else
				create titles_array.make (1, 1)
				titles_array.put (active_rows_cb.selected_item.text, 1)
			end
			result_item_object ?= tables_cb.selected_item.data
			check
				result_item_object /= Void
			end
			result_list := db_manager.load_list_with_select (query_text, result_item_object)
			application.destroy_select_results_window
			application.popup_select_results_window (result_list, titles_array)
		end
		
feature -- Implementation
		
	application: APPLICATION
		-- Contains features for windows' management.
		
end -- class SELECT_WINDOW

--|----------------------------------------------------------------
--| Eiffel COOL:Jex: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
