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
	
	PART_COMPARABLE

	CHARACTER_ROUTINES

feature {AST_FACTORY} -- Initialization

	initialize (s: STRING) is
			-- Create a new STRING AST node.
		require
			s_not_void: s /= Void
		do
			value := s
		ensure
			value_set: value = s
		end

feature -- Properties

	value: STRING
			-- Real string value.

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := value < other.value
		end

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
				-- `value' cannot be Void
			Result := value.is_equal (other.value)
		end

feature -- Type check and byte code

	value_i: STRING_VALUE_I is
			-- Interface value
		do
			!! Result
			Result.set_str_val (value)
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

	byte_node: STRING_B is
			-- Associated byte code
		do
			!! Result
			Result.set_value (value)
		end

feature -- Output

	string_value: STRING is
			-- Formatted value.
		do
			Result := eiffel_string (value)
			Result.precede ('"')
			Result.extend ('"')
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string_item (string_value)
		end

feature {AST_EIFFEL, DOCUMENTATION_ROUTINES} -- Output

	append_multilined (s: STRING; st: STRUCTURED_TEXT; ind: INTEGER) is
			-- Format on a new line, breaking at every newline.
			-- Indent `ind' times.
		local
			sb: STRING
			n: INTEGER
		do
			st.add_new_line
			st.add_indents (ind)
			n := s.substring_index ("%%N", 1)
			st.add_indexing_string (s.substring (1, n + 1) + "%%")
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
				sb := s.substring (1, n)
				s.remove_head (n)
				st.add_indexing_string ("%%" + sb + "%%")
				st.add_new_line
				st.add_indents (ind)
				n := s.substring_index ("%%N", 1)
			end
			st.add_indexing_string ("%%" + s)
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

	append_format_multilined (s: STRING; st: STRUCTURED_TEXT; in_index: BOOLEAN) is
			-- Format on a new line, breaking at every newline.
			-- Do not indent.
			-- If `in_index', try to find meaningful substrings (URLs, ...).
			-- Display %N... characters as they were typed.
		require
			valid_string: s /= Void
			valid_text: st /= Void
		local
			sb: STRING
			n: INTEGER
		do
				-- Forget differences between platforms.
			s.prune_all ('%R')
			from
				n := s.index_of (carriage_return_char, 1)
				if not s.is_empty then
					st.add_new_line
				end
			until
				n = 0
			loop
				sb := s.substring (1, n - 1)
				s.remove_head (n)
				if not sb.is_empty then
					if in_index then
						st.add_indexing_string (sb)
					else
						st.add_string (sb)
					end
				end
				st.add_new_line
				n := s.index_of (carriage_return_char, 1)
			end
			if not s.is_empty then
				if in_index then
					st.add_indexing_string (s)
				else
					st.add_string (s)
				end
			end
		end

feature {INFIX_AS, DOCUMENTATION_ROUTINES} -- Status setting

	set_value (s: STRING) is
		do
			value := s
		end

	carriage_return_char: CHARACTER is '%N'

end -- class STRING_AS
