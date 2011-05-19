note
	description: "[
					Manager to initialize data api for database access,
					create database connection and so on
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_STORAGE_MANAGER

inherit
	GLOBAL_SETTINGS

	REFACTORING_HELPER

create
	make

feature -- Initialization

	make (a_data_app: like data_app; a_schema: like schema; a_name: like name; a_password: like password;
			a_host_name: like host_name; a_role_id: like role_id; a_role_password: like role_password
			a_data_source: like data_source; a_group: like group)
			-- Initialize with login info.
			--
			-- `a_schema' is used for MySQL
			-- `a_name', the login user name
			-- `a_password', the login user password, unencrypted.
		do
			data_app := a_data_app
			schema := a_schema
			name := a_name
			password := a_password
			host_name := a_host_name
			role_id := a_role_id
			role_password := a_role_password
			data_source := a_data_source
			group := a_group

			set_use_extended_types (True)
			set_map_zero_null_value (False)

			if attached a_schema as l_schema then
				a_data_app.set_application (l_schema.as_string_8)
			end
			if attached a_data_source as l_ds then
				a_data_app.set_data_source (l_ds)
			end
			if attached a_host_name as l_hn then
				a_data_app.set_hostname (l_hn)
			end
			if attached a_role_id as l_rid and then attached a_role_password as l_rp then
				a_data_app.set_role (l_rid, l_rp)
			end
			if attached a_group as l_group then
				a_data_app.set_group (l_group)
			end

			a_data_app.login (a_name.as_string_8, a_password.as_string_8)
			a_data_app.set_base

			create session_control.make
		end

feature -- Session

	start_session
			-- Start session
		local
			l_session_control: like session_control
		do
			if not is_session_started then
				l_session_control := session_control
				l_session_control.connect
				if l_session_control.is_connected then
					is_session_started := True
				else
					if not l_session_control.is_ok then
						print (l_session_control.error_message_32)
						io.put_new_line
					else
						print ("Session could not be started for unknown reason%N")
					end
					session_control.reset
				end
			end
		end

	end_session
			-- End session
		do
			if session_control.is_connected then
				session_control.commit
				session_control.disconnect
			end
			is_session_started := False
		end

feature -- Query

	is_session_started: BOOLEAN
			-- Is session started?

feature -- Element Change

	set_last_inserted_id_function (a_f: like last_inserted_id_function)
			-- Set `last_inserted_id_function' with `a_f'
		do
			last_inserted_id_function := a_f
		ensure
			last_inserted_id_function_set: last_inserted_id_function = a_f
		end

feature -- Misc support

	test_no_arg_stored_procedure
		local
			l_action: NO_ARGS_STORED_PROCEDURE_TEST
		do
			if attached schema as l_s then
				start_session
				if is_session_started then
					create l_action.make (new_database_change)
					l_action.set_table_schema (l_s.as_string_32)
					l_action.execute_change
				end
				end_session
			else
				print ("Schema not set!%N")
			end
		end

feature -- Access

	schema: detachable READABLE_STRING_GENERAL
			-- Schema to access

	name: READABLE_STRING_GENERAL
			-- Login user name

	password: READABLE_STRING_8
			-- Password

	host_name: detachable READABLE_STRING_8
			-- Host name, and port if needed

	role_id: detachable READABLE_STRING_8
			-- Role id

	role_password: detachable READABLE_STRING_8
			-- Role password

	data_source: detachable READABLE_STRING_8
			-- Data source

	group: detachable READABLE_STRING_8
			-- Group

	data_app: DATABASE_APPL [DATABASE]
			-- Database application

	last_inserted_id_function: detachable FUNCTION [ANY, TUPLE, NATURAL_64]
			-- Function to get last inserted id.

feature -- Factory

	new_database_change: DB_CHANGE
			-- Database change
		do
			create Result.make
		end

	new_database_selection: DB_SELECTION
			-- Database selection
		do
			create Result.make
		end

	new_procedure (a_name: like {DB_PROC}.name): DB_PROC
			-- Database procedure
		do
			create Result.make (a_name)
		end

feature {NONE} -- Implementation

	session_control: DB_CONTROL
			-- Session

end
