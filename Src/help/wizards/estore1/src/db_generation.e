indexing
	description: "Generation Options page"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_GENERATION

inherit
	WIZARD_STATE_WINDOW
		redefine 
			update_state_information,
			proceed_with_current_info
		end

	WIZARD_SHARED
		undefine
			default_create
		end

creation
	make

feature -- basic Operations

	display is 
			-- Display user entries
		do
			build
		end

	build is 
			-- Build Page entries.
		do 
			Create generate_all_tables.make_with_text("Generate All tables/views")
			Create generate_specific_tables.make_with_text("Generate Specific tables/views")
			if state_information.generate_every_table then
				generate_all_tables.enable_select
			else
				generate_specific_tables.enable_select
			end
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(generate_all_tables)
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(generate_specific_tables)

			set_updatable_entries(<<generate_all_tables.press_actions,
									generate_specific_tables.press_actions>>)
		end

	proceed_with_current_info is 
			-- Process user entries
		do
			precursor
			if generate_all_tables.is_selected then
				proceed_with_new_state(Create {DB_GENERATION_TYPE}.make(state_information))
			else
				proceed_with_new_state(Create {DB_TABLE_SELECTION}.make(state_information))
			end
		end

	update_state_information is
			-- Check user entries
		local
			cl_name: CLASS_NAME
		do
			Create cl_name.make
			if is_oracle then
				table_list := db_manager.load_list_from_select("select TABLE_NAME from USER_TABLES",cl_name)
			elseif is_odbc then
				table_list := db_manager.load_list_from_select("Sqltables()",cl_name)
			else
				Create table_list.make
			end
			state_information.set_generate_all_table(generate_all_tables.is_selected)
			state_information.set_table_list(table_list)
			precursor
		end

feature -- Implementation

	generate_all_tables,generate_specific_tables: EV_RADIO_BUTTON
		-- Button which are provided in order to allow
		-- the user to choose which type of generation he	
		-- wish to do.

	table_list: LINKED_LIST[CLASS_NAME]
		-- List of all the system tables.

	pixmap_location: STRING is "essai2.bmp"
			-- Pixmap location
	
end -- class DB_GENERATION
