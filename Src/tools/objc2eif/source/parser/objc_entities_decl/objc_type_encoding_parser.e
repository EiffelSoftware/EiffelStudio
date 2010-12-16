note
	description: "Summary description for {OBJC_TYPE_ENCODING_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_TYPE_ENCODING_PARSER

feature -- Parsing

	parse_type_encoding (a_type_encoding: STRING): OBJC_TYPE_DECL
			-- Parse the passed `a_type_encoding'.
		require
			a_valid_type_encoding: not a_type_encoding.is_empty
		do
			type_encoding := a_type_encoding
			current_position := 1
			Result := parse_type
		end

feature {NONE} -- Implementation

	type_encoding: detachable STRING note option: stable attribute end
			-- The type encoding to be parsed.

	parse_type: OBJC_TYPE_DECL
			-- Parse `type_encoding' at the position specified by `type_encoding_cursor'.
		require
			type_encoding_not_void: type_encoding /= Void
			valid_current_position: current_position <= type_encoding.count
		local
			type_decl: OBJC_TYPE_DECL
			pointer_type_decl: OBJC_POINTER_TYPE_DECL
		do
			inspect current_character
			when 'c' then
				create {OBJC_BASIC_TYPE_DECL} Result.make ("char")
				Result.encoding := current_character.out
			when 'i' then
				create {OBJC_BASIC_TYPE_DECL} Result.make ("int")
				Result.encoding := current_character.out
			when 's' then
				create {OBJC_BASIC_TYPE_DECL} Result.make ("short")
				Result.encoding := current_character.out
			when 'q' then
				create {OBJC_BASIC_TYPE_DECL} Result.make ("long long")
				Result.encoding := current_character.out
			when 'C' then
				create {OBJC_BASIC_TYPE_DECL} Result.make ("unsigned char")
				Result.encoding := current_character.out
			when 'I' then
				create {OBJC_BASIC_TYPE_DECL} Result.make ("unsigned int")
				Result.encoding := current_character.out
			when 'S' then
				create {OBJC_BASIC_TYPE_DECL} Result.make ("unsigned short")
				Result.encoding := current_character.out
			when 'Q' then
				create {OBJC_BASIC_TYPE_DECL} Result.make ("unsigned long long")
				Result.encoding := current_character.out
			when 'f' then
				create {OBJC_BASIC_TYPE_DECL} Result.make ("float")
				Result.encoding := current_character.out
			when 'd' then
				create {OBJC_BASIC_TYPE_DECL} Result.make ("double")
				Result.encoding := current_character.out
			when 'v' then
				create {OBJC_BASIC_TYPE_DECL} Result.make ("void")
				Result.encoding := current_character.out
			when '*' then
				create {OBJC_POINTER_TYPE_DECL} Result.make ("char *")
				Result.encoding := current_character.out
			when '@' then
				if type_encoding.count = 1 then
					create {OBJC_POINTER_TYPE_DECL} Result.make ("id")
					Result.encoding := current_character.out
				else
						-- E.g.: "@?" (i.e. blocks)
					create {OBJC_UNSUPPORTED_TYPE_DECL} Result.make ("unsupported")
					Result.encoding := current_character.out
				end
			when '#' then
				create {OBJC_POINTER_TYPE_DECL} Result.make ("Class")
				Result.encoding := current_character.out
			when ':' then
				create {OBJC_POINTER_TYPE_DECL} Result.make ("SEL")
				Result.encoding := current_character.out
			when '{' then
				Result := parse_struct_type
			when '^' then
				current_position := current_position + 1
				type_decl := parse_type
				create pointer_type_decl.make (type_decl.name + " *")
				pointer_type_decl.pointed_type := type_decl
				if attached type_decl.encoding as type_decl_encoding then
					pointer_type_decl.encoding := "^" + type_decl_encoding
				else
					check type_encoding_not_void: False end
				end
				Result := pointer_type_decl
			when '[' then
				Result := parse_array_type
			when '(' then
				Result := parse_union_type
			when 'b' then
				Result := parse_bit_field
			when '?','B' then
				create {OBJC_UNSUPPORTED_TYPE_DECL} Result.make ("unsupported")
				Result.encoding := current_character.out
			when 'r','n','N','o','O','R','V' then
					-- Ignore this special attributes.
					-- See Apple documentation on type encodings for more information.
				current_position := current_position + 1
				Result := parse_type
			else
				create Result.make ("error")
				check expected_syntax: False end
			end
		end

	parse_struct_type: OBJC_STRUCT_TYPE_DECL
			-- Parse the struct type encoding at the current position in `type_encoding'.
		require
			type_encoding_not_void: type_encoding /= Void
			valid_current_position: current_position <= type_encoding.count
		local
			starting_position: INTEGER
			struct_name: STRING
			fields: ARRAYED_LIST [OBJC_TYPE_DECL]
		do
			starting_position := current_position
			create fields.make (0)
			current_position := current_position + 1
			struct_name := next_token
			if current_character = '=' then
				from
					current_position := current_position + 1
				until
					current_character = '}'
				loop
					fields.extend (parse_type)
					current_position := current_position + 1
				end
			elseif current_character /= '}' then
				check expected_syntax: False end
			end
			create Result.make_with_struct_info (struct_name, struct_name, fields)
			Result.encoding := type_encoding.substring (starting_position, current_position)
		end

	parse_union_type: OBJC_UNION_TYPE_DECL
			-- Parse the union type encoding at the current position in `type_encoding'.
		require
			type_encoding_not_void: type_encoding /= Void
			valid_current_position: current_position <= type_encoding.count
		local
			starting_position: INTEGER
			union_name: STRING
			fields: ARRAYED_LIST [OBJC_TYPE_DECL]
		do
			starting_position := current_position
			create fields.make (0)
			current_position := current_position + 1
			union_name := next_token
			if current_character = '=' then
				from
					current_position := current_position + 1
				until
					current_character = ')'
				loop
					fields.extend (parse_type)
					current_position := current_position + 1
				end
			elseif current_character /= ')' then
				check expected_syntax: False end
			end
			create Result.make_with_union_info (union_name, union_name, fields)
			Result.encoding := type_encoding.substring (starting_position, current_position)
		end

	parse_array_type: OBJC_ARRAY_TYPE_DECL
			-- Parse the array type encoding at the current position in `type_encoding'.
		require
			type_encoding_not_void: type_encoding /= Void
			valid_current_position: current_position <= type_encoding.count
		local
			starting_position: INTEGER
			type_decl: OBJC_TYPE_DECL
			count_string: STRING
		do
			starting_position := current_position
			from
				create count_string.make_empty
				current_position := current_position + 1
			until
				not current_character.is_digit
			loop
				count_string.append (current_character.out)
				current_position := current_position + 1
			end
			type_decl := parse_type
			current_position := current_position + 1
			check expected_syntax: current_character = ']' end
			create Result.make_with_array_info (type_decl.name + "[]", type_decl, count_string.to_natural)
			Result.encoding := type_encoding.substring (starting_position, current_position)
		end

	parse_bit_field: OBJC_UNSUPPORTED_TYPE_DECL
			-- Parse the bit field type encoding at the current position in `type_encoding'
		require
			type_encoding_not_void: type_encoding /= Void
			valid_current_position: current_position <= type_encoding.count
		local
			starting_position: INTEGER
		do
			starting_position := current_position
			from
				current_position := current_position + 1
			until
				not current_character.is_digit
			loop
				current_position := current_position + 1
			end
			current_position := current_position - 1
			create Result.make ("unsupported")
			Result.encoding := type_encoding.substring (starting_position, current_position)
		end

	next_token: STRING
			-- Return the next Objective-C token
		require
			type_encoding_not_void: type_encoding /= Void
			valid_current_position: current_position <= type_encoding.count
		do
			create Result.make_empty
				-- Ignore whitespaces.
			from until
				current_position > type_encoding.count or else not (current_character.is_equal ({OBJC_TOKEN}.space_character) or current_character.is_equal ({OBJC_TOKEN}.tab_character))
			loop
				current_position := current_position + 1
			end
			if current_position <= type_encoding.count then
					-- If we're parsing an identifier.
				if current_character.is_alpha or current_character.is_equal ({OBJC_TOKEN}.underscore_symbol) then
					Result.append_character (current_character)
					current_position := current_position + 1

					from until
						current_position > type_encoding.count or else not (current_character.is_alpha or
												 		   current_character.is_digit or
												           current_character.is_equal ({OBJC_TOKEN}.underscore_symbol))
					loop
						Result.append_character (current_character)
						current_position := current_position + 1
					end
				else
						-- If we're parsing a symbol.
					Result.append_character (current_character)
					current_position := current_position + 1
				end
			end
		end

	current_position: INTEGER
			-- The current position in the `type_encoding' string.

	current_character: CHARACTER
			-- Return the character at the current position.
		require
			type_encoding_not_void: type_encoding /= Void
			valid_current_position: current_position >= 1 and
									current_position <= type_encoding.count
		do
			Result := type_encoding [current_position]
		end

end
