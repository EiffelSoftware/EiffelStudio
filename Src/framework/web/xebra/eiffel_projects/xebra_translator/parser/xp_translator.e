note
	description: "[
			Reads a xebra scriptlet file and generates an eiffel class.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_TRANSLATOR

inherit
	ERROR_SHARED_ERROR_MANAGER

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING)
			-- Initialization for {XP_TRANSLATOR}.
		do
			output_path := "generated/" + a_name + "/"
			name := a_name
		end

feature {NONE} -- Access

feature -- Access

	output_path: STRING assign set_output_path
			-- Defines where the files should be written

	servlet_gen_path: STRING assign set_servlet_gen_path
			-- Defines where the servlets should be generated

	name: STRING assign set_name
			-- Name of the system

	taglib: XTL_TAG_LIBRARY
			-- Taglib which should be used to validate the xeb files

feature -- Status setting

	set_output_path (a_path: like output_path)
			-- Sets the output_path
		do
			output_path := a_path
		end

	set_servlet_gen_path (a_path: like servlet_gen_path)
			-- Sets the servlet_gen_path
		do
			servlet_gen_path := a_path
		end

	set_name (a_name: like name)
			-- Sets the name
		do
			name := a_name
		end

feature -- Processing

	process_with_files (a_files: LIST [STRING]; a_taglib_filename: STRING)
			-- `a_filename': Name of xeb file
			-- `taglib_filename': Name of tag library file
			-- Processes a file.
		local
			l_file: KL_TEXT_INPUT_FILE
			l_taglib_file: KL_TEXT_INPUT_FILE
			l_servlet_gag: XGEN_SERVLET_GENERATOR_APP_GENERATOR
			l_webapp_generator: XGEN_WEBAPP_GENERATOR
		do
			create l_taglib_file.make (a_taglib_filename)
			if (not l_taglib_file.exists) then
				error_manager.set_last_error (create {XERROR_FILENOTFOUND}.make ([a_taglib_filename]), false)
			else
				l_taglib_file.open_read
				if not l_taglib_file.is_open_read then
					error_manager.set_last_error (create {XERROR_FILENOTFOUND}.make (["cannot read file " + a_taglib_filename ]), false)
				else
					process_taglib_with_stream (l_taglib_file)
					l_taglib_file.close

					create l_servlet_gag.make
					from
						a_files.start
					until
						a_files.after
					loop
						if a_files.item.ends_with (".xeb") then
							create l_file.make (output_path + a_files.item.twin)
							l_file.open_read
							if not l_file.is_open_read then
								error_manager.set_last_error (create {XERROR_FILENOTFOUND}.make (["cannot read file " + l_file.name]), false)
							else
								l_servlet_gag.put_servlet_generator_generator (translate_to_servlet_generator_generator (a_files.item.substring (1, a_files.item.index_of ('.', 1)-1), l_file, taglib))
								l_file.close
							end
						end
						a_files.forth
					end
					l_servlet_gag.generate (servlet_gen_path)
					create l_webapp_generator.make_with_servlets (name, output_path, l_servlet_gag.servlet_generator_generators)
					l_webapp_generator.generate
				end
			end
		end

	translate_to_servlet_generator_generator (servlet_name: STRING; a_stream: KI_CHARACTER_INPUT_STREAM; a_taglib: XTL_TAG_LIBRARY): XGEN_SERVLET_GENERATOR_GENERATOR
		local
			l_root_tag: XP_TAG_ELEMENT
			l_parser: XM_PARSER
			l_p_callback: XP_XML_PARSER_CALLBACKS
		do
			create {XM_EIFFEL_PARSER} l_parser.make
			create {XP_XML_PARSER_CALLBACKS} l_p_callback.make
			l_p_callback.put_taglib (a_taglib)
			l_parser.set_callbacks (l_p_callback)
			l_parser.parse_from_stream (a_stream)

			l_root_tag := l_p_callback.root_tag
			create Result.make (servlet_name, name + "_CONTROLLER", False, l_root_tag, output_path)
		end

	process_taglib_with_stream (a_stream: KI_CHARACTER_INPUT_STREAM)
		local
			l_parser: XM_PARSER
			l_p_callback: XP_TAGLIB_PARSER_CALLBACKS
		do
			create {XM_EIFFEL_PARSER} l_parser.make
			create l_p_callback.make
			l_parser.set_callbacks (l_p_callback)
			l_parser.parse_from_stream (a_stream)

			taglib := l_p_callback.taglib
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
				error_manager.set_last_error (create {XERROR_FILENOTFOUND}.make ([a_filename]), false)
			else
				create l_file.make (a_filename)
				if not l_file.exists then
					error_manager.set_last_error (create {XERROR_FILENOTFOUND}.make ([a_filename]), false)
				else
					l_file.open_read
					if not l_file.is_open_read then
						error_manager.set_last_error (create {XERROR_FILENOTFOUND}.make ([a_filename]), false)
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
