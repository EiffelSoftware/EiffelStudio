indexing
	description: "Dialog that allows to choose what kind of task to add."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_TASK_DIALOG

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

create
	default_create,
	make_with_title

feature {NONE} -- Initialization

	initialize is
			-- Initialize.
		local
			vb: EV_VERTICAL_BOX
			hb1, hb: EV_HORIZONTAL_BOX
			cl: EV_CELL
		do
			Precursor {EV_DIALOG}

			set_title (dialog_task_add)

			create hb1
			extend (hb1)
			append_margin (hb1)
			create vb
			hb1.extend (vb)
			append_margin (vb)
			create element_container
			vb.extend (element_container)

			create pre.make_with_text (task_pre)
			element_container.extend (pre)
			create post.make_with_text (task_post)
			element_container.extend (post)

			append_small_margin (vb)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.set_padding (default_padding_size)
			create cl
			hb.extend (cl)
			create ok_button.make_with_text_and_action (ev_ok, agent on_ok)
			hb.extend (ok_button)
			hb.disable_item_expand (ok_button)
			ok_button.set_minimum_width (default_button_width)
			create cancel_button.make_with_text_and_action (ev_cancel, agent on_cancel)
			hb.extend (cancel_button)
			hb.disable_item_expand (cancel_button)
			cancel_button.set_minimum_width (default_button_width)

			append_margin (vb)
			append_margin (hb1)

			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
		end

feature -- Access

	is_ok: BOOLEAN
			-- Did the dialog close with an ok?

	is_pre: BOOLEAN is
			-- Was pre compilation as type of the new task choosen?
		do
			Result := pre.is_selected
		end

	is_post: BOOLEAN is
			-- Was post compilation as type of the new external choosen?
		do
			Result := not is_pre
		end

feature {NONE} -- GUI elements

	element_container: EV_VERTICAL_BOX
			-- Container to add new elements.

	pre: EV_RADIO_BUTTON
	post: EV_RADIO_BUTTON

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
