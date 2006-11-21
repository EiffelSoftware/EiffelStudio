indexing
	description: "[
		Used to do actual class file generation and persist files to disk.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	FILE_GENERATOR_ENGINE

feature -- Generation

	generate_files (a_opts: APPLICATION_OPTIONS) is
			-- Generates files for options `a_opts'.
		require
			a_opts_attached: a_opts /= Void
		do
			if a_opts.generate_interface then
				generate_file (a_opts, False)
			end
			if a_opts.generate_stub then
				generate_file (a_opts, True)
			end
		end

	generate_file (a_opts: APPLICATION_OPTIONS; a_stub: BOOLEAN) is
			-- Generates a single file for options `a_opts'. The type of file generated is dictated by `a_stub'. When False
			-- an interface is generated, True a stub class is generated for the interface.
		require
			a_opts_attached: a_opts /= Void
			a_stub_valid: (a_stub and a_opts.generate_stub) or else (not a_stub and a_opts.generate_interface)
		local
			l_generator: FULL_CLASS_GENERATOR
			l_buffer: STRING
			l_file: KL_TEXT_OUTPUT_FILE
			l_file_name: STRING
			retried: BOOLEAN
		do
			if not retried then
				create l_generator
				l_buffer := l_generator.generate (a_opts, a_stub)
				if l_buffer /= Void then
					if a_stub then
						l_file_name := a_opts.stub_output_file_name
					else
						l_file_name := a_opts.interface_output_file_name
					end
					check
						l_file_name_attached: l_file_name /= Void
					end
					create l_file.make (l_file_name)
					l_file.open_write
					l_file.put_string (l_buffer)
					l_file.flush
					l_file.close
				else
--ERROR
				end
			else
--ERROR
			end
		rescue
			retried := True
			if l_file /= Void and l_file.is_open_write then
				l_file.close
			end
			retry
		end

;indexing
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

end -- class {FILE_GENERATOR_ENGINE}
