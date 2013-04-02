note
	description:
		"Wizard to create attributes and insert them in a specific%N%
		%feature clause. Also provides field for invariant and option%N%
		%to automatically generate set-feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ATTRIBUTE_EDITOR

inherit
	EB_QUERY_EDITOR
		redefine
			initialize,
			is_attribute
		end

	EB_ASSERTION_GENERATOR
		undefine
			default_create, is_equal, copy
		end

feature {NONE} -- Initialization

	initialize
			-- Create as attribute wizard.
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			tab: EV_CELL
		do
			Precursor
			set_border_width (layout_constants.default_border_size)
			create feature_clause_selector
			extend (feature_clause_selector)
			disable_item_expand (feature_clause_selector)

			create tab
			tab.set_minimum_height (10)
			extend (tab)
			disable_item_expand (tab)



			create hb
			hb.extend (new_tab (1))
			hb.disable_item_expand (hb.last)
			create feature_name_field.make_with_text ("new")
			feature_name_field.change_actions.force_extend (agent on_declaration_change)


			hb.extend (feature_name_field)
			hb.extend (new_label (": "))
			hb.disable_item_expand (hb.last)

			create vb
			vb.extend (hb)
			vb.disable_item_expand (vb.last)
			vb.extend (create {EV_CELL})

			create hb
			hb.extend (vb)

			create type_selector
			type_selector.selector.change_actions.extend (agent on_declaration_change)
			hb.extend (type_selector)

			extend (hb)
			disable_item_expand (hb)
			add_comment_field

			add_label ("invariant", 0)
			create invariant_field
			invariant_field.set_text (Pc_none)
			invariant_field.focus_in_actions.extend (agent on_invariant_focus_gain)
			add_indented (invariant_field, 1, False)

			create tab
			tab.set_minimum_height (10)
			extend (tab)
			disable_item_expand (tab)

			add_setter
		end


feature -- Access

	code: STRING_32
			-- Current text of the feature in the wizard.
		do
			create Result.make (100)
			Result.append ({STRING_32} "%T" + feature_name_field.text + ": " + type_selector.code)
			if assigner_check_box.is_selected then
				Result.append ({STRING_32} " assign " + setter_text.text)
			end
			Result.append ("%N")
			Result.append (comments_code)

			if type_selector.detachable_check_box.is_sensitive and then not type_selector.detachable_check_box.is_selected then
				Result.append ({STRING_32} "%T%Tattribute check False then end end" + " --| Remove line when `" + feature_name_field.text + "' is initialized in creation procedure.%N")
			end
			Result.append ("%N")
		end


	arguments_code: STRING_32
			-- <Precursor>
		do
			-- No arguments needed for attribute so return Void
		end

	precondition: STRING_32
			-- Selected precondition for set-procedure.
		local
			f_name: STRING_32
		do
			Result := invariant_part
			if Result /= Void then
				f_name := feature_name_field.text
				Result.replace_substring_all (f_name, name_preposition + f_name)
			end
		end

	invariant_part: STRING_32
			-- Invariant for feature. Void if none.
		do
			Result := invariant_field.text
			if Result /= Void then
				if Result.is_empty or Result.is_equal (pc_None) then
					Result := Void
				end
			end
		end

feature -- Element change

	set_name_number (a_number: INTEGER)
			-- Assign `a_number' to `name_number'.
		do
			name_number := a_number
			if name_number /= 0 then
				feature_name_field.set_text	("new_" + name_number.out)
			end
		end

feature -- Status report

	is_attribute: BOOLEAN = True
			-- Is `Current' an attribute editor?


feature {NONE} -- Implementation

	name_preposition: STRING
			-- `Result' is either "an_" or "a_" depending on the first character of `feature_name_field.text'.
		require
			feature_name_field_not_empty: feature_name_field.text.count > 0
		local
			first_character: CHARACTER
		do
			first_character := feature_name_field.text.item (1).to_character_8.as_lower
			if first_character = 'a' or first_character = 'e' or first_character = 'i'
				or first_character = 'o' or first_character = 'u' then
				Result := "an_"
			else
				Result := "a_"
			end
		ensure
			Result_valid: Result.is_equal ("an_") or Result.is_equal ("a_")
		end

	pc_None: STRING = "(none)"
			-- Mark for no precondition.

	on_declaration_change
			-- Update invariant when attribute declaration changes.
		do
			if not feature_name_field.text.is_empty then
				fill_with_assertions (invariant_field, False)
			else
				invariant_field.wipe_out
				invariant_field.set_text (Pc_none)
			end
		end

	on_invariant_focus_gain
			-- `invariant_field' gained focus: update.
		do
			fill_with_assertions (invariant_field, False)
		end

	on_precondition_focus_gain
			-- `precondition_selector' gained focus: update.
		do
			fill_with_assertions (precondition_selector, True)
		end

	fill_with_assertions (b: EV_COMBO_BOX; for_precondition: BOOLEAN)
			-- Fill `b' with assertions for current attribute.
		local
			pc: LIST [STRING]
			li: EV_LIST_ITEM
			inv, f_name: STRING
			l_selected_index: INTEGER
			l_text: STRING
		do
			f_name := feature_name_field.text
			if b.selected_item /= Void then
				l_selected_index := b.index_of (b.selected_item, 1)
			end
					-- We have custom text so we must restore it afterwards
			l_text := b.text
			b.wipe_out
			create li.make_with_text (pc_None)
			b.extend (li)

			if for_precondition then
				pc := assertions (name_preposition + f_name, type_selector.code)
			else
				pc := assertions (f_name, type_selector.code)
			end
			from
				pc.start
			until
				pc.after
			loop
				create li.make_with_text (pc.item)
				b.extend (li)
				pc.forth
			end

			if for_precondition then
				inv := invariant_field.text
				if inv /= Void and then not inv.is_empty then
					inv.replace_substring_all (f_name, name_preposition + f_name)
					pc.compare_objects
					if not pc.has (inv) then
						create li.make_with_text (inv)
						b.extend (li)
					end
					b.set_text (inv)
				end
			end
				-- Get rid of the focus_in_actions since it can interfere
				-- with the expected behavior of the combo-box.

			if l_selected_index = 0 then
				b.set_text (l_text)
			elseif l_selected_index <= b.count then
				b.i_th (l_selected_index).enable_select
			end
			b.focus_in_actions.wipe_out
		end

	invariant_field: EV_COMBO_BOX
			-- Editor that lets the user type an invariant
			-- for current attribute.

	precondition_selector: EV_COMBO_BOX;
			-- Edit field where the user can select from
			-- generated preconditions or type her own.

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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

end -- class EB_ATTRIBUTE_EDITOR
