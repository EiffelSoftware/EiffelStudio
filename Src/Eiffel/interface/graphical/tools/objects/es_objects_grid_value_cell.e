indexing
	description : "Objects that represent a cell"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_OBJECTS_GRID_VALUE_CELL

inherit
	ES_OBJECTS_GRID_CELL
		redefine
			initialize,
			activate_action, deactivate,
			initialize_actions
		end

	EB_SHARED_PIXMAPS
		rename
			implementation as pixmaps_impl
		undefine
			copy, default_create
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	initialize is
			-- Initialize.
		do
			Precursor
		end

feature -- Query

	initialize_actions is
			-- Setup the actions sequences when the item is shown.
		do
			Precursor
			text_label.focus_out_actions.wipe_out
			text_label.focus_out_actions.extend (agent focus_lost)
			if button /= Void then
				button.focus_out_actions.extend (agent focus_lost)
				button.select_actions.extend (button_action)
				button.select_actions.extend (agent deactivate)
			end
		end

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		local
			hb: EV_HORIZONTAL_BOX
			h: INTEGER
		do
			Precursor (popup_window)
			if button_action /= Void then
				h := text_label.height
--				h := popup_window.height
				popup_window.prune_all (text_label)
				create hb
				hb.extend (text_label)
				create button
				button.set_pixmap (Mini_pixmaps.debugger_expand_info_icon)
				hb.extend (button)
				hb.disable_item_expand (button)

				popup_window.extend (hb)
				button.set_minimum_height (h)
			end
			is_activated := True
		end

	deactivate is
			-- Cleanup from previous call to activate.
		do
			Precursor
			is_activated := True
			if button /= Void then
				if button.parent /= Void then
					button.parent.destroy
				end
				button.destroy
				button := Void
			end
		end

feature -- Properties

	button_action: PROCEDURE [ANY, TUPLE]
			-- Actions called if the button is pressed.	

	is_activated: BOOLEAN
			-- Is the property activated?

	button: EV_BUTTON

feature -- Change

	set_button_action (v: like button_action) is
		do
			button_action := v
		end

feature {NONE} -- Impl

	focus_lost
			-- Check if no other element in the popup has the focus.
		do
			if is_activated and then not has_focus and then is_parented then
				deactivate
			end
		end

	has_focus: BOOLEAN
			-- Does this property have the focus?
		require
			is_activated
		do
			Result := text_label.has_focus or (button /= Void and then button.has_focus)
		end

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
