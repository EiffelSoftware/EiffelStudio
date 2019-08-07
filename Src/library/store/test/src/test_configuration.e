note
	description : "Objects that ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CONFIGURATION

create
	make

feature {NONE} -- Initialization

	make (fn: STRING)
			-- Initialize `Current'.
		do
			create json_config.make (fn)
			json_config.load
		end

	json_config: JSON_CONFIGURATION

feature -- Access

	item (k: STRING): detachable STRING
		do
			Result := json_config.item (k)
		end

feature -- Access

	script_dir: STRING
		do
			if attached item ("script.script_dir") as l_s then
				Result := l_s
			else
				Result := "../../schema_scripts"
			end
			Result := adapt_path_to_current_platform (Result)
		end

	tool_mysql_path: STRING
		do
			if attached item ("tool.mysql_path") as l_s and then not l_s.is_empty then
				Result := l_s
			else
				Result := "mysql"
			end
			Result := adapt_path_to_current_platform (Result)
		end

	database_name: detachable STRING
		do
			Result := item ("database.name")
		end

	database_server: STRING
		do
			if attached item ("database.server") as l_s then
				Result := l_s
			else
				Result := "localhost"
			end
		end

	database_user_name: detachable STRING
		do
			Result := item ("database.user_name")
		end

	database_user_passwd: detachable STRING
		do
			Result := item ("database.user_passwd")
		end

	has_database_administrative_info: BOOLEAN
		do
			Result := database_administrative_user /= Void
		end

	database_administrative_user: detachable STRING
		do
			Result := item ("database.administrative_user")
		end

	database_administrative_passwd: detachable STRING
		do
			Result := item ("database.administrative_user_passwd")
		end

feature {NONE} -- Implemetation

	adapt_path_to_current_platform (a_path: STRING): STRING
		do
			create Result.make_from_string (a_path)
			if {PLATFORM}.is_windows then
				Result.replace_substring_all ("/", "\")
			else
				Result.replace_substring_all ("\", "/")
			end
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
