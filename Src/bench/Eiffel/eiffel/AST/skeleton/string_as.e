indexing

	description: "Node for string constants. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class STRING_AS

inherit
	ATOMIC_AS
		redefine
			type_check, byte_node, value_i, is_equivalent
		end
	
	LEAF_AS
	
	CHARACTER_ROUTINES

create
	initialize

feature {NONE} -- Initialization

	initialize (s: STRING; l, c, p: INTEGER) is
			-- Create a new STRING AST node.
		require
			s_not_void: s /= Void
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
		do
			value := s
			set_position (l, c, p, s.count)
		ensure
			value_set: value = s
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_string_as (Current)
		end

feature -- Properties

	value: STRING
			-- Real string value.
			
	is_once_string: BOOLEAN
			-- Is current preceded by `once' keyword?

feature -- Settings

	set_is_once_string (v: like is_once_string) is
			-- Set `is_once_string' with `v'.
		do
			is_once_string := v
		ensure
			is_once_string_set: is_once_string = v
		end
		
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
				-- `value' cannot be Void
			Result := is_once_string = other.is_once_string and then value.is_equal (other.value)
		end

feature -- Type check and byte code

	value_i: STRING_VALUE_I is
			-- Interface value
		do
			create Result
			Result.set_string_value (value)
		end

	type_check is
			-- Type check a string constant
		do
				-- Update the type stack
			context.put (String_type)
		end

	String_type: CL_TYPE_A is
			-- Actual string type
		once
			Result := System.string_class.compiled_class.actual_type
		end

	byte_node: EXPR_B is
			-- Associated byte code
		do
			if is_once_string then
				context.add_once_manifest_string
				create {ONCE_STRING_B} Result.make (value, context.once_manifest_string_number)
			else
				create {STRING_B} Result.make (value)
			end
		end

feature -- Output

	string_value: STRING is
			-- Formatted value.
		do
			Result := eiffel_string (value)
			Result.precede ('"')
			Result.extend ('"')
		end

feature {DOCUMENTATION_ROUTINES} -- Output

	append_nice_multilined (s: STRING; st: STRUCTURED_TEXT; ind: INTEGER) is
			-- Format on a new line, breaking at every newline.
			-- Indent `ind' times.
			-- Prune all '%' and special characters.
		local
			sb: STRING
			n: INTEGER
		do
			st.add_new_line
			st.add_indents (ind)
			s.replace_substring_all ("%%T", "")
			s.replace_substring_all ("%%R", "")
			n := s.substring_index ("%%N", 1)
			st.add_indexing_string (s.substring (1, n - 1))
			st.add_new_line
			st.add_indents (ind)
			s.remove_head (n + 1)
			from
				n := s.substring_index ("%%N", 1)
			until
				n = 0
			loop
				if n = 0 then
					n := s.count
				else
					n := n + 1
				end
				sb := s.substring (1, n - 2)
				s.remove_head (n)
				st.add_indexing_string (sb)
				st.add_new_line
				st.add_indents (ind)
				n := s.substring_index ("%%N", 1)
			end
			st.add_indexing_string (s)
		end

feature {INFIX_PREFIX_AS, DOCUMENTATION_ROUTINES} -- Status setting

	set_value (s: STRING) is
		do
			value := s
		end

	carriage_return_char: CHARACTER is '%N'

invariant
	value_not_void: value /= Void

end -- class STRING_AS
