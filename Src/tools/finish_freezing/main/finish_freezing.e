note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class FINISH_FREEZING

inherit
	EXECUTION_ENVIRONMENT
		rename
			command_line as non_used_command_line
		export
			{NONE} non_used_command_line
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make
			-- Creation
		local
			l_parser: ARGUMENT_PARSER
			l_layout: FINISH_FREEZING_EIFFEL_LAYOUT
		do
			create l_layout
			l_layout.check_environment_variable
			set_eiffel_layout (l_layout)
			create l_parser.make
			l_parser.execute (agent start (l_parser))
		end

	start (a_parser: ARGUMENT_PARSER)
		require
			a_parser_attached: a_parser /= Void
		local
			retried: BOOLEAN -- did an error occur?
			c_error: BOOLEAN -- did an error occur during C compilation?
			l_msg, make_util: STRING -- the C make utility for this platform
			l_location: STRING
			l_location_index: INTEGER
			l_unc_mapper: detachable UNC_PATH_MAPPER
			l_mapped_path: BOOLEAN
			l_exception: EXCEPTIONS
			l_processors: NATURAL_8
			l_gen_only: BOOLEAN
			l_library_cmd: STRING
			l_c_setup: COMPILER_SETUP
			l_options: RESOURCE_TABLE
			l_translator: MAKEFILE_TRANSLATOR
		do
			if not retried then
					-- if location has been specified, update it
				if a_parser.has_location then
					l_location := a_parser.location
				else
						-- Location defaults to the current directory
					l_location := current_working_directory
				end

					-- if generate_only is specified then only generate makefile
				l_gen_only := a_parser.generate_only

					-- Map `location' if it is a network path if needed
				if l_location.substring (1, 2) ~ "\\" then
					create l_unc_mapper.make (l_location)
					if attached l_unc_mapper.access_name as l_access_name then
						l_mapped_path := True
						l_location := l_access_name + "\"
					end
				end

					-- Change the working directory if needed
				if l_location /~ current_working_directory then
					change_working_directory (l_location)
				end

				if a_parser.has_max_processors then
					l_processors := a_parser.max_processors
				else
						-- Use default
					l_processors := 0
				end

				create l_options.make (20)
				read_options_in (l_options)
				if a_parser.is_for_library then
					create l_c_setup.initialize (l_options, a_parser.force_32bit_code_generation)
						-- Simply execute our batch script to compile the C code of libraries.
					create l_library_cmd.make (256)
						-- The double quote twice are there because the command is executed through COMSPEC.
					l_library_cmd.append_character ('"')
					l_library_cmd.append_character ('"')
					l_library_cmd.append (eiffel_layout.compile_library_command_name)
					l_library_cmd.append_character ('"')
					l_library_cmd.append_character ('"')
					env.system (l_library_cmd)
				else
					create l_translator.make (l_options, l_mapped_path, a_parser.force_32bit_code_generation, l_processors)

					l_translator.translate
					if not l_gen_only and l_translator.has_makefile_sh then
							-- We don't want to be launched when there is no Makefile.SH file.
						l_translator.run_make
						c_error := c_compilation_error
					end

					if not l_gen_only then
							-- Reduce execution priority
						if a_parser.use_low_priority_mode then
							demote_execution_priority
						end

						if l_translator = Void then
							l_msg := "Internal error during Makefile translation preparation.%N%N%
									%Please report this problem to Eiffel Software at:%N%
									%http://support.eiffel.com"
							io.put_string (l_msg)
							io.standard_default.flush
						else
							if l_translator.has_makefile_sh then
								if not c_error then
										-- For eweasel processing
									io.put_string ("C compilation completed%N")
								end
								io.standard_default.flush
							elseif l_translator.is_il_code and not c_error then
									-- For eweasel processing
								io.put_string ("C compilation completed%N")
								io.standard_default.flush
							end
						end
					end
				end

					-- Destroy network path mapping if any
				if l_unc_mapper /= Void then
					l_unc_mapper.destroy
				end
			end

			if retried or else (c_error and not l_gen_only) then
					-- Make the application return a non-zero value to OS to flag an error
					-- to calling process.
				create l_exception
				l_exception.die (1)
			end
		rescue
			retried := True
			retry
		end

feature -- Access

	env: EXECUTION_ENVIRONMENT
		once
			create Result
		end

	c_compilation_error: BOOLEAN
			-- check if the c-compilation went ok
		local
			completed: PLAIN_TEXT_FILE
		do
			create completed.make("completed.eif")
			if not completed.exists then
				Result := True
			else
				completed.delete
				Result := False
			end
		end

feature {NONE} -- Basic operations

	demote_execution_priority
			-- Demotes execution priority for low-execution priority, yeilding to processes
			-- with a normal or higher execution priority.
		do
			c_win_set_thread_priority (c_win_thread_priority_below_normal)
		end

feature -- Implementation

	read_options_in (a_options: RESOURCE_TABLE)
			-- read options from config.eif
		require
			a_options_not_void: a_options /= Void
		local
			reader: RESOURCE_PARSER
		do
			create reader
			if attached {FINISH_FREEZING_EIFFEL_LAYOUT} eiffel_layout as l_layout then
				reader.parse_file (l_layout.config_eif_file_name, a_options)
			else
				check not_correctly_initialized: False end
			end
		end

feature {NONE} -- Externals

	c_win_set_thread_priority (a_priority: INTEGER)
			-- Set executing thread's priority so below normal, if the priority
			-- is set above that.
		external
			"C inline use <windows.h>"
		alias
			"[
				// Set thread priority instead of process class so
				// Windows will determine the relative priority based on a user set
				// process class.
				DWORD dwThreadPri;
				dwThreadPri = GetThreadPriority(GetCurrentThread()); 
				
				if ((EIF_INTEGER) dwThreadPri >= $a_priority)
				{
					// Only set thread priority if it's not already below normal.
					SetThreadPriority(GetCurrentThread(), (DWORD)$a_priority);
				}
			]"
		end

	c_win_thread_priority_below_normal: INTEGER
		external
			"C [macro <windows.h>] : EIF_INTEGER"
		alias
			"THREAD_PRIORITY_BELOW_NORMAL"
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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

end -- class FINISH_FREEZING
