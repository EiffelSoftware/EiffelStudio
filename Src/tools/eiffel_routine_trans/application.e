note
	description: "[
		Translate content of input file into readable a file with Eiffel routine names.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_parser: ARGUMENT_PARSER
		do
			create l_parser.make
			l_parser.execute (agent do_nothing)

			create translat_table.make (2000)
			if l_parser.is_successful and attached l_parser.input_file as l_file and then attached l_parser.translate_file as l_trans_file then
				output_path := l_parser.output_path
				read_translate_data (l_trans_file)
				if not has_error then
					translate_input_file (l_file)
				else
					io.error.put_string (l_file + " or " + l_trans_file + " is invalid%N")
				end
			end
		end

feature -- Access

	output_path: detachable STRING_32
			-- Path where files will be generated.

	translat_table: HASH_TABLE [like translate_data_from_line, STRING_32]

feature -- Status Report

	has_error: BOOLEAN
			-- Did we encounter an error of some sort?

feature -- Basic operations

	read_translate_data (a_file: READABLE_STRING_32)
			-- Read translate data from `a_file'
		local
			l_input: PLAIN_TEXT_FILE
			l_table: like translat_table
			retried: BOOLEAN
		do
			if not retried then
				create l_input.make_with_name (a_file)
				l_input.open_read
				l_table := translat_table
				from
					l_input.read_line
				until
					l_input.end_of_file
				loop
					if attached l_input.last_string as l_line and then not l_line.is_empty then
						if attached translate_data_from_line (l_line) as l_data then
							l_table.put (l_data, l_data.translated_name)
						end
					end
					l_input.read_line
				end
				l_input.close

			else
				has_error := True
			end
		rescue
			retried := True
			retry
		end

	translate_input_file (a_file: STRING_32)
			-- Translate `a_file' and write to output
		local
			l_input: RAW_FILE
			l_output: RAW_FILE
			l_table: like translat_table
			retried: BOOLEAN
			l_token: STRING
			l_output_string: STRING
		do
			if not retried then
				create l_input.make_with_name (a_file)
				create l_token.make (20)
				l_input.open_read
				l_table := translat_table
				create l_output_string.make (l_input.count)
				from
					l_input.read_character
				until
					l_input.end_of_file
				loop
					if l_input.last_character.is_alpha_numeric or l_input.last_character = '_' then
						l_token.append_character (l_input.last_character)
					else
						if not l_token.is_empty then
								-- Try to find translate
							if l_token.item (1).is_alpha and then attached l_table.item (l_token.as_string_32) as l_item then
								l_output_string.append_character ('{')
								l_output_string.append (l_item.class_name)
								l_output_string.append_character ('}')
								l_output_string.append_character ('.')
								l_output_string.append (l_item.feature_name)
							else
								l_output_string.append (l_token)
							end
							l_token.wipe_out
						end
						l_output_string.append_character (l_input.last_character)
					end
					l_input.read_character
				end
				l_input.close

				if attached output_path as l_output_path then
					create l_output.make_with_name (l_output_path)
					l_output.create_read_write
					l_output.put_string (l_output_string)
					l_output.close
				else
					io.put_string (l_output_string)
				end
			else
				has_error := True
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implemetnation

	translate_data_from_line (a_line: STRING): detachable TUPLE [cluster, class_name, feature_name, translated_name, location: STRING_32]
			-- Parse translate data from `a_line'.
		local
			l_line: STRING
			l_items: LIST [STRING]
		do
			l_line := a_line
			l_line.left_adjust
			l_line.right_adjust

			l_items := a_line.split ('%T')
			if l_items.count = 5 then
				Result := [l_items.i_th (1).as_string_32, l_items.i_th (2).as_string_32, l_items.i_th (3).as_string_32, l_items.i_th (4).as_string_32, l_items.i_th (5).as_string_32]
			end
		end

end

