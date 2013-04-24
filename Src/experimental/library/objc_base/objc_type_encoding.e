note
	description: "Encoding of objective C types."
	status: "Not completed"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_TYPE_ENCODING

feature -- Access

	readable_type (s: STRING): STRING
		do
			if is_array (s) then
				Result := readable_type (array_type (s)) + " []"
			elseif is_structure (s) then
				Result := "struct " + readable_type (structure_type (s))
			elseif is_union (s) then
				Result := "union " + readable_type (union_type (s))
			elseif is_pointer (s)  then
				Result := readable_type (pointer_type (s)) + " *"
			elseif is_class (s) then
				Result := class_type (s)
			elseif is_basic (s) and then attached objective_c_to_eiffel_map.item (s [1]) as l_type then
				Result := l_type.twin
			else
				Result := s.twin
			end
		end

	pointer_type (s: STRING): STRING
		require
			is_pointer: is_pointer (s)
		do
			Result := s.substring (2, s.count)
		ensure
			pointer_type_not_empty: not Result.is_empty
		end

	class_type (s: STRING): STRING
		require
			is_pointer: is_class (s)
		do
			if s.count > 3 and s.item (2) = '"' and s.item (s.count) = '"' then
				Result := s.substring (3, s.count - 1)
			else
				Result := s.substring (2, s.count)
			end
		ensure
			pointer_type_not_empty: not Result.is_empty
		end

	basic_type (s: STRING): STRING
		require
			is_basic: is_basic (s)
		do
			Result := s.twin
		ensure
			basic_type_not_empty: not Result.is_empty
		end

	array_type (s: STRING): STRING
		require
			is_array: is_array (s)
		local
			i: INTEGER
		do
			from
				i := 2
			until
				not s.item (i).is_digit
			loop
				i := i + 1
			end
			Result := s.substring (i, s.count - 1)
		ensure
			array_type_not_empty: not Result.is_empty
		end

	structure_type (s: STRING): STRING
		require
			is_structure: is_structure (s)
		local
			i, nb: INTEGER
		do
			from
				i := 2
				nb := s.count
			until
				s.item (i) = '=' or else i > nb
			loop
				i := i + 1
			end
			Result := s.substring (2, i - 1)
		ensure
			structure_type_not_empty: not Result.is_empty
		end

	union_type (s: STRING): STRING
		require
			is_union: is_union (s)
		local
			i, nb: INTEGER
		do
			from
				i := 2
				nb := s.count
			until
				s.item (i) = '=' or else i > nb
			loop
				i := i + 1
			end
			Result := s.substring (2, i - 1)
		ensure
			union_type_not_empty: not Result.is_empty
		end

feature -- Status report

	is_basic (s: STRING): BOOLEAN
			-- Is `s' representing a basic C type?
		do
			Result := s.count = 1 and then objective_c_to_eiffel_map.has (s [1])
		end

	is_void (s: STRING): BOOLEAN
			-- Is `s' representing void, i.e. the return type of a procedure?
		do
			Result := s.count = 1 and then s [1] = 'v'
		end

	is_class (s: STRING): BOOLEAN
			-- Is `s' representing an objective C class?
		do
			Result := s.count > 1 and then s [1] = '@'
		ensure
			is_class: Result implies s.count > 1
		end

	is_unknown (s: STRING): BOOLEAN
			-- Is `s' unknown?
		do
			Result := s.count = 1 and then s [1] = '?'
		end

	is_class_type (s: STRING): BOOLEAN
			-- Is `s' representing a `Class' type?
		do
			Result := s.count = 1 and then s [1] = '#'
		end

	is_selector (s: STRING): BOOLEAN
			-- Is `s' representing a `SEL' type?
		do
			Result := s.count = 1 and then s [1] = ':'
		end

	is_c_string (s: STRING): BOOLEAN
			-- Is `s' representing a C string type?
		do
			Result := s.count = 1 and then s [1] = '*'
		end

	is_pointer (s: STRING): BOOLEAN
		do
			Result := s.count > 1 and then s [1] = '^'
		end

	is_array (s: STRING): BOOLEAN
		do
			Result := s.count > 1 and then s [1] = '[' and then s [s.count] = ']'
		end

	is_structure (s: STRING): BOOLEAN
		do
			Result := s.count > 1 and then s [1] = '{' and then s [s.count] = '}'
		end

	is_union (s: STRING): BOOLEAN
		do
			Result := s.count > 1 and then s [1] = '(' and then s [s.count] = ')'
		end

	has_type_specifier (s: STRING): BOOLEAN
			-- Does `s' have a type specifier?
			-- Currently it is one of the following:
			--  const  r
			--  in     n
			--  inout  N
			--  out    o
			--  bycopy O
			--  oneway V
		do
			if s.count > 1 then
				inspect s [1]
				when 'r', 'n', 'N', 'o', 'O', 'V' then
					Result := True
				else
				end
			end
		end

feature {NONE} -- Access

	objective_c_to_eiffel_map: HASH_TABLE [STRING, CHARACTER]
		once
			create Result.make (10)
			Result.put ("INTEGER_8", 'c')
			Result.put ("NATURAL_8", 'C')
			Result.put ("INTEGER_16", 's')
			Result.put ("NATURAL_16", 'S')
			Result.put ("INTEGER_32", 'i')
			Result.put ("NATURAL_32", 'I')
			Result.put ("INTEGER_64", 'l')
			Result.put ("NATURAL_64", 'L')
			Result.put ("INTEGER_64", 'q')
			Result.put ("NATURAL_64", 'Q')
			Result.put ("REAL_32", 'f')
			Result.put ("REAL_64", 'd')
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
