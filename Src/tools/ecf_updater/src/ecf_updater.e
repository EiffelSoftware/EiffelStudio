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
	SHARED_FILE_SYSTEM

create
	make

feature {NONE} -- Initialization

	make (args: APPLICATION_ARGUMENTS)
		local
			dv: ECF_DIRECTORY_ITERATOR
			tb: like ecf_table
			confirmed: BOOLEAN
		do
			create tb.make_with_key_tester (50, create {STRING_EQUALITY_TESTER})

			create errors.make (0)
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

			io.output.put_string ("Root=" + root_directory.as_string_8 + "%N")
			if attached root_base_name as l_base then
				io.output.put_string ("Base=" + l_base.as_string_8 + "%N")
			end
			if attached replacements as l_replacements then
				io.output.put_string ("Replacements=")
				across
					l_replacements as rpl
				loop
					io.output.put_string (" [" + rpl.item.src.as_string_8 + "=" + rpl.item.new.as_string_8 + "]")
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
					report_progress ("Scanning %"" + root_directory.as_string_8 + "%" for .ecf files ...")
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

				if attached args.files as l_files then
					across
						l_files as c
					loop
						update_ecf (c.item)
					end
				end
				if attached args.directories as l_dirs then
					create dv.make (agent update_ecf)
					across
						l_dirs as c
					loop
						dv.process_directory (absolute_directory_path (c.item))
					end
				end

				if not errors.is_empty then
					io.error.put_string ("[ERROR] " + errors.count.out + " errors occurred.")
					io.error.put_new_line
					across
						errors as err
					loop
						io.error.put_string (err.item.as_string_8)
						io.error.put_new_line
					end
				end
			else
				io.output.put_string ("Operation cancelled by user.%N")
			end
		end

feature -- Access

	root_directory: READABLE_STRING_GENERAL
			-- Root directory of the collection of lib
			-- or as reference for an environment variable

	root_base_name: detachable READABLE_STRING_GENERAL
			-- Optional name/path to replace the `root_directory' in .ecf

	ecf_table: HASH_TABLE_EX [attached like path_details, READABLE_STRING_GENERAL]
			-- Table of existing ecf inside `root_directory'

	is_simulation: BOOLEAN

	backup_enabled: BOOLEAN
	diff_enabled: BOOLEAN
	verbose: BOOLEAN

	errors: ARRAYED_LIST [READABLE_STRING_GENERAL]


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

	apply_variable_expansions (s: STRING_8)
		do
			if attached variable_expansions as l_variable_expansions then
				across
					l_variable_expansions as rpl
				loop
					s.replace_substring_all ("$" + rpl.item.src.as_string_8, rpl.item.new.as_string_8)
				end
			end
		end

feature -- Substitutions	

	replacements: detachable LIST [TUPLE [src,new: READABLE_STRING_GENERAL]]
			-- Optional replacements

	add_replacement	(s: READABLE_STRING_GENERAL)
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

	apply_replacements (s: STRING_8)
		do
			if attached replacements as l_replacements then
				across
					l_replacements as rpl
				loop
					s.replace_substring_all (rpl.item.src.as_string_8, rpl.item.new.as_string_8)
				end
			end
		end

feature -- Basic operation	

	analyze_ecf (a_fn: READABLE_STRING_GENERAL)
		local
			fn: STRING_GENERAL
			lst: like segments_from_string
		do
			create {STRING_32} fn.make (a_fn.count)
			lst := segments_from_string (a_fn)
			append_segments_to_string (lst, fn)

			if attached path_details (fn) as d then
				ecf_table.force (d, fn)
			end
		end

	update_ecf (fn: READABLE_STRING_GENERAL)
		local
			f,bf: detachable RAW_FILE
			l_line: STRING_8
			l_new_path: READABLE_STRING_GENERAL
			p,q: INTEGER
			l_rn: STRING_32
			l_ecf: STRING_8
			l_old_content, l_new_content: STRING_32
		do
			if attached path_details (fn) as l_info then
				create l_rn.make_from_string (root_directory.as_string_32)
				l_rn.replace_substring_all ("\", "/")

				create f.make (fn.as_string_8)
				debug
					print (f.name + "%N")
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
								l_ecf := l_line.substring (q + 1, p + 3)
								if l_line [q + 1] = '$' then
									if root_base_name /= Void then
										apply_variable_expansions (l_ecf)
									end

									-- Should be using absolute path based on variable name
									-- FIXME: check the first segment related to `l_ecf' exists ...
								else
									apply_variable_expansions (l_ecf)
									l_ecf := l_info.dir.as_string_8 + l_ecf
								end
								if l_ecf [1] = '$' then
--									l_line.replace_substring_all ("\", "/")
								else
									if attached ecf_location (l_ecf) as l_location then
										l_new_path := relative_path (l_location, fn, l_rn, root_base_name)
									else
										l_new_path := relative_path (l_ecf, fn, l_rn, root_base_name)
									end
									debug
										print ("%T" + l_new_path.as_string_8 + "%N")
									end
									if same_path (l_line.substring (q + 1, p + 3), l_new_path) then

									elseif not l_new_path.is_empty then
										l_line.replace_substring (l_new_path.as_string_8, q+1, p+3)
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
							report_progress ("No diff for %"" + f.name + "%"")
						end
					else
						if backup_enabled then
							create bf.make (f.name + ".bak")
							if not bf.exists or else bf.is_writable then
								if not is_simulation then
									bf.create_read_write
									f.open_read
									f.copy_to (bf)
									f.close
									bf.close
								end
								report_progress ("Backup %"" + f.name + "%" into %"" + bf.name + "%"")
							else
								report_error ("could not backup %"" + f.name + "%" into %"" + bf.name + "%"")
								io.error.put_new_line
								bf := Void
							end
						end

						if f.is_writable then
							if not is_simulation or else verbose then
								if backup_enabled and bf = Void then
									report_error ("could not backup %"" + f.name + "%".")
									-- Skip this file
								else
									if not is_simulation then
										f.open_write
										f.put_string (l_new_content.as_string_8)
										f.close
									end
									report_progress ("Updated %"" + f.name + "%"")
								end
							end
						else
							report_error ("could not update %"" + f.name + "%" (not writable)")
						end

						if
							diff_enabled and then
							attached diff (l_old_content, l_new_content) as l_diff
						then
							if is_simulation and not verbose then
								report_progress ("Updated %"" + f.name + "%"")
							end
							io.output.put_string (l_diff.as_string_8)
							io.output.put_new_line
						end
					end
				end
			end
		end

	diff (s1,s2: READABLE_STRING_8): detachable STRING_GENERAL
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
			s1.replace_substring_all ("\", "/")
			s2.replace_substring_all ("\", "/")
			Result := s1.same_string (s2)
		end

feature {NONE} -- Implementation

	report_warning (m: READABLE_STRING_GENERAL)
		do
			io.error.put_string ("[Warning] " + m.as_string_8)
			io.error.put_new_line
		end

	report_progress (m: READABLE_STRING_GENERAL)
		do
			io.output.put_string (m.as_string_8)
			io.output.put_new_line
		end

	report_error (m: READABLE_STRING_GENERAL)
		do
			errors.extend (m)
			io.error.put_string ("[Error] " + m.as_string_8)
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
								n := 0
								i_lst := c.item.segments
								i_lst.finish
								lst.finish
							until
								i_lst.before or lst.before
							loop
								if i_lst.item.same_string (lst.item) then
									n := n + 1
								end
								i_lst.back
								lst.back
							end
							if n > r then
								r := n
								Result := c.key
							end
						end
					end
				else
--					l_ecf := reduced_path (a_ecf, 2) -- keep only sub dir and ecf filename		
--					n := 0
--					across
--						ecf_table as c
--					until
--						Result /= Void
--					loop
--						if c.item.subdir_file.same_string (l_ecf) and c.item.uuid ~ l_uuid then
--							Result := c.key
--						end
--					end
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
				create s.make (a_lib_ecf.count)
				append_segments_to_string (lst, s)

				if bn /= Void then
					s.replace_substring (bn.as_string_8, 1, rn.count)
				end
			end

			Result := s
		end

	path_details (fn: READABLE_STRING_GENERAL): detachable TUPLE [uuid: detachable READABLE_STRING_8; segments: like segments_from_string; dir, subdir_file, file: READABLE_STRING_GENERAL]
		local
			f: RAW_FILE
			n,p: INTEGER
			l_uuid: detachable READABLE_STRING_8
			l_dir, l_subdir: detachable READABLE_STRING_GENERAL
			l_file: detachable READABLE_STRING_GENERAL
			c_slash, c_bslash: NATURAL_32
			c: NATURAL_32
		do
			c_slash := ('/').natural_32_code
			c_bslash := ('\').natural_32_code
			from
				n := fn.count
			until
				n = 0 or l_subdir /= Void
			loop
				c := fn.code (n)
				if c = c_slash or c = c_bslash then
					if l_dir = Void then
						l_file := fn.substring (n + 1, fn.count)
						l_dir := fn.substring (1, n)
					else
						l_subdir := l_dir.substring (n + 1, l_dir.count)
					end
				else
				end
				n := n - 1
			end
			if l_dir = Void then
				l_dir := ""
			end
			if l_subdir = Void then
				l_subdir := ""
			end
			if l_file /= Void then
				create f.make (fn.as_string_8)
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
						report_warning ("No UUID in %"" + fn.as_string_8 + "%"")
					end
				end
				Result := [l_uuid, segments_from_string (l_dir), l_dir, l_subdir + l_file, l_file]
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
			append_segments_to_string (lst, Result)
		end

	append_segments_to_string (lst: LIST [READABLE_STRING_GENERAL]; s: STRING_GENERAL)
		do
			across
				lst as curs
			loop
				if not s.is_empty then
					s.append ("/")
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

	absolute_directory_path (dn: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
		do
			Result := reduced_path (file_system.absolute_directory_path (dn), 0)
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
