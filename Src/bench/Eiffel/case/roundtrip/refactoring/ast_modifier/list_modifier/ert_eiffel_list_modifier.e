indexing
	description: "Object to modify an EIFFEL_LIST AST node"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_EIFFEL_LIST_MODIFIER

inherit
	ERT_BASIC_EIFFEL_LIST_MODIFIER

create
	make

feature{NONE} -- Implementation

	make (a_eif_list: like eiffel_list; a_match_list: like match_list) is
			-- Initialization instance.
		require
			a_eif_list_not_void: a_eif_list /= Void
			a_eif_list_not_empty: not a_eif_list.is_empty
			a_match_list_not_void: a_match_list /= Void
		do
			set_arguments ("", "", "")
			eiffel_list := a_eif_list
			match_list := a_match_list
			initialize_modifier_list
			counter := 1
		end

feature -- Modification apply

	compute_modification is
			-- Compute modification.
		local
			i: INTEGER
			l_cnt: INTEGER
			l_modifier: ERT_LIST_ITEM_MODIFIER
		do
			from
				i := 1
				l_cnt := modifier_list.count
			until
				i > l_cnt
			loop
				l_modifier := modifier_list.i_th (i)
				if has_separator then
					if l_modifier.is_removed then
						l_modifier.set_is_separator_needed (False)
					else
						if is_last_item (i) then
							l_modifier.set_is_separator_needed (False)
						else
							l_modifier.set_is_separator_needed (True)
						end
					end
				else
					l_modifier.set_is_separator_needed (False)
				end
				i := i + 1
			end
		end

	apply is
			-- Apply all registered modifications
		local
			i: INTEGER
			l_cnt: INTEGER
		do
			modifier_list.do_all (agent {ERT_LIST_ITEM_MODIFIER}.set_arguments (separator, leading_text, trailing_text))
			original_item_list.do_all (agent {ERT_EXISTING_ITEM_MODIFIER}.apply)
			from
				i := 1
				l_cnt := modifier_list.count
			until
				i > l_cnt
			loop
				if not modifier_list.i_th (i).is_original_item then
					modifier_list.i_th (i).apply
				end
				i := i + 1
			end
			applied := True
		end

	can_apply: BOOLEAN is
			-- Can all registered modifications be applied?
		local
			i: INTEGER
		do
			compute_modification
			Result := modifier_list.for_all (agent {ERT_LIST_ITEM_MODIFIER}.can_apply)
		end

feature -- Modifier register

	prepend_item (item_text: STRING; i: INTEGER) is
			-- Register a prepend operation on `i'-th item in `eiffel_list'.
		require else
			i_valid: i > 0 and i <= eiffel_list_count
		local
			l_modifier: ERT_PREPENDED_ITEM_MODIFIER
		do
			create l_modifier.make (eiffel_list.i_th (i), item_text, i, counter, match_list)
			counter := counter + 1
			modifier_list.extend (l_modifier)
		end

	append_item (item_text: STRING; i: INTEGER) is
			-- Register an append operation on `i'-th item in `eiffel_list'.
		require else
			i_valid: i > 0 and i <= eiffel_list_count
		local
			l_modifier: ERT_APPENDED_ITEM_MODIFIER
			l_attached_ast: AST_EIFFEL
		do
			if original_item_list.i_th (i).separator_ast /= Void then
				l_attached_ast := original_item_list.i_th (i).separator_ast
			else
				l_attached_ast := original_item_list.i_th (i).item_ast
			end
			create l_modifier.make (l_attached_ast, item_text, i, counter, match_list)
			counter := counter + 1
			modifier_list.extend (l_modifier)
		end

	replace_item (item_text: STRING; i: INTEGER) is
			-- Register a replace operation on `i'-th item in `eiffel_list'.
		require else
			i_valid: i > 0 and i <= eiffel_list_count
		local
			l_modifier: ERT_EXISTING_ITEM_MODIFIER
		do
			l_modifier := original_item_list.i_th (i)
			l_modifier.set_text (item_text)
		end

	remove_item (i: INTEGER) is
			-- Register a remove operation on `i'-th item in `eiffel_list'.	
		require else
			i_valid: i > 0 and i <= eiffel_list_count
		local
			l_modifier: ERT_EXISTING_ITEM_MODIFIER
		do
			l_modifier := original_item_list.i_th (i)
			l_modifier.set_text ("")
		end

	prepend_first_item (item_text: STRING) is
			-- Register a prepend operation on the first item in `eiffel_list'.
		do
			prepend_item (item_text, 1)
		end

	append_last_item (item_text: STRING) is
			-- Register a append operation on the last item in `eiffel_list'.
		do
			append_item (item_text, eiffel_list.count)
		end

feature -- Access

	is_last_item (i: INTEGER): BOOLEAN is
			-- Is  `i'-th item in `modifier_list' last item?
		local
			j: INTEGER
			n: INTEGER
		do
			from
				j := i + 1
				n := modifier_list.count
				Result := True
			until
				j > n or not Result
			loop
				Result := modifier_list.i_th (j).is_removed
				j := j + 1
			end
		end

	is_empty: BOOLEAN is
			-- Is current empty?
		do
			Result := modifier_list.for_all (agent {ERT_LIST_ITEM_MODIFIER}.is_removed)
		end

feature -- Eiffel list

	eiffel_list: EIFFEL_LIST [AST_EIFFEL]
			-- EIFFEL_LIST AST node to be modified

	eiffel_list_count: INTEGER is
			-- Count of `eiffel_list'.
		do
			Result := eiffel_list.count
		end

feature{NONE} -- Initialization

	initialize_modifier_list is
			-- Initialize.
		local
			i: INTEGER
			l_cnt: INTEGER
			l_modifier: ERT_EXISTING_ITEM_MODIFIER
			l_item_ast: AST_EIFFEL
			l_separator_ast: AST_EIFFEL
			l_has_separator: BOOLEAN
		do
			l_cnt := eiffel_list_count
			create original_item_list.make (l_cnt)
			create modifier_list.make
			l_has_separator := eiffel_list.separator_list /= Void and then not eiffel_list.separator_list.is_empty
			from
				i := 1
			until
				i > l_cnt
			loop
				l_item_ast := eiffel_list.i_th (i)
				if l_has_separator and i < l_cnt then
					l_separator_ast := eiffel_list.separator_list.i_th (i)
				else
					l_separator_ast := Void
				end
				l_modifier := create {ERT_EXISTING_ITEM_MODIFIER}.make (l_item_ast, l_separator_ast, i, counter, match_list)
				counter := counter + 1
				original_item_list.extend (l_modifier)
				modifier_list.extend (l_modifier)
				i := i + 1
			end
		end

feature{NONE} -- Implementation

	modifier_list: SORTED_TWO_WAY_LIST [ERT_LIST_ITEM_MODIFIER]
			-- List of regisitered modifiers

	original_item_list: ARRAYED_LIST [ERT_EXISTING_ITEM_MODIFIER]
			-- List of original items

	counter: INTEGER
			-- Internal counter for modifier index

invariant
	eiffel_list_not_void: eiffel_list /= Void

end
