note
	description : "Objects that represent a cell"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID_VALUE_CELL

inherit
	ES_OBJECTS_GRID_CELL
		redefine
			initialize,
			activate_action, deactivate,
			initialize_actions,
			has_focus
		end

	EB_SHARED_PIXMAPS
		undefine
			copy, default_create
		end

	EV_SHARED_APPLICATION
		undefine
			copy, default_create
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	initialize
			-- Initialize.
		do
			Precursor
		end

feature -- Query

	initialize_actions
			-- Setup the actions sequences when the item is shown.
		do
			Precursor
--			text_label.focus_out_actions.wipe_out
--			text_label.focus_out_actions.extend (agent focus_lost)
			if attached button as but then
				but.focus_out_actions.extend (agent focus_lost)
				but.select_actions.extend (button_action)
				but.select_actions.extend (agent deactivate)
				but.set_focus
			end
		end

	activate_action (popup_window: EV_POPUP_WINDOW)
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
				if is_for_high_potential_effect_value then
					button.set_pixmap (Mini_pixmaps.evaluation_refresh_icon)
				else
					button.set_pixmap (Mini_pixmaps.debugger_expand_info_icon)
				end
				hb.extend (button)
				hb.disable_item_expand (button)

				popup_window.extend (hb)
					-- To make sure that the window is top most when 
					-- the parent window is disconnected from window manager.
				popup_window.disconnect_from_window_manager
				button.set_minimum_height (h)
			end
			is_activated := True
		end

	deactivate
			-- Cleanup from previous call to activate.
		do
			Precursor
			if attached button as but then
				but.focus_out_actions.wipe_out
				if attached but.parent as p then
					p.destroy
				end
				but.destroy
				button := Void
			end
			check is_not_activated:	not is_activated end
		end

feature -- Properties

	button_action: PROCEDURE [ANY, TUPLE]
			-- Actions called if the button is pressed.	

	button: EV_BUTTON

	is_for_high_potential_effect_value: BOOLEAN
			-- Is for high potential effect value?

feature -- Change

	set_button_action (v: like button_action)
		do
			button_action := v
		end

	set_for_high_potential_effect_value (a_b: BOOLEAN)
			-- Set for high potential effect value style
		do
			is_for_high_potential_effect_value := a_b
		ensure
			value_set: is_for_high_potential_effect_value = is_for_high_potential_effect_value
		end

feature {NONE} -- Impl

	has_focus: BOOLEAN
			-- Does this property have the focus?
		do
			Result := Precursor or (attached button as but and then but.has_focus)
		end

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

end
