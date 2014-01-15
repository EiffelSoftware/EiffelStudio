note
	description: "Objects that can easily create display objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_FACTORY

create
	make

feature -- Initialization

	make
			-- Gives access.
		do
			create_tbox (100, 1, create {DV_LABEL}.make_with_text ("test"))
		end

feature -- Access

	model: DV_TABLEROW_FIELD
			-- Last processing element created.

	view: DV_BOX
			-- Last display element created.

feature -- Basic operations

	sensitive_field (a_minimum_width, a_code: INTEGER)
			-- Display field adapted to display
			-- a typed database table row.
			-- Field is sensitive.
			-- Set field minimum width to `a_minimum_width'.
			-- FIeld represent attribute with `code'
		require
			valid_minimum_width: a_minimum_width >= 0
		local
			text_field: DV_TEXT_FIELD
		do
			create text_field
			text_field.set_minimum_width (a_minimum_width)
			create_tbox (a_minimum_width, a_code, text_field)
			view.extend (text_field)
		end

	insensitive_field (a_minimum_width, a_code: INTEGER)
			-- Display field adapted to display
			-- a typed database table row.
			-- Field is insensitive.
			-- Set field minimum width to `a_minimum_width'.
		require
			valid_minimum_width: a_minimum_width >= 0
		local
			text_field: DV_TEXT_FIELD
		do
			create text_field
			text_field.set_minimum_width (a_minimum_width)
			create_tbox (a_minimum_width, a_code, text_field)
			text_field.lock_sensitiveness
			view.extend (text_field)
		end

	sensitive_area (a_minimum_width, a_code: INTEGER)
			-- Display field adapted to display
			-- a typed database table row.
			-- Field is sensitive.
			-- Set field minimum width to `a_minimum_width'.
		require
			valid_minimum_width: a_minimum_width >= 0
		local
			text: DV_TEXT
		do
			create text
			text.set_minimum_width (a_minimum_width)
			create_tbox (a_minimum_width, a_code, text)
			view.extend (text)
		end

	insensitive_area (a_minimum_width, a_code: INTEGER)
			-- Display field adapted to display
			-- a typed database table row.
			-- Field is insensitive.
			-- Set field minimum width to `a_minimum_width'.
		require
			valid_minimum_width: a_minimum_width >= 0
		local
			text: DV_TEXT
		do
			create text
			text.set_minimum_width (a_minimum_width)
			create_tbox (a_minimum_width, a_code, text)
			text.lock_sensitiveness
			view.extend (text)
		end

	sensitive_combo_box (a_minimum_width, a_code: INTEGER; combo_box: DV_COMBO_BOX)
			-- Display combo box adapted to display
			-- a typed database table row.
			-- Field is sensitive.
			-- Set field minimum width to `a_minimum_width'.
		require
			valid_minimum_width: a_minimum_width >= 0
		do
			combo_box.set_minimum_width (a_minimum_width)
			create_tbox (a_minimum_width, a_code, combo_box)
			view.extend (combo_box)
		end

	insensitive_combo_box (a_minimum_width, a_code: INTEGER; combo_box: DV_COMBO_BOX)
			-- Display combo box adapted to display
			-- a typed database table row.
			-- Field is insensitive.
			-- Set field minimum width to `a_minimum_width'.
		require
			valid_minimum_width: a_minimum_width >= 0
		do
			combo_box.set_minimum_width (a_minimum_width)
			create_tbox (a_minimum_width, a_code, combo_box)
			combo_box.lock_sensitiveness
			view.extend (combo_box)
		end

feature -- Settings

	fill_column_selecting_cbox (cbox: DV_COMBO_BOX; table_description: DB_TABLE_DESCRIPTION)
			-- Fill `cbox' with existing columns of table described by `table_description'.
		require
			not_void: cbox /= Void
			has_integer_data_behavior: cbox.behavior_type = cbox.Integer_data
			table_description_not_void: table_description /= Void
		local
			attribute_code_list: ARRAYED_LIST [INTEGER]
			description_list: ARRAYED_LIST [STRING]
		do
			attribute_code_list := table_description.attribute_code_list
			description_list := table_description.description_list
			from
				attribute_code_list.start
			until
				attribute_code_list.after
			loop
				cbox.add_data_choice (attribute_code_list.item,
						description_list.i_th (attribute_code_list.item))
				attribute_code_list.forth
			end
		end

	fill_basic_qualifying_cbox (cbox: DV_COMBO_BOX; db_handler: ABSTRACT_DB_TABLE_MANAGER)
			-- Fill `cbox' with existing columns of table described by `table_description'.
		require
			combo_box_not_void: cbox /= Void
			has_integer_data_behavior: cbox.behavior_type = cbox.Integer_data
			db_handler_not_void: db_handler /= Void
		do
			cbox.add_data_choice (db_handler.Contains_type, "contains")
			cbox.add_data_choice (db_handler.Prefix_type, "begins with")
			cbox.add_data_choice (db_handler.Suffix_type, "ends with")
			cbox.add_data_choice (db_handler.Equals_type, "equals")
			cbox.add_data_choice (db_handler.Greater_type, "is greater than")
			cbox.add_data_choice (db_handler.Lower_type, "is lower than")
		end

feature {NONE} -- Implementation

	create_tbox (a_minimum_width, a_code: INTEGER; sensitive_string: DV_SENSITIVE_STRING)
			-- Display field adapted to display
			-- a typed database table row.
			-- Set field minimum width to `a_minimum_width'.
		local
			vbox: DV_VERTICAL_BOX
			hbox: DV_HORIZONTAL_BOX
			label: DV_LABEL
		do
			create model.make_with_code (a_code)
			create vbox.make
			vbox.disable_borders
			create hbox.make
			hbox.disable_borders
			create label
			label.align_text_left
			label.lock_sensitiveness
			model.set_graphical_title (label)
			hbox.extend (label)
			create label
			label.align_text_right
			label.set_foreground_color (Type_color)
			label.lock_sensitiveness
			model.set_graphical_type (label)
			hbox.extend (label)
			vbox.extend (hbox)
			vbox.disable_item_expand (hbox)
			sensitive_string.request_insensitive
			model.set_graphical_value (sensitive_string)
			view := vbox
		end

	Type_color: EV_COLOR
			-- Color for type labels.
		once
				-- Medium grey.
			create Result.make_with_8_bit_rgb (150, 150, 150)
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"





end -- class DV_FACTORY


