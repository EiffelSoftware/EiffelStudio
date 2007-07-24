indexing
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

	make is
			-- Creation
		local
			l_parser: ARGUMENT_PARSER
			l_layout: FINISH_FREEZING_EIFFEL_LAYOUT
		do
			create l_layout
			l_layout.check_environment_variable
			set_eiffel_layout (l_layout)
			create l_parser.make (False, False)
			l_parser.execute (agent start (l_parser))
		end

	start (a_parser: ARGUMENT_PARSER) is
		require
			a_parser_attached: a_parser /= Void
		local
			retried: BOOLEAN -- did an error occur?
			c_error: BOOLEAN -- did an error occur during C compilation?
			l_msg, make_util: STRING -- the C make utility for this platform
			status_box: STATUS_BOX -- the status box displayed at the end of execution
			location: STRING
			location_index: INTEGER
			unc_mapper: UNC_PATH_MAPPER
			mapped_path: BOOLEAN
			l_exception: EXCEPTIONS
			l_processors: NATURAL_8
			gen_only: BOOLEAN
			l_library_cmd: STRING
			l_c_setup: COMPILER_SETUP
		do
			if not retried then
					-- if location has been specified, update it
				if a_parser.has_location then
					location := a_parser.location
				else
						-- Location defaults to the current directory
					location := current_working_directory
				end

					-- if generate_only is specified then only generate makefile
				gen_only := a_parser.generate_only

					-- Map `location' if it is a network path if needed
				if location.substring (1, 2).is_equal ("\\") then
					create unc_mapper.make (location)
					if unc_mapper.access_name /= Void then
						mapped_path := True
						location := unc_mapper.access_name + "\"
					end
				end

					-- Change the working directory if needed
				if not location.is_equal (current_working_directory) then
					change_working_directory (location)
				end

				if a_parser.has_max_processors then
					l_processors := a_parser.max_processors
				else
						-- Use default
					l_processors := 0
				end

				if a_parser.is_for_library then
					create l_c_setup.initialize (create {RESOURCE_TABLE}.make (20), a_parser.force_32bit_code_generation)
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
					create translator.make (mapped_path, a_parser.force_32bit_code_generation, l_processors)

					translator.translate
					if not gen_only and translator.has_makefile_sh then
							-- We don't want to be launched when there is no Makefile.SH file.
						translator.run_make
						c_error := c_compilation_error
					end

					if not gen_only then
						if translator = Void then
							l_msg := "Internal error during Makefile translation preparation.%N%N%
									%Please report this problem to Eiffel Software at:%N%
									%http://support.eiffel.com"
							io.put_string (l_msg)
							io.default_output.flush
						else
							if translator.has_makefile_sh then
								if not c_error then
										-- For eweasel processing
									io.put_string ("C compilation completed%N")
								end
								io.default_output.flush
							elseif translator.is_il_code and not c_error then
									-- For eweasel processing
								io.put_string ("C compilation completed%N")
								io.default_output.flush
							end
						end
					end
				end

					-- Destroy network path mapping if any
				if unc_mapper /= Void then
					unc_mapper.destroy
					unc_mapper := Void
				end
			end

			if retried or else (c_error and not gen_only) then
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

	translator: MAKEFILE_TRANSLATOR
			-- used to translate Makefile.SH into Makefile

	env: EXECUTION_ENVIRONMENT is
		once
			create Result
		end

	c_compilation_error: BOOLEAN is
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

feature -- Externals

	is_windows_x64: BOOLEAN is
			-- Is Current running on Windows 64 bits?
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"EIF_IS_64_BITS"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class FINISH_FREEZING
