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

feature -- Attributes

	verbatim_marker: STRING
			-- Delimiter used to mark the beginning and end of the
			-- verbatim string.
			-- If `empty', no marker was used.

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_string_item ("%"" + verbatim_marker + "[")
--			append_format_multilined (clone (value), ctxt.text, ctxt.in_indexing_clause)
--			ctxt.new_line
--			ctxt.put_string_item ("]" + verbatim_marker + "%"")
--		end

end -- class VERBATIM_STRING_AS

