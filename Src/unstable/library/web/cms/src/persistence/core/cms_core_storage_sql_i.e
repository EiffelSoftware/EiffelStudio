note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_CORE_STORAGE_SQL_I

inherit
	CMS_CORE_STORAGE_I

	CMS_STORAGE_SQL_I

	REFACTORING_HELPER

	SHARED_LOGGER

feature -- URL aliases

	set_path_alias (a_source: READABLE_STRING_8; a_alias: READABLE_STRING_8)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (2)
			l_parameters.put (a_source, "source")
			l_parameters.put (a_alias, "alias")
			if attached source_of_path_alias (a_alias) as l_path then
				if a_source.same_string (l_path) then
						-- already up to date
				else
					error_handler.add_custom_error (0, "alias exists", "Path alias %"" + a_alias + "%" already exists!")
				end
			else
				sql_change (sql_insert_path_alias, l_parameters)
			end
		end

	replace_path_alias (a_source: READABLE_STRING_8; a_previous_alias: detachable READABLE_STRING_8; a_alias: READABLE_STRING_8)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_previous_alias: detachable READABLE_STRING_8
		do
			error_handler.reset

			if a_previous_alias = Void then
				l_previous_alias := path_alias (a_source)
			else
				l_previous_alias := a_previous_alias
			end
			if
				l_previous_alias /= Void and then
				not a_alias.same_string (l_previous_alias)
			then
				create l_parameters.make (3)
				l_parameters.put (a_source, "source")
				l_parameters.put (l_previous_alias, "old")
				l_parameters.put (a_alias, "alias")

				sql_change (sql_update_path_alias, l_parameters)
			end
		end

	unset_path_alias (a_source: READABLE_STRING_8; a_alias: READABLE_STRING_8)
			-- <Precursor>	
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			if attached source_of_path_alias (a_alias) as l_path then
				if a_source.same_string (l_path) then
						-- Found
					create l_parameters.make (1)
					l_parameters.put (a_alias, "alias")
					sql_change (sql_delete_path_alias, l_parameters)
				else
					error_handler.add_custom_error (0, "alias mismatch", "Path alias %"" + a_alias + "%" is not related to source %"" + a_source + "%"!")
				end
			else
					-- No such alias
			end
		end

	path_alias (a_source: READABLE_STRING_8): detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			create l_parameters.make (1)
			l_parameters.put (a_source, "source")
			sql_query (sql_select_path_source, l_parameters)
			if not has_error then
				if sql_rows_count = 1 then
					Result := sql_read_string (1)
				end
			end
		end

	source_of_path_alias (a_alias: READABLE_STRING_8): detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			create l_parameters.make (1)
			l_parameters.put (a_alias, "alias")
			sql_query (sql_select_path_alias, l_parameters)
			if not has_error then
				if sql_rows_count = 1 then
					Result := sql_read_string (1)
				end
			end
		end

	sql_select_path_alias: STRING = "SELECT source FROM path_aliases WHERE alias=:alias ;"
			-- SQL select path aliases.

	sql_select_path_source: STRING = "SELECT alias FROM path_aliases WHERE source=:source ORDER BY pid DESC LIMIT 1;"
			-- SQL select latest path aliasing :source.			

	sql_insert_path_alias: STRING = "INSERT INTO path_aliases (source, alias) VALUES (:source, :alias);"
			-- SQL insert path alias.			

	sql_update_path_alias: STRING = "UPDATE path_aliases SET alias=:alias WHERE source=:source AND alias=:old ;"
			-- SQL update path alias.

	sql_delete_path_alias: STRING = "DELETE FROM path_aliases WHERE alias=:alias;"
			-- SQL delete path alias			

feature -- Logs

	save_log (a_log: CMS_LOG)
			-- Save `a_log'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			now: DATE_TIME
			s32: STRING_32
		do
			create now.make_now_utc
			error_handler.reset

			create l_parameters.make (8)
			l_parameters.put (a_log.category, "category")
			l_parameters.put (a_log.level, "level")
			l_parameters.put (0, "uid") -- Unsupported for now
			l_parameters.put (a_log.message, "message")
			l_parameters.put (a_log.info, "info")
			if attached a_log.link as lnk then
				create s32.make_empty
				s32.append_character ('[')
				s32.append_string_general (lnk.location)
				s32.append_character (']')
				s32.append_character ('(')
				s32.append (lnk.title)
				s32.append_character (')')
				l_parameters.put (s32, "link")
			else
				l_parameters.put (Void, "link")
			end
			l_parameters.put (now, "date")
			sql_change (sql_insert_log, l_parameters)
		end

	sql_insert_log: STRING = "INSERT INTO logs (category, level, uid, message, info, link, date) VALUES (:category, :level, :uid, :message, :info, :link, :date);"
				-- SQL Insert to add a new node.

feature -- Misc

	set_custom_value (a_name: READABLE_STRING_8; a_value: attached like custom_value; a_type: detachable READABLE_STRING_8)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (3)
			if a_type /= Void then
				l_parameters.put (a_type, "type")
			else
				l_parameters.put (a_type, "default")
			end
			l_parameters.put (a_name, "name")
			l_parameters.put (a_value, "value")
			if attached custom_value (a_name, a_type) as l_value then
				if a_value.same_string (l_value) then
						-- already up to date
				else
					sql_change (sql_update_custom_value, l_parameters)
				end
			else
				sql_change (sql_insert_custom_value, l_parameters)
			end
		end

	unset_custom_value (a_name: READABLE_STRING_8; a_type: detachable READABLE_STRING_8)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (3)
			if a_type /= Void then
				l_parameters.put (a_type, "type")
			else
				l_parameters.put (a_type, "default")
			end
			l_parameters.put (a_name, "name")
			sql_change (sql_delete_custom_value, l_parameters)
		end

	custom_value (a_name: READABLE_STRING_GENERAL; a_type: detachable READABLE_STRING_8): detachable READABLE_STRING_32
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (2)
			if a_type /= Void then
				l_parameters.put (a_type, "type")
			else
				l_parameters.put (a_type, "default")
			end
			l_parameters.put (a_name, "name")
			sql_query (sql_select_custom_value, l_parameters)
			if not has_error then
				if sql_rows_count = 1 then
					Result := sql_read_string_32 (1)
				end
			end
		end

	sql_select_custom_value: STRING = "SELECT value FROM custom_values WHERE type=:type AND name=:name;"
				-- SQL Insert to add a new custom value.

	sql_insert_custom_value: STRING = "INSERT INTO custom_values (type, name, value) VALUES (:type, :name, :value);"
				-- SQL Insert to add a new custom value.

	sql_update_custom_value : STRING = "UPDATE custom_values SET value=:value WHERE type=:type AND name=:name;"
				-- SQL Update to modify a custom value.

	sql_delete_custom_value: STRING = "DELETE FROM custom_values WHERE type=:type AND name=:name;"
				-- SQL delete custom value;


end
