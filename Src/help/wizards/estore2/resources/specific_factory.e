indexing
	description: "Objects that can easily create display objects."
	author: "Cedric Reduron"
	date: "$Date$"
	revision: "$Revision$"

class
	SPECIFIC_FACTORY

inherit
	DV_FACTORY

	SHARED

create
	make

feature -- Settings

	add_controls (table_component: DV_TABLE_COMPONENT; cont: DV_BOX) is
			-- Add standard controls to `table_component', create associated buttons and
			-- add them to `cont'.
		local
			button: DV_BUTTON
		do
			create button.make_with_text ("Apply")
			cont.extend (button)
			table_component.set_writing_control (button)
			create button.make_with_text ("Refresh")
			cont.extend (button)
			table_component.set_refreshing_control (button)
			create button.make_with_text ("Create")
			cont.extend (button)
			add_creator (table_component, button)
			create button.make_with_text ("Delete")
			cont.extend (button)
			table_component.set_deleting_control (button)
		end

	add_creator (table_comp: DV_TABLE_COMPONENT; button: DV_BUTTON) is
			-- Set a creator component to `table_comp'.
		local
			db_creator: DV_CHOICE_CREATOR
			db_tablerow_selector: DV_TABLEROW_ID_PROVIDER
			fields_list_comp: DV_CONTROL_NAVIGATOR
			tr_list: DV_TABLEROW_MULTILIST
			selection_window: DV_SELECTION_WINDOW
		do
			create db_creator.make
			db_creator.set_control (button)
			create tr_list
			create fields_list_comp.make
			fields_list_comp.set_display_list (tr_list)
			create db_tablerow_selector.make
			db_tablerow_selector.set_db_tablerow_navigator (fields_list_comp)
			create selection_window.make
			selection_window.set_display_list (tr_list)
			selection_window.set_content
			db_tablerow_selector.set_selecting_control (selection_window.selecting_control)
			db_tablerow_selector.set_raising_action (selection_window~show)
			db_creator.set_tablerow_selector (db_tablerow_selector)
			table_comp.set_db_creator (db_creator)
		end

	add_display_searcher (table_component: DV_TABLE_COMPONENT; cont: EV_CONTAINER) is
			-- Add a graphical searcher to `table_component' and add its display
			-- to `cont'.
		local
			button: DV_BUTTON
			cbox: DV_COMBO_BOX
			tfield: DV_TEXT_FIELD
			db_searcher: DV_INTERACTIVE_SEARCHER
			cbutton: DV_CHECK_BUTTON
			bar: DV_HORIZONTAL_BOX
		do
			create bar.make
			create db_searcher.make
			create first_cbox.make_with_integer_data
			fill_column_selecting_cbox (first_cbox, table_component.table_description)
			db_searcher.set_column_selector (first_cbox)
			bar.extend (first_cbox)
			create cbox.make_with_integer_data
			fill_basic_qualifying_cbox (cbox, db_manager)
			db_searcher.set_qualification_selector (cbox)
			bar.extend (cbox)
			create tfield
			db_searcher.set_value_selector (tfield)
			bar.extend (tfield)
			bar.enable_item_expand (tfield)
			create cbutton.make_with_text ("Case sensitive")
			db_searcher.set_case_selector (cbutton)
			bar.extend (cbutton)
			bar.disable_item_expand (cbutton)
			create button.make_with_text ("Go!")
			db_searcher.set_control (button)
			bar.extend (button)
			bar.disable_item_expand (button)
			table_component.set_db_searcher (db_searcher)
			cont.extend (bar)
		end

feature -- Access

	first_cbox: DV_COMBO_BOX
			-- First combo box created through `add_display_searcher'.

end -- class SPECIFIC_FACTORY
