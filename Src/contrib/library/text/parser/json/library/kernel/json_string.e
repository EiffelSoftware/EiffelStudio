note

    description: "[
        A JSON_STRING represent a string in JSON.
        A string is a collection of zero or more Unicodes characters, wrapped in double
        quotes, using blackslash espaces.
        ]"

    author: "Javier Velilla"
    date: "2008/08/24"
    revision: "Revision 0.1"
    license:"MIT (see http://www.opensource.org/licenses/mit-license.php)"


class
    JSON_STRING

inherit
    JSON_VALUE
        redefine
            is_equal
        end

create
    make_json,
	make_json_from_string_32,
	make_with_escaped_json

convert
	make_json ({READABLE_STRING_8, STRING_8, IMMUTABLE_STRING_8}),
	make_json_from_string_32 ({READABLE_STRING_32, STRING_32, IMMUTABLE_STRING_32})

feature {NONE} -- Initialization

    make_json (s: READABLE_STRING_8)
            -- Initialize.
        require
            item_not_void: s /= Void
        do
            make_with_escaped_json (escaped_json_string (s))
        end

    make_json_from_string_32 (s: READABLE_STRING_32)
            -- Initialize from STRING_32 `s'.
        require
            item_not_void: s /= Void
        do
            make_with_escaped_json (escaped_json_string_32 (s))
        end

    make_with_escaped_json (s: READABLE_STRING_8)
            -- Initialize with an_item already escaped
        require
            item_not_void: s /= Void
        do
            item := s
        end

feature -- Access

    item: STRING
            -- Contents with escaped entities if any

	unescaped_string_8: STRING_8
			-- Unescaped string from `item'
		local
			s: like item
			i, n: INTEGER
			c: CHARACTER
		do
			s := item
			n := s.count
			create Result.make (n)
			from i := 1 until i > n loop
				c := s[i]
				if c = '\' then
					if i < n then
						inspect s[i+1]
						when '\' then
							Result.append_character ('\')
							i := i + 2
						when '%"' then
							Result.append_character ('%"')
							i := i + 2
						when 'n' then
							Result.append_character ('%N')
							i := i + 2
						when 'r' then
							Result.append_character ('%R')
							i := i + 2
						when 'u' then
							--| Leave unicode \uXXXX unescaped
							Result.append_character ('\')
							i := i + 1
						else
							Result.append_character ('\')
							i := i + 1
						end
					else
						Result.append_character ('\')
						i := i + 1
					end
				else
					Result.append_character (c)
					i := i + 1
				end
			end
		end

	unescaped_string_32: STRING_32
			-- Unescaped string 32 from `item'
		local
			s: like item
			i, n: INTEGER
			c: CHARACTER
			hex: STRING
		do
			s := item
			n := s.count
			create Result.make (n)
			from i := 1 until i > n loop
				c := s[i]
				if c = '\' then
					if i < n then
						inspect s[i+1]
						when '\' then
							Result.append_character ('\')
							i := i + 2
						when '%"' then
							Result.append_character ('%"')
							i := i + 2
						when 'n' then
							Result.append_character ('%N')
							i := i + 2
						when 'r' then
							Result.append_character ('%R')
							i := i + 2
						when 'u' then
							hex := s.substring (i+2, i+2+4 - 1)
							if hex.count = 4 then
								Result.append_code (hexadecimal_to_natural_32 (hex))
							end
							i := i + 2 + 4
						else
							Result.append_character ('\')
							i := i + 1
						end
					else
						Result.append_character ('\')
						i := i + 1
					end
				else
					Result.append_character (c.to_character_32)
					i := i + 1
				end
			end
		end

    representation: STRING
			-- String representation of `item' with escaped entities if any
        do
            create Result.make (item.count + 2)
            Result.append_character ('%"')
            Result.append (item)
            Result.append_character ('%"')
        end

feature -- Visitor pattern

    accept (a_visitor: JSON_VISITOR)
            -- Accept `a_visitor'.
            -- (Call `visit_json_string' procedure on `a_visitor'.)
        do
            a_visitor.visit_json_string (Current)
        end

feature -- Comparison

    is_equal (other: like Current): BOOLEAN
            -- Is JSON_STRING  made of same character sequence as `other'
            -- (possibly with a different capacity)?
        do
            Result := item.same_string (other.item)
        end

feature -- Change Element

    append (a_string: STRING)
            -- Add a_string
        require
            a_string_not_void: a_string /= Void
        do
            item.append_string (a_string)
        end

feature -- Status report

    hash_code: INTEGER
            -- Hash code value
        do
            Result := item.hash_code
        end

feature -- Status report

    debug_output: STRING
            -- String that should be displayed in debugger to represent `Current'.
        do
            Result := item
        end

feature {NONE} -- Implementation

	is_hexadecimal (s: READABLE_STRING_8): BOOLEAN
			-- Is `s' an hexadecimal value?	
		do
			Result := across s as scur all scur.item.is_hexa_digit end
		end

	hexadecimal_to_natural_32 (s: READABLE_STRING_8): NATURAL_32
			-- Hexadecimal string `s' converted to NATURAL_32 value
		require
			s_not_void: s /= Void
			is_hexadecimal: is_hexadecimal (s)
		local
			i, nb: INTEGER
			char: CHARACTER
		do
			nb := s.count

			if nb >= 2 and then s.item (2) = 'x' then
				i := 3
			else
				i := 1
			end

			from
			until
				i > nb
			loop
				Result := Result * 16
				char := s.item (i)
				if char >= '0' and then char <= '9' then
					Result := Result + (char |-| '0').to_natural_32
				else
					Result := Result + (char.lower |-| 'a' + 10).to_natural_32
				end
				i := i + 1
			end
		end

    escaped_json_string (s: READABLE_STRING_8): STRING_8
            -- JSON string with '"' and '\' characters escaped
        require
            s_not_void: s /= Void
		local
			i, n: INTEGER
			c: CHARACTER_8
		do
			n := s.count
			create Result.make (n + n // 10)
			from i := 1 until i > n loop
				c := s.item (i)
				inspect c
				when '%"' then Result.append_string ("\%"")
				when '\' then Result.append_string ("\\")
				when '%R' then Result.append_string ("\r")
				when '%N' then Result.append_string ("\n")
				else
					Result.extend (c)
				end
				i := i + 1
			end
		end

    escaped_json_string_32 (s: READABLE_STRING_32): STRING_8
            -- JSON string with '"' and '\' characters and unicode escaped
        require
            s_not_void: s /= Void
		local
			i, j, n: INTEGER
			uc: CHARACTER_32
			c: CHARACTER_8
			h: STRING_8
		do
			n := s.count
			create Result.make (n + n // 10)
			from i := 1 until i > n loop
				uc := s.item (i)
				if uc.is_character_8 then
					c := uc.to_character_8
					inspect c
					when '%"' then Result.append_string ("\%"")
					when '\' then Result.append_string ("\\")
					when '%R' then Result.append_string ("\r")
					when '%N' then Result.append_string ("\n")
					else
						Result.extend (c)
					end
				else
					Result.append ("\u")
					h := uc.code.to_hex_string
					-- Remove first 0 and keep 4 hexa digit
					from
						j := 1
					until
						h.count = 4 or (j <= h.count and then h.item (j) /= '0')
					loop
						j := j + 1
					end
					h := h.substring (j, h.count)

					from
					until
						h.count >= 4
					loop
						h.prepend_integer (0)
					end
					check h.count = 4 end
					Result.append (h)
				end
				i := i + 1
			end
		end

invariant
    item_not_void: item /= Void

end
