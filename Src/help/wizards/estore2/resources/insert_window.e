indexing
	description: "window popped up to carry out an insert query."
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
		do
			default_create
			application := appli
			close_actions.extend (~destroy)
			make_combo_box -- Create combo_boxes.
			create_widgets
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
		local
			additional_object : DB_TABLE
			add_obj_descr: DB_TABLE_DESCRIPTION
			hbox: EV_HORIZONTAL_BOX
			cell: EV_CELL
			lab: EV_LABEL
			tf: EV_TEXT_FIELD
			i: INTEGER
			error_message: STRING
			is_ok, one_filled: BOOLEAN
			dt: DATE_TIME
		do
			additional_object ?= tables_cb.selected_item.data
			check
				additional_object /= Void
			end
			add_obj_descr := additional_object.table_description
			from
				active_rows_vb.start
				i := 1
				is_ok := True
			until
				active_rows_vb.after or else not is_ok
			loop
				hbox ?= active_rows_vb.item
				hbox.start
				hbox.forth
				cell ?= hbox.item
				lab ?= cell.item
				tf ?= hbox.last
				one_filled := one_filled or else not tf.text.is_equal ("")		
				if lab.text.is_equal ("(integer)") then
					is_ok := tf.text.is_integer or else tf.text.is_equal ("")
					if is_ok then
						if tf.text.is_equal ("") then
							tf.set_text ("0")
						end
						add_obj_descr.set_attribute (i, tf.text.to_integer)
					else
						error_message := "Please enter an integer value for attributes of type integer." 
					end
				elseif lab.text.is_equal("(double)") then
					is_ok := tf.text.is_double or else tf.text.is_integer or else tf.text.is_equal ("")
					if is_ok then
						if tf.text.is_equal ("") then
							tf.set_text ("0.0")
						elseif tf.text.is_integer then
							tf.set_text (tf.text + ".0")
						end
						add_obj_descr.set_attribute (i, tf.text.to_double)
					else
						error_message := "Please enter a double value for attributes of type double.%N%
							%This may be for instance: '3.0'. %
							%An integer value will be automatically translated." 
					end
				elseif lab.text.is_equal ("(date_time)") then
					create dt.make_now
					is_ok := dt.date_time_valid (tf.text, dt.default_format_string) or else tf.text.is_equal ("")
					if is_ok then
						if tf.text.is_equal ("") then
							tf.set_text (dt.out)
						end
						create dt.make_from_string (tf.text, dt.default_format_string)
						add_obj_descr.set_attribute (i, dt)
					else
						error_message := "Please enter a date_time value for attributes of type date_time.%N%
							%This may be for instance: '06/06/2000 12:00:00.0 PM'.%N%
							%If the field remains empty, it will be automatically filled with the system date and time." 
					end
				else
					add_obj_descr.set_attribute (i, tf.text)
				end
				active_rows_vb.forth
				i := i + 1
			end
			if is_ok and one_filled then
				db_table_manager.create_item (additional_object)
				display_results
			else
				if not one_filled then
					error_message := "Please fill in at least one of the fields."
				end
				application.popup_error_window (error_message)
			end 
		end

	display_results is
			-- Displays the table where the insertion was committed.
			-- Build a select query: "select * from <table_committed>" 
		require
			table_combo_box_not_empty: tables_cb /= Void and then tables_cb.selected_item /= Void
			active_rows_cb_not_void: active_rows_cb /= Void
		local
			query_text: STRING
			result_item_object: DB_TABLE
			result_list: ARRAYED_LIST [DB_TABLE] -- Like result_item_object.
			titles_array: ARRAY [STRING]
		do
			query_text := "select * from " + tables_cb.selected_item.text
			titles_array := convert_into_array (active_rows_cb)
			result_item_object ?= tables_cb.selected_item.data
			check
				valid_data_type: result_item_object /= Void
			end
			result_list := db_manager.load_list_with_select (query_text, result_item_object)
			application.destroy_select_results_window
			application.popup_select_results_window (result_list, titles_array)
		end

feature {NONE} -- Implementation
		
	application: APPLICATION
		-- Contains features for windows management.

end -- class INSERT_WINDOW
