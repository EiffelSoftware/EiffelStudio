indexing
	description: "[
		Command line interface application entry point.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make is
			-- Application entry point
		local
			l_parser: ARGUMENT_PARSER
		do
			create l_parser.make
			l_parser.execute (agent start (l_parser))
			if not l_parser.is_successful then
				(create {EXCEPTIONS}).die (1)
			elseif not error_handler.successful then
				(create {EXCEPTIONS}).die (2)
			end
		end

	start (a_parser: ARGUMENT_PARSER) is
			-- Application start
		require
			a_parser_attached: a_parser /= Void
			a_parser_successful: a_parser.is_successful
		local
			l_reader: REG_FILE_READER
			l_reg_files: HASH_TABLE [REG_FILE, STRING]
			l_files: ARRAYED_LIST [REG_FILE]
			l_generator: WIX_REGISTRY_GENERATOR
			l_document: XM_DOCUMENT
			l_output_file_name: STRING
			l_eh: like error_handler
			l_printer: ERROR_CUI_PRINTER
			l_traced: BOOLEAN
		do
			l_eh := error_handler

			create l_reader.make (l_eh)
			l_reg_files := l_reader.load_reg_files (a_parser.reg_files)
			l_files := l_reg_files.linear_representation

			if l_eh.successful then
				l_files.prune_all (Void)
				if not l_files.is_empty then
					create l_generator.make (error_handler)
					l_document := l_generator.generate_collection (l_files, a_parser)

					if a_parser.use_output_file_name then
						l_output_file_name := a_parser.output_file_name
					else
						l_output_file_name := default_output_file_name
					end
					save_xml_document (l_document, l_output_file_name)
				else
					l_eh.add_error (create {RWEF}.make, False)
				end
			end

			create l_printer
			if l_eh.has_warnings then
				l_eh.trace_warnings (l_printer)
				l_traced := True
			end
			if not l_eh.successful then
				l_eh.trace_errors (l_printer)
				l_traced := True
			else
				check l_output_file_name_attached: l_output_file_name /= Void end
				if l_traced then
					io.new_line
				end
				io.put_string ("Output file generated to '")
				io.put_string (l_output_file_name)
				io.put_string ("'.")
			end
			io.new_line
		end

feature -- Access

	error_handler: MULTI_ERROR_MANAGER is
			-- Error handler for application
		do
			Result := internal_error_handler
			if Result = Void then
				create Result.make
				internal_error_handler := Result
			end
		ensure
			result_attached: Result /= Void
			unified_access: Result = error_handler
		end

feature {NONE} -- Basic operations

	save_xml_document (a_doc: XM_DOCUMENT; a_file_name: STRING) is
			-- Saves the XML document `a_doc' to the file `a_file_name'.
		local
			l_filter: XM_INDENT_PRETTY_PRINT_FILTER
			l_generator: XM_XMLNS_GENERATOR
			l_output_file: KL_TEXT_OUTPUT_FILE
			retried: BOOLEAN
		do
			if not retried then
				create l_output_file.make (a_file_name)
				l_output_file.open_write

				create l_filter.make_null
				l_filter.set_output_stream (l_output_file)

				create l_generator.set_next (l_filter)
				a_doc.process_to_events (l_generator)
			else
				error_handler.add_error (create {RWEO}.make (a_file_name), False)
			end

			if l_output_file /= Void then
				l_output_file.close
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Constants

	default_output_file_name: STRING = "registry.wxi"
			-- Default WiX output file name

feature {NONE} -- Internal implementation cache

	internal_error_handler: like error_handler
			-- Cached version of `error_handler'
			-- Note: Do not use directly.

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
