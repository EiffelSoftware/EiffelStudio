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
			process
		end
		
create
	initialize

feature {NONE} -- Initialization

	initialize (s, marker: STRING; indentable: BOOLEAN; l, c, p, n: INTEGER) is
			-- Create a new Verbatim string AST node.
		require
			s_not_void: s /= Void
			marker_not_void: marker /= Void
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
		do
			string_initialize (s, l, c, p, n)
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

invariant
	verbatim_marker_not_void: verbatim_marker /= Void

end -- class VERBATIM_STRING_AS

