indexing
	description: "Node for verbatim strings. "
	date: "$Date$"
	revision: "$Revision$"

class
	VERBATIM_STRING_AS

inherit
	STRING_AS
		rename
			initialize as string_initialize
		redefine
			process,
			simple_format
		end

feature {AST_FACTORY} -- Initialization

	initialize (s, marker: STRING; indentable: BOOLEAN) is
			-- Create a new Verbatim string AST node.
		require
			s_not_void: s /= Void
			marker_not_void: marker /= Void
		do
			string_initialize (s)
			verbatim_marker := marker
			is_indentable := indentable
		ensure
			value_set: value = s
			verbatim_marker_set: verbatim_marker = marker
			is_indentable_set: is_indentable = indentable
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_verbatim_string_as (Current)
		end

feature -- Properties

	verbatim_marker: STRING
			-- Delimiter used to mark the beginning and end of the
			-- verbatim string.
			-- If `empty', no marker was used.

	is_indentable: BOOLEAN
			-- Is verbatim string indentable, i.e. can all lines be prepended
			-- by the same white space without changing string value?
			-- Normally, indentable verbatim string is enclosed in '[' and ']'.
			-- Non-indentable verbatim string is enclosed in '{' and '}'.

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if is_once_string then
				ctxt.put_text_item (ti_once_keyword)
				ctxt.put_space
			end
			ctxt.put_string_item ("%"" + verbatim_marker)
			if is_indentable then
				ctxt.text.add_char ('[')
			else
				ctxt.text.add_char ('{')
			end
			ctxt.put_new_line
			if not value.is_empty then
				append_format_multilined (value.twin, is_indentable, ctxt)
			end
			if is_indentable then
				ctxt.put_string_item ("]")
			else
				ctxt.put_string_item ("}")
			end
			ctxt.text.add_string (verbatim_marker + "%"")
		end

feature {NONE} -- Implementation

	append_format_multilined (s: STRING; indentable: BOOLEAN; ctxt: FORMAT_CONTEXT) is
			-- Format on a new line, breaking at every newline.
			-- Do not indent if `indentable' is false.
			-- If `in_index', try to find meaningful substrings (URLs, ...).
			-- Display %N... characters as they were typed.
		require
			string_not_void: s /= Void
			string_not_empty: not s.is_empty
			context_not_void: ctxt /= Void
		local
			st: STRUCTURED_TEXT
			in_index: BOOLEAN
			sb: STRING
			l: INTEGER
			n: INTEGER
			m: INTEGER
		do
			st := ctxt.text
			in_index := ctxt.in_indexing_clause
			if indentable then
				ctxt.indent
			end
			from
				l := s.count + 1
				n := 1
			until
				n > l
			loop
				m := s.index_of (carriage_return_char, n)
				if m = 0 then
					m := l
				end
				sb := s.substring (n, m - 1)
				if indentable then
					ctxt.put_string_item (sb)
				elseif in_index then
					st.add_indexing_string (sb)
				else
					st.add_string (sb)
				end
				ctxt.put_new_line
				n := m + 1
			end
			if indentable then
				ctxt.exdent
			end
		end

end -- class VERBATIM_STRING_AS

