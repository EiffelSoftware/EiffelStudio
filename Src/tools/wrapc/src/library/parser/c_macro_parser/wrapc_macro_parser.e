note
	description: "Summary description for {WRAPC_PARSER}."
	date: "$Date$"
	revision: "$Revision$"

class
	WRAPC_MACRO_PARSER


create

	make

feature {NONE} -- Initialization

	make (a_path: PATH)
		do
			path := a_path
			create last_line.make_empty
			create last_file_path.make_empty
			create constants.make_equal_caseless (10)
		end

feature -- Access

	constants: STRING_TABLE [LIST [TUPLE [constant:STRING; type: STRING; value: STRING]]]
		-- String table with header name and a list of tuples (contant and type)

feature -- Parser

	reset
		do
			error_description := Void
		end

	parse_macro
		do
			initialize
			if not has_error and then has_next_line then
				from
					next_line
				until
					has_error or else end_of_file
				loop
					parse_line
					if has_next_line then
						next_line
					end
				end
			end
			finalize
		end

feature {NONE} -- Parser Implementation

	initialize
		local
			l_file: like file
		do
			create {PLAIN_TEXT_FILE} l_file.make_with_path (path)
			if l_file.exists and then l_file.is_readable then
				l_file.open_read
				file := l_file
			else
				create error_description.make_from_string ("File is not readable or does not exist at path: " + path.out)
			end
		end

	finalize
		do
			if attached file as l_file then
				l_file.close
			end
		end

	parse_line
			-- Example
			-- #line 1 "C:\\home\\projects\\dev\\WrapC_dev\\wrap_libgit2\\library\\C\\include\\git2.h"
		local
			parser: WRAPC_MACRO_HEADER_PARSER
		do
			if not last_line.is_empty then
				skip_white_spaces
				if last_line.at (cursor) = '#' then
					next
					if is_line then
						-- mark_define
						if {PLATFORM}.is_windows then
							next
							next
							next
							next
						end
						skip_white_spaces
						skip_values
						skip_white_spaces
						if last_line.at (cursor) = '"' then
							create last_file_path.make_empty
							parse_file_path
							if not last_file_path.is_empty and then not constants.has_key (last_file_path) then
								create parser.make (create {PATH}.make_from_string (last_file_path))
								parser.parse_macro
								if not parser.constants.is_empty then
									constants.force (parser.constants, last_file_path)
								end
							end
						end
					end
				end
			end
		end

	skip_white_spaces
			-- Remove white spaces
		local
		do
			from
			until
				(last_line.at (cursor) /= ' ' and last_line.at (cursor) /= '%N' and last_line.at (cursor) /= '%R' and last_line.at (cursor) /= '%U' and last_line.at (cursor) /= '%T') or not has_next
			loop
				next
			end
		end

	parse_file_path
		do
			from
				next
			until
				(last_line.at (cursor) = '"') or not has_next
			loop
				last_file_path.append_character (last_line.at (cursor))
				next
			end
		end

	skip_values
			-- Remove values
		local
		do
			from
			until
				(last_line.at (cursor) = ' ' or last_line.at (cursor) = '%N' or last_line.at (cursor) = '%R' or last_line.at (cursor) = '%U' or last_line.at (cursor) = '%T') or not has_next
			loop
				next
			end
		end

	is_line: BOOLEAN
			-- Word at index represents define?
		do
			if {PLATFORM}.is_windows then
				Result := last_line.same_characters_general (line_id, 1, 4, cursor) -- 6 = line_id.count
			else
				Result := True
			end
		end

feature {NONE} -- Implementation

	is_value_supported: BOOLEAN

	is_defined_supported: BOOLEAN

	last_line: STRING

	last_file_path: STRING

	cursor: INTEGER


feature {NONE} -- File macro implementaetion

	next
		require
			has_next
		do
			if cursor < last_line.count then
				cursor := cursor + 1
			end
		ensure
			limits: cursor <= last_line.count
		end

	has_next: BOOLEAN
		do
			Result := cursor < last_line.count
		end

	end_of_file: BOOLEAN
		do
			if not has_error and then attached file as l_file then
				Result := l_file.end_of_file
			else
				Result := True
			end
		end

	has_next_line: BOOLEAN
		do
			Result := not end_of_file
		end

	next_line
		require
			has_next_line: has_next_line
			not_has_error: not has_error
		do
			if attached file as l_file then
				l_file.read_line
				last_line := l_file.last_string.twin
				cursor := 1
			else
				last_line := ""
				cursor := 1
			end
		end


feature {NONE} -- Implementation

	path: PATH

	file: detachable FILE

	error_description: detachable STRING

	has_error: BOOLEAN
		do
			Result := attached error_description
		end


feature {NONE} -- Constants

	line_id: STRING = "line"

end
