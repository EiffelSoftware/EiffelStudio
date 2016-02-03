note
	description: "[
				Ecf redirection builder
			]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_REDIRECTION_BUILDER

inherit

	EIFFEL_LAYOUT

	LOCALIZED_PRINTER

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (args_src: ARGUMENT_SOURCE; a_command_name: READABLE_STRING_8)
			-- Initialize `Current'.
		local
			l_target, l_redirection_ecf: detachable READABLE_STRING_32
			l_target_folder, l_redirection_folder: detachable READABLE_STRING_32
			has_cleanup: BOOLEAN
			n: INTEGER
			op: detachable READABLE_STRING_32
			env: EC_EIFFEL_LAYOUT
			v: READABLE_STRING_32
			args: LIST [READABLE_STRING_32]
			help_requested: BOOLEAN
		do
			if attached args_src.application.entry as e then
				redirection_command_name := e.utf_8_name + " " + a_command_name
			else
				redirection_command_name := "ecf_tool " + a_command_name
			end

			create env
			env.check_environment_variable
			set_eiffel_layout (env)

			is_verbose := False

			args := args_src.arguments
			n := args.count
			if n = 0 then
				op := {STRING_32} "help"
			else
				from
					args.start
				until
					args.after
				loop
					v := args.item
					if v.starts_with_general ("-") then
						if v.is_case_insensitive_equal_general ("-v") or v.is_case_insensitive_equal_general ("--verbose") then
							is_verbose := True
						elseif v.is_case_insensitive_equal_general ("-q") or v.is_case_insensitive_equal_general ("--quiet") then
							is_verbose := False
						elseif v.is_case_insensitive_equal_general ("-f") or v.is_case_insensitive_equal_general ("--force") then
							has_flag_force := True
						elseif v.is_case_insensitive_equal_general ("--cleanup") then
							has_cleanup := True
						elseif v.is_case_insensitive_equal_general ("-h") or v.is_case_insensitive_equal_general ("--help") then
							help_requested := True
						else
							localized_print_error ({STRING_32} "Unknown flag: " + v + {STRING_32} " -> ignored!%N")
						end
					else
						if op = Void then
							op := v
						elseif op.is_case_insensitive_equal_general ("create") or op.is_case_insensitive_equal_general ("update") then
							if l_redirection_ecf = Void then
								l_redirection_ecf := v
							elseif l_target = Void then
								l_target := v
							else
								localized_print_error ({STRING_32} "[" + op + "] Too many parameters : " + v + {STRING_32} " -> ERROR!%N")
								execute_help (op)
							end
						elseif op.is_case_insensitive_equal_general ("shadow") or op.is_case_insensitive_equal_general ("unshadow") then
							if l_redirection_folder = Void then
								l_redirection_folder := v
							elseif l_target_folder = Void then
								l_target_folder := v
							else
								localized_print_error ({STRING_32} "[" + op + "] Too many parameters : " + v + {STRING_32} " -> ERROR!%N")
								execute_help (op)
							end
						elseif
							op.is_case_insensitive_equal_general ("delete") or
							op.is_case_insensitive_equal_general ("check")
						then
							if l_redirection_ecf = Void then
								l_redirection_ecf := v
							elseif l_target = Void then
								l_target := v
							else
								localized_print_error ({STRING_32} "[" + op + "] Too many parameters : " + v + {STRING_32} " -> ERROR!%N")
								execute_help (op)
							end
						elseif op.is_case_insensitive_equal_general ("help") then
							execute_help (v)
						else
							localized_print_error ({STRING_32} "Unsupported operation: " + op + {STRING_32} " -> ERROR!%N")
							execute_help (op)
						end
					end
					args.forth
				end
			end

			if help_requested then
				execute_help (Void)
			elseif
				op /= Void and then
				(op.is_case_insensitive_equal_general ("shadow") or op.is_case_insensitive_equal_general ("unshadow"))
			then
				if l_redirection_folder /= Void and then l_redirection_folder.is_empty then
					l_redirection_folder := Void
				end
				if l_target_folder /= Void and then l_target_folder.is_empty then
					l_target_folder := Void
				end
			else
				if l_redirection_ecf /= Void and then l_redirection_ecf.is_empty then
					l_redirection_ecf := Void
				end
				if l_target /= Void and then l_target.is_empty then
					l_target := Void
				end
			end

			if op = Void then
				localized_print_error ({STRING_32} "Missing operation!%N")
				execute_help (Void)
			elseif op.is_case_insensitive_equal_general ("shadow") then
				if
					l_target_folder /= Void and l_redirection_folder /= Void
				then
					shadow_redirection (l_target_folder, l_redirection_folder, has_flag_force)
				else
					localized_print_error ({STRING_32} "Missing or invalid parameter for operation: " + op + {STRING_32} " -> ERROR!%N")
					execute_help (op)
				end
			elseif op.is_case_insensitive_equal_general ("unshadow") then
				if
					l_target_folder /= Void and l_redirection_folder /= Void
				then
					unshadow_redirection (l_target_folder, l_redirection_folder, has_flag_force, has_cleanup)
				else
					localized_print_error ({STRING_32} "Missing or invalid parameter for operation: " + op + {STRING_32} " -> ERROR!%N")
					execute_help (op)
				end
			elseif op.is_case_insensitive_equal_general ("create") then
				if
					l_target /= Void and l_redirection_ecf /= Void
				then
					set_redirection (l_target, l_redirection_ecf, Void, has_flag_force)
				else
					localized_print_error ({STRING_32} "Missing or invalid parameter for operation: " + op + {STRING_32} " -> ERROR!%N")
					execute_help (op)
				end
			elseif op.is_case_insensitive_equal_general ("delete") then
				if (l_redirection_ecf /= Void and then not l_redirection_ecf.is_empty) then
					unset_redirection (l_redirection_ecf)
				else
					localized_print_error ({STRING_32} "Missing or invalid parameter for operation: " + op + {STRING_32} " -> ERROR!%N")
					execute_help (op)
				end
			elseif op.is_case_insensitive_equal_general ("check") then
				if (l_redirection_ecf /= Void and then not l_redirection_ecf.is_empty) then
					check_redirection (l_target, l_redirection_ecf)
				else
					localized_print_error ({STRING_32} "Missing or invalid parameter for operation: " + op + {STRING_32} " -> ERROR!%N")
					execute_help (op)
				end
			else
				execute_help (op)
			end
			if has_error then
				(create {EXCEPTIONS}).die (-1)
			else
				(create {EXCEPTIONS}).die (0)
			end
		end

feature -- Status

	is_verbose: BOOLEAN

	has_flag_force: BOOLEAN

	has_error: BOOLEAN

feature -- Access

	conf_loader: CONF_LOAD
		once
			create Result.make (conf_factory)
		end

	conf_factory: CONF_PARSE_FACTORY
		once
			create Result
		end

	redirection_command_name: STRING
			-- Redirection command name.

feature -- Change

	execute_help (op: detachable READABLE_STRING_32)
		local
			l_redirection_command: STRING
		do
			l_redirection_command := redirection_command_name
			if
				op = Void
				or else op.is_case_insensitive_equal_general ("help")
			then
				localized_print ("usage: " + l_redirection_command + " <subcommand> [options] [args]%N")
				localized_print ("Type '" + l_redirection_command + " help <subcommand> for help on a specific subcommand.%N")
				localized_print ("Available subcommands:%N")
				localized_print ("   help%N")
				localized_print ("   create <redirection_ecf> <target_ecf>%N")
				localized_print ("   delete <redirection_ecf>%N")
				localized_print ("   check  <redirection_ecf> {target_ecf}%N")
				localized_print ("   shadow/unshadow  <redirection_ecf> {target_ecf}%N")
			elseif op.is_case_insensitive_equal_general ("create") then
				localized_print ("usage: " + l_redirection_command + " create [options] <redirection_ecf> <target_ecf>%N")
				localized_print ("   <redirection_ecf> : redirection ecf file%N")
				localized_print ("   <target_ecf>      : target ecf file%N")
				localized_print ("Create a redirection from <redirection_ecf> to <target_ecf>.%N")
				localized_print ("%NOptions:%N")
				localized_print ("   -f|--force: force operation%N")
			elseif op.is_case_insensitive_equal_general ("delete") then
				localized_print ("usage: " + l_redirection_command + " delete [options] <redirection_ecf>%N")
				localized_print ("   <redirection_ecf> : redirection ecf file%N")
				localized_print ("Delete redirection <redirection_ecf>.%N")
			elseif op.is_case_insensitive_equal_general ("check") then
				localized_print ("usage: " + l_redirection_command + " check [options] <redirection_ecf> {target_ecf}%N")
				localized_print ("   <redirection_ecf> : redirection ecf file%N")
				localized_print ("   {target_ecf}      : optional target ecf file%N")
				localized_print ("Check redirection <redirection_ecf>.%N")
			elseif op.is_case_insensitive_equal_general ("shadow") then
				localized_print ("usage: " + l_redirection_command + " shadow [options] <redirection_folder> <target_folder>%N")
				localized_print ("   <redirection_folder> : redirection folder%N")
				localized_print ("   <target_folder>      : target folder%N")
				localized_print ("Recursively create redirection from ecf file under <redirection_folder> to <target_folder>.%N")
				localized_print ("%NOptions:%N")
				localized_print ("   -f|--force: force operation%N")
			elseif op.is_case_insensitive_equal_general ("unshadow") then
				localized_print ("usage: " + l_redirection_command + " unshadow [options] <redirection_folder> <target_folder>%N")
				localized_print ("   <redirection_folder> : redirection folder%N")
				localized_print ("   <target_folder>      : target folder%N")
				localized_print ("Undo previous 'shadow' from <redirection_folder> to <target_folder>.%N")
				localized_print ("%NNote: only valid redirections will be unset,%N      and new empty folders will be deleted only if --cleanup is set.%N")
				localized_print ("%NOptions:%N")
				localized_print ("   -f|--force: force operation%N")
				localized_print ("   --cleanup: remove empty folder due to unshadow operation%N")
			end
			localized_print ("%NGlobal options:%N")
			localized_print ("   -v|--verbose: verbose output%N")

			localized_print ("%N")
			(create {EXCEPTIONS}).die (-1)
		end

	shadow_redirection (a_target_folder: READABLE_STRING_32; a_redirection_folder: READABLE_STRING_32; a_update: BOOLEAN)
			-- For each ecf file in `a_target_folder' create a redirection to the expected location in `a_redirection_folder'.
		require
			no_error: not has_error
			valid_redirection: not a_redirection_folder.is_empty
			valid_target_ecf: not a_target_folder.is_empty
		local
			d: DIRECTORY
			v: ECF_FINDER
			dn: READABLE_STRING_32
			s: STRING_32
			p,pn: PATH
		do
			create d.make_with_name (evaluated_location (a_target_folder))
			if d.exists then
				create v.make
				dn := d.path.canonical_path.name
				v.process_directory (d.path.canonical_path)
				if v.ecfs.is_empty then
					localized_print_error ({STRING_32} "[ERROR] Directory %"" + d.path.name + {STRING_32} "%" does not contain any ecf files!%N")
				else
					across
						v.ecfs as ic
					loop
						if ic.item.name.has_substring (dn) then
							create s.make_from_string (ic.item.name)
							s.remove_head (dn.count + 1)
							create p.make_from_string (a_redirection_folder)
							p := p.extended (s)
							create pn.make_from_string (a_target_folder)
							pn := pn.extended (s)
							file_utilities.create_directory_path (p.parent)
							set_redirection (ic.item.name, p.name, pn.name, a_update)
						end
					end
				end
			else
				localized_print_error ({STRING_32} "[ERROR] Directory %"" + d.path.name + {STRING_32} "%" does not exist!%N")
			end
		end

	unshadow_redirection (a_target_folder: READABLE_STRING_32; a_redirection_folder: READABLE_STRING_32; a_update: BOOLEAN; has_cleanup: BOOLEAN)
			-- For each ecf file in `a_redirection_folder' being a redirection to the expected location from `a_target_folder'
			-- unset associated redirection.
			-- If `has_cleanup' is True, empty folders will be removed.
		require
			no_error: not has_error
			valid_redirection: not a_redirection_folder.is_empty
			valid_target_ecf: not a_target_folder.is_empty
		local
			d: DIRECTORY
			v: ECF_FINDER
			dn: READABLE_STRING_32
			s: STRING_32
			p: detachable PATH
		do
			create d.make_with_name (a_redirection_folder)
			if d.exists then
				create v.make
				dn := d.path.canonical_path.name
				v.process_directory (d.path.canonical_path)
				if v.ecfs.is_empty then
					localized_print_error ({STRING_32} "[WARNING] Directory %"" + d.path.name + {STRING_32} "%" does not contain any ecf files!%N")
				else
					across
						v.ecfs as ic
					loop
						if ic.item.name.has_substring (dn) then
							create s.make_from_string (ic.item.name)
							s.remove_head (dn.count + 1)
							create p.make_from_string (a_target_folder)
							p := p.extended (s)
							if is_valid_redirection (p.name, ic.item.name) then
								unset_redirection (ic.item.name)
								if has_cleanup then
									from
										p := ic.item.parent
									until
										p = Void
									loop
										create d.make_with_path (p)
										if d.exists and then d.is_empty then
											localized_print ({STRING_32} "[INFO] Cleaning/deleting empty folder %"" + d.path.name + {STRING_32} "%"%N")
											d.recursive_delete
											p := p.parent
											if not p.name.has_substring (a_redirection_folder) then
												p := Void
											end
										else
											p := Void
										end
									end
								end
							end
						end
					end
				end
			else
				localized_print_error ({STRING_32} "[ERROR] Directory %"" + d.path.name + {STRING_32} "%" does not exist!%N")
			end
		end

	set_redirection (a_target_ecf: READABLE_STRING_32; a_redirection: READABLE_STRING_32; a_target_location_text: detachable READABLE_STRING_32; a_update: BOOLEAN)
			-- Create redirection from `a_redirection' to `a_target'
			-- if precised use `a_redirection_location' text in redirection location value.
			-- if `a_redirection' already exists, update only if `a_update' is True.
		require
			no_error: not has_error
			valid_redirection: not a_redirection.is_empty
			valid_target_ecf: not a_target_ecf.is_empty
		local
			redir: CONF_REDIRECTION
			l_uuid: detachable UUID
			l_location: detachable READABLE_STRING_GENERAL
			l_continue: BOOLEAN
		do
			if is_redirection (a_redirection) then
				if a_update then
					l_continue := True
				else
					if is_valid_redirection (a_target_ecf, a_redirection) then
						localized_print_error ("[WARNING] Redirection already exists!%N")
						localized_print_error ("To update it, please use flag [--force].%N")
					else
						localized_print_error ("[ERROR] Redirection already exists but is not valid!%N")
						localized_print_error ("To update it, please delete it first or use flag [--force].%N")
						has_error := True
					end
				end
			else
				l_continue := True
			end

			if l_continue then
				has_error := False
				if a_target_ecf /= Void then
--					l_target := evaluated_location (a_target_ecf)
					conf_loader.retrieve_configuration (evaluated_location (a_target_ecf))
					if conf_loader.is_error then
						io.error.put_string ({STRING_32} "[WARNING] Unable to get data from target <" + a_target_ecf + ">.%N")
					else
						if attached conf_loader.last_redirection as l_redir then
							if is_verbose then
								print ("= Redirection =%N")
								print (create {STRING}.make_filled ('-', 60))
								print ("%N")
								print (l_redir.text)
								print ("%N")
								print (create {STRING}.make_filled ('-', 60))
								print ("%N")
							end
							l_uuid := l_redir.uuid
						elseif attached conf_loader.last_system as l_system then
							if is_verbose then
								print ("= System =%N")
								print (create {STRING}.make_filled ('-', 60))
								print ("%N")
								print (l_system.text)
								print ("%N")
								print (create {STRING}.make_filled ('-', 60))
								print ("%N")
							end
							l_uuid := l_system.uuid
						else
							has_error := True
						end
					end
				else
					io.error.put_string ({STRING_32} "[ERROR] Missing redirection location.%N")
					has_error := True
				end

				if not has_error then
					l_location := a_target_ecf
					if a_target_location_text /= Void then
						l_location := a_target_location_text
					end

					if l_location /= Void then
						redir := conf_factory.new_redirection_with_file_name (a_redirection, l_location, l_uuid)
						if not file_utilities.file_exists (a_redirection) or else a_update then
							if redir.is_storable then
								redir.store
								has_error := not redir.store_successful
								if has_error then
									localized_print_error ("[ERROR] Redirection creation: failed!%N")
								else
									print ("[OK] Redirection created: ")
									localized_print (a_redirection)
									print (" -> ")
									if a_target_ecf.same_string_general (l_location) then
										localized_print (l_location)
									else
										localized_print (a_target_ecf)
										localized_print (" = ")
										localized_print (l_location)
									end
									print ("%N")
								end
							end
						else
							print ("[WARNING] Redirection already exists!%N")
							print ("Use flag [--force] to force the update!%N")
							has_error := True
						end
					end
				end
			end
		ensure
			not has_error implies is_valid_redirection (a_target_ecf, a_redirection)
		end

	unset_redirection (a_redirection: READABLE_STRING_32)
			-- Unset redirection `a_redirection' if this is really a redirection
		require
			no_error: not has_error
		local
			f: RAW_FILE
		do
			conf_loader.retrieve_configuration (a_redirection)
			if attached conf_loader.last_redirection as l_redir then
				create f.make_with_name (a_redirection)
				f.delete
				localized_print ({STRING_32} "[OK] Redirection %"" + a_redirection + {STRING_32} "%" deleted!%N")
			else
				localized_print_error ({STRING_32} "[ERROR] File %"" + a_redirection + {STRING_32} "%" is not a redirection: file not deleted!%N")
				has_error := True
			end
		end

	check_redirection (a_target_ecf: detachable READABLE_STRING_32; a_redirection: READABLE_STRING_32)
		require
			no_error: not has_error
		do
			if attached conf_redirection (a_redirection) as l_redir then
				if attached conf_system (a_redirection) as l_redirection_ecf_system then
					localized_print_error ({STRING_32} "File `" + a_redirection + "' is a redirection%N")
					localized_print_error ({STRING_32} "  from `" + a_redirection + "'%N")
					if attached l_redirection_ecf_system.file_name as fn then
						localized_print_error ({STRING_32} "  to  `" + fn + "'%N")
					end
					if a_target_ecf /= Void then
						if attached conf_system (evaluated_location (a_target_ecf)) as l_target_ecf_system then
							if same_strings (l_target_ecf_system.file_name, l_redirection_ecf_system.file_name) then
								localized_print_error ({STRING_32} "File `" + a_redirection + "' is a valid redirection.%N")
							else
								localized_print_error ({STRING_32} "  but does not point to same system as `" + a_target_ecf + "'%N")
							end
						end
					end
				else
					localized_print_error ({STRING_32} "[ERROR] File `" + a_redirection + "' is NOT a valid redirection.%N")
					has_error := True
				end
			else
				localized_print_error ({STRING_32} "[ERROR] File `" + a_redirection + "' is NOT a redirection.%N")
				has_error := True
			end
		end

	is_valid_redirection (a_target_ecf: detachable READABLE_STRING_32; a_redirection: READABLE_STRING_32): BOOLEAN
		require
			no_error: not has_error
		do
			if attached conf_redirection (a_redirection) as l_redir then
				if attached conf_system (a_redirection) as l_redirection_ecf_system then
					if a_target_ecf = Void then
						Result := True
					else
						if attached conf_system (evaluated_location (a_target_ecf)) as l_target_system then
							Result := same_strings (l_redirection_ecf_system.file_name , l_target_system.file_name)
						else
							Result := False
						end
					end
				else
					Result := False
				end
			end
		end

	is_redirection (fn: READABLE_STRING_32): BOOLEAN
		require
			no_error: not has_error
		do
			Result := conf_redirection (fn) /= Void
			has_error := False
		ensure
			no_error: not has_error
		end

feature -- Change

feature {NONE} -- Implementation

	evaluated_location (p: READABLE_STRING_32): READABLE_STRING_32
		local
			exp: STRING_ENVIRONMENT_EXPANDER
		do
			if p.has ('$') then
				create exp
				Result := exp.expand_string_32 (p, True)
			else
				Result := p
			end
		end

	same_strings (s1,s2: detachable READABLE_STRING_GENERAL): BOOLEAN
		do
			if s1 = Void then
				Result := s2 = Void
			elseif s2 = Void then
				Result := False
			else
				Result := s1.same_string (s2)
			end
		end

	file_utilities: FILE_UTILITIES
		once
			create Result
		end

	conf_system (fn: READABLE_STRING_32): detachable CONF_SYSTEM
		do
			conf_loader.retrieve_configuration (fn)
			if not conf_loader.is_error then
				Result := conf_loader.last_system
			end
		end

	conf_redirection (fn: READABLE_STRING_32): detachable CONF_REDIRECTION
		do
			conf_loader.retrieve_configuration (fn)
			Result := conf_loader.last_redirection
			has_error := conf_loader.is_error
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
