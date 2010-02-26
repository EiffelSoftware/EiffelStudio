note
	description: "Summary description for {EB_CONTRACT_SELECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CONTRACT_SELECTOR


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

feature {NONE} -- Initialization

	initialize
			-- Build interface.
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
		do
			Precursor
			create hb
			create tag_field
			tag_field.pointer_button_press_actions.force_extend (agent edit_contract)

			hb.extend (tag_field)
			hb.disable_item_expand (hb.last)
			hb.extend (new_label (":"))
			hb.disable_item_expand (hb.last)

			create vb
			vb.extend (hb)
			vb.disable_item_expand (vb.last)
			vb.extend (create {EV_CELL})

			extend (vb)
			disable_item_expand (vb)

			create contract_selector.make_with_text ("True")
			contract_selector.align_text_left
			contract_selector.pointer_button_press_actions.force_extend (agent edit_contract)
			extend (contract_selector)

			create vb
			create remove_button
			remove_button.set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)
			remove_button.set_minimum_size (16, 16)
			vb.extend (remove_button)
			vb.disable_item_expand (vb.last)
			vb.extend (create {EV_CELL})
			set_padding (Layout_constants.small_padding_size)
			extend (vb)
			disable_item_expand (vb)
		end

feature -- Access

	tag_field: EV_LABEL
			-- Tag text box.

	contract_selector: EV_LABEL
			-- Contract selection widget.

	remove_button: EV_BUTTON
			-- Button to remove `Current' from its container.
			-- Does nothing until `set_remove_procedure' gets called.

	code: STRING
			-- Generated code.
		local
			t: STRING
		do
			t := tag_field.text
			create Result.make (10)
			if not t.is_empty then
				Result.append (t)
				Result.append (": ")
				Result.append (contract_selector.text)
			end
		ensure
			not_void: Result /= Void
		end

feature -- Status report

	valid_content: BOOLEAN
			-- Is user input valid for code generation?
		local
			t: STRING
		do
			t := tag_field.text
			Result := t /= Void and then not t.is_empty
		end

feature -- Element change

	set_tag (a_tag: STRING)
			-- Put `a_tag' in `tag_field'.
		do
			if a_tag.is_empty then
				tag_field.remove_text
			else
				tag_field.set_text (a_tag)
			end
		end

	set_remove_procedure (proc: PROCEDURE [ANY, TUPLE])
			-- Make `remove_button' call `proc'.
		require
			proc_exists: proc /= Void
		do
			remove_button.select_actions.wipe_out
			remove_button.select_actions.extend (proc)
		end

feature {NONE} -- Implementation

	edit_contract
			-- Edit contract represented by `Current'.
		local
			l_dialog: ES_EDIT_CONTRACT_DIALOG
		do
			create l_dialog.make
			l_dialog.set_contract (tag_field.text, contract_selector.text)
			l_dialog.show_on_active_window
			if l_dialog.dialog_result = l_dialog.default_confirm_button then
				set_tag (l_dialog.contract.tag)
				contract_selector.set_text (l_dialog.contract.contract)
			end
		end

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
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

end -- EB_CONTRACT_SELECTOR
