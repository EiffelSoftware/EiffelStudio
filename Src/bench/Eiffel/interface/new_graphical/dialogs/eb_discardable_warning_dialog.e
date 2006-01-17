indexing
	description	: "Dialog asking the user if he really wants to start a command"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr] / Etienne Amodeo"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_DISCARDABLE_WARNING_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize,
			destroy,
			show_modal_to_window,
			is_in_default_state
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	EB_SHARED_PREFERENCES
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize to default state.
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			hb2: EV_HORIZONTAL_BOX
			vb2: EV_VERTICAL_BOX
			pixmap_clone: EV_PIXMAP
			label_box: EV_VERTICAL_BOX
			option_box: EV_HORIZONTAL_BOX
			label: EV_LABEL -- Text label where `text' is displayed.
			pixmap_box: EV_CELL -- Container to display pixmap in.
			button_box: EV_HORIZONTAL_BOX -- Bar with all buttons of the dialog.
		do
			Precursor {EV_DIALOG}
			set_icon_pixmap (Default_pixmaps.Warning_pixmap)

			create check_button.make_with_text (Check_button_label)

			button_box := build_buttons_box

			create label
			label.align_text_left
			label.set_text (warning_message_label)

			create label_box
			label_box.extend (create {EV_CELL})
			label_box.extend (label)
			label_box.disable_item_expand (label)
			label_box.extend (create {EV_CELL})

			create pixmap_box
			pixmap_clone := Default_pixmaps.Warning_pixmap.twin
			pixmap_box.extend (pixmap_clone)
			pixmap_box.set_minimum_size (pixmap_clone.width, pixmap_clone.height)

			create option_box
			option_box.extend (check_button)
			option_box.disable_item_expand (check_button)
			option_box.extend (create {EV_CELL})

			create vb2
			vb2.extend (pixmap_box)
			vb2.disable_item_expand (pixmap_box)
			vb2.extend (create {EV_CELL})
	
			create hb
			hb.extend (vb2)
			hb.disable_item_expand (vb2)
			hb.extend (label_box)
			hb.set_padding (Layout_constants.Default_border_size)

			create hb2
			hb2.extend (create {EV_CELL})
			hb2.extend (button_box)
			hb2.disable_item_expand (button_box)
			hb2.extend (create {EV_CELL})

			create vb
			vb.extend (hb)
			vb.extend (option_box)
			vb.disable_item_expand (option_box)
			vb.extend (hb2)
			vb.disable_item_expand (hb2)
			vb.set_padding (Layout_constants.Small_border_size)
			vb.set_border_width (Layout_constants.Default_border_size)
			extend (vb)

			set_title (dialog_title)
			set_default_push_button (ok_button)
			set_default_cancel_button (ok_button)
			disable_user_resize
		end
		
	build_buttons_box: EV_HORIZONTAL_BOX is
			-- Build the button box.
		do
			create Result
			Result.set_padding (Layout_constants.Default_border_size)
			Result.enable_homogeneous

			ok_button := create_button (ok_button_label)
			Result.extend (ok_button)
		ensure
			valid_result: Result /= Void and then not Result.is_empty
		end

feature -- Basic operations

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show and wait until `Current' is closed.
			-- `Current' is shown modal with respect to `a_window'.
		do
			if assume_ok then
				check
					ok_action_not_void: ok_action /= Void
				end -- `assume_cancel' ensures `ok_action' /= Void.
				ok_action.call(Void)
			else
				Precursor (a_window)
			end
		end

feature -- Status setting

	set_ok_action (an_agent: PROCEDURE [ANY, TUPLE]) is
			-- Set the action performed when the Ok button is selected.
		do
				-- Remove the previous `ok_action' if any.
			if ok_action /= Void then
				ok_button.select_actions.prune_all (ok_action)
			end
				-- Setup the new ok_action.
			ok_action := an_agent
			ok_button.select_actions.extend (an_agent)
		end

feature {NONE} -- Contract support
	
	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
				-- FIXME: Manu 02/27/2001
				-- Does not check everything that EV_DIALOG was
				-- checking because parent is using Precursor
				-- and here we do not have access to those `Precursor'.
			Result := not user_can_resize and menu_bar = Void
		end

feature {NONE} -- Implementation

	check_button: EV_CHECK_BUTTON
			-- Check button labeled "Do not ask me again"

	ok_button: EV_BUTTON
			-- Button for "Ok" or "Yes" answer.

	ok_action: PROCEDURE [ANY, TUPLE]
			-- Action performed when ok is selected.

	destroy is
			-- Destroy the dialog (update the preferences based on the check button first)
		do
			save_check_button_state (check_button.is_selected)

			Precursor {EV_DIALOG}
		end

	create_button (a_text: STRING): EV_BUTTON is
			-- Create a new button labeled `a_text'
		do
			create Result
			Result.align_text_center
			Result.set_text (a_text)
			Layout_constants.set_default_size_for_button (Result)
			Result.select_actions.extend (agent destroy)
		end

	dialog_title: STRING is
			-- Title for this confirmation dialog
		do
			Result := "Warning"
		end

feature {NONE} -- Deferred Constants

	check_button_label: STRING is
			-- Label for `check_button'.
		deferred
		ensure
			valid_label: Result /= Void and then not Result.is_empty
		end

	ok_button_label: STRING is
			-- Label for the Ok/Yes button.
		do
			Result := Interface_names.b_ok
		ensure
			valid_label: Result /= Void and then not Result.is_empty
		end

	warning_message_label: STRING is
			-- Label for the confirmation message.
		deferred
		ensure
			valid_label: Result /= Void and then not Result.is_empty
		end

feature {NONE} -- Deferred Implementation

	assume_ok: BOOLEAN is
			-- Should `Ok' be assumed as selected?
		deferred
		ensure
			Assume_ok_implies_ok_action_not_void:
				Result implies ok_action /= Void
		end

	save_check_button_state (check_button_checked: BOOLEAN) is
			-- Save the preferences according to the state of the check button.
		deferred
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

end -- class EB_DISCARDABLE_WARNING_DIALOG
