note
	description: "[
			Tool to create an ecf redirection
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

	EIFFEL_LAYOUT

	LOCALIZED_PRINTER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			l_target, l_redirection_ecf: detachable READABLE_STRING_32
			n,i: INTEGER
			op: detachable READABLE_STRING_32
			env: EC_EIFFEL_LAYOUT
			v: READABLE_STRING_32
		do
			create env
			env.check_environment_variable
			set_eiffel_layout (env)

			is_verbose := False

			n := argument_count
			if n = 0 then
				op := {STRING_32} "help"
			else
				from
					i := 1
				until
					i > n
				loop
					v := argument (i)
					if v.starts_with_general ("-") then
						if v.is_case_insensitive_equal_general ("-v") or v.is_case_insensitive_equal_general ("--verbose") then
							is_verbose := True
						elseif v.is_case_insensitive_equal_general ("-q") or v.is_case_insensitive_equal_general ("--quiet") then
							is_verbose := False
						elseif v.is_case_insensitive_equal_general ("-f") or v.is_case_insensitive_equal_general ("--force") then
							has_flag_force := True
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
						else
							localized_print_error ({STRING_32} "Unsupported operation: " + op + {STRING_32} " -> ERROR!%N")
							execute_help (op)
						end
					end
					i := i + 1
				end
			end
			if l_redirection_ecf /= Void and then l_redirection_ecf.is_empty then
				l_redirection_ecf := Void
			end
			if l_target /= Void and then l_target.is_empty then
				l_target := Void
			end

			if op = Void then
				localized_print_error ({STRING_32} "Missing operation!%N")
				execute_help (Void)
			elseif op.is_case_insensitive_equal_general ("create") then
				if
					l_target /= Void and l_redirection_ecf /= Void
				then
					set_redirection (l_target, l_redirection_ecf, has_flag_force)
				else
					localized_print_error ({STRING_32} "Missing or invalid parameters for operation: " + op + {STRING_32} " -> ERROR!%N")
					execute_help (op)
				end
			elseif op.is_case_insensitive_equal_general ("delete") then
				if (l_redirection_ecf /= Void and then not l_redirection_ecf.is_empty) then
					unset_redirection (l_redirection_ecf)
				else
					localized_print_error ({STRING_32} "Missing or invalid parameters for operation: " + op + {STRING_32} " -> ERROR!%N")
					execute_help (op)
				end
			elseif op.is_case_insensitive_equal_general ("check") then
				if (l_redirection_ecf /= Void and then not l_redirection_ecf.is_empty) then
					check_redirection (l_target, l_redirection_ecf)
				else
					localized_print_error ({STRING_32} "Missing or invalid parameters for operation: " + op + {STRING_32} " -> ERROR!%N")
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

feature -- Change

	execute_help (op: detachable READABLE_STRING_32)
		do
			if op = Void or else op.is_case_insensitive_equal_general ("help") then
				localized_print ("usage: ecf_redirection <subcommand> [options] [args]%N")
				localized_print ("Type 'ecf_redirection help <subcommand> for help on a specific subcommand.%N")
				localized_print ("Available subcommands:%N")
				localized_print ("   help%N")
				localized_print ("   create <redirection_ecf> <target_ecf>%N")
				localized_print ("   delete <redirection_ecf>%N")
				localized_print ("   check  <redirection_ecf> {target_ecf}%N")
			elseif op.is_case_insensitive_equal_general ("create") then
				localized_print ("usage: ecf_redirection create [options] <redirection_ecf> <target_ecf>%N")
				localized_print ("   <redirection_ecf> : redirection ecf file%N")
				localized_print ("   <target_ecf>      : target ecf file%N")
				localized_print ("Create a redirection from <redirection_ecf> to <target_ecf>.%N")
				localized_print ("%NOptions:%N")
				localized_print ("   -f|--force: force operation%N")
			elseif op.is_case_insensitive_equal_general ("delete") then
				localized_print ("usage: ecf_redirection delete [options] <redirection_ecf>%N")
				localized_print ("   <redirection_ecf> : redirection ecf file%N")
				localized_print ("Delete redirection <redirection_ecf>.%N")
			elseif op.is_case_insensitive_equal_general ("check") then
				localized_print ("usage: ecf_redirection check [options] <redirection_ecf> {target_ecf}%N")
				localized_print ("   <redirection_ecf> : redirection ecf file%N")
				localized_print ("   {target_ecf}      : optional target ecf file%N")
				localized_print ("Check redirection <redirection_ecf>.%N")
			end
			localized_print ("%NGlobal options:%N")
			localized_print ("   -v|--verbose: verbose output%N")

			localized_print ("%N")
			(create {EXCEPTIONS}).die (-1)
		end

	set_redirection (a_target_ecf: READABLE_STRING_32; a_redirection: READABLE_STRING_32; a_update: BOOLEAN)
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
						localized_print_error ("Redirection already exists!%N")
						localized_print_error ("To update it, please use flag [--force].%N")
					else
						localized_print_error ("Redirection already exists but is not valid!%N")
						localized_print_error ("To update it, please delete it first.%N")
					end
				end
			else
				l_continue := True
			end

			if l_continue then
				l_location := a_target_ecf
				has_error := False
				if a_target_ecf /= Void then
--					l_target := evaluated_location (a_target_ecf)
					conf_loader.retrieve_configuration (evaluated_location (a_target_ecf))
					if conf_loader.is_error then
						io.error.put_string ({STRING_32} "Unable to get data from target <" + a_target_ecf + ">.%N")
						l_location := a_target_ecf
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
--							l_location := l_redir.file_name
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
--							l_location := l_system.file_name
						else
							has_error := True
						end
					end
				else
					io.error.put_string ({STRING_32} "Missing redirection location.%N")
					has_error := True
				end

				if not has_error then
					if l_location /= Void then
						redir := conf_factory.new_redirection (l_location, l_uuid)
						redir.set_file_name (a_redirection)
						if not file_utilities.file_exists (a_redirection) or else a_update then
							if redir.is_storable then
								redir.store
								has_error := not redir.store_successful
								if has_error then
									print ("Redirection creation: failed!%N")
								else
									print ("Redirection created: ")
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
							print ("Redirection already exists!%N")
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
				print ("Redirection deleted: OK!%N")
			else
				print ("This is not a redirection: file not deleted!%N")
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
					localized_print_error ({STRING_32} "File `" + a_redirection + "' is NOT a valid redirection.%N")
					has_error := True
				end
			else
				localized_print_error ({STRING_32} "File `" + a_redirection + "' is NOT a redirection.%N")
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
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
