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
			l_source: like source_of_path_alias
			l_continue: BOOLEAN
		do
			error_handler.reset

			create l_parameters.make (2)
			l_parameters.put (a_source, "source")
			l_parameters.put (a_alias, "alias")
			l_source := source_of_path_alias (a_alias)
			l_continue := True
			if
				l_source /= Void -- Alias exists!
			then
				if a_source.same_string (l_source) then
					if attached path_alias (l_source) as l_alias and then l_alias.same_string (a_alias) then
							-- already up to date
						l_continue := False
					else
							-- multiple alias and a_alias is not the default alias
							-- then unset, and set again !
						unset_path_alias (a_source, a_alias)
					end
				else
					l_continue := False
					error_handler.add_custom_error (0, "alias exists", "Path alias %"" + a_alias + "%" already exists!")
				end
			end
			if l_continue then
				sql_insert (sql_insert_path_alias, l_parameters)
				sql_finalize_insert (sql_insert_path_alias)
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

				sql_modify (sql_update_path_alias, l_parameters)
				sql_finalize_modify (sql_update_path_alias)
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
					sql_modify (sql_delete_path_alias, l_parameters)
					sql_finalize_modify (sql_delete_path_alias)
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
			if not has_error and not sql_after then
				Result := sql_read_string (1)
				sql_forth
				check one_row: sql_after end
			end
			sql_finalize_query (sql_select_path_source)
		end

	source_of_path_alias (a_alias: READABLE_STRING_GENERAL): detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			create l_parameters.make (1)
			l_parameters.put (a_alias, "alias")
			sql_query (sql_select_path_alias, l_parameters)
			if not has_error then
				if not has_error and not sql_after then
					Result := sql_read_string (1)
					sql_forth
					check one_row: sql_after end
				end
			end
			sql_finalize_query (sql_select_path_alias)
		end

	path_aliases: STRING_TABLE [READABLE_STRING_8]
			-- All path aliases as a table containing sources indexed by alias.
		local
			l_source: READABLE_STRING_8
		do
			error_handler.reset
			create Result.make (5)
			sql_query (sql_select_all_path_alias, Void)
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached sql_read_string (1) as s_src then
						l_source := s_src
						if attached sql_read_string (2) as s_alias then
							Result.force (l_source, s_alias)
						end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_all_path_alias)
		end

	sql_select_all_path_alias: STRING = "SELECT source, alias, lang FROM path_aliases ORDER BY pid DESC;"
			-- SQL select all path aliases.

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
			sql_insert (sql_insert_log, l_parameters)
			sql_finalize_insert (sql_insert_log)
		end

	logs (a_category: detachable READABLE_STRING_GENERAL; a_lower: INTEGER; a_count: INTEGER): ARRAYED_LIST [CMS_LOG]
			-- <Precursor>.
		local
			l_parameters: detachable STRING_TABLE [detachable ANY]
			l_sql: READABLE_STRING_8
		do
			error_handler.reset
			create l_parameters.make (3)
			if a_category /= Void then
				l_parameters.put (a_category, "category")
				l_sql := sql_select_categorized_logs
			else
				l_sql := sql_select_logs
			end
			if a_count > 0 then
				l_parameters.put (a_lower, "offset")
				l_parameters.put (a_count, "size")
				check l_sql.ends_with_general (";") end
				l_sql := l_sql.substring (1, l_sql.count - 1) -- Remove ';'
							+ "LIMIT :size OFFSET :offset ;"
			end

			from
				if a_count > 0 then
					create Result.make (a_count)
				else
					create Result.make (10)
				end
				if l_parameters.is_empty then
					l_parameters := Void
				end
				sql_query (l_sql, l_parameters)
				sql_start
			until
				sql_after or has_error
			loop
				if attached fetch_log as l_log then
					Result.force (l_log)
				end
				sql_forth
			end
			sql_finalize_query (l_sql)
		end

	fetch_log: detachable CMS_LOG
			-- SQL: 1:id, 2:category, 3:level, 4:uid, 5:message, 6:info, 7:link, 8:date
		local
			l_cat: detachable READABLE_STRING_8
			l_mesg: detachable READABLE_STRING_8
			l_level: INTEGER
			l_date: detachable DATE_TIME
			i: INTEGER
			lnk: CMS_LOCAL_LINK
		do
			l_cat := sql_read_string (2)
			l_mesg := sql_read_string (5)
			l_level := sql_read_integer_32 (3)
			l_date := sql_read_date_time (8)

			if l_cat = Void then
				l_cat := "unknown"
			end
			if l_mesg = Void then
				l_mesg := ""
			end

			create Result.make (l_cat, l_mesg, l_level, l_date)
			Result.set_id (sql_read_integer_64 (1))
			Result.set_info (sql_read_string (6))
			if attached sql_read_string_8 (7) as l_link_text then
					-- Format:   "[title](location)"
				i := l_link_text.index_of ('(', 1)
				if i > 0 then
					create lnk.make (l_link_text.substring (i + 1, l_link_text.count - 1), l_link_text.substring (2, i - 2))
					Result.set_link (lnk)
				end
			end
		end

	sql_insert_log: STRING = "INSERT INTO logs (category, level, uid, message, info, link, date) VALUES (:category, :level, :uid, :message, :info, :link, :date);"
				-- SQL Insert to add a new node.

	sql_select_logs: STRING = "SELECT id, category, level, uid, message, info, link, date FROM logs ORDER by date DESC, id DESC;"
				-- SQL Insert to add a new node.

	sql_select_categorized_logs: STRING = "SELECT id, category, level, uid, message, info, link, date FROM logs WHERE category=:category ORDER by date DESC, id DESC;"
				-- SQL Insert to add a new node.

feature -- Misc

	set_custom_value (a_name: READABLE_STRING_8; a_value: attached like custom_value; a_type: READABLE_STRING_8)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (3)
			l_parameters.put (a_type, "type")
			l_parameters.put (a_name, "name")
			l_parameters.put (a_value, "value")
			sql_begin_transaction
			if attached custom_value (a_name, a_type) as l_value then
				if a_value.same_string (l_value) then
						-- already up to date
				else
					sql_modify (sql_update_custom_value, l_parameters)
					sql_finalize_modify (sql_update_custom_value)
				end
			else
				sql_insert (sql_insert_custom_value, l_parameters)
				sql_finalize_insert (sql_insert_custom_value)
			end
			if has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end

	unset_custom_value (a_name: READABLE_STRING_8; a_type: READABLE_STRING_8)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (2)
			l_parameters.put (a_type, "type")
			l_parameters.put (a_name, "name")
			sql_delete (sql_delete_custom_value, l_parameters)
			sql_finalize_delete (sql_delete_custom_value)
		end

	custom_value (a_name: READABLE_STRING_GENERAL; a_type: READABLE_STRING_8): detachable READABLE_STRING_32
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (2)
			l_parameters.put (a_type, "type")
			l_parameters.put (a_name, "name")
			sql_query (sql_select_custom_value, l_parameters)
			if not has_error and not sql_after then
				Result := sql_read_string_32 (1)
				sql_forth
				check one_row: sql_after end
			end
			sql_finalize_query (sql_select_custom_value)
		end

	custom_values: detachable LIST [TUPLE [name: READABLE_STRING_GENERAL; type: READABLE_STRING_8; value: detachable READABLE_STRING_32]]
			-- Values as list of [name, type, value].
		local
			l_type, l_name: READABLE_STRING_8
		do
			error_handler.reset
			create {ARRAYED_LIST [TUPLE [name: READABLE_STRING_GENERAL; type: READABLE_STRING_8; value: detachable READABLE_STRING_32]]} Result.make (5)
			sql_query (sql_select_all_custom_values, Void)
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached sql_read_string (1) as s_type then
						l_type := s_type
						if attached sql_read_string (2) as s_name then
							l_name := s_name
							if attached sql_read_string_32 (3) as s_value then
								Result.force ([l_name, l_type, s_value])
							end
						end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_all_custom_values)
		end

	sql_select_all_custom_values: STRING = "SELECT type, name, value FROM custom_values;"
				-- SQL Insert to add a new custom value.

	sql_select_custom_value: STRING = "SELECT value FROM custom_values WHERE type=:type AND name=:name;"
				-- SQL Insert to add a new custom value.

	sql_insert_custom_value: STRING = "INSERT INTO custom_values (type, name, value) VALUES (:type, :name, :value);"
				-- SQL Insert to add a new custom value.

	sql_update_custom_value : STRING = "UPDATE custom_values SET value=:value WHERE type=:type AND name=:name;"
				-- SQL Update to modify a custom value.

	sql_delete_custom_value: STRING = "DELETE FROM custom_values WHERE type=:type AND name=:name;"
				-- SQL delete custom value;


note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
