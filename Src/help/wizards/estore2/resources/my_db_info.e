indexing
	description: "Generation of tables and tables' rows of the chosen database"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MY_DB_INFO

inherit
		-- Enable to access integer codes corresponding to types for a table attribute.
		-- These codes may change according to the database used.
	TYPES [<DATABASE_NAME>]

feature -- Trigger

	make_combo_box is
			-- Create combo_boxes. 
		local
			eli: EV_LIST_ITEM
<TAG_LOCAL_DEFINITIONS
>		do
			create tables_cb
			tables_cb.disable_edit
			create active_rows_cb
			active_rows_cb.disable_edit
			create eli.make_with_text ("*")
			active_rows_cb.extend (eli)
			create active_rows_vb

				-- Autogeneration of the tables according to
				-- the selection made in the wizard HCI.
			<TAG_CREATION_TABLES>
			tables_cb.first.enable_select 	-- Select the first item : set the top part of the combo_box
			active_rows_cb.first.enable_select
			combo_boxes_made:= True
		ensure
			combo_boxes_made: combo_boxes_made = True
			item_selected: tables_cb.selected_item /= void and active_rows_cb.selected_item /= void
			table_cb_item_has_data: table_cb_item_has_data
		end

	update_active_rows_cb (table: STRING) is
			-- Fill the combo_box corresponding to the rows of the active table and
			-- sets active_rows_cb.
		require
			not_void: table /= Void and then active_rows_cb /= Void
		local
			eli: EV_LIST_ITEM
			rep: DB_REPOSITORY
			col: COLUMNS [DATABASE]
			i: INTEGER
		do
			create rep.make (table)
			rep.load
			active_rows_cb.wipe_out
			create eli.make_with_text ("*")
			active_rows_cb.extend (eli)
			from
				i:= 1
			until
				i > rep.column_number
			loop
				col:= rep.column_i_th (i)
				col.column_name.to_lower
				create eli.make_with_text (col.column_name)
				active_rows_cb.extend (eli)
				i:= i + 1
			end
			active_rows_cb.first.enable_select 	-- Select the first item : set the top part of the combo_box
		ensure
			item_selected: tables_cb.selected_item /= void and active_rows_cb.selected_item /= void
		end
		
	update_active_rows_vb (table: STRING) is
			-- Fill the vertical box corresponding to the rows of the active table and
			-- sets active_rows_vb.
		require
			not_void: active_rows_vb /= Void and then table /= Void
		local
			rep: DB_REPOSITORY
			col: COLUMNS [DATABASE]
			hbox: EV_HORIZONTAL_BOX
			cell: EV_CELL
			lab: EV_LABEL
			tf: EV_TEXT_FIELD
			i, type_code: INTEGER
			str, type_info: STRING
		do
			create rep.make (table)
			rep.load
			active_rows_vb.wipe_out
			from
				i:= 1
			until
				i > rep.column_number
			loop
				col:= rep.column_i_th (i)
				col.column_name.to_lower
				type_code:= col.eiffel_type
					-- 'type_info' values may be changed but have to be updated in class 'INSERT_WINDOW', feature 'is_vb_valid'.				
				if type_code = Integer_type_database then
					type_info := "(integer)"
				elseif type_code = Boolean_type_database then
					type_info := "(boolean)"
				elseif type_code = Real_type_database then
					type_info := "(double)"
				elseif type_code = Float_type_database then
					type_info := "(double)"
				elseif type_code = String_type_database or type_code = Character_type_database then
					if col.data_length = 1 then
						type_info := "(character)"
					else
						type_info := "(string)"
					end
				elseif type_code = Date_type_database then
					type_info := "(date_time)"
				else
					type_info :=  "(any)"
				end
				create hbox
				create cell
				cell.set_minimum_width (100)				
				create lab.make_with_text (col.column_name)
				lab.align_text_left
				cell.extend (lab)
				hbox.extend (cell)
				create cell
				cell.set_minimum_width (50)				
				create lab.make_with_text (type_info)
				lab.align_text_left
				cell.extend (lab)
				hbox.extend (cell)
				create tf
				tf.set_minimum_width (100)
				hbox.extend (tf)
				active_rows_vb.extend (hbox)
				i:= i + 1
			end
			ensure	
				positive: active_rows_vb.count >= 1
		end
		
feature {NONE} -- Implementation

	convert_into_array (lis: EV_COMBO_BOX): ARRAY [STRING] is
			-- Extract the text fields of the combo_box and fill the array, excepting for "*".
			-- 'lis' is required to contain one and only one '*' text. 
		require
			not_void: lis /= Void
		local
			i: INTEGER
		do
			create Result.make (1, lis.count - 1)
			from
				lis.start
				i:= 1
			until
				lis.after
			loop
				if not lis.item.text.is_equal ("*") then
					Result.put (lis.item.text, i)
					i:= i+1
				end --if
				lis.forth
			end
		end	
		
feature -- Access

	tables_cb: EV_COMBO_BOX
		-- Table's ev_list made from wizard using tags.
		
	active_rows_cb: EV_COMBO_BOX
		-- Ev_list of selected table's rows.

	active_rows_vb: EV_VERTICAL_BOX
		-- Ev_list of selected table's rows.

feature -- Status

	combo_boxes_made: BOOLEAN
		-- Are the combo boxes made?
	
	table_cb_item_has_data: BOOLEAN is
			-- Does the current combo box item from "table_cb" has a data of class 'QUERYABLE' associated?
		require
			table_cb_item_selected: tables_cb.selected_item /= void
		local
			q: QUERYABLE
		do
			q?= tables_cb.selected_item.data
			Result:= q /= Void
		end
		
end -- class MY_DB_INFO


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
