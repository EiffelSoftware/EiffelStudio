indexing
	description: "Abstract description of a parent. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class
	PARENT_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent, location
		end

feature {AST_FACTORY} -- Initialization

	initialize (t: like type; rn: like renaming; e: like exports;
		u: like undefining; rd: like redefining; s: like selecting) is
			-- Create a new PARENT AST node.
		require
			t_not_void: t /= Void
		do
			type := t
			renaming := rn
			exports := e
			undefining := u
			redefining := rd
			selecting := s
		ensure
			type_set: type = t
			renaming_set: renaming = rn
			exports_set: exports = e
			undefining_set: undefining = u
			redefining_set: redefining = rd
			selecting_set: selecting = s
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_parent_as (Current)
		end

feature -- Attributes

	type: CLASS_TYPE_AS
			-- Parent type

	renaming: EIFFEL_LIST [RENAME_AS]
			-- Rename clause

	exports: EIFFEL_LIST [EXPORT_ITEM_AS]
			-- Exports for parent

	redefining: EIFFEL_LIST [FEATURE_NAME]
			-- Redefining clause

	undefining: EIFFEL_LIST [FEATURE_NAME]
			-- Undefine clause

	selecting: EIFFEL_LIST [FEATURE_NAME]
			-- Select clause

	location: TOKEN_LOCATION
			-- Index in class text.

feature {EIFFEL_PARSER} -- Element change

	set_location (l: like location) is
			-- Set `location' to `l'.
		require
			l_not_void: l /= Void
		do
			location := clone (l)
		ensure
			location_set: location.is_equal (l)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (exports, other.exports) and
				equivalent (redefining, other.redefining) and
				equivalent (renaming, other.renaming) and
				equivalent (selecting, other.selecting) and
				equivalent (type, other.type) and
				equivalent (undefining, other.undefining)
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt : FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		local
--			end_to_print: BOOLEAN
--		do
--				-- There is no source as it is a parent description and target is
--				-- current analyzed class.
--			ctxt.set_classes (Void, ctxt.class_c)
--			ctxt.format_ast (type)
--			if renaming /= Void then
--				format_clause (ctxt, ti_Rename_keyword, renaming)
--				end_to_print := true
--			end
--			if exports /= Void then
--				format_clause (ctxt, ti_Export_keyword, exports)
--				end_to_print := true
--			end
--			if undefining /= Void then
--				format_clause (ctxt, ti_Undefine_keyword, undefining)
--				end_to_print := true
--			end
--			if redefining /= Void then
--				format_clause (ctxt, ti_Redefine_keyword, redefining)
--				end_to_print := true
--			end
--			if selecting /= Void then
--				format_clause (ctxt, ti_Select_keyword, selecting)
--				end_to_print := true
--			end
--			if end_to_print then
--				ctxt.indent
--				ctxt.new_line
--				ctxt.put_text_item (ti_End_keyword)
--				ctxt.exdent
--			end
--		end
--
--feature {NONE} -- Implementation
--
--	format_clause (ctxt: FORMAT_CONTEXT; a_keyword: KEYWORD_TEXT; a_clause: EIFFEL_LIST [AST_EIFFEL]) is
--			-- Format one of rename, export, undefine, redefine or select clauses.
--		do
--			ctxt.indent
--			ctxt.new_line
--			ctxt.put_text_item (a_keyword)
--			ctxt.indent
--			ctxt.new_line
--			ctxt.set_separator (ti_Comma)
--			ctxt.set_new_line_between_tokens
--			ctxt.format_ast (a_clause)
--			ctxt.exdent
--			ctxt.exdent
--		end

feature -- Status report

	is_effecting: BOOLEAN is
			-- Is this parent clause redefining or undefining
			-- one or more features?
		do
			Result := undefining /= Void and then not undefining.is_empty
				and then redefining /= Void and then not redefining.is_empty
		end

feature {NONE} -- Implementation

	Redef: INTEGER is 1
	Undef: INTEGER is 2
	Selec: INTEGER is 3

end -- class PARENT_AS
