indexing
	description: "Generation Options page"
	author: "David S"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_GENERATION

inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

	WIZARD_SHARED
		undefine
			default_create
		end

create
	make

feature -- basic Operations

	build is 
			-- Build Page entries.
		do 
			Create generate_all_tables.make_with_text("Generate All tables/views")
			Create generate_specific_tables.make_with_text("Generate Specific tables/views")
			if wizard_information.generate_every_table then
				generate_all_tables.enable_select
			else
				generate_specific_tables.enable_select
			end
			choice_box.extend(Create {EV_CELL})
			choice_box.extend(generate_all_tables)
			generate_all_tables.set_minimum_height (20)
			choice_box.disable_item_expand (generate_all_tables)
			choice_box.extend(generate_specific_tables)
			generate_specific_tables.set_minimum_height (20)
			choice_box.disable_item_expand (generate_specific_tables)
			choice_box.extend(Create {EV_CELL})

			set_updatable_entries(<<generate_all_tables.select_actions,
									generate_specific_tables.select_actions>>)
		end

	proceed_with_current_info is 
			-- Process user entries
		do
			precursor
			if generate_all_tables.is_selected then
				proceed_with_new_state(Create {DB_GENERATION_TYPE}.make(wizard_information))
			else
				proceed_with_new_state(Create {DB_TABLE_SELECTION}.make(wizard_information))
			end
		end

	update_state_information is
			-- Check user entries
		local
			cl_name: CLASS_NAME
		do
			Create cl_name.make
			if is_oracle then
				unselected_table_list := db_manager.load_list_from_select ("select TABLE_NAME from USER_TABLES",cl_name)
			elseif is_odbc then
				unselected_table_list := db_manager.load_list_from_select ("Sqltables()",cl_name)
			else
				create unselected_table_list.make
			end
			create table_list.make
			wizard_information.set_generate_all_table (generate_all_tables.is_selected)
			wizard_information.set_unselected_table_list (unselected_table_list)
			if generate_all_tables.is_selected then
				wizard_information.set_table_list (unselected_table_list)
				wizard_information.set_unselected_table_list (table_list)
			else
				wizard_information.set_table_list (table_list)
			end
			precursor
		end

	display_state_text is
		do
			title.set_text ("STEP 2: TABLE SELECTION")
			message.set_text ("%NChoose if you want to automatically generate all the tables of your database%
								%%Nor if you prefer to choose your own tables.")
		end

feature -- Implementation

	generate_all_tables,generate_specific_tables: EV_RADIO_BUTTON
		-- Button which are provided in order to allow
		-- the user to choose which type of generation he	
		-- wish to do.

	table_list: LINKED_LIST [CLASS_NAME]
		-- List of all the system tables.

	unselected_table_list: LINKED_LIST [CLASS_NAME]
		-- List of unselected tables.

end -- class DB_GENERATION
