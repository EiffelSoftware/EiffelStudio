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

	initialize (s, marker: STRING) is
			-- Create a new Verbatim string AST node.
		require
			s_not_void: s /= Void
			marker_not_void: marker /= Void
		do
			string_initialize (s)
			verbatim_marker := marker
		ensure
			value_set: value = s
			verbatim_marker_set: verbatim_marker = marker
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

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if is_once_string then
				ctxt.put_text_item (ti_once_keyword)
				ctxt.put_space
			end
			ctxt.put_string_item ("%"" + verbatim_marker + "[")
			append_format_multilined (value.twin, ctxt.text, ctxt.in_indexing_clause)
			ctxt.new_line
			ctxt.put_string_item ("]" + verbatim_marker + "%"")
		end

feature {NONE} -- Implementation

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

end -- class VERBATIM_STRING_AS

