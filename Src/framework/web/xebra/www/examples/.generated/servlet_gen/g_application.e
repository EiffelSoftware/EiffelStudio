note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_APPLICATION

inherit
	XU_SHARED_OUTPUTTER

create
	make

feature-- Access

feature-- Implementation

	make
			--<Precursor>
		local
			l_arg_parser: XTAG_ARGUMENT_PARSER
		do
			create l_arg_parser.make
			l_arg_parser.execute (agent run (l_arg_parser))
		end

	run (a_arg_parser: XTAG_ARGUMENT_PARSER)
			--<Precursor>
		local
			l_path: STRING
			l_controller_table: HASH_TABLE [TUPLE [STRING, STRING], STRING]
			l_const_class: XEL_CONSTANTS_CLASS_ELEMENT
			buf: XU_INDENDATION_FORMATTER
			constants_file: PLAIN_TEXT_FILE
			constants_file_name: FILE_NAME
		do
			create l_const_class.make_constant
			log.set_name ("XEBSRVLGEN")
			log.set_debug_level (10)
			if not a_arg_parser.is_successful then
			print ("usage:servlet_gen -o output_path%N")
			else
			l_path := a_arg_parser.output_path
			create l_controller_table.make (1)
			l_controller_table.put (["MAIN_CONTROLLER", "make"], "controller_1")
			(create {G_INDEX_SERVLET_GENERATOR}.make (l_path, "index", l_controller_table, "./g_index_servlet_generator.e",l_const_class)).generate;
			create constants_file_name.make_from_string ("./.generated/")
			constants_file_name.set_file_name ("g_servlet_constants.e")
			create constants_file.make (constants_file_name)
			constants_file.open_write
			create buf.make (constants_file)
			l_const_class.serialize (buf)
			constants_file.close
			end
			log.iprint ("System generated.")
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
		]"end
