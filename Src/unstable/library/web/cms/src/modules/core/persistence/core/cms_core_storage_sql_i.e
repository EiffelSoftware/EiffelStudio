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

	logs (a_category: detachable READABLE_STRING_GENERAL; a_level: INTEGER; a_offset: INTEGER; a_count: INTEGER): ARRAYED_LIST [CMS_LOG]
			-- <Precursor>.
		local
			l_parameters: detachable STRING_TABLE [detachable ANY]
			l_sql: READABLE_STRING_8
		do
			error_handler.reset
			create l_parameters.make (3)
			if a_category /= Void then
				l_parameters.put (a_category, "category")
				if a_level > 0 then
					l_parameters.put (a_level, "level")
					l_sql := sql_select_level_and_categorized_logs
				else
					l_sql := sql_select_categorized_logs
				end
			elseif a_level > 0 then
				l_parameters.put (a_level, "level")
				l_sql := sql_select_level_logs
			else
				l_sql := sql_select_logs
			end
			if a_count > 0 then
				check l_sql.ends_with_general (";") end
				l_sql := l_sql.substring (1, l_sql.count - 1) -- Remove ';'
				l_sql := l_sql + " LIMIT " + a_count.out
				l_sql := l_sql + " OFFSET " + a_offset.out
				l_sql := l_sql + " ;"
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

	sql_select_logs: STRING = "SELECT id, category, level, uid, message, info, link, date FROM logs ORDER by date DESC, id DESC;"

	sql_select_categorized_logs: STRING = "SELECT id, category, level, uid, message, info, link, date FROM logs WHERE category=:category ORDER by date DESC, id DESC;"

	sql_select_level_and_categorized_logs: STRING = "SELECT id, category, level, uid, message, info, link, date FROM logs WHERE category=:category AND level=:level ORDER by date DESC, id DESC;"

	sql_select_level_logs: STRING = "SELECT id, category, level, uid, message, info, link, date FROM logs WHERE level=:level ORDER by date DESC, id DESC;"

feature -- Emails

	save_mail (a_mail: CMS_EMAIL)
		local
			vis: JSON_PRETTY_STRING_VISITOR
			s: STRING
			l_parameters: STRING_TABLE [detachable ANY]
			l_retried: BOOLEAN
		do
			if not l_retried then
				error_handler.reset

				create l_parameters.make (8)
				l_parameters.put (a_mail.id, "mid")
				l_parameters.put (a_mail.date, "date")
				l_parameters.put ("email", "msgtype")
				if a_mail.is_sent then
					l_parameters.put ("sent", "status")
				else
					l_parameters.put ("waiting", "status")
				end
				if attached a_mail.to_user as l_to_user then
					l_parameters.put (l_to_user.id, "user_to")
				else
					l_parameters.put (0, "user_to")
				end
				if attached a_mail.from_user as l_from_user then
					l_parameters.put (l_from_user.id, "user_from")
				else
					l_parameters.put (0, "user_from")
				end
				l_parameters.put (a_mail.subject, "subject")

				create s.make_empty
				create vis.make_custom (s, 3, 3)
				vis.visit_json_object (mail_to_json (a_mail))
				l_parameters.put (s, "data")

				sql_begin_transaction
				sql_insert (sql_insert_message, l_parameters)
				sql_finalize_insert (sql_insert_message)
				if has_error then
					sql_rollback_transaction
				else
					sql_commit_transaction
				end
			else
				-- TODO: better error handling
			end
		rescue
			l_retried := True
			retry
		end

	mails_to (a_user: detachable CMS_USER; a_offset: INTEGER; a_count: INTEGER): detachable LIST [CMS_EMAIL]
			-- <Precursor>.
		local
			l_parameters: detachable STRING_TABLE [detachable ANY]
			l_sql: READABLE_STRING_8
		do
			error_handler.reset
			create l_parameters.make (2)

			l_parameters.put ("email", "msgtype")

			if a_user /= Void then
				l_parameters.put (a_user.id, "user_to")
				l_sql := sql_select_messages_by_user_to
			else
				l_sql := sql_select_messages
			end

			if a_count > 0 then
				check l_sql.ends_with_general (";") end
				l_sql := l_sql.substring (1, l_sql.count - 1) -- Remove ';'
				l_sql := l_sql + " LIMIT " + a_count.out
				l_sql := l_sql + " OFFSET " + a_offset.out
				l_sql := l_sql + " ;"
			end

			from
				if a_count > 0 then
					create {ARRAYED_LIST [CMS_EMAIL]} Result.make (a_count)
				else
					create {ARRAYED_LIST [CMS_EMAIL]} Result.make (10)
				end
				if l_parameters.is_empty then
					l_parameters := Void
				end
				sql_query (l_sql, l_parameters)
				sql_start
			until
				sql_after or has_error
			loop
				if attached fetch_mail as l_msg then
					Result.force (l_msg)
				end
				sql_forth
			end
			sql_finalize_query (l_sql)
		end

	mail_to_json (m: CMS_EMAIL): JSON_OBJECT
		local
			arr: JSON_ARRAY
			obj: JSON_OBJECT
			lst: LIST [READABLE_STRING_8]
		do
			create Result.make_with_capacity (5)
			create obj.make_with_capacity (2)
			if m.is_sent then
				obj.put_string ("sent", "status")
			else
				obj.put_string ("waiting", "status")
			end
			if attached m.to_user as u then
				obj.put_string (u.id.out, "to_user.id")
				obj.put_string (u.name, "to_user.name")
			end
			if attached m.from_user as u then
				obj.put_string (u.id.out, "from_user.id")
				obj.put_string (u.name, "from_user.name")
			end

			Result.put (obj, "info")

			Result.put_string ({CMS_API}.date_time_to_iso8601_string (m.date), "date")
			Result.put_string (m.subject, "subject")
			Result.put_string (m.from_address, "from_address")
			if attached m.reply_to_address as l_reply_to_address then
				Result.put_string (l_reply_to_address, "reply_to_address")
			end
			lst := m.to_addresses
			if lst /= Void and then not lst.is_empty then
				create arr.make (lst.count)
				across lst as ic loop
					arr.extend (create {JSON_STRING}.make_from_string_general (ic.item))
				end
				Result.put (arr, "to_addresses")
			end
			lst := m.cc_addresses
			if lst /= Void and then not lst.is_empty then
				create arr.make (lst.count)
				across lst as ic loop
					arr.extend (create {JSON_STRING}.make_from_string_general (ic.item))
				end
				Result.put (arr, "cc_addresses")
			end
			lst := m.bcc_addresses
			if lst /= Void and then not lst.is_empty then
				create arr.make (lst.count)
				across lst as ic loop
					arr.extend (create {JSON_STRING}.make_from_string_general (ic.item))
				end
				Result.put (arr, "bcc_addresses")
			end
			Result.put_string (m.content, "content")
			lst := m.additional_header_lines
			if lst /= Void and then not lst.is_empty then
				create arr.make (lst.count)
				across lst as ic loop
					arr.extend (create {JSON_STRING}.make_from_string_general (ic.item))
				end
				Result.put (arr, "additional_header_lines")
			end
		end

	mail_from_json_string (a_json: READABLE_STRING_8): detachable CMS_EMAIL
		local
			jp: JSON_PARSER
			js: JSON_STRING
			jarr: JSON_ARRAY
			htdate: HTTP_DATE
			l_from: READABLE_STRING_8
			l_to_address: READABLE_STRING_8
			l_addresses: ARRAYED_LIST [READABLE_STRING_8]
			l_subject: READABLE_STRING_8
			l_content: READABLE_STRING_8
			l_partial_user: CMS_PARTIAL_USER
		do
			create jp.make
			jp.parse_string (a_json.to_string_8)
			if
				jp.is_parsed and then
				jp.is_valid and then
				attached jp.parsed_json_object as jo
			then
				js := jo.string_item ("subject")
				if js /= Void then
					l_subject := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (js.unescaped_string_32)
				end

				js := jo.string_item ("from_address")
				if js /= Void then
					l_from := js.unescaped_string_8
				end

				js := jo.string_item ("content")
				if js /= Void then
					l_content := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (js.unescaped_string_32)
				end

				jarr := jo.array_item ("to_addresses")
				if jarr /= Void then
					create l_addresses.make (jarr.count)
					across jarr as ic loop
						if attached {JSON_STRING} ic.item as l_js_addr then
							l_to_address := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_js_addr.unescaped_string_32)
							l_addresses.force (l_to_address)
						end
					end
					l_to_address := l_addresses.first
				end

				if l_from /= Void and l_to_address /= Void and l_subject /= Void and l_content /= Void then
					create Result.make (l_from, l_to_address, l_subject, l_content)
					if l_addresses /= Void then
						across
							l_addresses as ic
						loop
							if not Result.to_addresses.has (ic.item) then
								Result.to_addresses.force (ic.item)
							end
						end
					end

					js := jo.string_item ("date")
					if js /= Void then
						create htdate.make_from_rfc3339_string (js.unescaped_string_32)
						Result.set_date (htdate.date_time)
					end

					js := jo.string_item ("reply_to_address")
					if js /= Void then
						Result.set_reply_to_address ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (js.unescaped_string_32))
					end

					jarr := jo.array_item ("cc_addresses")
					if jarr /= Void then
						across jarr as ic loop
							if attached {JSON_STRING} ic.item as l_js_addr then
								Result.add_cc_address ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_js_addr.unescaped_string_32))
							end
						end
					end
					jarr := jo.array_item ("bcc_addresses")
					if jarr /= Void then
						across jarr as ic loop
							if attached {JSON_STRING} ic.item as l_js_addr then
								Result.add_bcc_address ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_js_addr.unescaped_string_32))
							end
						end
					end

					jarr := jo.array_item ("additional_header_lines")
					if jarr /= Void then
						across jarr as ic loop
							if attached {JSON_STRING} ic.item as l_js_line then
								Result.add_header_line ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_js_line.unescaped_string_32))
							end
						end
					end

					if attached {JSON_OBJECT} jo.item ("info") as j_info then
						if attached j_info.string_item ("status") as st and then st.same_string ("sent") then
							Result.set_is_sent (True)
						end
						if
							attached j_info.string_item ("to_user.id") as j_uid and then
							attached j_uid.unescaped_string_32 as l_uid and then
							l_uid.is_integer_64
						then
							create l_partial_user.make_with_id (l_uid.to_integer_64)
						elseif attached j_info.string_item ("to_user.name") as l_uname then
							create l_partial_user.make (l_uname.unescaped_string_32)
						end
						if l_partial_user /= Void then
							Result.set_to_user (l_partial_user)
							l_partial_user := Void
						end
						if
							attached j_info.string_item ("from_user.id") as j_uid and then
							attached j_uid.unescaped_string_32 as l_uid and then
							l_uid.is_integer_64
						then
							create l_partial_user.make_with_id (l_uid.to_integer_64)
						elseif attached j_info.string_item ("from_user.name") as l_uname then
							create l_partial_user.make (l_uname.unescaped_string_32)
						end
						if l_partial_user /= Void then
							Result.set_from_user (l_partial_user)
							l_partial_user := Void
						end
					end
				end
			end
		end

	fetch_mail: detachable CMS_EMAIL
			-- SQL: 1:mid, 2:date, 3:msgtype, 4:status, 5:user_from, 6:user_to, 7:subject, 8:data
		local
			l_date: detachable DATE_TIME
			l_data: detachable READABLE_STRING_8
			l_uid: READABLE_STRING_GENERAL
			i64: INTEGER_64
		do
			l_date := sql_read_date_time (2)
			if attached sql_read_string_8 (3) as s and then s.same_string ("email") then
				l_data := sql_read_string_8 (8)
				if
					l_data /= Void and then
					attached mail_from_json_string (l_data) as l_email
				then
					Result := l_email
					if attached sql_read_string_8 (1) as l_mid then
						Result.set_id (l_mid)
					end
					if l_date /= Void then
						Result.set_date (l_date)
					end

-- from_user is not yet implemented nor used.					
--					i64 := sql_read_integer_64 (5)
--					if i64 > 0 then
--						Result.set_from_user (create {CMS_PARTIAL_USER}.make_with_id (i64))
--					end


					l_uid := sql_read_string_32 (6)
					if l_uid /= Void then
						if l_uid.is_integer_64  then
							i64 := l_uid.to_integer_64
							if i64 > 0 then
								Result.set_to_user (create {CMS_PARTIAL_USER}.make_with_id (i64))
							end
						else
								-- Unicode username ?
						end
					end


--					l_subject := sql_read_string_8 (7)

					if attached sql_read_string_8 (4) as l_status then
						if l_status.is_case_insensitive_equal ("sent") then
							Result.set_is_sent (True)
						end
					end
				end
			end
		end

	sql_insert_message: STRING = "INSERT INTO messages (mid, date, msgtype, status, user_from, user_to, subject, data) VALUES (:mid, :date, :msgtype, :status, :user_from, :user_to, :subject, :data);"

	sql_select_messages_by_user_to: STRING = "SELECT mid, date, msgtype, status, user_from, user_to, subject, data FROM messages WHERE msgtype=:msgtype AND user_to=:user_to ORDER by date DESC, mid DESC;"

	sql_select_messages: STRING = "SELECT mid, date, msgtype, status, user_from, user_to, subject, data FROM messages WHERE msgtype=:msgtype ORDER by date DESC, mid DESC;"

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
	copyright: "2011-2023, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
