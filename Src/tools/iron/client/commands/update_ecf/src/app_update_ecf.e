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
		do
			create args
			create l_ecf_files.make (0)

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
						ic.item.is_case_insensitive_equal_general ("--stdout")
					then
						is_stdout := True
					elseif
						ic.item.is_case_insensitive_equal_general ("--save")
					then
						is_stdout := False
					end
				elseif ic.item.ends_with_general (".ecf") then
					l_ecf_files.force (ic.item)
				end
			end

			across
				l_ecf_files as ic
			loop
				update_ecf (ic.item)
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
			p: PATH
			pp, prev: PATH
			l_iron_files: like iron_files
			s1,s2: STRING_32
			repo_fac: IRON_REPOSITORY_FACTORY
			pif: detachable IRON_PACKAGE_FILE
		do
			io.error.put_string ("IRON::Updating ecf ")
			io.error.put_string (a_ecf)
			io.error.put_string ("%N")

			create cfg_factory
			create cfg.make (cfg_factory)

			cfg.retrieve_configuration (a_ecf)
			if attached cfg.last_system as sys then
				across
					sys.targets as ic
				loop
					tgt := ic.item
					across
						tgt.libraries as lib_ic
					loop
						p := lib_ic.item.location.evaluated_path
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

						debug
							io.error.put_string (lib_ic.item.location.evaluated_path.name.as_string_8) -- FIXME: unicode
							io.error.put_string ("%N")
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
							if pif /= Void then
								create repo_fac
								if attached {IRON_WORKING_COPY_REPOSITORY} repo_fac.new_repository (pif.path.parent.canonical_path.absolute_path.name) as l_wc_repo then
									s1 := pif.path.parent.canonical_path.absolute_path.name
									s2 := p.canonical_path.absolute_path.name
									if s2.has_substring (s1) then
										s2.remove_head (s1.count + 1)
									else
										check False end
									end
									if attached pif.to_iron_uri_location (create {PATH}.make_from_string (s2)) as l_uri then
										io.error.put_string (l_uri.string)
										io.error.put_string ("  (")
										io.error.put_string (lib_ic.item.location.evaluated_path.name.as_string_8) -- FIXME: unicode
										io.error.put_string (")%N")

										lib_ic.item.set_location (create {CONF_FILE_LOCATION}.make (l_uri.string, lib_ic.item.target))
									end
								end
							end
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
