indexing
	description: "window popped up to carry out an insert query"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	INSERT_WINDOW

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
	make_window

feature -- Initialization

	make_window (appli: APPLICATION) is
			-- Initialize Current
		require
			not_void: appli /= Void
		local
		do
			default_create
			application := appli
			make_combo_box -- Create combo_boxes.
			create_widgets
		ensure
			application_set: appli = application
		end

	create_widgets is
			-- Design of the window including popup buttons.
		require
			combo_boxes_made: combo_boxes_made
		local
			v0: EV_VERTICAL_BOX
			h0: EV_HORIZONTAL_BOX
			b1: EV_BUTTON
			cell: EV_CELL
			lab : EV_LABEL
		do
			create v0
			extend (v0)

			create cell
			cell.set_minimum_height (10)
			v0.extend (cell)
			v0.disable_item_expand (cell)		

			create h0
			h0.set_border_width (5)
			create cell
			create lab.make_with_text ("Table:")
			lab.align_text_left
			cell.extend (lab)
			cell.set_minimum_width (117)
			h0.extend (cell)
			create cell
			create lab.make_with_text ("Attributes:")
			lab.align_text_left
			cell.extend (lab)
			cell.set_minimum_width (285)
			h0.extend (cell)
			v0.extend (h0)		
			v0.disable_item_expand (h0)		

			create h0
			h0.set_border_width (5)
			tables_cb.set_minimum_width (100)
			h0.extend (tables_cb)
			create cell
			cell.set_minimum_width (5)
			h0.extend (cell)
			h0.disable_item_expand (cell)
			active_rows_vb.set_border_width (5)
			active_rows_vb.set_minimum_width (285)
			h0.extend (active_rows_vb)			
			v0.extend (h0)		
			v0.disable_item_expand (h0)		
				
			create cell
			v0.extend (cell)

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
			-- Commit the query according to the table combo_box selection and the filled fields in the vertical box.
		require
			table_combo_box_not_empty: tables_cb /= Void and then tables_cb.selected_item /= Void
			vertical_box_not_empty: active_rows_vb /= Void and then active_rows_vb.count >= 1
			appli_not_void: application /= Void
		local
			rep : DB_REPOSITORY
			additional_object : QUERYABLE
			hbox: EV_HORIZONTAL_BOX
			cell: EV_CELL
			lab: EV_LABEL
			tf: EV_TEXT_FIELD
			error_str: STRING
		do
			error_str := is_vb_valid
			if error_str = Void then	
				create rep.make (tables_cb.selected_item.text)
				rep.load
				additional_object ?= tables_cb.selected_item.data
				from
					active_rows_vb.start
				until
					active_rows_vb.after
				loop
					hbox ?= active_rows_vb.item
					cell ?= hbox.first
					lab ?= cell.item
					tf ?= hbox.last
					additional_object.set_feature_value (lab.text, tf.text)				
					active_rows_vb.forth
				end
				db_manager.Insert_row (additional_object, rep)
				display_results
			else	
				application.popup_error_window (error_str)
			end 
		end

	display_results is
			-- Displays the table where the insertion was committed.
			-- Build a select query: "select * from <table_committed>" 
		require
			appli_not_void: application /= Void
			table_combo_box_not_empty: tables_cb /= Void and then tables_cb.selected_item /= Void
			active_rows_cb_not_void: active_rows_cb /= Void
		local
			query_text: STRING
			result_item_object: ANY
			result_list: LINKED_LIST [ANY] -- Like result_item_object.
			titles_array: ARRAY [STRING]
		do
			query_text := "select * from " + tables_cb.selected_item.text
			titles_array := convert_into_array (active_rows_cb)
			result_item_object := tables_cb.selected_item.data
			result_list := db_manager.load_list_from_select (query_text, result_item_object)
			application.destroy_select_results_window
			application.popup_select_results_window (result_list, titles_array)
		end

feature {NONE} -- Implementation
	
	is_vb_valid: STRING is
			-- Is the vertical box properly filled to launch the query? An additional row may have at least one field filled
			-- and every filled integer value must represent an integer. Return Void if everything is alright.
		require
			combo_boxes_made: combo_boxes_made = True
		local
			one_filled, is_integer, is_double, is_datetime: BOOLEAN
			hbox: EV_HORIZONTAL_BOX
			cell: EV_CELL
			lab: EV_LABEL
			tf: EV_TEXT_FIELD
			dt: DATE_TIME
		do
			is_integer := True
			is_double := True
			is_datetime := True
			from
				active_rows_vb.start
			until
				not is_integer or else not is_double or else not is_datetime or else active_rows_vb.after
			loop
				hbox ?= active_rows_vb.item
					-- Search for the second item.
				hbox.start
				hbox.forth
				cell ?= hbox.item
				lab ?= cell.item
				tf ?= hbox.last
				one_filled := one_filled or else not tf.text.is_equal ("")		
				if lab.text.is_equal ("(integer)") then
					is_integer := tf.text.is_integer or else tf.text.is_equal ("")
					if tf.text.is_equal ("") then
						tf.set_text ("0")
					end
				elseif lab.text.is_equal("(double)") then
					is_double := tf.text.is_double or else tf.text.is_integer or else tf.text.is_equal ("")
					if tf.text.is_equal ("") then
						tf.set_text ("0.0")
					elseif tf.text.is_integer then
						tf.set_text (tf.text + ".0")
					end
				elseif lab.text.is_equal ("(date_time)") then
					create dt.make_now
					is_datetime := dt.date_time_valid (tf.text, dt.default_format_string) or else tf.text.is_equal ("")
					if tf.text.is_equal ("") then
						tf.set_text (dt.out)
					end
				end
				active_rows_vb.forth
			end
			if not one_filled then
				Result := "Please fill in at least one of the fields."
			elseif not is_integer then
				Result := "Please enter an integer value for attributes of type integer." 
			elseif not is_double then
				Result := "Please enter a double value for attributes of type double.%N%
					%This may be for instance: '3.0'.%
					%An integer value will be automatically translated." 
			elseif not is_datetime then
				Result := "Please enter a date_time value for attributes of type date_time.%N%
					%This may be for instance: '06/06/2000 12:00:00.0 PM'.%N%
					%If the field remains empty, it will be automatically filled with the system date and time." 
			end
		end

feature -- Implementation
		
	application: APPLICATION
		-- Contains features for windows management.
		
end -- class INSERT_WINDOW

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
