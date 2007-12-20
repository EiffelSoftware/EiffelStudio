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

inherit
	ANY

	STRING_HANDLER
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature -- Generation

	generate_files (a_opts: APPLICATION_OPTIONS) is
			-- Generates files for options `a_opts'.
		require
			a_opts_attached: a_opts /= Void
		local

		do
			if a_opts.generate_interface then
				generate_file (a_opts, False)
			end
			if a_opts.generate_stub then
				generate_file (a_opts, True)
			end
			if a_opts.generate_process_routines then
				generate_process_routines (a_opts)
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

	generate_process_routines (a_opts: APPLICATION_OPTIONS) is
			-- Generates `process' routines in files `a_opts.files'.
		require
			a_opts_attached: a_opts /= Void
		local
			l_files: LIST [STRING_8]
			l_cursor: CURSOR
		do
			l_files := a_opts.files
			l_cursor := l_files.cursor
			create string_buffer.make (102400)
			create factory
			create parser.make_with_factory (factory)
			parser.set_il_parser
			create visitor.make_with_default_context
			from
				l_files.start
			until
				l_files.after
			loop
				if l_files.item /= Void then
					generate_process_routines_for (a_opts, l_files.item)
				end
				l_files.forth
			end
			l_files.go_to (l_cursor)
			string_buffer := Void
			factory := Void
			parser := Void
			visitor := Void
		end

feature {NONE} -- Implementation

	string_buffer: STRING
			-- Buffer for reading Eiffel classes.

	factory: AST_ROUNDTRIP_FACTORY
	parser: EIFFEL_PARSER
			-- Parsing objects.

	visitor: AST_ADD_PROCESS_VISITOR
			-- Processor for adding `process' routines to a class.

	generate_process_routines_for (a_opts: APPLICATION_OPTIONS; a_file_name: STRING_8) is
			-- Generate `process' routines for class in `a_file_name'.
		require
			a_opts_attached: a_opts /= Void
			a_file_name_not_void: a_file_name /= Void
			string_buffer_not_void: string_buffer /= Void
			factory_not_void: factory /= Void
			parser_not_void: parser /= Void
			visitor_not_void: visitor /= Void
		local
			file: KL_BINARY_INPUT_FILE
			outfile: KL_BINARY_OUTPUT_FILE
			count, nb: INTEGER
			l_feat: FEATURE_AS
		do
			create file.make (a_file_name)
			count := file.count
			file.open_read
			if file.is_open_read then
				if string_buffer.count < count then
					string_buffer.resize (count)
				end
				string_buffer.set_count (count)
				nb := file.read_to_string (string_buffer, 1, count)
				string_buffer.set_count (nb)
				file.close

				parser.parse_from_string (string_buffer)
				if parser.root_node = Void then
					io.error.put_string ("Syntax error in file: " + a_file_name)
					io.error.put_new_line
				else
					l_feat := parser.root_node.feature_with_name (names_heap.id_of ("process"))
					if l_feat = Void then
						visitor.setup (parser.root_node, parser.match_list, True, True)
						parser.reset
						parser.reset_nodes
						if string_buffer.item (string_buffer.count -1) = '%R'  then
							visitor.add_process_routine (a_opts, "%R%N")
						else
							visitor.add_process_routine (a_opts, "%N")
						end
						create outfile.make (a_file_name)
						outfile.open_write
						if outfile.is_open_write then
							outfile.put_string (visitor.text)
							outfile.close
						else
							io.error.put_string ("Could not write to: " + a_file_name)
							io.error.put_new_line
						end
						visitor.reset
					end
				end
			end
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

end -- class {FILE_GENERATOR_ENGINE}
