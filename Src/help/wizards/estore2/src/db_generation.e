indexing
	description: "Generation Options page"
	author: "David S"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_GENERATION

inherit
	WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

create
	make

feature -- basic Operations

	build is 
			-- Build Page entries.
		do 
			create generate_all_tables.make_with_text ("Generate All tables/views")
			create generate_specific_tables.make_with_text ("Generate Specific tables/views")
			choice_box.extend (create {EV_CELL})
			choice_box.extend (generate_all_tables)
			generate_all_tables.set_minimum_height (20)
			choice_box.disable_item_expand (generate_all_tables)
			choice_box.extend (generate_specific_tables)
			generate_specific_tables.set_minimum_height (20)
			choice_box.disable_item_expand (generate_specific_tables)
			choice_box.extend (create {EV_CELL})

			if wizard_information.generate_every_table then
				generate_all_tables.enable_select
			else
				generate_specific_tables.enable_select
			end

			set_updatable_entries (<<generate_all_tables.select_actions,
									generate_specific_tables.select_actions>>)
		end

	proceed_with_current_info is 
			-- Process user entries
		do
			precursor
			if generate_all_tables.is_selected then
				proceed_with_new_state (create {DB_GENERATION_TYPE}.make (wizard_information))
			else
				proceed_with_new_state (create {DB_TABLE_SELECTION}.make (wizard_information))
			end
		end

	update_state_information is
			-- Check user entries
		local
			cl_name: CLASS_NAME
		do
			create cl_name.make
			if is_oracle (wizard_information.dbms_code) then
				unselected_table_list := db_manager (wizard_information.dbms_code).load_list_with_select ("select TABLE_NAME from USER_TABLES",cl_name)
			elseif is_odbc (wizard_information.dbms_code) then
				unselected_table_list := db_manager (wizard_information.dbms_code).load_list_with_select ("Sqltables ()",cl_name)
			else
				create unselected_table_list.make (0)
			end
			create table_list.make (0)
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

	table_list: ARRAYED_LIST [CLASS_NAME]
		-- List of all the system tables.

	unselected_table_list: ARRAYED_LIST [CLASS_NAME]
		-- List of unselected tables.

end -- class DB_GENERATION
