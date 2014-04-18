note
	description: "[
	
				Application that analyze a folder and build (or just update) the related package file "package_name.iron"
				Usage: 
					Precise a list of folder names (relative or absolute)
						update_iron folder1 folder2 ...
						
					It is also possible to precise the expected name with
						update_iron folder1 folder2/foo.iron


		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	APP_UPDATE_IRON

inherit
	CONF_ACCESS

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			args: ARGUMENTS_32
			iron_name: detachable READABLE_STRING_32
			folder: detachable PATH
			iron_path: detachable PATH
			l_is_first: BOOLEAN
			p: PATH
		do
			create args

			is_stdout := False

			l_is_first := True
			across
				args as ic
			loop
				if l_is_first then
					l_is_first := False
						-- Skip args[0]
				else
					if ic.item.starts_with_general ("-") then
						if
							ic.item.is_case_insensitive_equal_general ("-v")
							or ic.item.is_case_insensitive_equal_general ("--verbose")
						then
							is_verbose := True
						elseif
							ic.item.is_case_insensitive_equal_general ("--stdout")
						then
							is_stdout := True
						elseif
							ic.item.is_case_insensitive_equal_general ("--save")
						then
							is_stdout := False
						elseif
							ic.item.is_case_insensitive_equal_general ("--folder")
						then
							ic.forth
							if not ic.after then
								create folder.make_from_string (ic.item)
							end
						end
					else
						if
							ic.item.ends_with_general (".iron")
						then
							create p.make_from_string (ic.item)
							iron_path := p.absolute_path.canonical_path
							if folder = Void then
								folder := p.parent
							end
							if attached p.entry as e then
								iron_name := e.name
							else
								iron_name := ic.item
							end
							iron_name := iron_name.head (iron_name.count - (".iron").count)
							if iron_name.is_case_insensitive_equal_general ("package") then
									-- Use parent name ...
								iron_name := Void
							end
						elseif folder = Void then
							create folder.make_from_string (ic.item)
						else
							check False end
						end
					end
				end
			end

			if folder = Void then
				folder := execution_environment.current_working_path
			end

			if iron_name = Void then
				if attached folder.entry as e then
					iron_name := e.name
				end
			end

			if iron_name /= Void then
				if iron_path = Void then
					iron_path := folder.extended ("package.iron")
				end
				update_iron (iron_name, iron_path)
			else
				print ("Missing name")
			end
		end

	is_verbose: BOOLEAN

	is_stdout: BOOLEAN
			-- Output updated ecf file to stdout

	has_error: BOOLEAN
			-- Last `update_iron' has error?

	update_iron (a_package_name: READABLE_STRING_32; a_iron_file: PATH)
		require
			attached a_iron_file.extension as ext and then ext.is_case_insensitive_equal_general ("iron")
		local
			pp, p: PATH
			pp_name, p_name: STRING_32
			uri_root, uri_item: STRING
			repo_fac: IRON_REPOSITORY_FACTORY
			pif: detachable IRON_PACKAGE_FILE
			pif_fac: IRON_PACKAGE_FILE_FACTORY
			pac: IRON_PACKAGE
			p_uri, l_uri: PATH_URI
			s1, s: STRING_32

			vis_ecfs: APP_ECF_SCANNER
			vis_clibs: APP_CLIB_SCANNER
		do
			has_error := False
			io.error.put_string ("IRON::Updating ")
			io.error.put_string (a_iron_file.name.as_string_8) -- FIXME unicode
			io.error.put_string ("%N")

			p_name := a_package_name

			create repo_fac
			uri_root := uri_from_path (a_iron_file.parent.absolute_path.canonical_path)
			if attached {IRON_WORKING_COPY_REPOSITORY} repo_fac.new_repository (uri_root) as l_wc_repo then
				create pac.make (p_name, l_wc_repo)
				pac.set_name (p_name)
				create pif_fac
				pif := pif_fac.new_package_file (a_iron_file)
				pif.enable_assistant

				pif.load_package (pac)
				has_error := pif.has_error

				create vis_clibs.make
				pp := a_iron_file.parent.absolute_path.canonical_path
				pp_name := pp.name
				create p_uri.make_from_path (pp)
				s1 := p_uri.string

				vis_clibs.process_directory (pp)
				across
					vis_clibs.items as ic
				loop
					p := ic.item.absolute_path.canonical_path
					create l_uri.make_from_path (p)
					s := l_uri.string
					check s.starts_with (s1) end
					s.remove_head (s1.count + 1)
					pif.add_setup ("compile_library", s)

--					if attached library_target_name (p) as l_lib_name then
--						uri_item := uri_from_path (p)
--						if uri_item.starts_with (uri_root) then
--							uri_item.remove_head (uri_root.count + 1)
--							pif.add_project (l_lib_name, uri_item)
--						else
--							has_error := True
--						end
--					end
				end

				create vis_ecfs.make
				pp := a_iron_file.parent.absolute_path.canonical_path
				pp_name := pp.name
				vis_ecfs.process_directory (pp)
				across
					vis_ecfs.items as ic
				loop
					p := ic.item.absolute_path.canonical_path

					if attached library_target_name (p) as l_lib_name then
						uri_item := uri_from_path (p)
						if uri_item.starts_with (uri_root) then
							uri_item.remove_head (uri_root.count + 1)
							pif.add_project (l_lib_name, uri_item)
						else
							has_error := True
						end
					end
				end

				if has_error then
					io.error.put_string ("error raised during process!%N")
				else
					if is_stdout then
						print (pif.text)
					else
						pif.save
						print ("iron file %""+ pif.path.name +"%" updated!%N")
						pif := pif_fac.new_package_file (a_iron_file)
						pif.enable_assistant
						if pif.has_error then
							io.error.put_string ("Saved file has error in content!%N")
						end
					end
				end
			end
		end

	uri_from_path (p: PATH): STRING
		local
			uri: PATH_URI
		do
			create uri.make_from_path (p)
			Result := uri.string
		end

	library_target_name (a_ecf: PATH): detachable READABLE_STRING_32
		require
			a_ecf.name.ends_with_general (".ecf")
		local
			cfg: CONF_LOAD
			cfg_factory: CONF_PARSE_FACTORY
		do
			create cfg_factory
			create cfg.make (cfg_factory)

			cfg.retrieve_configuration (a_ecf.name)
			if attached cfg.last_system as sys then
				if attached sys.library_target as l_library_target then
					Result := l_library_target.name
				end
			end
		end

end
