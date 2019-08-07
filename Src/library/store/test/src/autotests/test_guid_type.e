note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_GUID_TYPE

inherit
	TEST_BASIC_DATABASE
		redefine
			on_prepare
		end

feature {NONE} -- Prepare

	on_prepare
			-- Prepare
		do
			Precursor;
			(create {GLOBAL_SETTINGS}).set_use_extended_types (True)
		end

feature -- Test routines

	test_uuid_type
			-- Test select using extended type
		do
			reset_database
			establish_connection

			if attached session_control as l_control and then not l_control.is_connected then
				assert ("Could not connect to database", False)
			else
				uuid_type_load_data
				uuid_type_make_selection
			end
			disconnect
		end

feature {NONE} -- Implementation

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
		once
			create Result.make (1)
				-- Do not create any object for the table to prevent table creation.
				-- We create the table directly by SQL in this test.
		end

feature {NONE} -- Basic select

	uuid_data: UUID_DATA
			-- Filled data to put into database
		do
			create Result.make ("")
		end

	uuid_type_load_data
			-- Load data
		local
			l_table_name: STRING
		do
			drop_repository (uuid_type_table_name)

			if is_odbc then
				l_table_name := sql_table_name (uuid_type_table_name)
				execute_query ("create table " + l_table_name + " (uuid_t uniqueidentifier)")
				execute_query ("insert into " + l_table_name + " (uuid_t) values ('6F9619FF-8B86-D011-B42D-00C04FC964FF')")
			end
		end

	uuid_type_make_selection
			-- Select data
		local
			l_list: ARRAYED_LIST [like uuid_data]
			l_data: like uuid_data
		do
			if is_odbc then
				l_data := uuid_data
				l_data.set_uuid_t ("6F9619FF-8B86-D011-B42D-00C04FC964FF")
				l_list := load_list_with_select (uuid_type_select_data, uuid_data)
				if l_list.count = 1 then
					assert ("Result is not expected", l_list.i_th (1) ~ l_data)
				else
					assert ("Number of results is not expected", False)
				end
			end
		end

	uuid_type_select_data: STRING
		do
			Result := "select * from " + sql_table_name (uuid_type_table_name)
		end

	uuid_type_table_name: STRING = "DB_GUID_TYPE"

end
