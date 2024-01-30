note
	description: "Installation command."
	date: "$Date$"
	revision: "$Revision$"

class
	ROC_INSTALL_COMMAND

inherit
	ROC_COMMAND

create
	make

feature -- Access

	help: STRING_32
		once
			Result := "[--module|-m <MODULE_PATH>] [--theme <THEME_PATH>] [(--dir|-d <CMS_PATH>) | <MODULE_NAME>] [--site-dir <CMS_SITE_PATH>]"
		end

feature -- Status report

	is_valid (args:	ARRAY [READABLE_STRING_32]): BOOLEAN
			-- Is the submitted install command valid?
		local
			i, n: INTEGER
			optional_theme: BOOLEAN
			optional_module: BOOLEAN
			optional_config: BOOLEAN
			cms_path: BOOLEAN
		do
			n := args.upper
				-- TODO add error reporting.
			if n >= 1 and then n <= 5 then
				from
					i := 1
				until
					i > n
				loop
					if args [i].same_string ("-f") then
						optional_config := True
					elseif args [i].same_string ("--config") then
						optional_config := True
					elseif
						args [i].same_string ("-m") or args [i].same_string ("--module")
					then
						optional_module := True
					elseif
						args [i].same_string ("--theme")
					then
						optional_theme := True
					elseif args [i].same_string ("-d") then
						cms_path := True
					elseif args [i].same_string ("--dir") then
						cms_path := True
					end
					i := i + 1
				end
				if optional_config then
					Result := True
				else
					if n <= 5 then
						if cms_path and optional_module then
								-- valid command
							Result := True
						else
							print ("Error check the optional argument --module|-m and --dir|-d")
						end
					elseif n <= 3 then
						if cms_path and not optional_module then
							Result := True
						else
							print ("Error missing value for dir")
							Result := False
						end
					else
						Result := True
					end
				end
			else
				Result := False
				if n > 5 then
					print ("Too many arguments")
				end
				if n < 1 then
					print ("Too few arguments")
				end
			end
		end

feature -- Helpers

	module_name (a_path: PATH): STRING_32
		do
				-- FIXME: better implementation needed. Either based on "a" new module.info file, or parsing the .ecf
			if attached a_path.entry as e then
				Result := e.name
			else
				Result := a_path.name
			end
		end

	theme_name (a_path: PATH): STRING_32
		do
				-- FIXME: better implementation needed. Either based on "a" new theme.info file, or parsing the .ecf
			if attached a_path.entry as e then
				Result := e.name
			else
				Result := a_path.name
			end
		end

feature -- Execution

	execute (args: ARRAY [READABLE_STRING_32])
			-- Install a module into a cms application.
			-- Pattern: module_src/site/* => cms/site/modules/$module_name/*
		local
			l_config_path, l_site_path, l_cms_path, p: detachable PATH
			l_module_source_locations, l_theme_source_locations: ARRAYED_LIST [ROC_INSTALL_COPY_PARAMETERS]
			l_site_dir: DIRECTORY
			l_modules_dir: DIRECTORY
			l_themes_dir: DIRECTORY
			l_dest_dir: DIRECTORY
			l_cp_params: ROC_INSTALL_COPY_PARAMETERS
			i,n: INTEGER
			l_modules_count, l_themes_count, l_global_file_changes, l_errors_count: INTEGER
		do
			create l_module_source_locations.make (1)
			create l_theme_source_locations.make (1)
			from
				i := 1
				n := args.upper
			until
				i > n
			loop
				if attached args[i] as arg then
					if
						arg.same_string ("-f")
						or arg.same_string ("--config")
					then
						i := i + 1
						if i <= n then
							create l_config_path.make_from_string (args[i])
						end
					elseif
						arg.same_string ("-d")
						or arg.same_string ("--dir")
					then
						i := i + 1
						if i <= n then
							create l_cms_path.make_from_string (args[i])
						end
					elseif
						arg.same_string ("--site-dir")
					then
						i := i + 1
						if i <= n then
							create l_site_path.make_from_string (args[i])
						end
					elseif
						arg.same_string ("-m")
						or arg.same_string ("--module")
					then
						i := i + 1
						if i <= n then
							l_module_source_locations.force (create {PATH}.make_from_string (args[i]))
						end
					elseif
						arg.same_string ("--theme")
					then
						i := i + 1
						if i <= n then
							l_theme_source_locations.force (create {PATH}.make_from_string (args[i]))
						end
					elseif
						arg.same_string ("-v")
						or arg.same_string ("--verbose")
					then
						is_verbose := True
					end
				end
				i := i + 1
			end

			if l_config_path /= Void and then attached {CONFIG_READER} roc_configuration (l_config_path) as cfg then
				if attached cfg.resolved_text_item ("location") as cfg_location then
					create p.make_from_string (cfg_location)
					if not p.is_absolute then
						p := l_config_path.parent.extended_path (p)
					end
					l_cms_path := p.canonical_path
				end
				if l_cms_path = Void then
					l_cms_path := l_config_path.parent
				end

				if attached cfg.resolved_text_item ("site_directory") as cfg_site_dir then
					create p.make_from_string (cfg_site_dir)
					if not p.is_absolute then
						p := l_cms_path.extended_path (p)
					end
					l_site_path := p.canonical_path
				end
				if attached cfg.resolved_text_table_item ("modules") as tb then
					across
						tb as ic
					loop
						l_module_source_locations.extend (create {PATH}.make_from_string (ic.item))
					end
				elseif attached cfg.table_keys ("modules") as tb_keys then
					across
						tb_keys as ic
					loop
						if attached cfg.resolved_text_item ({STRING_32} "modules." + ic.item + ".location") as l_loc then
							create p.make_from_string (l_loc)
							if not p.is_absolute then
								p := l_cms_path.extended_path (p)
							end
							create l_cp_params.make_with_location (p.canonical_path)
							if attached cfg.resolved_text_item ({STRING_32} "modules." + ic.item + ".mode") as l_mode and then l_mode.is_case_insensitive_equal_general ("link") then
								l_cp_params.set_link_mode (True)
							end
							l_module_source_locations.extend (l_cp_params)
						end
					end
				end
				if attached cfg.resolved_text_table_item ("themes") as tb then
					across
						tb as ic
					loop
						l_theme_source_locations.extend (create {PATH}.make_from_string (ic.item))
					end
				elseif attached cfg.table_keys ("themes") as tb_keys then
					across
						tb_keys as ic
					loop
						if attached cfg.resolved_text_item ({STRING_32} "themes." + ic.item + ".location") as l_loc then
							create p.make_from_string (l_loc)
							if not p.is_absolute then
								p := l_cms_path.extended_path (p)
							end
							create l_cp_params.make_with_location (p.canonical_path)
							if attached cfg.resolved_text_item ({STRING_32} "modules." + ic.item + ".mode") as l_mode and then l_mode.is_case_insensitive_equal_general ("link") then
								l_cp_params.set_link_mode (True)
							end
							l_theme_source_locations.extend (l_cp_params)
						end
					end
				end
			elseif l_config_path /= Void then
				l_errors_count := l_errors_count + 1
				localized_print_error ({STRING_32} "Unable to read configuration file %"" + l_config_path.name + "%"!%N")
			end

			if l_cms_path = Void then
				l_cms_path := Execution_environment.current_working_path.extended ("modules")
			end
				-- If l_site_path is not set; initialize it to $cms_path/site.
			if l_site_path = Void then
				l_site_path := l_cms_path.extended ("site").canonical_path
			end

			across
				l_module_source_locations as ic
			loop
				if
					attached ic.item as l_module_source_path and then
					attached module_name (l_module_source_path.location) as l_mod_name
				then
						-- Install configuration files.
					create l_site_dir.make_with_path (l_site_path)
					if l_site_dir.exists then
						l_modules_count := l_modules_count + 1
						create l_modules_dir.make_with_path (l_site_path.extended ("modules"))
						if not l_modules_dir.exists then
							l_modules_dir.create_dir
						end

					    create l_dest_dir.make_with_path (l_modules_dir.path.extended (l_mod_name))
						if not l_dest_dir.exists then
							l_dest_dir.create_dir
						end
						if is_verbose then
							print ("Install module ")
							print (l_mod_name)
							print (" in %"")
							print (l_dest_dir.path.name)
							print ("%":%N")
						end
						install_module_elements (l_mod_name, l_module_source_path, l_dest_dir.path, Void)
						l_global_file_changes := l_global_file_changes + files_changes_count
						if is_verbose then
							print (" - ")
							print (directories_count.out + " director" + if directories_count > 1 then "ies" else "y" end + ", ")
							print (files_count.out + " file" + if files_count > 1 then "s" else "" end)
							if files_changes_count > 0 then
								print (" (+" + files_changes_count.out + ")")
							end
							print (".%N")
						elseif files_changes_count > 0 then
							print ("Install module ")
							print (l_mod_name)
							print (" in %"")
							print (l_dest_dir.path.name)
							print ("%": ")
							print (files_changes_count.out)
							if files_changes_count = 1 then
								print (" change.%N")
							else
								print (" changes.%N")
							end
						end
					else
						l_errors_count := l_errors_count + 1
						print ({STRING_32} "The CMS Application located at " + l_cms_path.name + "does not have the site or modules folders.%N")
					end
				else
					print ("Error: could not retrieve module name.%N")
				end
			end
			across
				l_theme_source_locations as ic
			loop
				if
					attached ic.item as l_theme_source_path and then
					attached theme_name (l_theme_source_path.location) as l_theme_name
				then
						-- Install configuration files.
					create l_site_dir.make_with_path (l_site_path)
					if l_site_dir.exists then
						l_themes_count := l_themes_count + 1
						create l_themes_dir.make_with_path (l_site_path.extended ("themes"))
						if not l_themes_dir.exists then
							l_themes_dir.create_dir
						end

					    create l_dest_dir.make_with_path (l_themes_dir.path.extended (l_theme_name))
						if not l_dest_dir.exists then
							l_dest_dir.create_dir
						end
						if is_verbose then
							print ("Install theme ")
							print (l_theme_name)
							print (" in %"")
							print (l_dest_dir.path.name)
							print ("%":%N")
						end
						install_theme_elements (l_theme_source_path, l_dest_dir.path, Void)
						l_global_file_changes := l_global_file_changes + files_changes_count
						if is_verbose then
							print (" - ")
							print (directories_count.out + " director" + if directories_count > 1 then "ies" else "y" end + ", ")
							print (files_count.out + " file" + if files_count > 1 then "s" else "" end)
							if files_changes_count > 0 then
								print (" (+" + files_changes_count.out + ")")
							end
							print (".%N")
						elseif files_changes_count > 0 then
							print ("Install theme ")
							print (l_theme_name)
							print (" in %"")
							print (l_dest_dir.path.name)
							print ("%": ")
							print (files_changes_count.out)
							if files_changes_count = 1 then
								print (" change.%N")
							else
								print (" changes.%N")
							end
						end
					else
						l_errors_count := l_errors_count + 1
						print ({STRING_32} "The CMS Application located at " + l_cms_path.name + "does not have the site or themes folders.%N")
					end
				else
					l_errors_count := l_errors_count + 1
					print ("Error: could not retrieve theme name.%N")
				end
			end
			if l_modules_count > 0 then
				if l_modules_count = 1 then
					print ("One module updated.%N")
				else
					print (l_modules_count.out + " modules updated.%N")
				end
			end
			if l_themes_count > 0 then
				if l_themes_count = 1 then
					print ("One theme updated.%N")
				else
					print (l_themes_count.out + " themes updated.%N")
				end
			end
			if l_global_file_changes > 0 then
				if l_global_file_changes = 1 then
					print ("One file updated.%N")
				else
					print (l_global_file_changes.out + " files updated.%N")
				end
			else
				print ("No file updated.%N")
			end
			if l_errors_count > 0 then
				print (l_errors_count.out + " errors.%N")
			end
		end

	roc_configuration (a_cfg_location: PATH): detachable CONFIG_READER
		do
			create {JSON_CONFIG} Result.make_from_file (a_cfg_location)
			if Result.has_error then
				Result := Void
			end
		end

	ecf_location (a_module_name: READABLE_STRING_GENERAL; a_module_source_path: ROC_INSTALL_COPY_PARAMETERS): detachable PATH
			-- ecf location if exists.
			-- Try to find based on `a_module_name`, or dir name from `a_module_source_path`, or .. search unique .ecf file (ignoring -safe.ecf).
		local
			l_name: READABLE_STRING_GENERAL
			p: PATH
			ut: FILE_UTILITIES
		do
			p := a_module_source_path.location
			Result := p.extended (a_module_name).appended_with_extension ("ecf")
			if ut.file_path_exists (Result) then
					-- Found.
			else
				Result := Void
				if attached p.entry as e then
					Result := p.extended (e.name).appended_with_extension ("ecf")
					if not ut.file_path_exists (Result) then
						Result := Void
					end
				end
				if Result = Void then
					if attached ut.file_names (p.name) as l_filenames then
						across
							l_filenames as ic
						until
							Result /= Void
						loop
							l_name := ic.item
							if l_name.ends_with (".ecf") then
								if l_name.ends_with ("-safe.ecf") then
										-- Ignore
								else
									Result := p.extended (l_name)
									if not ut.file_path_exists (Result) then
										check existing_file: False end
										Result := Void
									end
								end
							end
						end
					end
				end
			end
		end

	install_module_elements (a_module_name: READABLE_STRING_GENERAL; a_module_source_path: ROC_INSTALL_COPY_PARAMETERS; a_cms_module_target_path: PATH; a_element: detachable READABLE_STRING_GENERAL)
			-- Install module site files from `a_module_source_path' to cms application `a_cms_module_target_path' under expected modules folder.
			-- If `a_element' is set, take into account only sub folder `a_element'.
		local
			l_path: PATH
			l_dest_dir: DIRECTORY
			l_src_dir: DIRECTORY
			fut: FILE_UTILITIES
		do
			l_path := a_module_source_path.location.extended ("site")
			if fut.directory_path_exists (l_path) then
				if a_element /= Void then
						-- Copy all files under "site/$a_element" into "site/modules/$module_name/$a_element" location.
					create l_src_dir.make_with_path (l_path.extended (a_element))
					create l_dest_dir.make_with_path (a_cms_module_target_path.extended (a_element))
				else
						-- Copy all files under "site" into "site/modules/$module_name/" location.
					create l_src_dir.make_with_path (l_path)
					create l_dest_dir.make_with_path (a_cms_module_target_path)
				end
				if not l_dest_dir.exists then
					l_dest_dir.create_dir
				end
				files_count := 0
				directories_count := -1
				files_changes_count := 0

				if a_module_source_path.is_link_mode then
					copy_directory (l_src_dir, l_dest_dir, True)
				else
					link_directory (l_src_dir, l_dest_dir, True)
				end
					-- Detect ecf file (in the future, update main ecf file).
				if attached ecf_location (a_module_name, a_module_source_path) as l_ecf_loc then
						-- Found ecf file.
				elseif not a_module_name.is_case_insensitive_equal ("core") then
					localized_print_error ({STRING_32} "Missing .ecf file for " + a_module_name + "!%N")
				end
			end
		end

	install_theme_elements (a_theme_source_path: ROC_INSTALL_COPY_PARAMETERS; a_cms_theme_target_path: PATH; a_element: detachable READABLE_STRING_GENERAL)
			-- Install theme site files from `a_theme_source_path' to cms application `a_cms_theme_target_path' under expected "themes" folder.
			-- If `a_element' is set, take into account only sub folder `a_element'.
		local
			l_path: PATH
			l_dest_dir: DIRECTORY
			l_src_dir: DIRECTORY
		do
			l_path := a_theme_source_path.location
			if a_element /= Void then
					-- Copy all files under "site/$a_element" into "site/themes/$theme_name/$a_element" location.
				create l_src_dir.make_with_path (l_path.extended (a_element))
				create l_dest_dir.make_with_path (a_cms_theme_target_path.extended (a_element))
			else
					-- Copy all files under "site" into "site/themes/$theme_name/" location.
				create l_src_dir.make_with_path (l_path)
				create l_dest_dir.make_with_path (a_cms_theme_target_path)
			end
			if not l_dest_dir.exists then
				l_dest_dir.create_dir
			end
			files_count := 0
			directories_count := -1
			files_changes_count := 0

			if a_theme_source_path.is_link_mode then
				copy_directory (l_src_dir, l_dest_dir, True)
			else
				link_directory (l_src_dir, l_dest_dir, True)
			end
		end

	is_verbose: BOOLEAN

	files_count: INTEGER
			-- Number of copied files during installation.

	files_changes_count: INTEGER
			-- Number of files changed during installation.

	directories_count: INTEGER
			-- Number of copied directories during installation.


feature {NONE} -- System/copy files

	copy_directory (a_src: DIRECTORY; a_dest: DIRECTORY; is_recursive: BOOLEAN)
			-- Copy all elements from `a_src' to `a_dest'.
		local
			l_dir: DIRECTORY
			l_new_dir: DIRECTORY
			entry: PATH
			l_path: PATH
			l_file: FILE
			ut: FILE_UTILITIES
		do
			directories_count := directories_count + 1
			across
				a_src.entries as ic
			loop
				entry := ic.item
				if not (entry.is_current_symbol or else entry.is_parent_symbol) then
					l_path := a_src.path.extended_path (entry)
					create {RAW_FILE} l_file.make_with_path (l_path)
					if not l_file.is_directory then
						copy_file_in_directory (l_file, a_dest.path)
					elseif is_recursive then
						create l_dir.make_with_path (l_path)
						create l_new_dir.make_with_path (a_dest.path.extended_path (entry))
						ut.create_directory_path (l_new_dir.path)
						if l_dir.exists then
							copy_directory (l_dir, l_new_dir, is_recursive)
						end
					end
				end
			end
		end

	link_directory (a_src: DIRECTORY; a_dest: DIRECTORY; is_recursive: BOOLEAN)
			-- Link all elements from `a_src' to `a_dest'.
		do
				-- TODO: implement symbolic link ...
			copy_directory (a_src, a_dest, is_recursive)
		end

	copy_file_in_directory (a_file: FILE; a_dir: PATH)
			-- Copy file `a_file' to dir `a_dir'.
		local
			retried: BOOLEAN
			l_dest: RAW_FILE
		do
			if not retried then
				if attached a_file.path.entry as e then
					a_file.open_read
						-- Copy file source to destination
					if
						a_file.exists and then
						a_file.is_access_readable
					then
						create l_dest.make_with_path (a_dir.extended_path (e))
						if
							not l_dest.exists or else
							l_dest.is_writable
						then
							if not l_dest.exists or else (a_file.date > l_dest.date) then
								files_changes_count := files_changes_count + 1
								if is_verbose then
									print ({STRING_32} " - file %"" + l_dest.path.name + "%"%N")
								end
							end

							l_dest.create_read_write
							a_file.copy_to (l_dest)
							a_file.close
							l_dest.close
							files_count := files_count + 1
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

--feature -- Constants

--	Config_dir: STRING = "config"
--			-- Configuration dir.

--	Scripts_dir: STRING = "scripts"
--			-- Scripts dir.

--	Themes_dir: STRING = "themes"
--			-- Themes dir.


note
	copyright: "2011-2024, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
