indexing
	description: "Generation Options page"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_GENERATION

inherit
	STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info
		end

	SHARED
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
			Create generate_all_tables.make_with_text("Generate All tables/Views")
			generate_all_tables.enable_select
			generate_all_tables.press_actions.extend(~change_entries)
			Create load_classes_b.make_with_text("Select generated Tables/Views")
			generate_all_tables.press_actions.extend(~change_entries)
			main_box.extend(generate_all_tables)
			main_box.extend(load_classes_b)
		end

	proceed_with_current_info is 
			-- Process user entries
		local
			db_generation_type: DB_GENERATION_TYPE
			message: EV_ERROR_DIALOG
		do
			precursor
			if generate_all_tables.is_selected then
				Create db_generation_type.make(state_information)
				proceed_with_new_state(db_generation_type)
				--proceed_with_new_state(Create {DB_GENERATION_TYPE}.make(state_information))
			else
				proceed_with_new_state(Create {DB_TABLE_SELECTION}.make(state_information))
			end
		end

	update_state_information is
			-- Check user entries
		local
			li: LINKED_LIST[CLASS_NAME]
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
			state_information.set_table_list(table_list)
			precursor
		end

feature -- Implementation

	generate_all_tables,load_classes_b: EV_CHECK_BUTTON

	table_list: LINKED_LIST[CLASS_NAME]
		-- List of all the system tables.
	
end -- class DB_GENERATION
