note
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_DATABASE_READER

feature -- Access

	set_variable (a_value, a_name: READABLE_STRING_32)
		local
			vars: like variables
		do
			vars := variables
			if vars = Void then
				create vars.make_caseless (1)
				variables := vars
			end
			vars.force (a_value, a_name)
		end

	variables: detachable STRING_TABLE [READABLE_STRING_32]

	resolved_location (p: PATH): PATH
			-- Location `p' resolved with `variables'.
		local
			s, k: STRING_32
			i, j, n: INTEGER
		do
			Result := p
			if attached variables as vars then
				s := p.name
				i := s.index_of ('$', 1)
				if i > 1 then
					from
						j := i + 1
						n := s.count
					until
						j > n or not (s [j].is_alpha_numeric or s [j] = '_')
					loop
						j := j + 1
					end
					if j > i then
						k := s.substring (i + 1, j - 1)
						if attached vars.item (k) as l_new then
							s.replace_substring (l_new, i, j - 1)
							create Result.make_from_string (s)
						end
					end
				end
			end
		end

feature -- Store

	reset
		do
			last_database := Void
			last_context := Void
		end

	last_database: detachable LIBRARY_DATABASE

	read (fn: PATH; ctx: detachable LIBRARY_DATABASE_CONTEXT)
		local
			f: RAW_FILE
			l_line, s: STRING_8
			utf: UTF_CONVERTER
			p: INTEGER
			err: BOOLEAN
			db: detachable LIBRARY_DATABASE
		do
			reset
			create f.make_with_path (fn)
			if f.exists and then f.is_access_readable then
				create db.make (ctx)
				f.open_read
				from
					err := False
					f.read_line_thread_aware
				until
					f.exhausted or err
				loop
					l_line := f.last_string
					l_line.left_adjust
					if l_line.is_whitespace then
						f.read_line_thread_aware
					else
						if l_line.starts_with ("[") then
							p := l_line.index_of (']', 2)
							if p > 0 then
								s := l_line.substring (2, p - 1)
								if s.is_case_insensitive_equal_general ("context") then
									read_context (f)
									if attached last_context as l_ctx then
										db.update_context (l_ctx)
									end
								elseif s.is_case_insensitive_equal ("ecf_files") then
									from
										f.read_line_thread_aware
									until
										f.exhausted or l_line.starts_with ("[")
									loop
										l_line := f.last_string
										l_line.left_adjust
										db.ecf_files.extend (create {PATH}.make_from_string (utf.utf_8_string_8_to_escaped_string_32 (l_line)))
										f.read_line_thread_aware
									end
								elseif s.starts_with ("item:") then
									read_info_into (f, db)
								end
							else
								err := True
							end
						else
							f.read_line_thread_aware
						end
					end
				end
				if err then
					last_database := Void
				else
					last_database := db
				end
			end
		end

	last_context: detachable LIBRARY_DATABASE_CONTEXT

	read_context (f: FILE)
		local
			l_line: STRING
			k, v: READABLE_STRING_8
			done, err: BOOLEAN
			ctx: LIBRARY_DATABASE_CONTEXT
			vars: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]
		do
			last_context := Void
			from
				create vars.make (10)
				create ctx.make
			until
				f.exhausted or err or done
			loop
				f.read_line_thread_aware
				l_line := f.last_string
				l_line.left_justify
				if l_line.is_whitespace then
				elseif l_line.starts_with ("[") then
					done := True
				else
					if attached name_value_from_string (l_line, ':') as d then
						vars.force (d.value, d.name)
					else
						err := True
					end
--					i := l_line.index_of (':', 1)
--					if i > 0 then
--						k := l_line.head (i - 1)
--						v := l_line.substring (i + 1, l_line.count)
--						if k.is_case_insensitive_equal_general ("any_settings") then
--							ctx.use_any_settings (v.is_case_insensitive_equal ("true"))
--						elseif k.is_case_insensitive_equal_general ("platform") then
--							ctx.set_platform (v)
--						elseif k.is_case_insensitive_equal_general ("concurrency") then
--							ctx.set_concurrency (v)
--						elseif k.is_case_insensitive_equal_general ("is_il_generation") then
--							ctx.set_is_il_generation (v.is_case_insensitive_equal ("true"))
--						elseif k.is_case_insensitive_equal_general ("build") then
--							ctx.set_build (v)
--						elseif k.is_case_insensitive_equal_general ("void_safety") then
--							ctx.set_void_safety (v)
--						end
--					else
--						err := True
--					end
				end
			end
			if not err then
				across
					vars as ic
				loop
					k := @ ic.key
					v := ic
					if k.is_case_insensitive_equal_general ("any_settings") then
						ctx.use_any_settings (v.is_case_insensitive_equal ("true"))
					elseif k.is_case_insensitive_equal_general ("platform") then
						if
							attached vars.item (k + ".set") as v_set and then
							v_set.is_case_insensitive_equal_general ("true")
						then
							ctx.set_platform (v)
						end
					elseif k.is_case_insensitive_equal_general ("concurrency") then
						if
							attached vars.item (k + ".set") as v_set and then
							v_set.is_case_insensitive_equal_general ("true")
						then
							ctx.set_concurrency (v)
						end
					elseif k.is_case_insensitive_equal_general ("is_il_generation") then
						ctx.set_is_il_generation (v.is_case_insensitive_equal ("true"))
					elseif k.is_case_insensitive_equal_general ("build") then
						if
							attached vars.item (k + ".set") as v_set and then
							v_set.is_case_insensitive_equal_general ("true")
						then
							ctx.set_build (v)
						end
					elseif k.is_case_insensitive_equal_general ("void_safety") then
						if
							attached vars.item (k + ".set") as v_set and then
							v_set.is_case_insensitive_equal_general ("true")
						then
							ctx.set_void_safety (v)
						end
					end
				end
				last_context := ctx
			end
		end

	read_info_into (f: FILE; db: LIBRARY_DATABASE)
			-- [item:$key]
		local
			i, j: INTEGER
			l_line, inf_key, s: STRING
			k, v: READABLE_STRING_8
			done, err: BOOLEAN
			inf: detachable LIBRARY_INFO
			l_name, l_uuid, l_location: detachable STRING
			utf: UTF_CONVERTER
		do
			from
				l_line := f.last_string
				l_line.adjust
				i := l_line.index_of (']', 1)
				inf_key := l_line.substring (7, i - 1)
			until
				f.exhausted or err or done
			loop
				f.read_line_thread_aware
				l_line := f.last_string
				l_line.adjust
				if l_line.starts_with ("[") then
					done := True
				elseif l_line.starts_with ("name:") then
					l_name := l_line.substring (6, l_line.count)
					f.read_line_thread_aware
					l_line := f.last_string
					l_line.adjust
					if l_line.starts_with ("uuid:") then
						l_uuid := l_line.substring (6, l_line.count)
						f.read_line_thread_aware
						l_line := f.last_string
						l_line.adjust
						if l_line.starts_with ("location:") then
							l_location := l_line.substring (10, l_line.count)
							create inf.make (l_name, create {UUID}.make_from_string (l_uuid), create {PATH}.make_from_string (utf.utf_8_string_8_to_string_32 (l_location)))
						else
							err := True
						end
					else
						err := True
					end
				else
					err := True
				end
				if inf = Void then
					err := True
				else
					from

					until
						f.exhausted or err or done
					loop
						f.read_line_thread_aware
						l_line := f.last_string
						l_line.adjust
						if attached name_value_from_string (l_line, ':') as l_var then
							k := l_var.name
							v := l_var.value
							if k.is_case_insensitive_equal ("is_application") then
								inf.set_is_application (v.is_case_insensitive_equal ("true"))
							elseif k.is_case_insensitive_equal ("void_safety_option") then
								inf.set_void_safety_option (v)
							elseif k.is_case_insensitive_equal ("classes") then
								from
									j := 1
								until
									j > v.count
								loop
									i := v.index_of (',', j)
									if i = 0 then
										s := v.substring (j, v.count).to_string_8
										i := v.count
									else
										s := v.substring (j, i - 1).to_string_8
									end
									s.adjust
									inf.classes.force (s)
									j := i + 1
								end
							elseif k.is_case_insensitive_equal ("dependencies") then
								if not v.is_whitespace then
									across
										dependencies_from_string (v) as ic
									loop
										inf.dependencies.force (ic)
									end
								end
							elseif k.starts_with ("[") then
								done := True
							else
								err := True
							end
						else
							done := True
						end
					end
				end
				done := True
			end
			if inf /= Void and not err then
				db.items.force (inf, inf_key)
			end
		end

	dependencies_from_string (v: READABLE_STRING_8): ARRAYED_LIST [attached like dependency_from_string]
		local
			i, j, k, n: INTEGER
			err: BOOLEAN
			s: READABLE_STRING_8
		do
			create Result.make (v.occurrences ('{'))
			from
				i := 1
				n := v.count
			until
				i > n or err
			loop
				j := v.index_of ('{', i)
				if j >= i then
					k := v.index_of ('}', j + 1)
					if k > j then
						s := v.substring (j + 1, k - 1)
						i := k + 1
						if attached dependency_from_string (s) as dep then
							Result.extend (dep)
						end
					else
						check no_error: False end
							-- exit
						err := True
					end
				else
					check no_error: False end
						-- exit
					err := True
				end
			end
		end

	dependency_from_string (s: READABLE_STRING_8): detachable TUPLE [name: READABLE_STRING_GENERAL; location: READABLE_STRING_32; evaluated_location: PATH]
		local
			l_name,
			l_location,
			l_evaluated_location: detachable READABLE_STRING_32
			err: BOOLEAN
		do
			across
				s.split (',') as ic
			until
				err
			loop
				if attached unicode_name_value_from_utf_8_string (ic, '=') as d then
					if d.name.is_case_insensitive_equal_general ("name") then
						l_name := d.value
					elseif d.name.is_case_insensitive_equal_general ("location") then
						l_location := d.value
					elseif d.name.is_case_insensitive_equal_general ("evaluated_location") then
						l_evaluated_location := d.value
					else
						err := True
					end
				end
			end
			if not err and l_name /= Void and l_location /= Void and l_evaluated_location /= Void then
				Result := [l_name, l_location, create {PATH}.make_from_string (l_evaluated_location)]
			end
		end

	name_value_from_string (s: READABLE_STRING_8; sep: CHARACTER): detachable TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]
		local
			i: INTEGER
			k, v: STRING
		do
			i := s.index_of (sep, 1)
			if i > 0 then
				k := s.head (i - 1).to_string_8
				k.adjust
				v := s.substring (i + 1, s.count).to_string_8
				v.adjust
				if
					not v.is_empty and then
					v [1] = '%"'
				then
					v.adjust
					if v [v.count] = '%"' then
						v := v.substring (2, v.count - 1)
					end
				end
				Result := [k, v]
			end
		end

	unicode_name_value_from_utf_8_string (s: READABLE_STRING_8; sep: CHARACTER): detachable TUPLE [name: READABLE_STRING_32; value: READABLE_STRING_32]
		local
			utf: UTF_CONVERTER
		do
			if attached name_value_from_string (s, sep) as d then
				Result := [utf.utf_8_string_8_to_string_32 (d.name), utf.utf_8_string_8_to_string_32 (d.value)]
			end
		end

end
