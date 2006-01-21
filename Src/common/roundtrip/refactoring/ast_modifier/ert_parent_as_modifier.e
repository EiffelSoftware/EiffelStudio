indexing
	description: "Object that is responsiable for modifying a PARENT_AS for refactoriing."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_PARENT_AS_MODIFIER

inherit
	ERT_AST_MODIFIER

create
	make

feature

	make (a_parent_as: PARENT_AS; a_match_list: like match_list) is
			-- Initialize instance.
			-- `a_parent_as' is PARENT AST node on which modifications are conducted.
			-- `a_match_list' is match_list needed by roundtrip operations.
		require
			a_parent_as_not_void: a_parent_as /= Void
			a_match_list_not_void: a_match_list /= Void
		do
			parent_ast := a_parent_as
			match_list := a_match_list
			initialize
		ensure
			parent_ast_set: parent_ast = a_parent_as
			match_list_set: match_list = a_match_list
		end

feature -- Applicability

	can_apply: BOOLEAN is
			-- Can current modifier be applied?
		local
			i: INTEGER
		do
			from
				i := 1
				Result := True
			until
				i > 5 or not Result
			loop
				if inherit_clause_modifier.i_th (i).is_empty then
					if inherit_clause.i_th (i) /= Void then
						Result := inherit_clause.i_th (i).can_replace_text (match_list)
					end
				else
					Result := inherit_clause_modifier.i_th (i).can_apply
				end
				i := i + 1
			end
			if Result then
				if is_end_keyword_needed then
					if parent_ast.end_keyword = Void then
						Result := parent_ast.can_append_text (match_list)
					end
				else
					if parent_ast.end_keyword /= Void then
						Result := parent_ast.end_keyword.can_replace_text (match_list)
					end
				end
			end
		end

	apply is
			-- Apply current modifier.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > 5
			loop
				if inherit_clause_modifier.i_th (i).is_empty then
					if inherit_clause.i_th (i) /= Void then
						inherit_clause.i_th (i).replace_text ("", match_list)
					end
				else
					inherit_clause_modifier.i_th (i).apply
				end
				i := i + 1
			end

			if is_end_keyword_needed then
				if parent_ast.end_keyword = Void then
					parent_ast.append_text ("%N%T%Tend", match_list)
				end
			else
				if parent_ast.end_keyword /= Void then
					parent_ast.end_keyword.replace_text ("", match_list)
				end
			end
			applied := True
		end

feature -- Modification Register

	append_item (a_clause: INTEGER; a_text: STRING) is
			-- Register an item append in `a_clause'-th inherit clause.
			-- `a_text' is text of the item to be appended in that inherit clause.
		require
			a_clause_valid: valid_clause (a_clause)
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		do
			inherit_clause_modifier.i_th (a_clause).append_last_item (a_text)
		end

	replace_item (a_clause: INTEGER; a_index: INTEGER; a_text: STRING) is
			-- Register an item replacement of the `a_index'-th item in `a_clause'-th inherit clause
			-- by `a_text'.
		require
			a_clause_valid: valid_clause (a_clause)
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
			index_valid: valid_index (a_clause, a_index)
		do
			inherit_clause_modifier.i_th (a_clause).replace_item (a_text, a_index)
		end

	remove_item (a_clause: INTEGER; a_index: INTEGER) is
			-- Register a removal of `a_index'-th item in `a_clause'-th inherit clause.
		require
			a_clause_valid: valid_clause (a_clause)
			index_valid: valid_index (a_clause, a_index)
		do
			inherit_clause_modifier.i_th (a_clause).remove_item (a_index)
		end

feature -- Inherit clause indicators

	valid_clause (a_clause: INTEGER): BOOLEAN is
			-- Is `a_clause' valid?
		do
			Result := a_clause = rename_clause or a_clause = export_clause or a_clause = undefine_clause or a_clause = redefine_clause or a_clause = select_clause
		ensure
			Result_set: (a_clause = rename_clause or a_clause = export_clause or a_clause = undefine_clause or a_clause = redefine_clause or a_clause = select_clause) implies Result
		end

	valid_index (a_clause: INTEGER; a_index: INTEGER): BOOLEAN is
			-- Is `a_index' in `a_clause'-th inherit clause valid?
		require
			a_clause_valid: valid_clause (a_clause)
		do
			Result := True
			if inherit_clause.i_th (a_clause) /= Void then
				Result := a_index > 0 and a_index <= inherit_clause.i_th (a_clause).count
			end
		end

	rename_clause: INTEGER is 1
	export_clause: INTEGER is 2
	undefine_clause: INTEGER is 3
	redefine_clause: INTEGER is 4
	select_clause: INTEGER is 5
			-- Indicators for rename, export, undefine, redefine and select inherit clauses.

feature{NONE} -- Initialization

	initialize is
			-- Initialize
		local
			l_sep_list: ARRAYED_LIST [STRING]
			l_head_list: ARRAYED_LIST [STRING]
			i: INTEGER
			l_modifier: ERT_BASIC_EIFFEL_LIST_MODIFIER
			l_empty_modifier: ERT_EMPTY_EIFFEL_LIST_MODIFIER
		do
			create inherit_clause_modifier.make (5)
			create inherit_clause.make (5)
			create l_sep_list.make (5)
			create l_head_list.make (5)

			l_sep_list.extend (",")
			l_sep_list.extend (Void)
			l_sep_list.extend (",")
			l_sep_list.extend (",")
			l_sep_list.extend (",")

			l_head_list.extend ("%N%T%Trename")
			l_head_list.extend ("%N%T%Texport")
			l_head_list.extend ("%N%T%Tundefine")
			l_head_list.extend ("%N%T%Tredefine")
			l_head_list.extend ("%N%T%Tselect")

			inherit_clause.extend (parent_ast.internal_renaming)
			inherit_clause.extend (parent_ast.internal_exports)
			inherit_clause.extend (parent_ast.internal_undefining)
			inherit_clause.extend (parent_ast.internal_redefining)
			inherit_clause.extend (parent_ast.internal_selecting)

			from
				i := 1
			until
				i > 5
			loop
				if inherit_clause.i_th (i) = Void then
					l_empty_modifier := create{ERT_EMPTY_EIFFEL_LIST_MODIFIER}.make (attached_ast (i), False, match_list)
					l_empty_modifier.set_header (l_head_list.i_th (i))
					l_modifier := l_empty_modifier
				else
					l_modifier := create{ERT_EIFFEL_LIST_MODIFIER}.make (inherit_clause.i_th (i), match_list)
				end
				l_modifier.set_arguments (l_sep_list.i_th (i), "%T%T%T", "%N")
				inherit_clause_modifier.extend (l_modifier)
				i := i + 1
			end
		end

	attached_ast (a_clause: INTEGER): AST_EIFFEL is
			-- The AST structure appearing befor `a_index'-th inherit clause
			-- It is used when an inherit clause is present while the one before it is missing.
		local
			i: INTEGER
		do
			from
				i := a_clause - 1
				Result :=  Void
			until
				i < 1 or (Result /= Void)
			loop
				Result := inherit_clause.i_th (i)
				i := i - 1
			end
			if Result = Void then
				Result := parent_ast.type
			end
		ensure
			Result_not_void: Result /= Void
		end

	is_end_keyword_needed: BOOLEAN is
			-- Is "end" keyword needed?
			-- If no inherit presents, "end" keyword is not needed, otherwise, needed.
		do
			Result := not inherit_clause_modifier.for_all (agent {ERT_BASIC_EIFFEL_LIST_MODIFIER}.is_empty)
		end

feature{NONE} -- Implementation

	parent_ast: PARENT_AS
			-- PRAENT AST node on which modifications are conducted.

	inherit_clause_modifier: ARRAYED_LIST [ERT_BASIC_EIFFEL_LIST_MODIFIER]
			-- List of inherit clauses modifiers

	inherit_clause: ARRAYED_LIST [EIFFEL_LIST [AST_EIFFEL]]
			-- List of inherit clauses

invariant
	parent_ast_not_void: parent_ast /= Void
	inherit_clause_modifier_not_void: inherit_clause_modifier /= Void
	inherit_clause_not_void: inherit_clause /= Void

end
