note
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

	initialize
			-- Fill for test purposes.
		local
			l_vbox: EV_VERTICAL_BOX
		do
			Precursor

			create l_vbox

			create generic_type_selectors.make
			create generic_box
			create selector.make_with_strings (initial_strings)

				-- Add Class Completion
			create text_completion.make (system.any_class.compiled_class, Void)
			text_completion.set_code_completable (selector)

			selector.set_completion_possibilities_provider (text_completion)
			selector.set_completing_feature (False)

			selector.set_text (selector.first.text)
			selector.set_minimum_width (150)
			l_vbox.extend (selector)
			l_vbox.disable_item_expand (selector)

			create detachable_check_box
			detachable_check_box.set_text ("Detachable?")
			l_vbox.extend (detachable_check_box)
			l_vbox.disable_item_expand (detachable_check_box)

			selector.change_actions.extend (agent on_selection_change)
			extend (l_vbox)
			disable_item_expand (last)

			create l_vbox
			l_vbox.extend (generic_box)
			l_vbox.disable_item_expand (generic_box)

			extend (l_vbox)
			disable_item_expand (last)
		end

feature -- Access

	selector: EB_CODE_COMPLETABLE_COMBO_BOX
			-- Text box with list of possible types.

	text_completion: EB_NORMAL_COMPLETION_POSSIBILITIES_PROVIDER

	generic_type_selectors: LINKED_LIST [EB_TYPE_SELECTOR]
			-- All type selectors in `generic_box'.

	detachable_check_box: EV_CHECK_BUTTON
			-- Check box for determining if types should be detachable.

	code: STRING
			-- Type currently selected by user.
			-- Including generics.
		local
			gts: like generic_type_selectors
			generic_type_name: STRING
--			type_as_class_c: CLASS_C
--			l: LIST [CLASS_I]
		do
			Result := selector.text
			if Result.is_empty or Result.index_of (' ', 1) > 0 then
					-- Nothing to do as it is empty, or either containing an invalid name
					-- or simply an anchore type `like x'.
			else
				Result.to_upper
				if detachable_check_box.is_selected and then detachable_check_box.is_sensitive then
					Result.prepend ("detachable ")
				end
--				if expanded_needed then
--					l := Universe.compiled_classes_with_name (Result)
--					if not l.is_empty then
--						type_as_class_c := l.first.compiled_class
--						if not type_as_class_c.is_basic and not type_as_class_c.is_expanded then
--							Result.prepend ("expanded ")
--						end
--					else
--						Result.prepend ("expanded ")
--					end
--				end
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

	valid_content: BOOLEAN
			-- Is user input valid for code generation?
		local
			t: STRING
		do
			t := selector.text
			Result := t /= Void and then not t.is_empty
		end

feature -- Element change

	set_from_other (other: like Current)
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

	on_selection_change
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
			s.to_upper

				-- Make sure that `s' is a valid class name in selector.
			if s.has_substring (" [") then
				s := s.substring (1, (s.index_of (' ', 1) - 1).max (1))
				selector.set_text (s)
			end

			is_tuple := s.is_equal ("TUPLE")

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
			elseif not s.is_empty then
				gen_count := generics_count (s)
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
			update_detachable_status (s)
		end

	fill_generic_box
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
					if supplier_type /= Void then
						ts.set_initial_types (client_type, supplier_type)
						ts.update_list_strings (False)
					end

					-- ts.set_constraint (...)
					generic_type_selectors.extend (ts)
					generic_box.extend (ts)
					i := i + 1
				end
				generic_box.extend (new_label ("]"))
				generic_box.disable_item_expand (generic_box.last)
			end
		end

	update_detachable_status (a_class_name: STRING)
			-- Update detachable status for `a_class_name'.
		local
			l_class_i: CLASS_I
			l_is_expanded: BOOLEAN
		do
			if a_class_name /= Void and then not a_class_name.is_empty then
				l_class_i := class_i_by_name (a_class_name)
			end
			if l_class_i /= Void then
				l_is_expanded := l_class_i.compiled_class /= Void and then l_class_i.compiled_class.is_expanded
			end
			if l_is_expanded then
				detachable_check_box.disable_sensitive
			else
				detachable_check_box.enable_sensitive
			end
		end

	generics_count (a_class_name: STRING): INTEGER
			-- Number of generics for `a_class_name'.
		require
			a_class_name_valid: a_class_name /= Void
			not_tuple: not is_tuple
		local
			class_i: CLASS_I
			class_c: CLASS_C
			l_class_text: STRING
		do
			l_class_text := a_class_name.substring (a_class_name.index_of (' ', 1) + 1, a_class_name.count)
			if not l_class_text.is_empty then
				class_i := class_i_by_name (l_class_text)
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
		end

	on_add_generic
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

	initial_strings: ARRAY [STRING]
			-- Initial list items.
			--| FIXME Get favorites, previously entered names, etc.
		once
			Result := <<
				"ANY",
				"BOOLEAN",
				"CHARACTER_8",
				"NATURAL_32",
				"INTEGER_32",
				"REAL_32",
				"REAL_64",
				"STRING_8",
				"STRING_32",
				"like Current",
				"ARRAYED_LIST [..]",
				"LINKED_LIST [..]",
				"HASH_TABLE [..]",
				"FUNCTION [..]",
				"PROCEDURE [..]",
				"POINTER",
				"TUPLE [..]"
			>>
		end

feature {EB_FEATURE_EDITOR, EB_TYPE_SELECTOR} -- Access

	client_type, supplier_type: ES_CLASS

	set_initial_types (a_client_type, a_supplier_type: ES_CLASS)
		do
			client_type := a_client_type
			supplier_type := a_supplier_type
		end

	update_list_strings (a_initial_list: BOOLEAN)
			-- Update types listed in selector.
		local
			l_list: ARRAY [STRING_8]
			i: INTEGER
		do
			l_list := strings_from_type (client_type, supplier_type)
			if a_initial_list then
					-- Initial setting of list so we don't need to block the change actions.
				selector.set_strings (l_list)
			else
				selector.change_actions.block
				selector.set_strings (l_list)
					-- Select the first non generic item in the list.
				from
					i := 1
				until
					i > l_list.count
				loop
					if l_list [i].index_of ('[', 1) = 0 then
						selector.set_text (l_list [i])
						i := l_list.count
					end
					i := i + 1
				end
				selector.change_actions.resume
			end
		end

	strings_from_type (a_client_type, a_supplier_type: ES_CLASS): ARRAY [STRING]
			-- Return default type selector strings for `a_client_type' and `a_supplier_type'.
		local
			l_list: ARRAYED_LIST [STRING]
			l_str: STRING
		do
			create l_list.make (2 + initial_strings.count)


			l_str := a_supplier_type.name.string
			if generics_count (l_str) > 0 then
				l_str.append (" [..]")
			end
			l_list.extend (l_str)

			if a_client_type /= a_supplier_type then
				l_str := a_client_type.name.string
				if generics_count (l_str) > 0 then
					l_str.append (" [..]")
				end
				l_list.extend (l_str)
			end
			l_list.fill (initial_strings)
			Result := l_list.to_array
		end

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state.
		do
			Result := (
				not is_homogeneous and
				border_width = 0 and
				padding = 0
			)
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_TYPE_SELECTOR
