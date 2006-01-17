indexing
	description:
		"Combobox that lets the user select a type%N%
		%If that type has generics, displays more type selectors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			selector.change_actions.extend (agent on_selection_change)
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
			generic_type_name: STRING
			type_as_class_c: CLASS_C
			l: LIST [CLASS_I]
		do
			Result := selector.text
			if Result.is_empty or Result.index_of (' ', 1) > 0 then
					-- Nothing to do as it is empty, or either containing an invalid name
					-- or simply an anchore type `like x'.
			else
				Result.to_upper
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
					from 
						gts.start
					until
						gts.after
					loop
						generic_type_name := gts.item.code
						Result.append (generic_type_name)
						gts.forth
						if not gts.after then
							Result.append (", ")
						end
					end
					Result.append ("]")
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
	
	is_tuple: BOOLEAN
			-- Is current a tuple?

	add_generic_button: EV_BUTTON
			-- Visible when `is_tuple'.

	on_selection_change is
			-- User selected something in `selector'.
		local
			gen_count: INTEGER
			s: STRING
			l_was_tuple: BOOLEAN
		do
				-- Special treatment here because when we enter `tuple' in lower case,
				-- then the combo box select automatically the `TUPLE' item and thus
				-- causing the `on_selection_change' to be called twice. To avoid
				-- useless wipeout and creation of the generics part, we check the previous
				-- state for `is_tuple'.
			l_was_tuple := is_tuple

				-- Find what the user entered
			s := selector.text
			s.to_lower
			is_tuple := s.is_equal ("tuple")

			if is_tuple then
				if not l_was_tuple then
					generic_box.wipe_out
					generic_type_selectors.wipe_out
					generic_box.extend (new_label (" ["))
					generic_box.disable_item_expand (generic_box.last)
					add_generic_button := new_create_button
					add_generic_button.select_actions.extend (agent on_add_generic)
					generic_box.extend (add_generic_button)
					generic_box.extend (new_label ("]"))
					generic_box.disable_item_expand (generic_box.last)
				end
			else
				gen_count := generics_count (selector.text.as_upper)
				if
					generic_count /= gen_count or
					(generic_count = 0 and not generic_box.is_empty)
				then
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
				ts.selector.set_focus
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_TYPE_SELECTOR
