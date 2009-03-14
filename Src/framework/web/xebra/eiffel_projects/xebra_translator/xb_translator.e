note
	description: "[
			Reads a xebra scriptlet file and generates an eiffel class.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XB_TRANSLATOR

inherit
	ERROR_SHARED_ERROR_MANAGER

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING)
			-- Initialization for `XB_TRANSLATOR'.
		do
			create preprocessor.make
				-- Create a default output_path
			output_path := "code_gen/generated/"
			name := a_name
		end

feature {NONE} -- Access

	preprocessor: XB_PREPROCESSOR
			-- Used to parse the file

feature -- Access

	output_path: STRING assign set_output_path
			-- Defines where the files should be written		

	name: STRING assign set_name
			-- Name of the system

feature -- Status setting

	set_output_path (a_path: like output_path)
			-- Sets the output_path
		do
			output_path := a_path
		end

	set_name (a_name: like name)
			-- Sets the name
		do
			name := a_name
		end

feature -- Processing

	process_with_file (a_filename: STRING)
			-- Processes a file.
		local
			l_file: KL_TEXT_INPUT_FILE
			l_failed: BOOLEAN
		do
			if l_failed then
				error_manager.set_last_error (create {ERROR_FILENOTFOUND}.make ([a_filename]), false)
			else
				create l_file.make (a_filename)
				if not l_file.exists then
					error_manager.set_last_error (create {ERROR_FILENOTFOUND}.make ([a_filename]), false)
				else
					l_file.open_read
					if not l_file.is_open_read then
						error_manager.set_last_error (create {ERROR_FILENOTFOUND}.make ([a_filename]), false)
					else
							process_with_stream (l_file)

							l_file.close
					end
				end
			end
			rescue
				l_failed := true
				retry
		end

	process_with_stream (a_stream: KI_CHARACTER_INPUT_STREAM)
			-- Processes a file.
		local
			l_webapp_generator: WEBAPP_GENERATOR
			l_root_tag: XB_TAG
			l_parser: XM_PARSER
			l_p_callback: XB_XML_PARSER_CALLBACKS
		do
				create l_webapp_generator.make (name, output_path)

				create {XM_EIFFEL_PARSER} l_parser.make
				create {XB_XML_PARSER_CALLBACKS} l_p_callback.make
				l_parser.set_callbacks (l_p_callback)
				l_parser.parse_from_stream (a_stream)

				l_root_tag := l_p_callback.root_tag
				print ("done")
			--	create l_root_element.make_with_elements (name, name + "_controller", True, l_p_callback.elements_inverted) -- calculate last argument (stateful)
			--	l_webapp_generator.put_servlet (l_root_element)
			--	l_webapp_generator.generate

		end

	old_process_with_file (a_filename: STRING)
			-- Processes a file.
		do
			old_process_with_string (read_file(a_filename))
		end

	old_process_with_string (a_string: STRING)
			-- Processes a string.
		local
			webapp_generator: WEBAPP_GENERATOR
			root_element: ROOT_SERVLET_ELEMENT
			output_elements: LIST[OUTPUT_ELEMENT]
		do
				create webapp_generator.make (name, output_path)
				output_elements := preprocessor.parse_string (a_string)
				create root_element.make_with_elements (name, name + "_controller", True, output_elements) -- calculate last argument (stateful)
				webapp_generator.put_servlet (root_element)
				webapp_generator.generate
		end

feature {NONE} -- Implementation


	read_file (a_filename: STRING): STRING
			--reads a file into a string			
		local
			l_file: PLAIN_TEXT_FILE
			l_failed: BOOLEAN
		do
			Result := ""
			if l_failed then
				error_manager.set_last_error (create {ERROR_FILENOTFOUND}.make ([a_filename]), false)
			else
				create l_file.make (a_filename)
				if not l_file.exists then
					error_manager.set_last_error (create {ERROR_FILENOTFOUND}.make ([a_filename]), false)
				else
					l_file.open_read
					if not l_file.is_open_read then
						error_manager.set_last_error (create {ERROR_FILENOTFOUND}.make ([a_filename]), false)
					else
						from until l_file.end_of_file
						loop
							l_file.read_line

							if attached {STRING} l_file.last_string as s then
								Result.append(s)
							else
								Result.append ("")
							end
						end
						l_file.close
					end
				end
			end
			rescue
				l_failed := true
				retry
		end



note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
