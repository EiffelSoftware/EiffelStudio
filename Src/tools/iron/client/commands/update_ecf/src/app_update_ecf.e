note
	description: "Objects that ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	APP_UPDATE_ECF

inherit
	CONF_ACCESS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			args: ARGUMENTS_32
			l_ecf_files: ARRAYED_LIST [READABLE_STRING_32]
			l_folders: ARRAYED_LIST [READABLE_STRING_32]
--			is_recursive: BOOLEAN
			ecf_scanner: IRON_ECF_SCANNER
			p: PATH
			d: DIRECTORY
			is_help: BOOLEAN
		do
			create args
			create l_ecf_files.make (0)
			create l_folders.make (0)

			is_stdout := True

			across
				args as ic
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
				print ("   -h|--help: display help%N")
			else
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
			io.error.put_string (a_ecf)
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
					sys.targets as ic
				loop
					tgt := ic.item
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
					if is_simulation or is_stdout then
						if attached sys.text as l_sys_text then
							print (l_sys_text)
							print ("%N")
						else
							print ("ERROR: issue while trying to generate ecf content%N")
						end
					else
						backup_system (sys)
						sys.store
					end
				end
			end
		end

	iron_package_file (p: PATH): detachable IRON_PACKAGE_FILE
		local
			pp, prev: PATH
			pif: detachable IRON_PACKAGE_FILE
			l_iron_files: like iron_files
		do
			from
				pp := p.parent
				prev := p
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
					io.error.put_string (p.name.as_string_8) -- FIXME: unicode
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
								io.error.put_string (l_uri.string)
								io.error.put_string ("  (")
								io.error.put_string (a_loc.evaluated_path.name.as_string_8) -- FIXME: unicode
								io.error.put_string (")%N")
								create Result.make (l_uri.string, a_target)
							end
						end
					end
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
					io.error.put_string (p.name.as_string_8) -- FIXME: unicode
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
								io.error.put_string (a_loc.evaluated_path.name.as_string_8) -- FIXME: unicode
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
		local
			lst1,lst2: LIST [PATH]
			l_common_done: BOOLEAN
			i, j, n1, n: INTEGER
		do
			lst1 := p.components
			lst2 := ref.components
			from
				i := 1
				n1 := lst1.count
				n := n1.min (lst2.count)
			until
				i > n or l_common_done
			loop
				if lst1[i].name.same_string (lst2[i].name) then
					i := i + 1
				else
					l_common_done := True
				end
			end
			if i >= n1 then
				create Result.make_current
			else
				create Result.make_empty
			end
			from
				j := i
			until
				j >= n1
			loop
				Result := Result.extended ("..")
				j := j + 1
			end
			from

			until
				i > n1
			loop
				Result := Result.extended_path (lst1[i])
				i := i + 1
			end
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
		end

feature -- Status

feature -- Access

feature -- Change


invariant
--	invariant_clause: True

end

