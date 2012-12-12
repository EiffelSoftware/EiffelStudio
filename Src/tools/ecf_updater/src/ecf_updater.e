note
	description: "[
				Root class for ecf updater
				
				note: we should support unicode path in the future, that's why we tried to use STRING_GENERAL
				      but in many places we have  .as_string_8
				      so this is hybrid for now, and now it works only with ASCII path...
			]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_UPDATER

inherit
	LOCALIZED_PRINTER

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (args: APPLICATION_ARGUMENTS)
		local
			dv: ECF_DIRECTORY_ITERATOR
			tb: like ecf_table
			has_processed_node: BOOLEAN
			confirmed: BOOLEAN
		do
			create tb.make (50)

			create errors.make (0)
			create warnings.make (0)
			has_processed_node := False
			ecf_table := tb
			root_directory := args.root_directory	--"c:\_dev\EWF\EWF-dev"
			root_base_name := args.base_name	--"$EIFFEL_LIBRARY"
			if attached args.replacements as rep_lst and then not rep_lst.is_empty then
				across
					rep_lst as r
				loop
					add_replacement (r.item)
				end
			end
			if attached args.variable_expansions as exp_lst and then not exp_lst.is_empty then
				across
					exp_lst as x
				loop
					add_variable_expansion (x.item)
				end
			end

			is_simulation := args.simulation_enabled
			backup_enabled := args.backup_enabled
			diff_enabled := args.diff_enabled
			verbose := args.verbose

			io.output.put_string ("Root=" )
			localized_print (root_directory.name)
			io.output.put_string ("%N")
			if attached root_base_name as l_base then
				io.output.put_string ("Base=")
				localized_print (l_base)
				io.output.put_string ("%N")
			end
			if attached replacements as l_replacements then
				io.output.put_string ("Replacements=")
				across
					l_replacements as rpl
				loop
					io.output.put_string (" [")
					localized_print (rpl.item.src)
					io.output.put_string ("=")
					localized_print (rpl.item.new)
					io.output.put_string ("]")
				end
				io.output.put_string ("%N")
			end
			io.output.put_string ("Simulation=" + is_simulation.out + "%N")
			io.output.put_string ("Backup=" + backup_enabled.out + "%N")
			if diff_enabled then
				io.output.put_string ("Diff=" + diff_enabled.out + "%N")
			end
			if verbose then
				io.output.put_string ("Verbose=" + verbose.out + "%N")
			end


			if args.execution_forced then
				confirmed := True
			else
				io.output.put_string ("Continue (y|N)?")
				io.read_line
				io.last_string.left_adjust
				io.last_string.right_adjust
				io.last_string.to_lower
				if io.last_string.same_string ("y") then
					confirmed := True
				else
					confirmed := False
				end
			end

			if confirmed then
				create dv.make (agent analyze_ecf)
				if verbose then
					report_progress ({STRING_32} "Scanning %"" + root_directory.name + {STRING_32} "%" for .ecf files ...")
				end
				dv.process_directory (absolute_directory_path (root_directory))
				if verbose then
					report_progress ("Found " + ecf_table.count.out + " .ecf files.")
				end

	-- TESTS
	--			update_ecf (root_directory + "\library\server\wsf\tests\echo\echo-safe.ecf")
	--			update_ecf (root_directory + "\examples\tutorial\step_4\hello\hello.ecf")
	--			update_ecf (root_directory + "\examples\tutorial\step_4\hello\hello.ecf")
	--			update_ecf (root_directory + "\library\server\wsf\wsf.ecf")
	--			update_ecf (root_directory + "\library\server\wsf\tests\tests-safe.ecf")

				if attached args.files as l_files and then not l_files.is_empty then
					has_processed_node := True
					across
						l_files as c
					loop
						update_ecf (c.item)
					end
				end
				if attached args.directories as l_dirs and then not l_dirs.is_empty then
					has_processed_node := True
					create dv.make (agent update_ecf)
					across
						l_dirs as c
					loop
						dv.process_directory (absolute_directory_path (c.item))
					end
				end
				if not has_processed_node then
					io.output.put_string ("No file or directory are asked to be updated.%N")
					if not args.execution_forced then
						io.output.put_string ("Do you want to update recursively current directory %N%T%"")
						localized_print (execution_environment.current_working_path.name)
						io.output.put_string ("%" %N Continue (y|N)?")
						io.read_line
						io.last_string.left_adjust
						io.last_string.right_adjust
						io.last_string.to_lower
						if io.last_string.same_string ("y") then
							has_processed_node := True
							create dv.make (agent update_ecf)
							dv.process_directory (absolute_directory_path (execution_environment.current_working_path))
						end
					end
				end

				if not warnings.is_empty then
					io.error.put_string ("[WARNING] " + warnings.count.out + " warnings occurred.")
					io.error.put_new_line
					across
						warnings as warn
					loop
						localized_print_error (warn.item)
						io.error.put_new_line
					end
				end

				if not errors.is_empty then
					io.error.put_string ("[ERROR] " + errors.count.out + " errors occurred.")
					io.error.put_new_line
					across
						errors as err
					loop
						localized_print_error (err.item)
						io.error.put_new_line
					end
				end
			else
				io.output.put_string ("Operation cancelled by user.%N")
			end
		end

feature -- Access

	root_directory: PATH
			-- Root directory of the collection of lib
			-- or as reference for an environment variable

	root_base_name: detachable STRING_32
			-- Optional name/path to replace the `root_directory' in .ecf

	ecf_table: STRING_TABLE [attached like path_details]
			-- Table of existing ecf inside `root_directory'

	is_simulation: BOOLEAN

	backup_enabled: BOOLEAN
	diff_enabled: BOOLEAN
	verbose: BOOLEAN

	errors: ARRAYED_LIST [READABLE_STRING_GENERAL]
	warnings: ARRAYED_LIST [READABLE_STRING_GENERAL]


feature -- Variable expansions

	variable_expansions: detachable LIST [TUPLE [src,new: READABLE_STRING_GENERAL]]
			-- Optional variable expansions

	add_variable_expansion	(s: READABLE_STRING_GENERAL)
		local
			l_expansions: like variable_expansions
			p: INTEGER
		do
			l_expansions := variable_expansions
			if l_expansions = Void then
				create {ARRAYED_LIST [like variable_expansions.item]} l_expansions.make (1)
				variable_expansions := l_expansions
			end

			p := s.index_of_code (('=').natural_32_code, 1)
			if p > 0 then
				l_expansions.extend ([s.substring (1, p-1), s.substring (p+1, s.count)])
			else
				check wrong_syntax: False end
			end
		end

	apply_variable_expansions (s: STRING_32)
		do
			if attached variable_expansions as l_variable_expansions then
				across
					l_variable_expansions as rpl
				loop
					s.replace_substring_all ({STRING_32} "$" + rpl.item.src.to_string_32, rpl.item.new.to_string_32)
				end
			end
		end

feature -- Substitutions	

	replacements: detachable LIST [TUPLE [src, new: STRING_32]]
			-- Optional replacements

	add_replacement	(s: STRING_32)
		local
			l_replacements: like replacements
			p: INTEGER
		do
			l_replacements := replacements
			if l_replacements = Void then
				create {ARRAYED_LIST [like replacements.item]} l_replacements.make (1)
				replacements := l_replacements
			end

			p := s.index_of_code (('=').natural_32_code, 1)
			if p > 0 then
				l_replacements.extend ([s.substring (1, p-1), s.substring (p+1, s.count)])
			else
				check wrong_syntax: False end
			end
		end

	apply_replacements (s: STRING_32)
		do
			if attached replacements as l_replacements then
				across
					l_replacements as rpl
				loop
					s.replace_substring_all (rpl.item.src, rpl.item.new)
				end
			end
		end

feature -- Basic operation	

	analyze_ecf (a_fn: PATH)
		local
			fn: STRING_GENERAL
			--lst: like segments_from_string
		do
			fn := reduced_path (a_fn.name, 0)
			--lst := segments_from_string (a_fn)
			--append_segments_to_string (lst, fn)

			if attached path_details (fn) as d then
				ecf_table.force (d, fn)
			end
		end

	update_ecf (fn: PATH)
		local
			f,bf: detachable RAW_FILE
			l_line: STRING_8
			l_new_path: READABLE_STRING_GENERAL
			p,q: INTEGER
			l_rn: STRING_32
			l_ecf: STRING_32
			l_old_content, l_new_content: STRING_32
			u: FILE_UTILITIES
		do
			if attached path_details (fn.name) as l_info then
				l_rn := root_directory.name
				l_rn.replace_substring_all ("\", "/")

				create f.make_with_path (fn)
				debug
					localized_print (f.path.name)
					print ("%N")
				end
				if f.exists and f.is_readable then
					f.open_read
					create l_old_content.make (256)
					create l_new_content.make (256)
					from
						f.read_line
					until
						f.exhausted
					loop
						l_line := f.last_string
						l_old_content.append (l_line + "%N")
						p := l_line.substring_index (".ecf", 1)
						if p > 0 and l_line[p + 4] = '"' then
							q := l_line.last_index_of ('"', p)
							if q > 0 then
								l_ecf := l_line.substring (q + 1, p + 3).to_string_32
								if l_line [q + 1] = '$' then
									if root_base_name /= Void then
										apply_variable_expansions (l_ecf)
									end

									-- Should be using absolute path based on variable name
									-- FIXME: check the first segment related to `l_ecf' exists ...
								else
									apply_variable_expansions (l_ecf)
									l_ecf := l_info.dir.to_string_32 + l_ecf
								end
								if l_ecf [1] = '$' then
--									l_line.replace_substring_all ("\", "/")
								else
									if attached ecf_location (l_ecf) as l_location then
										l_new_path := relative_path (l_location, fn.name, l_rn, root_base_name)
									else
										if not u.file_exists (l_ecf) then
											report_warning ({STRING_32} "Unable to find %"" + l_ecf.to_string_32 + {STRING_32} "%" from file %"" + fn.name + {STRING_32} "%"")
										end

										l_new_path := relative_path (l_ecf, fn.name, l_rn, root_base_name)
									end
									debug
										print ("%T")
										localized_print (l_new_path)
										print ("%N")
									end
									if same_path (l_line.substring (q + 1, p + 3), l_new_path) then

									elseif not l_new_path.is_empty then
										l_line.replace_substring (l_new_path.to_string_8, q+1, p+3)
									end
								end

								apply_replacements (l_line)
							end
						end
						l_new_content.append (l_line + "%N")
						f.read_line
					end
					f.close

					if l_old_content.same_string (l_new_content) then
						if verbose then
							report_progress ({STRING_32} "No diff for %"" + f.path.name + {STRING_32} "%"")
						end
					else
						if backup_enabled then
							create bf.make_with_path (f.path.appended (".bak"))
							if not bf.exists or else bf.is_writable then
								if not is_simulation then
									bf.create_read_write
									f.open_read
									f.copy_to (bf)
									f.close
									bf.close
								end
								report_progress ({STRING_32} "Backup %"" + f.path.name + {STRING_32} "%" into %"" + bf.path.name + {STRING_32} "%"")
							else
								report_error ({STRING_32} "could not backup %"" + f.path.name + {STRING_32} "%" into %"" + bf.path.name + {STRING_32} "%"")
								io.error.put_new_line
								bf := Void
							end
						end

						if f.is_writable then
							if not is_simulation or else verbose then
								if backup_enabled and bf = Void then
									report_error ({STRING_32} "could not backup %"" + f.path.name + {STRING_32} "%".")
									-- Skip this file
								else
									if not is_simulation then
										f.open_write
										f.put_string (l_new_content.as_string_8)
										f.close
									end
									report_progress ({STRING_32} "Updated %"" + f.path.name + {STRING_32} "%"")
								end
							else
								report_progress ({STRING_32} "To-update %"" + f.path.name + {STRING_32} "%"")
							end
						else
							report_error ({STRING_32} "could not update %"" + f.path.name + {STRING_32} "%" (not writable)")
						end

						if
							diff_enabled and then
							attached diff (l_old_content, l_new_content) as l_diff
						then
							if is_simulation and not verbose then
								report_progress ("Updated %"" + f.path.name + "%"")
							end
							io.output.put_string (l_diff.as_string_8)
							io.output.put_new_line
						end
					end
				end
			end
		end

	diff (s1,s2: READABLE_STRING_8): detachable STRING_8
		local
			d: DIFF_TEXT
		do
			if s1.same_string (s2) then
			else
				create d
				d.set_text (s1, s2)
				d.compute_diff
				Result := d.unified
			end
		end

	same_path (p1, p2: READABLE_STRING_GENERAL): BOOLEAN
		local
			s1, s2: STRING_32
		do
			create s1.make_from_string (p1.as_string_32)
			create s2.make_from_string (p2.as_string_32)
			s1.replace_substring_all ({STRING_32} "\", {STRING_32} "/")
			s2.replace_substring_all ({STRING_32} "\", {STRING_32} "/")
			Result := s1.same_string (s2)
		end

feature {NONE} -- Implementation

	report_warning (m: READABLE_STRING_GENERAL)
		do
			warnings.extend (m)
			localized_print ({STRING_32} "[Warning] " + m.to_string_32)
			io.error.put_new_line
		end

	report_progress (m: READABLE_STRING_GENERAL)
		do
			localized_print (m)
			io.output.put_new_line
		end

	report_error (m: READABLE_STRING_GENERAL)
		do
			errors.extend (m)
			localized_print_error ({STRING_32} "[Error] " + m.to_string_32)
			io.error.put_new_line
		end

	ecf_location (a_ecf: READABLE_STRING_GENERAL): detachable READABLE_STRING_GENERAL
		local
			l_ecf: STRING_GENERAL
			l_uuid: detachable READABLE_STRING_8
			n,r: INTEGER
			lst, i_lst: like segments_from_string
		do
			l_ecf := reduced_path (a_ecf, 0)
			if attached path_details (l_ecf) as d then
				l_uuid := d.uuid
			end
			if attached ecf_table.item (l_ecf) as l_info then
				Result := l_ecf
			else
				if attached path_details (l_ecf) as l_info then
					lst := l_info.segments
					r := 0
					across
						ecf_table as c
					loop
						if c.item.file.same_string (l_info.file) then
							from
								n := 1
								i_lst := c.item.segments
								i_lst.finish
								lst.finish
							until
								i_lst.before or lst.before
							loop
								if i_lst.item.same_string (lst.item) then
									n := n + 1
								else
										-- Exit look
									lst.start
								end
								i_lst.back
								lst.back
							end
							if n > r then
								r := n
								Result := c.key
							elseif n = r then
								-- Choose the closest
								if common_segment_count (l_ecf, Result) < common_segment_count (l_ecf, c.key) then
									Result := c.key
								end
							end
						end
					end
				else
				end
			end
		end

	relative_path (a_lib_ecf: READABLE_STRING_GENERAL; a_ecf: READABLE_STRING_GENERAL; rn: READABLE_STRING_GENERAL; bn: detachable READABLE_STRING_GENERAL): STRING_GENERAL
		local
			n: INTEGER
			lst, blst: ARRAYED_LIST [READABLE_STRING_GENERAL]
			s: STRING_8
		do
			lst := segments_from_string (a_lib_ecf)

			if bn = Void then
				-- relative
				blst := segments_from_string (a_ecf)

				from
					lst.start
					blst.start
				until
					lst.after or blst.after
				loop
					if lst.item.same_string (blst.item) then

						blst.remove
						lst.remove
					else
						lst.finish
						lst.forth
						blst.forth
					end
				end
				if blst.count > 0 then
					from
						n := blst.count - 1
					until
						n = 0
					loop
						lst.put_front ("..")
						n := n - 1
					end
				end
				create s.make (a_lib_ecf.count)
				append_segments_to_string (lst, s)

			else
				s := reduced_path (a_lib_ecf, 0).as_string_8
				s.replace_substring (bn.as_string_8, 1, rn.count)
			end

			Result := s
		end

	path_details (fn: READABLE_STRING_GENERAL): detachable TUPLE [uuid: detachable READABLE_STRING_8; segments: like segments_from_string; dir, file: READABLE_STRING_GENERAL]
		local
			f: RAW_FILE
			n,p: INTEGER
			l_uuid: detachable READABLE_STRING_8
			l_dir: detachable READABLE_STRING_GENERAL
			l_file: detachable READABLE_STRING_GENERAL
			c_slash, c_bslash: NATURAL_32
			c: NATURAL_32
		do
			c_slash := ('/').natural_32_code
			c_bslash := ('\').natural_32_code
			from
				n := fn.count
			until
				n = 0 or l_dir /= Void
			loop
				c := fn.code (n)
				if c = c_slash or c = c_bslash then
					l_file := fn.substring (n + 1, fn.count)
					l_dir := fn.substring (1, n)
				else
				end
				n := n - 1
			end
			if l_dir = Void then
				l_dir := ""
			end
			if l_file /= Void then
				create f.make_with_name (fn)
				if f.exists and then f.is_readable then
					f.open_read
					from
						f.read_line
					until
						f.exhausted or l_uuid /= Void
					loop
						if attached f.last_string as l_line then
							p := l_line.substring_index ("uuid=%"", 1)
							if p > 0 then
								n := l_line.index_of ('"', p + 6)
								if n > p then
									l_uuid := l_line.substring (p + 6, n - 1)
								end
							end
						end
						f.read_line
					end
					f.close
					if verbose and l_uuid = Void then
--						check has_uuid: l_uuid /= Void end
						report_warning ("No UUID in %"" + fn.to_string_8 + "%"")
					end
				end
				Result := [l_uuid, segments_from_string (l_dir), l_dir, l_file]
			end
		end

feature {NONE} -- Path manipulation

	reduced_path (fn: READABLE_STRING_GENERAL; a_depth: INTEGER): STRING_GENERAL
		local
			lst: like segments_from_string
		do
			create {STRING_32} Result.make (fn.count)
			lst := segments_from_string (fn)
			if a_depth > 0 then
				from
					lst.start
				until
					lst.count = a_depth
				loop
					lst.remove
				end
			end
			if fn.starts_with ("/") then
				Result.append ("/")
			end
			append_segments_to_string (lst, Result)
		end

	common_segment_count (p1, p2: detachable READABLE_STRING_GENERAL): INTEGER
			-- Number of segments common between p1 and p2 starting from the left.
		do
			if
				(p1 /= Void and then attached segments_from_string (p1) as lst_1) and
				(p2 /= Void and then attached segments_from_string (p2) as lst_2)
			then
				from
					lst_1.start
					lst_2.start
				until
					lst_1.after or lst_2.after
				loop
					if lst_1.item.same_string (lst_2.item) then
						Result := Result  + 1
					else
						lst_1.finish
						lst_2.finish
					end
					lst_1.forth
					lst_2.forth
				end
			end
		end

	append_segments_to_string (lst: LIST [READABLE_STRING_GENERAL]; s: STRING_GENERAL)
		do
			across
				lst as curs
			loop
				if not s.is_empty then
					if not s.ends_with ("/") then
						s.append ("/")
					end
				end
				s.append (curs.item)
			end
		end

	segments_from_string (fn: READABLE_STRING_GENERAL): ARRAYED_LIST [READABLE_STRING_GENERAL]
		local
			c_slash, c_bslash: NATURAL_32
			i,p,n: INTEGER
			c: NATURAL_32
			lst: ARRAYED_LIST [READABLE_STRING_GENERAL]
		do
			c_slash := ('/').natural_32_code
			c_bslash := ('\').natural_32_code
			from
				create lst.make (2)
				i := 1
				p := 1
				n := fn.count
			until
				i > n
			loop
				c := fn.code (i)
				if c = c_slash or c = c_bslash then
					lst.extend (fn.substring (p, i - 1))
					p := i + 1
				end
				i := i + 1
			end
			if i > p then
				lst.extend (fn.substring (p, n))
			end
			from
				lst.start
			until
				lst.after
			loop
				if not lst.isfirst and then lst.item.same_string ("..") then
					lst.remove_left
					lst.remove
				elseif lst.item.same_string (".") then
					lst.remove
				else
					lst.forth
				end
			end
			Result := lst
		end

	absolute_directory_path (dn: PATH): PATH
		do
			create Result.make_from_string (reduced_path (dn.absolute_path.name, 0))
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
