indexing
	description:
		"Combobox that lets the user select a type%N%
		%If that type has generics, displays more type selectors."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TYPE_SELECTOR

inherit
	EV_HORIZONTAL_BOX
		redefine
			initialize,
			is_in_default_state
		end

	FEATURE_WIZARD_COMPONENT
		undefine
			default_create, is_equal, copy
		end

	SHARED_API_ROUTINES
		undefine
			default_create, is_equal, copy
		end

feature {NONE} -- Initialization

	initialize is
			-- Fill for test purposes.
		do
			Precursor
			create generic_type_selectors.make
			create generic_box
			create selector.make_with_strings (initial_strings)
			selector.set_text ("INTEGER")
			selector.set_minimum_width (100)
			extend (selector)
			extend (generic_box)
			disable_item_expand (generic_box)
			selector.change_actions.extend (~on_selection_change)
			expanded_needed := False
		end

feature -- Access

	selector: EV_COMBO_BOX
			-- Text box with list of possible types.

	generic_type_selectors: LINKED_LIST [EB_TYPE_SELECTOR]
			-- All type selectors in `generic_box'.

	code: STRING is
			-- Type currently selected by user.
			-- Including generics.
		local
			gts: like generic_type_selectors
			type_as_class_c: CLASS_C
			l: LINKED_LIST [CLASS_I]
		do
			Result := selector.text
			if Result = Void then
				create Result.make (0)
			else
				if expanded_needed then
					l := Universe.compiled_classes_with_name (Result)
					if not l.is_empty then
						type_as_class_c := l.first.compiled_class
						if not type_as_class_c.is_basic and not type_as_class_c.is_expanded then
							Result.prepend ("expanded ")
						end
					else
						Result.prepend ("expanded ")
					end
				end
				gts := generic_type_selectors
				if not gts.is_empty then
					Result.append (" [")
					from gts.start until gts.after loop
						Result.append (gts.item.code)
						gts.forth
						if not gts.after then
							Result.append (", ")
						end
					end
					Result.append ("]")
				elseif is_tuple then
					Result.append (" []")
				end
			end
		end

feature -- Status report

	valid_content: BOOLEAN is
			-- Is user input valid for code generation?
		local
			t: STRING
		do
			t := selector.text
			Result := t /= Void and then not t.is_empty
		end

	is_tuple: BOOLEAN is
			-- Is the selected type TUPLE?
			-- If yes, need to create dynamic length
			-- `generic_selectors'-list.
		local
			s: STRING
		do
			s := selector.text
			if s /= Void then
				s.to_lower
				Result := s.is_equal ("tuple")
			end
		end

	expanded_needed: BOOLEAN
			-- Does return type have to be expanded?

feature {EB_QUERY_EDITOR} -- Status setting

	enable_expanded_needed is
			-- Set `expanded_needed' to `True'.
		do
			expanded_needed := True
		ensure
			expanded_needed_set: expanded_needed = True
		end

feature -- Element change

	set_from_other (other: like Current) is
			-- Set with same type as `other'.
		local
			gts: LINKED_LIST [EB_TYPE_SELECTOR]
			tmpstr: STRING
		do
			tmpstr := other.selector.text
			if not tmpstr.is_empty then
				selector.set_text (tmpstr)
			else
				selector.remove_text
			end
			gts := other.generic_type_selectors
			from gts.start until gts.after loop
				if gts.index > generic_type_selectors.count then
					on_add_generic
				end
				generic_type_selectors.i_th (gts.index).set_from_other (gts.item)
				gts.forth
			end
			if other.expanded_needed then
				enable_expanded_needed
			end
		end

feature {NONE} -- Implementation

	constraint: STRING
			-- To be implemented. (Not of type STRING anyway)
			-- Generic constraint type.

	generic_box: EV_HORIZONTAL_BOX
			-- Container of generic selectors,
			-- enclosed by square brackets.

	generic_count: INTEGER
			-- Current number of generic parameters.

	add_generic_button: EV_BUTTON
			-- Visible when `is_tuple'.

	on_selection_change is
			-- User selected something in `selector'.
		local
			gen_count: INTEGER
		do
			if is_tuple then
				generic_box.wipe_out
				generic_type_selectors.wipe_out
				generic_box.extend (new_label (" ["))
				generic_box.disable_item_expand (generic_box.last)
				add_generic_button := new_create_button
				add_generic_button.select_actions.extend (~on_add_generic)
				generic_box.extend (add_generic_button)
				generic_box.extend (new_label ("]"))
				generic_box.disable_item_expand (generic_box.last)
			else
				if selector.text /= Void then
					gen_count := generics_count (selector.text)
				else
					gen_count := 0
				end
				if generic_count /= gen_count 
					or (generic_count = 0 and not generic_box.is_empty) then
						generic_count := gen_count
						generic_box.wipe_out
						generic_type_selectors.wipe_out
						fill_generic_box
				end
			end
		end

	fill_generic_box is
			-- Fill `generic_box' with `generic_count' type selectors.
		local
			i: INTEGER
			ts: EB_TYPE_SELECTOR
		do
			if generic_count > 0 then
				generic_box.extend (new_label (" ["))
				generic_box.disable_item_expand (generic_box.last)
				from i := 1 until i > generic_count loop
					if i > 1 then
						generic_box.extend (new_label (", "))
					end
					create ts
					-- ts.set_constraint (...)
					generic_type_selectors.extend (ts)
					generic_box.extend (ts)
					i := i + 1
				end
				generic_box.extend (new_label ("]"))
				generic_box.disable_item_expand (generic_box.last)
			end
		end

	generics_count (a_class_name: STRING): INTEGER is
			-- Number of generics for `a_class_name'.
		require
			a_class_name_valid: a_class_name /= Void
			not_tuple: not is_tuple
		local
			class_i: CLASS_I
			class_c: CLASS_C
		do
			class_i := class_i_by_name (a_class_name)
			if class_i /= Void then
				class_c := class_i.compiled_class
				if class_c /= Void then
					if class_c.generics /= Void then
						Result := class_c.generics.count
					end
				else
					--| FIXME parse class text and find it!
				end
			end
		end

	on_add_generic is
			-- Type is TUPLE and user clicked on "*".
		local
			ts: EB_TYPE_SELECTOR
		do
			generic_box.start
			generic_box.search (add_generic_button)
			if not generic_box.exhausted then
				if not generic_type_selectors.is_empty then
					generic_box.put_left (new_label (", "))
					generic_box.disable_item_expand (generic_box.last)
				end
				create ts
				generic_type_selectors.extend (ts)
				generic_box.put_left (ts)
			end
		end

	initial_strings: ARRAY [STRING] is
			-- Initial list items.
			--| FIXME Get favorites, previously entered names, etc.
		once
			Result := <<
				"ARRAY",
				"BOOLEAN",
				"CHARACTER",
				"DOUBLE",
				"FUNCTION",
				"INTEGER",
				"LIST",
				"PROCEDURE",
				"REAL",
				"STRING",
				"TUPLE"
			>>
		end

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := (
				not is_homogeneous and
				border_width = 0 and
				padding = 0			
			)
		end

end -- class EB_TYPE_SELECTOR
