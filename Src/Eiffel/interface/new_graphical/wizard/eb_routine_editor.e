note
	description: "Component to let the user create routines."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_ROUTINE_EDITOR

inherit
	EB_FEATURE_EDITOR
		redefine
			initialize
		end

feature {NONE} -- Initialization

	initialize
			-- Create as function/procedure wizard.
		local
			vb, fake_vb, fake_vb2: EV_VERTICAL_BOX
			name_hb, hb: EV_HORIZONTAL_BOX
			tab, tab2: EV_CELL
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

			create fake_vb
			create name_hb
			fake_vb.extend (name_hb)
			fake_vb.disable_item_expand (name_hb)
			create feature_name_field.make_with_text ("new")

			create fake_vb2
			fake_vb2.extend (new_label (" ("))
			fake_vb2.disable_item_expand (fake_vb2.last)
			fake_vb2.extend (create {EV_CELL})

			name_hb.extend (feature_name_field)
			name_hb.extend (fake_vb2)
			name_hb.disable_item_expand (name_hb.last)

			create tab2
			fake_vb.extend (tab2)
			fake_vb.disable_item_expand (tab2)

			create hb
			hb.extend (fake_vb)
			hb.disable_item_expand (hb.last)
			create vb
			hb.extend (vb)
			create argument_list
			vb.extend (argument_list)
			add_argument_button := new_create_button
			add_argument_button.select_actions.extend (agent on_new_argument)
			vb.extend (routine_is_part)

			extend (hb)
			disable_item_expand (hb)

			create require_list
			add_require_button := new_create_button
			add_require_button.select_actions.extend (agent on_new_require)
			create hb
			hb.extend (add_require_button)
			hb.disable_item_expand (hb.last)
			hb.extend (create {EV_CELL})
			require_list.extend (hb)

			create ensure_list
			add_ensure_button := new_create_button
			add_ensure_button.select_actions.extend (agent on_new_ensure)
			create hb
			hb.extend (add_ensure_button)
			hb.disable_item_expand (hb.last)
			hb.extend (create {EV_CELL})
			ensure_list.extend (hb)

			build_body_type_box
			create ensure_field

			add_comment_field

			add_label ("require", 2)
			add_indented (require_list, 3, True)
			extend (body_type_box)
			disable_item_expand (body_type_box)
			add_label ("ensure", 2)
			add_indented (ensure_list, 3, True)
			add_label ("end", 2)

			extend (create {EV_CELL})
		end

	routine_is_part: EV_HORIZONTAL_BOX
			-- Procedure: "[!!]): "
			-- Function: "[!!]): <typefield>"
		require
			argument_button_not_void: add_argument_button /= Void
		deferred
		ensure
			not_void: Result /= Void
			argument_button_added: Result.has_recursive (add_argument_button)
		end

	build_body_type_box
			-- Create radio group with "do", "once" and "deferred".
		local
			tab: EV_CELL
		do
			create body_type_box
			tab := new_tab (2)
			body_type_box.extend (tab)
			body_type_box.disable_item_expand (tab)
			body_type_label := new_label ("do")
			body_type_box.extend (body_type_label)
			body_type_label.align_text_left

			create do_button.make_with_text ("do")
			body_type_box.extend (do_button)
			body_type_box.disable_item_expand (do_button)
			do_button.select_actions.extend (agent on_body_change (do_button.text))

			create once_button.make_with_text ("once")
			body_type_box.extend (once_button)
			body_type_box.disable_item_expand (once_button)
			once_button.select_actions.extend (agent on_body_change (once_button.text))

			create deferred_button.make_with_text ("deferred")
			body_type_box.extend (deferred_button)
			body_type_box.disable_item_expand (deferred_button)
			deferred_button.select_actions.extend (agent on_body_change (deferred_button.text))

			create external_button.make_with_text ("external")
			body_type_box.extend (external_button)
			body_type_box.disable_item_expand (external_button)
			external_button.select_actions.extend (agent on_body_change (external_button.text))
		end

feature -- Status report

	is_deferred: BOOLEAN
			-- Is current selected body "deferred"?
		do
			Result := body_type_label.text.is_equal ("deferred")
		end

	is_external: BOOLEAN
			-- Is current selected body "external"?
		do
			Result := body_type_label.text.is_equal ("external")
		end

feature -- Access

	add_argument
			-- Add an argument to `argument_list'.
		do
			on_new_argument
		end

	add_require
			-- Add a require to `require_list'.
		do
			on_new_require
		end

	add_ensure
			-- Add am ensure to `ensure_list'.
		do
			on_new_ensure
		end

	i_th_argument (i: INTEGER): EB_ARGUMENT_SELECTOR
		do
			Result := {like i_th_argument}.attempted (argument_list.i_th (i))
		end

	do_button, once_button, deferred_button, external_button: EV_RADIO_BUTTON

feature -- Element change

	set_name_number (a_number: INTEGER)
			-- Assign `a_number' to `name_number'.
		do
			name_number := a_number
			if name_number /= 0 then
				feature_name_field.set_text	("new" + "_" + name_number.out)
			end
		end

feature {NONE} -- Implementation

	arguments_code: STRING_32
			-- Arguments as text. Empty if no arguments.
		local
			asc: EB_ARGUMENT_SELECTOR
		do
			create Result.make (10)
			if not argument_list.is_empty then
				from
					argument_list.start
				until
					argument_list.after
				loop
					if attached {EB_ARGUMENT_SELECTOR} argument_list.item as asc then
						Result.append (asc.code)
						if not argument_list.islast then
							Result.append ("; ")
						end
					else
						check
							asc_not_void: False
						end
					end
					argument_list.forth
				end
			end
		end

	routine_code: STRING_32
			-- Code of routine without signature.
		do
			Result := require_code
			if is_deferred then
				Result.append ("%T%Tdeferred%N")
			else
				Result.append (body_code)
			end
			Result.append (ensure_code)
			Result.append ("%T%Tend%N%N")
		end

	require_code: STRING_32
			-- Code for precondition.
		do
			Result := code_for_contract_list (require_list, "require")
		end

	body_code: STRING_32
			-- Code for routine body.
		do
			create Result.make (8)
			Result.append_character ('%T')
			Result.append_character ('%T')
			Result.append (body_type_label.text)
			Result.append_character ('%N')
		end

	ensure_code: STRING
			-- Code for postcondition.
		do
			Result := code_for_contract_list (ensure_list, "ensure")
		end

	code_for_field (f: EV_TEXT_FIELD; kw: STRING_32): STRING_32
			-- Code for routine part `f' with keyword `kw'.
		local
			l_text: STRING_32
		do
			l_text := f.text
			if not l_text.is_empty then
					-- Insert header `kw'
				create Result.make (20)
				Result.append_character ('%T')
				Result.append_character ('%T')
				Result.append (kw)
				Result.append_character ('%N')

				Result.append_character ('%T')
				Result.append_character ('%T')
				Result.append_character ('%T')
				Result.append (l_text)
				Result.append_character ('%N')
			else
				create Result.make_empty
			end
		end

	code_for_contract_list (a_list: EV_BOX; a_keyword: STRING_32): STRING_32
			-- Code for contract list `a_list' for keyword `a_keyword'.
		do
			create Result.make (10)
			if a_list.count > 1 then
				Result.append_string ("%T%T")
				Result.append (a_keyword + "%N")
				from
					a_list.start
				until
					a_list.after
				loop
					if attached {EB_CONTRACT_SELECTOR} a_list.item as cs then
						Result.append ("%T%T%T")
						Result.append (cs.code)
						Result.append_character ('%N')
					end
					a_list.forth
				end
			end
		end

	on_new_require
			-- Add contract selector to require list.
		local
			csc: EB_CONTRACT_SELECTOR
			l_dialog: ES_ADD_CONTRACT_DIALOG
		do
			create l_dialog.make
			l_dialog.show_on_active_window
			if l_dialog.dialog_result = l_dialog.default_confirm_button then
				create csc
				csc.set_remove_procedure (agent on_require_removed (csc))
				require_list.extend (csc)

				csc.set_tag (l_dialog.contract.tag)
				csc.contract_selector.set_text (l_dialog.contract.contract)
			end
		end

	on_require_removed (req: EB_CONTRACT_SELECTOR)
			-- Remove `req' from require list.
		do
			require_list.prune (req)
			add_require_button.set_focus
		end

	on_new_ensure
			-- Add contract selector to require list.
		local
			csc: EB_CONTRACT_SELECTOR
			l_dialog: ES_ADD_CONTRACT_DIALOG
		do
			create l_dialog.make
			l_dialog.show_on_active_window
			if l_dialog.dialog_result = l_dialog.default_confirm_button then
				create csc
				csc.set_remove_procedure (agent on_ensure_removed (csc))
				ensure_list.extend (csc)

				csc.set_tag (l_dialog.contract.tag)
				csc.contract_selector.set_text (l_dialog.contract.contract)
				csc.tag_field.set_focus
			end
		end

	on_ensure_removed (req: EB_CONTRACT_SELECTOR)
			-- Remove `req' from require list.
		do
			ensure_list.prune (req)
			add_ensure_button.set_focus
		end

	on_new_argument
			-- Add argument selector to `argument_list'.
		local
			asc: EB_ARGUMENT_SELECTOR
		do
			create asc
			asc.type_selector.set_initial_types (client_type, supplier_type, False)
			asc.type_selector.update_list_strings (True)
			asc.set_remove_procedure (agent on_argument_removed (asc))
			argument_list.extend (asc)
			asc.set_name ("arg" + argument_list.count.out)
			asc.name_field.select_all
			asc.name_field.set_focus
		end

	on_argument_removed (arg: EB_ARGUMENT_SELECTOR)
			-- Remove `arg' from `argument_list'.
		require
			argument_exists: arg /= Void
		do
			argument_list.prune (arg)
			add_argument_button.set_focus
		ensure
			argument_removed: not argument_list.has (arg)
		end

	on_body_change (new_body: STRING)
			-- User selected different routine body type.
		do
			body_type_label.set_text (new_body)
		end

feature {EB_FEATURE_EDITOR} -- Access

	add_argument_button: EV_BUTTON
	argument_list: EV_VERTICAL_BOX

	add_require_button: EV_BUTTON
	require_list: EV_VERTICAL_BOX

	add_ensure_button: EV_BUTTON
	ensure_list: EV_VERTICAL_BOX

	require_field: EV_TEXT_FIELD
	body_type_label: EV_LABEL
	body_type_box: EV_HORIZONTAL_BOX
	ensure_field: EV_TEXT_FIELD;

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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

end -- class EB_ROUTINE_EDITOR
