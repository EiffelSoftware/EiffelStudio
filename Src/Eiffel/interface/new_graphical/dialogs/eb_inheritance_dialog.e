note
	description: "Summary description for {EB_INHERITANCE_DIALOG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_INHERITANCE_DIALOG

inherit
	EV_DIALOG

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_VISION2_FACILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create wizard.
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			l_frame: EV_FRAME
		do
			default_create
			set_title (interface_names.l_diagram_add_ancestors)
			set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
			create vb
			vb.set_padding (layout_constants.small_padding_size)
			vb.set_border_width (layout_constants.default_border_size)

			create non_conformance_check_box.make_with_text ("Non Conforming?")
			vb.extend (non_conformance_check_box)
			vb.disable_item_expand (vb.last)

			create type_selector.make_for_inheritance
			vb.extend (type_selector)

			create hb
			hb.set_padding (layout_constants.small_padding_size)
			hb.extend (create {EV_CELL})
			create ok_button.make_with_text (Interface_names.b_Ok)
			ok_button.select_actions.extend (agent on_ok)
			extend_button (hb, ok_button)
			create cancel_button.make_with_text (Interface_names.b_Cancel)
			cancel_button.select_actions.extend (agent on_cancel)
			extend_button (hb, cancel_button)
			vb.extend (hb)
			vb.disable_item_expand (hb)
			extend (vb)
			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
		end

feature -- Access

	ok_button: EV_BUTTON
			-- Button labeled "OK".

	cancel_button: EV_BUTTON
			-- Button labeled "Cancel".

	code: STRING
			-- Current text of the feature in the wizard.
		do
			Result := type_selector.code
		end

	is_non_conforming: BOOLEAN
			-- Did the user select non-conforming inheritance?
		do
			Result := non_conformance_check_box.is_selected
		end

	type: STRING
			-- User selected name for ancestor type.
		do
			Result := type_selector.code
		end

	type_selector: EB_TYPE_SELECTOR

	non_conformance_check_box: EV_CHECK_BUTTON
		-- Check button used for non-conformance.

feature -- Status setting

	set_child_type (c: ES_CLASS)
			-- Set child type to `c'.
		do
			child_type := c
		end

	set_parent_type (s: ES_CLASS)
			-- Create a parent type of `p'
		do
			parent_type := s
			type_selector.set_initial_types (child_type, parent_type, True)
		end

	child_type: ES_CLASS
	parent_type: ES_CLASS

feature -- Status report

	valid_content: BOOLEAN
			-- Is user input valid for code generation?
		do
			Result := type_selector.valid_content
		end

	ok_clicked: BOOLEAN
			-- Was "OK" clicked?
			-- ie should code be generated?

feature {NONE} -- Implementation


	on_ok
			-- OK button was clicked.
		do
			ok_clicked := True
			if valid_content then
				hide
			end
		end

	on_cancel
			-- Cancel button was clicked.
		do
			ok_clicked := False
			hide
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

end -- class EB_INHERITANCE_DIALOG
