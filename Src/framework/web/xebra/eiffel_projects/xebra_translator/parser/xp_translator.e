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

	taglibs: HASH_TABLE [XTL_TAG_LIBRARY, STRING]
			-- Taglib which should be used to validate the xeb files

feature -- Status setting

	set_output_path (a_path: like output_path)
			-- Sets the output_path
		require
			a_path_is_valid: not a_path.is_empty
		do
			output_path := a_path
		end

	set_servlet_gen_path (a_path: like servlet_gen_path)
			-- Sets the servlet_gen_path
		require
			a_path_is_valid: not a_path.is_empty
		do
			servlet_gen_path := a_path
		end

	set_name (a_name: like name)
			-- Sets the name
		require
			a_name_is_valid: not a_name.is_empty
		do
			name := a_name
		end

feature -- Processing

	process_with_files (a_files: LIST [STRING]; a_taglib_folder: STRING)
			-- `a_files': Alle the files of a folder with xeb files
			-- `a_taglib_folder': Path to the folder the tag library definitions
			-- Generates classes for all the xeb files in `a_files' using `a_taglib_folder' for the taglib
		local
			l_file: KL_TEXT_INPUT_FILE
			l_servlet_gag: XGEN_SERVLET_GENERATOR_APP_GENERATOR
			l_webapp_generator: XGEN_WEBAPP_GENERATOR
		do
			create l_servlet_gag.make
			taglibs := parse_taglibs (a_taglib_folder)
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
						print ("Processing '" + l_file.name + "'...%N")
						l_servlet_gag.put_servlet_generator_generator (translate_to_servlet_generator_generator (a_files.item.substring (1, a_files.item.index_of ('.', 1)-1), l_file, taglibs, l_file.name))
						l_file.close
						print ("Done.%N")
					end
				end
				a_files.forth
			end
			l_servlet_gag.generate (servlet_gen_path)
			create l_webapp_generator.make_with_servlets (name, output_path, l_servlet_gag.servlet_generator_generators)
			l_webapp_generator.generate
		end

	parse_taglibs (taglib_folder: STRING): HASH_TABLE [XTL_TAG_LIBRARY, STRING]
			-- Generates tag libraries from all the the *.taglib files in the directory
		require
			taglib_folder_valid: not taglib_folder.is_empty
		local
			l_taglib_file: KL_TEXT_INPUT_FILE
			dir: DIRECTORY
			files: LIST [STRING]
		do
			create {HASH_TABLE [XTL_TAG_LIBRARY, STRING]} Result.make (5)
			create dir.make (taglib_folder)
			files := dir.linear_representation
			from
				files.start
			until
				files.after
			loop
				if files.item.ends_with (".taglib") then
					create l_taglib_file.make (files.item)
					if (not l_taglib_file.exists) then
						error_manager.set_last_error (create {XERROR_FILENOTFOUND}.make ([files.item]), false)
					else
						l_taglib_file.open_read
						if not l_taglib_file.is_open_read then
							error_manager.set_last_error (create {XERROR_FILENOTFOUND}.make (["cannot read file " + files.item ]), false)
						else
							process_taglib_with_stream (Result, l_taglib_file)
							l_taglib_file.close
						end
					end
				end
				files.forth
			end
		end

	process_taglib_with_stream (a_taglibs: TABLE [XTL_TAG_LIBRARY, STRING]; a_stream: KI_CHARACTER_INPUT_STREAM)
			-- Trasforms stream to tag library and adds it to `a_taglibs'
		local
			l_parser: XM_PARSER
			l_p_callback: XP_TAGLIB_PARSER_CALLBACKS
		do
			create {XM_EIFFEL_PARSER} l_parser.make
			create l_p_callback.make
			l_parser.set_callbacks (l_p_callback)
			l_parser.parse_from_stream (a_stream)

			a_taglibs.put (l_p_callback.taglib, l_p_callback.taglib.id)
		end

	translate_to_servlet_generator_generator (servlet_name: STRING; a_stream: KI_CHARACTER_INPUT_STREAM; a_taglib: HASH_TABLE [XTL_TAG_LIBRARY, STRING]; a_path: STRING): XGEN_SERVLET_GENERATOR_GENERATOR
			-- Transforms `a_stream' to a {XGEN_SERVLET_GENERATOR_GENERATOR}
		require
			servlet_name_valid: not servlet_name.is_empty
		local
			l_root_tag: XP_TAG_ELEMENT
			l_controller_class: STRING
			l_parser: XM_PARSER
			l_p_callback: XP_XML_PARSER_CALLBACKS
			l_external_resolver: XP_EXTERNAL_RESOLVER
			l_controller_resolver: XP_CONTROLLER_SET_VISITOR
		do
			create l_external_resolver
			create {XM_EIFFEL_PARSER} l_parser.make
			l_parser.set_dtd_resolver (l_external_resolver)
			l_parser.set_entity_resolver (l_external_resolver)
			create {XP_XML_PARSER_CALLBACKS} l_p_callback.make (l_parser, a_path)
			l_p_callback.put_taglibs (a_taglib)
			l_parser.set_callbacks (l_p_callback)
			l_parser.parse_from_stream (a_stream)

			l_root_tag := l_p_callback.root_tag
				-- Sets the controller_id of all the tags
			l_controller_class := l_p_callback.controller_class
			create Result.make (servlet_name, False, l_root_tag, output_path, l_p_callback.is_template, l_controller_class)
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
