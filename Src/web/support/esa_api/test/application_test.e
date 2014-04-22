class APPLICATION_TEST

inherit

	ESA_SERVER_TEST

create
	make

feature -- Initialization

	make
	local
		l_rest: ESA_RESET_DB
		l_list: ARRAYED_LIST[READABLE_STRING_GENERAL]
		l_old_dir : STRING
		l_env: EXECUTION_ENVIRONMENT
		l_clean: ESA_CLEAN_DB
	do
		create l_env
		l_old_dir := l_env.current_working_directory
		l_env.change_working_directory (current_dir)
		create l_rest
		create l_list.make_from_array (<<server_name, database_name, schema>>)
		l_rest.reset_db (l_list, False, Void)
		l_env.change_working_directory (l_old_dir)
		make_and_launch
	end



	current_dir: STRING
		local
			l_path: PATH
			l_env: EXECUTION_ENVIRONMENT
		do
			Result := (create {EXECUTION_ENVIRONMENT}).current_working_directory
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
			Result.append ("..")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
			Result.append ("database")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
			Result.append ("mssql")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
		end


end
