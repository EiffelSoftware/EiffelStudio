note
	description: "[

				Application that update an Eiffel Configuration File to use iron references (uri:  iron:package-name:relative-path-to-file.ecf)
				Usage:
					Precise an ecf file

		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_UPDATE_ECF_TASK

inherit
	IRON_TASK

	CONF_ACCESS
		rename
			print as print_any
		end

	SHARED_EXECUTION_ENVIRONMENT
		rename
			print as print_any
		end

create
	make

feature -- Access

	name: STRING = "update_ecf"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
			-- Initialize `Current'.
		local
			l_ecf_files: ARRAYED_LIST [READABLE_STRING_32]
			l_folders: ARRAYED_LIST [READABLE_STRING_32]
--			is_recursive: BOOLEAN
			ecf_scanner: IRON_ECF_SCANNER
			p: PATH
			d: DIRECTORY
			is_help: BOOLEAN
			envs: STRING_TABLE [READABLE_STRING_32]
		do
			create l_ecf_files.make (0)
			create l_folders.make (0)
			create envs.make (0)

			is_stdout := True
			keep_backup := False

			across
				argument_source.arguments as ic
			loop
				if ic.item.starts_with_general ("-") then
					if
						ic.item.is_case_insensitive_equal_general ("-i")
						or ic.item.is_case_insensitive_equal_general ("--simulation")
					then
						is_simulation := True
					elseif
						ic.item.is_case_insensitive_equal_general ("-h")
						or ic.item.is_case_insensitive_equal_general ("--help")
					then
						is_help := True
					elseif
						ic.item.is_case_insensitive_equal_general ("--stdout")
					then
						is_stdout := True
--					elseif
--						ic.item.is_case_insensitive_equal_general ("-r")
--						or ic.item.is_case_insensitive_equal_general ("--recursive")
--					then
--						is_recursive := True
					elseif
						ic.item.is_case_insensitive_equal_general ("--save")
					then
						is_stdout := False
					elseif
						ic.item.is_case_insensitive_equal_general ("--backup")
					then
						keep_backup := True
					elseif
						ic.item.is_case_insensitive_equal_general ("--no_backup")
					then
						keep_backup := False
					elseif
						ic.item.is_case_insensitive_equal_general ("-D")
						or ic.item.is_case_insensitive_equal_general ("--define")
					then
						ic.forth
						if not ic.after then
							add_variable_definition_to (ic.item, envs)
						end
					end
				elseif ic.item.ends_with_general (".ecf") then
					l_ecf_files.force (ic.item)
				else
					l_folders.force (ic.item)
				end
			end
			if is_help then
				print ("Usage: {options} ecf_files_or_ecf_folders%N")
				print ("   It updates the ecf file to use the iron:package-name:path-to-ecf convention%N")
				print ("   -i|--simulation: simulation mode, no change on files%N")
				print ("   --stdout: updated file content is display in stdout%N")
				print ("   --save: update file directly%N")
				print ("   --backup: backup updated files as .bak file%N")
				print ("   --no_backup: do no backup updated file (this is the default)%N")
				print ("   -h|--help: display help%N")
			else
				apply_variable_definitions (envs)
				across
					l_folders as ic
				loop
					create p.make_from_string (ic.item)
					create d.make_with_path (p)
					if d.exists then
						create ecf_scanner.make
						ecf_scanner.process_directory (p)
						across
							ecf_scanner.items as ecf_ic
						loop
							l_ecf_files.force (ecf_ic.item.name)
						end
					end
				end

				if l_ecf_files.count > 1 then
					print (l_ecf_files.count.out + " files to update:%N")
				end
				across
					l_ecf_files as ic
				loop
					update_ecf (ic.item)
				end
			end
		end

	is_simulation: BOOLEAN

	is_stdout: BOOLEAN
			-- Output updated ecf file to stdout

	keep_backup: BOOLEAN
			-- Keep system backuped as ".bak" file?

	add_variable_definition_to (s: READABLE_STRING_32; envs: STRING_TABLE [READABLE_STRING_32])
		local
			p: INTEGER
			k, v: READABLE_STRING_32
		do
			p := s.index_of ('=', 1)
			if p > 0 then
				k := s.substring (1, p - 1)
				v := s.substring (p + 1, s.count)
			else
				k := s
				v := {STRING_32} ""
			end
			envs.force (v, k)
		end

	apply_variable_definitions (envs: STRING_TABLE [READABLE_STRING_32])
		do
			across
				envs as ic
			loop
				execution_environment.put (ic.item, ic.key)
			end
		end

	update_ecf (a_ecf: READABLE_STRING_32)
		require
			a_ecf.ends_with_general (".ecf")
		local
			cfg: CONF_LOAD
			cfg_factory: CONF_PARSE_FACTORY
			tgt: CONF_TARGET
			lib: CONF_LIBRARY
			clu: CONF_CLUSTER
			pif: like iron_package_file
			ref: PATH
		do
			io.error.put_string ("IRON::Updating ecf ")
			localized_print_error (a_ecf)
			io.error.put_string ("%N")

			create cfg_factory
			create cfg.make (cfg_factory)

			cfg.retrieve_configuration (a_ecf)
			if attached cfg.last_system as sys then
				create ref.make_from_string (a_ecf)
				ref := ref.absolute_path.canonical_path
				pif := iron_package_file (ref)
				ref := ref.parent -- reference folder
				across
					sys.targets as targets_ic
				loop
					tgt := targets_ic.item
					across
						tgt.libraries as lib_ic
					loop
						lib := lib_ic.item
						if attached iron_updated_file_location (lib.location, tgt, ref, pif) as l_new_loc then
							lib.set_location (l_new_loc)
						end
					end
					across
						tgt.clusters as clu_ic
					loop
						clu := clu_ic.item
						if attached iron_updated_directory_location (clu.location, tgt, ref, pif) as l_new_loc then
							clu.set_location (l_new_loc)
						end
					end

					across
						tgt.external_object as ic
					loop
						debug ("update_ecf")
							print ("  - ")
							print (ironized_text (ic.item.location, ref, pif))
							print ("%N")
						end
						ic.item.set_location (ironized_text (ic.item.location, ref, pif))
					end

					across
						tgt.external_include as ic
					loop
						debug ("update_ecf")
							print ("  - ")
							print (ironized_text (ic.item.location, ref, pif))
							print ("%N")
						end
						ic.item.set_location (ironized_text (ic.item.location, ref, pif))
					end
					across
						tgt.external_library as ic
					loop
						debug ("update_ecf")
							print ("  - ")
							print (ironized_text (ic.item.location, ref, pif))
							print ("%N")
						end
						ic.item.set_location (ironized_text (ic.item.location, ref, pif))
					end

					across
						tgt.external_linker_flag as ic
					loop
						debug ("update_ecf")
							print ("  - ")
							print (ironized_text (ic.item.location, ref, pif))
							print ("%N")
						end
						ic.item.set_location (ironized_text (ic.item.location, ref, pif))
					end

					across
						tgt.external_cflag as ic
					loop
						debug ("update_ecf")
							print ("  - ")
							print (ironized_text (ic.item.location, ref, pif))
							print ("%N")
						end
						ic.item.set_location (ironized_text (ic.item.location, ref, pif))
					end

					if is_simulation or is_stdout then
						if attached sys.text as l_sys_text then
							print (l_sys_text)
							print ("%N")
						else
							print ("ERROR: issue while trying to generate ecf content%N")
						end
					else
						if keep_backup then
							backup_system (sys)
						end
						sys.store
					end
				end
			end
		end

	text_mapping (a_string: READABLE_STRING_32; a_text: READABLE_STRING_32): ARRAYED_LIST [TUPLE [left: INTEGER_INTERVAL; right: INTEGER_INTERVAL]]
		local
			k,p: INTEGER

			s_count, r_count: INTEGER
			s, r: INTEGER
			cr,cs: CHARACTER_32
		do
			create Result.make (1)
			debug ("update_ecf")
				print ("Text mapping:%N")
				print ("%T")
				print (a_string)
				print ("%N")
				print ("%T")
				print (a_text)
				print ("%N")
			end

			from
				s := 1
				r := 1
				s_count := a_string.count
				r_count := a_text.count
			until
				s > s_count or r > r_count
			loop
				cr := a_text [r]

				p := a_string.index_of (cr, s)
				if p > 0 then
						-- Let's try to find a common part, should ends with '$' or end of input
					from
						k := 1
						cs := cr
					until
						cs /= cr or (k > 1 and cs = '$') or (p + k - 1 > s_count) or (r + k - 1 > r_count)
					loop
						if cs /= cr then
								-- Exit loop
						else
							k := k + 1
							if r + k - 1 <= r_count then
								cr := a_text [r + k - 1]
							else
								cr := '%U'
							end
							if p + k - 1 <= s_count then
								cs := a_string [p + k - 1]
							else
								cs := '%U'
							end
						end
					end

					if
						(cs = '$' and ( (a_string.valid_index (p - 1) implies a_string[p - 1] = ')') or k >= 4)) -- $ + ( + ? + )
						or
						(cs = '%U' and cr = '%U')
					then
							-- found matches
						if Result.is_empty and p > 1 then
							Result.force ([1 |..| (p - 1), 1 |..| (r - 1)])
						end
						Result.force ([p |..| (p + k - 1 - 1), r |..| (r + k - 1 - 1)])

						debug ("update_ecf")
							print (" -> ")
							print ("[(")
							print (r.out)
							print (",")
							print (p.out)
							print (") - (")
						end

						s := p + k - 1
						r := r + k - 1

						debug ("update_ecf")
							print ((r - 1).out)
							print (",")
							print ((s - 1).out)

							print (")] : ")
							print (a_string.substring (p, s - 1))
							print ("%N")
						end
					else
						r := r + 1
					end
				else
					r := r + 1
				end
			end

			if Result.is_empty then
				Result.force ([1 |..| s_count, 1 |..| r_count])
			elseif Result.last.left.upper < s_count then
				Result.force ([ (Result.last.left.upper + 1) |..| s_count, (Result.last.right.upper) |..| r_count])
			end
			from
				Result.start
				s := 1
				r := 1
			until
				Result.after
			loop
				if attached Result.item as tu then
					if tu.left.lower > s then
						Result.put_left ([s |..| (tu.left.lower - 1), r |..| (tu.right.lower - 1)])
						s := tu.left.upper + 1
						r := tu.right.upper + 1
					else
						s := tu.left.upper + 1
						r := tu.right.upper + 1
					end
				end
				Result.forth
			end
		end

	ironized_text (a_string: READABLE_STRING_32; ref: PATH; pif: detachable IRON_PACKAGE_FILE): STRING_32
		local
			str_exp: STRING_ENVIRONMENT_EXPANDER
			l_base: READABLE_STRING_32
			i,j: INTEGER
			ci,cj, sep: CHARACTER_32
			l_same_char: BOOLEAN
			l_iron_text: STRING_32
			l_tmp_p_name: detachable READABLE_STRING_32
			l_mapping: detachable like text_mapping
		do
			if a_string.has_substring ("$(IRON_PATH)") then
				create Result.make_from_string (a_string)
			else
				create str_exp

				Result := str_exp.expand_string_32 (a_string, True)
				if not Result.same_string (a_string) then
					l_mapping := text_mapping (a_String, Result)
					debug ("update_ecf")
						display_text_mapping (a_string, Result, l_mapping)
					end
				end

				if
					pif /= Void and then
					attached pif.package_name as p_name
				then
					l_base := pif.path.parent.name
					from
						i := 1
						j := 1
						cj := l_base[1]
					until
						i > Result.count
					loop
						if Result.count - i < l_base.count then
							i := Result.count + 1 --| Out
						else
							from
								j := 1
								l_same_char := True
							until
								j > l_base.count or i + j - 1 > Result.count or not l_same_char
							loop
								ci := Result [i + j - 1]
								cj := l_base[j]
								if ci.as_lower = cj.as_lower then
									l_same_char := True
									if sep = '%U' and (ci = '/' or ci = '\') then
										sep := ci
									end
								elseif (ci = '/' and cj = '\') or (ci = '\' and cj = '/') then
									l_same_char := True
									if sep = '%U' then
										sep := ci
									end
								else
									l_same_char := False
								end
								j := j + 1
							end
							if l_same_char and j = l_base.count + 1 then
								if sep = '/' then
									l_iron_text := {STRING_32} "$(IRON_PATH)/packages/" + p_name + {STRING_32} "/"
								else
									l_iron_text := {STRING_32} "$(IRON_PATH)\packages\" + p_name + {STRING_32} "\"
								end

								Result.replace_substring (l_iron_text, i, i + j - 1)
								if l_mapping /= Void then
									update_text_mapping (a_string, Result, i, i + j - 1, l_iron_text.count, l_mapping)
									debug ("update_ecf")
										display_text_mapping (a_string, Result, l_mapping)
									end
								end
								i := i + l_iron_text.count + 1
							elseif j > l_base.count - p_name.count then
								j := l_base.count - p_name.count + 1
								from
									ci := Result [i + j - 1]
								until
									j > Result.count or ci = '\' or ci = '/' or ci.is_space or ci = '%U'
								loop
									j := j + 1
									if Result.valid_index (i + j - 1) then
										ci := Result [i + j - 1]
									else
										ci := '%U'
									end
								end
								l_tmp_p_name := Result.substring (i + l_base.count - p_name.count, i + j - 1 - 1)
								print ("  !WARNING! guessing dependency package name [")
								print (l_tmp_p_name)
								print ("].%N")
								check no_hidden_dependency: False end

								if sep = '/' then
									l_iron_text := {STRING_32} "$(IRON_PATH)/packages/" + l_tmp_p_name + {STRING_32} "/"
								else
									l_iron_text := {STRING_32} "$(IRON_PATH)\packages\" + l_tmp_p_name + {STRING_32} "\"
								end

									-- FIXME: duplication of previous if .. then ... code
								Result.replace_substring (l_iron_text, i, i + j - 1)
								if l_mapping /= Void then
									update_text_mapping (a_string, Result, i, i + j - 1, l_iron_text.count, l_mapping)
									debug ("update_ecf")
										display_text_mapping (a_string, Result, l_mapping)
									end
								end
								i := i + l_iron_text.count + 1
							else
								i := i + 1
							end
						end
					end
				end
				if l_mapping /= Void then
					debug ("update_ecf")
						display_text_mapping (a_string, Result, l_mapping)
					end
					Result := text_mapping_to_text (a_string, Result, l_mapping, "$(IRON_PATH)")
					print ("  - ")
					print (Result)
					print ("%N")
				end

			end
		end

	update_text_mapping (a_left, a_right: READABLE_STRING_32; a_lower, a_upper, a_new_len: INTEGER; a_mapping: like text_mapping)
		local
			prev: detachable TUPLE [left: INTEGER_INTERVAL; right: INTEGER_INTERVAL]
			l_diff: INTEGER
		do
			l_diff := a_new_len - (a_upper - a_lower + 1)
			from
				a_mapping.start
			until
				a_mapping.after
			loop
				if
					a_mapping.item.right.lower <= a_lower and
					a_mapping.item.right.upper >= a_lower
					or
					a_mapping.item.right.upper >= a_upper and
					a_mapping.item.right.lower <= a_upper
				then
					if prev = Void then
						prev := a_mapping.item
						a_mapping.forth
					else
						prev.right.resize_exactly (prev.right.lower, a_mapping.item.right.upper)
						prev.left.resize_exactly (prev.left.lower, a_mapping.item.left.upper)
						a_mapping.remove
					end
				else
					a_mapping.forth
				end
			end

			from
				a_mapping.start
			until
				a_mapping.after
			loop
				if
					a_mapping.item.right.upper >= a_upper
				then
					prev := a_mapping.item
					if a_mapping.item.right.lower >= a_upper then
						prev.right.resize_exactly (prev.right.lower + l_diff, prev.right.upper + l_diff)
					else
						prev.right.resize_exactly (prev.right.lower, prev.right.upper + l_diff)
					end
					check left_ok:  prev.left.lower > 0 and prev.left.upper >= prev.left.lower end
					check right_ok: prev.right.lower > 0 and prev.right.upper >= prev.right.lower end
				end
				a_mapping.forth
			end
		ensure
			text_mapping_to_text (a_left, a_right, a_mapping, Void).same_string (a_left)
		end

	text_mapping_to_text (a_left, a_right: READABLE_STRING_32; a_mapping: like text_mapping; a_starts_with_kept: detachable READABLE_STRING_GENERAL): STRING_32
		local
			s: READABLE_STRING_32
		do
			create Result.make (a_right.count)
			across
				a_mapping as ic
			loop
				s := a_right.substring (ic.item.right.lower, ic.item.right.upper)
				if a_starts_with_kept /= Void and then s.starts_with_general (a_starts_with_kept) then
						-- Keep this updated text
				else
					s := a_left.substring (ic.item.left.lower, ic.item.left.upper)
				end
				Result.append (s)
			end
		end

	display_text_mapping (a_left, a_right: READABLE_STRING_32; a_mapping: like text_mapping)
		do
			print (text_mapping_to_string (a_left, a_right, a_mapping))
		end

	text_mapping_to_string (a_left, a_right: READABLE_STRING_32; a_mapping: like text_mapping): STRING
		do
			create Result.make (0)
			Result.append ("Mapping between: ")
			Result.append (a_mapping.count.out + " segments%N")
			Result.append (" - "); Result.append (a_left); Result.append ("%N")
			Result.append (" - "); Result.append (a_right); Result.append ("%N")
			across
				a_mapping as ic
			loop
				Result.append (" >> [")
				Result.append (ic.item.left.lower.out)
				Result.append (":")
				Result.append (ic.item.left.upper.out)
				Result.append ("]")
				Result.append (a_left.substring (ic.item.left.lower, ic.item.left.upper))
				Result.append ("%N")
				Result.append (" << [")
				Result.append (ic.item.right.lower.out)
				Result.append (":")
				Result.append (ic.item.right.upper.out)
				Result.append ("]")
				Result.append (a_right.substring (ic.item.right.lower, ic.item.right.upper))
				Result.append ("%N")
			end
		end

	is_text_related_to_windows_path (s: READABLE_STRING_32): BOOLEAN
		do
			Result := s.has ('\')
		end

	iron_package_file (p: PATH): detachable IRON_PACKAGE_FILE
		local
			pp, prev: PATH
			pif: detachable IRON_PACKAGE_FILE
			l_iron_files: like iron_files
		do
			from
				if p.extension /= Void then
						-- i.e .ecf, or similar, let's assume this is a file
						-- otherwise this is a folder
					pp := p.parent
					prev := p
				else
					pp := p
					prev := p.extended ("dummy.ext")
				end
				l_iron_files := Void
			until
				l_iron_files /= Void or prev.same_as (pp)
			loop
				l_iron_files := iron_files (pp)
				prev := pp
				pp := pp.parent
			end

			if l_iron_files /= Void and then not l_iron_files.is_empty then
				l_iron_files.start
				pif := Void
				across
					l_iron_files as f_ic
				until
					pif /= Void
				loop
					pif := f_ic.item
					if pif.has_error then
						pif := Void
					end
				end
			end
			Result := pif
		end

	iron_updated_file_location (a_loc: CONF_LOCATION; a_target: CONF_TARGET; a_ref: PATH; a_parent_pif: like iron_package_file): detachable CONF_FILE_LOCATION
		local
			p: PATH
			l_orig_loc: READABLE_STRING_32
			p1,p_ecf: PATH
			s1,s_ecf: STRING_32
			repo_fac: IRON_REPOSITORY_FACTORY
			p_ecf_entry: detachable PATH
			p_ecf_dir: PATH
		do
			l_orig_loc := a_loc.original_path
			if l_orig_loc.starts_with_general ("iron:") then
					-- Ok
			else
				p := a_loc.evaluated_path
				debug
					localized_print_error (p.name)
					io.error.put_string ("%N")
				end

				if attached iron_package_file (p) as pif then
					create repo_fac
					if attached {IRON_WORKING_COPY_REPOSITORY} repo_fac.new_repository (pif.path.parent.canonical_path.absolute_path.name) as l_wc_repo then
						p_ecf := p.canonical_path.absolute_path
						p1 := pif.path.parent.canonical_path.absolute_path
						if a_parent_pif /= Void and then a_parent_pif.path.is_same_file_as (pif.path) then
							p_ecf_entry := p_ecf.entry
							p_ecf_dir := p_ecf.parent

							p_ecf := relative_path_to (p_ecf_dir, a_ref)
							if p_ecf_entry /= Void then
								p_ecf := p_ecf.extended_path (p_ecf_entry)
							end
							create Result.make (p_ecf.name, a_target)
						else
							s1 := p1.name
							s_ecf := p_ecf.name

							if s_ecf.has_substring (s1) then
								s_ecf.remove_head (s1.count + 1)
							else
								check False end
							end
							if attached pif.to_iron_uri_location (create {PATH}.make_from_string (s_ecf)) as l_uri then
								io.error.put_string ("  - ")
								io.error.put_string (l_uri.string)
								io.error.put_string ("  (")
								localized_print_error (a_loc.evaluated_path.name)
								io.error.put_string (")%N")
								create Result.make (l_uri.string, a_target)
							end
						end
					end
				else
					print ("  !WARNING! missing or bad package.iron at %"")
					print (p.name)
					print ("%" .%N")
--					check has_pif: False end
				end
			end
		end

	iron_updated_directory_location (a_loc: CONF_LOCATION; a_target: CONF_TARGET; a_ref: PATH; a_parent_pif: like iron_package_file): detachable CONF_DIRECTORY_LOCATION
		local
			p: PATH
			l_orig_loc: READABLE_STRING_32
			p1,p_ecf: PATH
			s1,s_ecf: STRING_32
			repo_fac: IRON_REPOSITORY_FACTORY
		do
			l_orig_loc := a_loc.original_path
			if l_orig_loc.starts_with_general ("iron:") then
					-- Ok
			else
				p := a_loc.evaluated_path
				debug
					localized_print_error (p.name)
					io.error.put_string ("%N")
				end

				if attached iron_package_file (p) as pif then
					create repo_fac
					if attached {IRON_WORKING_COPY_REPOSITORY} repo_fac.new_repository (pif.path.parent.canonical_path.absolute_path.name) as l_wc_repo then
						p_ecf := p.canonical_path.absolute_path
						p1 := pif.path.parent.canonical_path.absolute_path
						if a_parent_pif /= Void and then a_parent_pif.path.is_same_file_as (pif.path) then
							create Result.make (relative_path_to (p_ecf, a_ref).name, a_target)
						else
							s1 := p1.name
							s_ecf := p_ecf.name

							if s_ecf.has_substring (s1) then
								s_ecf.remove_head (s1.count + 1)
							else
								check False end
							end
							if attached pif.to_iron_uri_location (create {PATH}.make_from_string (s_ecf)) as l_uri then
								io.error.put_string (l_uri.string)
								io.error.put_string ("  (")
								localized_print_error (a_loc.evaluated_path.name)
								io.error.put_string (")%N")
								create Result.make (l_uri.string, a_target)
							end
						end
					end
				end
			end
		end

	relative_path_to (p, ref: PATH): PATH
			-- `p' as relative to `ref'.
			--| For instance
			--| ("a/b/c", "a/z") => "../b/c"
			--| ("a/z", "a/b/c") => "../../z"
		local
			lst1,lst2: LIST [PATH]
			l_common_done: BOOLEAN
			i, j, n1, n2, n: INTEGER
		do
			lst1 := p.components
			lst2 := ref.components
			n1 := lst1.count
			n2 := lst2.count
			n := n1.min (n2)

				-- Find common part
			from
				i := 1
			until
				i > n or l_common_done
			loop
				if lst1[i].name.is_case_insensitive_equal (lst2[i].name) then
					i := i + 1
				else
					l_common_done := True
				end
			end

--			if i >= n1 and n1 >= n2 then
--				create Result.make_current
--			else
				create Result.make_empty
--			end


				-- Back to common part from ref
			from
				j := i
			until
				j > n2
			loop
				Result := Result.extended ("..")
				j := j + 1
			end

				-- Going to `p'
			from
			until
				i > n1
			loop
				Result := Result.extended_path (lst1[i])
				i := i + 1
			end
		ensure
			ref.extended_path (Result).absolute_path.canonical_path.name.is_case_insensitive_equal (p.absolute_path.canonical_path.name)
		end

	backup_system (a_sys: CONF_SYSTEM)
		local
			f_src, f_bak: RAW_FILE
		do
			create f_src.make_with_path (a_sys.file_path)
			f_src.open_read
			create f_bak.make_with_path (a_sys.file_path.appended_with_extension ("bak"))
			f_bak.create_read_write
			f_src.copy_to (f_bak)
			f_bak.close
			f_src.close
		end

	iron_files (p: PATH): detachable ARRAYED_LIST [IRON_PACKAGE_FILE]
		local
			d: DIRECTORY
			ip: PATH
			f: RAW_FILE
			pif_fac: IRON_PACKAGE_FILE_FACTORY
			pif: IRON_PACKAGE_FILE
		do
			create d.make_with_path (p)
			if d.exists then
				create Result.make (0)
				create pif_fac
				across
					d.entries as ic
				loop
					if ic.item.is_current_symbol or ic.item.is_parent_symbol then
					else
						ip := p.extended_path (ic.item)
						if attached ip.extension as ext and then ext.is_case_insensitive_equal ("iron") then
							create f.make_with_path (ip)
							if f.exists then
								pif := pif_fac.new_package_file (ip)
								if not pif.has_error then
									Result.force (pif)
								end
							end
						end
					end
				end
				if Result.is_empty then
					Result := Void
				end
			else
				Result := Void
			end
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
