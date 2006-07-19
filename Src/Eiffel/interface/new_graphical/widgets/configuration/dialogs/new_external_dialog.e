indexing
	description: "Dialog that allows to choose what kind of external to add."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_EXTERNAL_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
		end

	PROPERTY_GRID_LAYOUT
		undefine
			default_create,
			copy
		end

	CONF_INTERFACE_NAMES
		undefine
			default_create,
			copy
		end

	EB_LAYOUT_CONSTANTS
		undefine
			default_create,
			copy
		end

	EB_CONSTANTS
		undefine
			default_create,
			copy
		end

create
	default_create,
	make_with_title

feature {NONE} -- Initialization

	initialize is
			-- Initialize.
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
			Precursor {EV_DIALOG}
			set_title (dialog_external_add)

			create vb
			vb.set_padding (default_padding_size)
			vb.set_border_width (default_border_size)
			extend (vb)

			create element_container
			element_container.set_padding (default_padding_size)
			vb.extend (element_container)

			create include.make_with_text (external_include)
			include.set_pixmap (pixmaps.icon_pixmaps.project_settings_include_file_icon)
			element_container.extend (include)
			create object.make_with_text (external_object)
			include.set_pixmap (pixmaps.icon_pixmaps.project_settings_object_file_icon)
			element_container.extend (object)
			create library.make_with_text (external_library)
			include.set_pixmap (pixmaps.icon_pixmaps.project_settings_object_file_icon)
			element_container.extend (library)
			create make.make_with_text (external_make)
			include.set_pixmap (pixmaps.icon_pixmaps.project_settings_make_file_icon)
			element_container.extend (make)
			create resource.make_with_text (external_resource)
			include.set_pixmap (pixmaps.icon_pixmaps.project_settings_resource_file_icon)
			element_container.extend (resource)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.set_padding (default_padding_size)
			hb.extend (create {EV_CELL})
			create ok_button.make_with_text_and_action (ev_ok, agent on_ok)
			hb.extend (ok_button)
			hb.disable_item_expand (ok_button)
			ok_button.set_minimum_width (default_button_width)
			create cancel_button.make_with_text_and_action (ev_cancel, agent on_cancel)
			hb.extend (cancel_button)
			hb.disable_item_expand (cancel_button)
			cancel_button.set_minimum_width (default_button_width)

			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
		end

feature -- Access

	is_ok: BOOLEAN
			-- Did the dialog close with an ok?

	is_include: BOOLEAN is
			-- Was include as type of the new external choosen?
		do
			Result := include.is_selected
		end

	is_object: BOOLEAN
			-- Was object as type of the new external choosen?
		do
			Result := object.is_selected
		end

	is_library: BOOLEAN
			-- Was library as type of the new external choosen?
		do
			Result := library.is_selected
		end

	is_make: BOOLEAN
			-- Was makefile as type of the new external choosen?
		do
			Result := make.is_selected
		end

	is_resource: BOOLEAN
			-- Was ressource as type of the new external choosen?
		do
			Result := resource.is_selected
		end

feature {NONE} -- GUI elements

	element_container: EV_VERTICAL_BOX
			-- Container to add new elements.

	include: EV_RADIO_BUTTON
	object: EV_RADIO_BUTTON
	library: EV_RADIO_BUTTON
	make: EV_RADIO_BUTTON
	resource: EV_RADIO_BUTTON

	cancel_button: EV_BUTTON
			-- Cancel button.

	ok_button: EV_BUTTON
			-- Ok Button.

feature {NONE} -- Agents

	on_ok is
			-- Ok was pressed.
		do
			is_ok := True
			destroy
		end

	on_cancel is
			-- Cancel was pressed.
		do
			is_ok := False
			destroy
		end

invariant
	elements: is_initialized implies ok_button /= Void and cancel_button /= Void
	one_type: is_include implies not (is_object or is_make or is_resource)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
end
