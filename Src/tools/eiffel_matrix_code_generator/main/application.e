indexing
	description: "Application root."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation procedure.
		local
			l_parser: ARGUMENT_PARSER
		do
			create l_parser.make
			l_parser.execute (agent start (l_parser))
		end

	start (a_parser: ARGUMENT_PARSER) is
			-- Starts application after all command-line arguments have been validated.
		require
			a_parser_attached: a_parser /= Void
			a_parser_successful: a_parser.is_successful
		local
			l_opt: ARGUMENT_OPTION
			l_source_fn: STRING
			l_class_name: STRING
			l_output_fn: STRING
			l_fn: FILE_NAME
			l_doc: INI_DOCUMENT
			l_frame_text: STRING
			l_generator: MATRIX_FILE_GENERATOR
			l_cls_generator: MATRIX_EIFFEL_CLASS_GENERATOR
			l_ico_generator: MATRIX_ICON_GENERATOR
			l_printer: ERROR_CUI_PRINTER
			l_pixmap: EV_PIXMAP
			l_error_manager: like error_manager
			retried: BOOLEAN
		do
			if not retried then
					-- Set ini document
				if a_parser.use_slice_mode then
					create l_ico_generator.make
					l_generator := l_ico_generator
				else
					create l_cls_generator.make
					l_generator := l_cls_generator
				end
				l_error_manager := l_generator
				error_manager := l_error_manager

				l_source_fn := a_parser.ini_file_option
				l_doc := open_ini_document (l_source_fn)
				if l_doc /= Void then

					if a_parser.use_slice_mode then
						(create {EV_APPLICATION}).do_nothing
							-- Try loading pixmap. If not create a blank one.
						l_pixmap := (agent (a_fn: STRING): EV_PIXMAP
							local
								retried_il: BOOLEAN
							do
								if not retried_il then
									create Result
									Result.set_with_named_file (a_fn)
								else
									create Result.make_with_size (10, 10)
									error_manager.add_error (create {ERROR_INVALID_MATRIX_PNG}.make_with_context ([a_fn]), False)
								end
							rescue
								retried_il := True
								retry
							end).item ([a_parser.slice_matrix])
						if l_error_manager.successful then
							l_ico_generator.generate (l_doc, a_parser.png_slices_locations, l_pixmap)
						end
					else
							-- Set frame file option
						l_opt := a_parser.frame_file_option
						create l_fn.make
						if l_opt /= Void then
							l_fn.set_file_name (l_opt.value)
						else
							l_fn.set_directory (a_parser.application_base)
							l_fn.set_subdirectory (frame_folder)
							l_fn.set_file_name (frame_file)
						end
						l_frame_text := open_frame_file (l_fn)
						if l_frame_text /= Void and then not l_frame_text.is_empty then
								-- Set output file name option
							l_opt := a_parser.output_file_name_option
							if l_opt /= Void then
								l_output_fn := l_opt.value
							end

								-- Set class name option
							l_opt := a_parser.class_name_option
							if l_opt /= Void then
								l_class_name := l_opt.value
							end

							l_cls_generator.generate (l_doc, l_frame_text, l_class_name, l_output_fn)
						end
					end
				else
					l_error_manager.add_error (create {ERROR_INVALID_INI_FILE}.make_with_context ([l_source_fn]), False)
				end
			end

			create l_printer
			if not l_error_manager.successful then
				l_error_manager.trace_errors (l_printer)
			else
				if l_error_manager.has_warnings then
					l_error_manager.trace_warnings (l_printer)
					io.new_line
				end
				check l_generator_attached: l_generator /= Void end
				io.put_string ("Generation successful.%N")
				if a_parser.use_slice_mode then
					io.put_string ("Output tiles generated into folder: '")
					io.put_string (a_parser.png_slices_locations)
				else
					io.put_string ("Output generated into file: '")
					io.put_string (l_cls_generator.generated_file_name)
				end
				io.put_string ("'%N%N")
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Basic Operations

	open_ini_document (a_file_name: STRING): INI_DOCUMENT is
			-- Attempts to open `a_file_name' as an INI document.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: (create {PLAIN_TEXT_FILE}.make (a_file_name)).exists
			error_manager_attached: error_manager /= Void
		local
			l_file: PLAIN_TEXT_FILE
			l_reader: INI_DOCUMENT_READER
			retried: BOOLEAN
		do
			if not retried then
				create l_file.make_open_read (a_file_name)
				create l_reader.make
				l_reader.read_from_file (l_file, True)
				if l_reader.successful then
					Result := l_reader.read_document
				else
					error_manager.add_error (create {ERROR_INVALID_INI_FILE}.make_with_context ([a_file_name]), False)
				end
			end
			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
		rescue
			retried := True
			retry
		end

	open_frame_file (a_file_name: STRING): STRING is
			-- Attempts to open frame file `a_file_name' and returns it's content
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			error_manager_attached: error_manager /= Void
		local
			l_file: PLAIN_TEXT_FILE
			l_line: STRING
			retried: BOOLEAN
		do
			if not retried then
				create l_file.make_open_read (a_file_name)
				create Result.make (l_file.count)
				if not l_file.is_empty then
					from until l_file.end_of_file loop
						l_file.read_line
						l_line := l_file.last_string
						if l_line /= Void then
							Result.append (l_line)
						end
						if not l_file.end_of_file then
							Result.append_character ('%N')
						end
					end
				else
					error_manager.add_error (create {ERROR_INVALID_FRAME_FILE}.make_with_context ([a_file_name]), False)
					Result := Void
				end
			else
				error_manager.add_error (create {ERROR_FRAME_FILE_NOT_READABLE}.make_with_context ([a_file_name]), False)
				Result := Void
			end
			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	error_manager: MULTI_ERROR_MANAGER
			-- Error manager used to report errors

feature {NONE} -- Constants

	frame_file: STRING is "matrix.e.frame"
			-- File name of frame file

	frame_folder: STRING is "frames";
			-- Sub folder where frame files are located

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {APPLICATION}
