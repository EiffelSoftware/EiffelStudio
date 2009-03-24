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
		--	create preprocessor.make
				-- Create a default output_path
			output_path := "generated/" + a_name + "/"
			name := a_name
		end

feature {NONE} -- Access

--	preprocessor: XB_PREPROCESSOR
			-- Used to parse the file

feature -- Access

	output_path: STRING assign set_output_path
			-- Defines where the files should be written		

	name: STRING assign set_name
			-- Name of the system

	taglib: TAG_LIBRARY

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

	process_with_file (a_files: LIST [STRING]; a_taglib_filename: STRING)
			-- `a_filename': Name of xeb file
			-- `taglib_filename': Name of tag library file
			-- Processes a file.
		local
			l_file: KL_TEXT_INPUT_FILE
			l_taglib_file: KL_TEXT_INPUT_FILE
			l_wgenerator: WEBAPP_GENERATOR
		do

			create l_taglib_file.make (a_taglib_filename)
			if (not l_taglib_file.exists) then
				error_manager.set_last_error (create {ERROR_FILENOTFOUND}.make ([a_taglib_filename]), false)
			else
				l_taglib_file.open_read
				if not l_taglib_file.is_open_read then
					error_manager.set_last_error (create {ERROR_FILENOTFOUND}.make (["cannot read file " + a_taglib_filename ]), false)
				else
					process_taglib_with_stream (l_taglib_file)
					l_taglib_file.close

					create l_wgenerator.make (name, output_path)

					from
						a_files.start
					until
						a_files.after
					loop
						if a_files.item.ends_with (".xeb") then
							create l_file.make (output_path + a_files.item.twin)
							l_file.open_read
							if not l_file.is_open_read then
								error_manager.set_last_error (create {ERROR_FILENOTFOUND}.make (["cannot read file " + l_file.name]), false)
							else
								l_wgenerator.put_servlet (process_with_stream (a_files.item.substring (1, a_files.item.index_of ('.', 1)-1), l_file, taglib))
								l_file.close
							end
						end
						a_files.forth
					end

					l_wgenerator.generate
				end
			end

		end

	process_taglib_with_stream (a_stream: KI_CHARACTER_INPUT_STREAM)
		local
			l_parser: XM_PARSER
			l_p_callback: XB_TAGLIB_PARSER_CALLBACKS
		do
			create {XM_EIFFEL_PARSER} l_parser.make
			create l_p_callback.make
			l_parser.set_callbacks (l_p_callback)
			l_parser.parse_from_stream (a_stream)

			taglib := l_p_callback.taglib

		end

	process_with_stream (servlet_name: STRING; a_stream: KI_CHARACTER_INPUT_STREAM; a_taglib: TAG_LIBRARY): ROOT_SERVLET_ELEMENT
			-- Processes a file.
		local
			l_webapp_generator: WEBAPP_GENERATOR
			l_root_tag: TAG_ELEMENT
			l_parser: XM_PARSER
			l_p_callback: XB_XML_PARSER_CALLBACKS
			root_servlet_element: ROOT_SERVLET_ELEMENT
		do
				create l_webapp_generator.make (name, output_path)

				create {XM_EIFFEL_PARSER} l_parser.make
				create {XB_XML_PARSER_CALLBACKS} l_p_callback.make
				l_p_callback.put_taglib (a_taglib)
				l_parser.set_callbacks (l_p_callback)
				l_parser.parse_from_stream (a_stream)

				l_root_tag := l_p_callback.root_tag
				create root_servlet_element.make (servlet_name, name + "_CONTROLLER", False, l_root_tag)
				root_servlet_element.set_tag (l_root_tag)
				root_servlet_element.set_controller_calls (l_p_callback.controller_calls)
				Result := root_servlet_element
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
