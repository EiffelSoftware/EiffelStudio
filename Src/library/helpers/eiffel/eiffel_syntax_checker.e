indexing
	description: "Utilities relative to the Eiffel syntax"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SYNTAX_CHECKER

inherit
	SYNTAX_STRINGS

feature -- Status report

	is_valid_class_name (cn: STRING): BOOLEAN is
			-- Is `cn' a valid class name?
		require
			name_not_void: cn /= Void
		do
			Result := is_valid_identifier (cn)
		end

	is_valid_cluster_name (cn: STRING): BOOLEAN is
			-- Is `cn' a valid cluster name?
		require
			name_not_void: cn /= Void
		do
			Result := True
		end

	is_valid_feature_name (fn: STRING): BOOLEAN is
			-- Is `fn' a valid feature name?
		require
			name_not_void: fn /= Void
		do
			Result := is_valid_identifier (fn) or
					-- Is `fn' a prefix operator?
				((fn.count > Prefix_str.count + 1) and then
				 ((fn.substring_index_in_bounds (Prefix_str, 1, Prefix_str.count) = 1) and
				  (fn.item (fn.count) = '%"') and
				  (is_valid_operator (fn.substring (Prefix_str.count + 1, fn.count - Quote_str.count))))) or
				  	-- Is `fn' an infix operator?
				((fn.count > Infix_str.count + 1) and then
				 ((fn.substring_index_in_bounds (Infix_str, 1, Infix_str.count) = 1) and
				  (fn.item (fn.count) = '%"') and
				  (is_valid_operator (fn.substring (Infix_str.count + 1, fn.count - Quote_str.count)))))
		end

	is_valid_system_name (cn: STRING): BOOLEAN is
			-- Is `cn' a valid system name?
		require
			name_not_void: cn /= Void
		do
			Result := True
		end

	is_valid_identifier (s: STRING): BOOLEAN is
			-- Is `s' a valid Eiffel identifier?
		require
			name_not_void: s /= Void
		local
			i: INTEGER
			cc: CHARACTER
		do
			Result := not s.is_empty and then s.item (1).is_alpha
			from
				i := 2
			until
				i > s.count or not Result
			loop
				cc := s.item (i)
				Result := cc.is_alpha or cc.is_digit or cc = '_'
				i := i + 1
			end
		end

	is_valid_operator (op: STRING): BOOLEAN is
			-- Is `op' a valid operator name?
		require
			not_void_name: op /= Void
		local
			lcop: STRING
		do
			lcop := clone (op)
			lcop.to_lower
			Result := is_valid_free_operator (op) or else basic_operators.has (lcop)
		end

	is_valid_free_operator (op: STRING): BOOLEAN is
			-- Is `op' a valid free operator name?
		require
			not_void_name: op /= Void
		local
			i: INTEGER
			cc: CHARACTER
		do
			Result := not op.is_empty and then free_operators_start.has (op.item (1))
			from
				i := 2
			until
				i > op.count or not Result
			loop
				cc := op.item (i)
				Result := cc.is_alpha or cc.is_digit or free_operators_characters.has (cc)
				i := i + 1
			end
		ensure then
			Result implies not basic_operators.has (op);
		end

	is_constant (s: STRING): BOOLEAN is
			-- Is `s' a valid Eiffel constant?
		do
			Result := 	is_integer_constant (s) or
						is_double_constant (s) or
						is_string_constant (s) or
						is_boolean_constant (s)
		end

	is_integer_constant (s: STRING): BOOLEAN is
			-- Is `s' a valid Eiffel constant?
		do
			Result := s.is_integer
		end

	is_double_constant (s: STRING): BOOLEAN is
			-- Is `s' a valid Eiffel constant?
		do
			Result := s.is_double
		end

	is_string_constant (s: STRING): BOOLEAN is
			-- Is `s' a valid Eiffel constant?
		do
			Result := s.count >= 2 and then (s.item (1) = '%"' and s.item (s.count) = '%"')
		end

	is_boolean_constant (s: STRING): BOOLEAN is
			-- Is `s' a valid Eiffel constant?
		do
			Result := s.is_boolean
		end

	basic_operators: LIST [STRING] is
			-- List of basic Eiffel operators (lower-case).
		once
			create {ARRAYED_LIST [STRING]} Result.make (20)
			Result.extend ("not")
			Result.extend ("+")
			Result.extend ("-")
			Result.extend ("*")
			Result.extend ("/")
			Result.extend ("<")
			Result.extend (">")
			Result.extend ("<=")
			Result.extend (">=")
			Result.extend ("//")
			Result.extend ("\\")
			Result.extend ("^")
			Result.extend ("and")
			Result.extend ("or")
			Result.extend ("xor")
			Result.extend ("and then")
			Result.extend ("or else")
			Result.extend ("implies")
			Result.compare_objects
		end

	free_operators_start: LIST [CHARACTER] is
			-- List of characters that can start a free operator name.
		once
			create {ARRAYED_LIST [CHARACTER]} Result.make (4)
			Result.extend ('@')
			Result.extend ('#')
			Result.extend ('|')
			Result.extend ('&')
		end

	free_operators_characters: LIST [CHARACTER] is
			-- List of characters that can start a free operator name.
		once
			create {ARRAYED_LIST [CHARACTER]} Result.make (10)
			Result.extend ('@')
			Result.extend ('#')
			Result.extend ('|')
			Result.extend ('&')
			Result.extend ('*')
			Result.extend ('/')
			Result.extend ('-')
			Result.extend ('\')
			Result.extend ('$')
			Result.extend ('_')
			Result.extend ('!')
			Result.extend ('%'')
			Result.extend ('(')
			Result.extend (')')
			Result.extend ('+')
			Result.extend (',')
			Result.extend ('.')
			Result.extend (':')
			Result.extend (';')
			Result.extend ('<')
			Result.extend ('>')
			Result.extend ('=')
			Result.extend ('?')
			Result.extend ('[')
			Result.extend (']')
			Result.extend ('^')
			Result.extend ('`')
			Result.extend ('{')
			Result.extend ('}')
			Result.extend ('~')
		end

end -- class EIFFEL_SYNTAX_CHECKER

