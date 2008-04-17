indexing
	description	: "Window on which is displayed the wizards"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Pascal FREUND, Arnaud PICHERY [arnaud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_WIZARD_WINDOW

inherit
	EV_DIALOG

	EB_WIZARD_STATE_MANAGER
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize Current window.
		local
			v1: EV_VERTICAL_BOX
		do
			default_create
			set_size (dialog_unit_to_pixels(503), dialog_unit_to_pixels(385))
			create wizard_page
			create v1
			v1.extend (wizard_page)
			build_navigation_bar (v1)
			extend (v1)

			set_default_push_button (next_b)
			set_default_cancel_button (cancel_b)
		end

	build_navigation_bar (a_box: EV_BOX) is
			-- Build the navigation bar.
		local
			h1: EV_HORIZONTAL_BOX
			h2: EV_HORIZONTAL_BOX
			h_sep: EV_HORIZONTAL_SEPARATOR
		do
			Create h_sep
			a_box.extend(h_sep)
			a_box.disable_item_expand(h_sep)
			Create h1
			a_box.extend (h1)
			a_box.disable_item_expand (h1)

			Create previous_b.make_with_text_and_action (interface_names.b_arrow_back, agent previous_page)
			Create next_b.make_with_text_and_action (interface_names.b_arrow_next, agent next_page)
			Create cancel_b.make_with_text_and_action (interface_names.b_cancel, agent cancel_actions)

			h1.extend (create {EV_CELL})

			create h2
			h1.extend (h2)
			h1.disable_item_expand (h2)

			h2.extend (previous_b)
			set_default_width_for_button (previous_b)
			previous_b.align_text_center
			h2.disable_item_expand(previous_b)

			h2.extend (next_b)
			set_default_width_for_button (next_b)
			next_b.align_text_center
			h2.disable_item_expand (next_b)

			h1.extend (cancel_b)
			h1.disable_item_expand (cancel_b)
			set_default_width_for_button (cancel_b)
			cancel_b.align_text_center

			h1.set_padding (dialog_unit_to_pixels(11))
			h1.set_border_width (dialog_unit_to_pixels(11))
		end

feature -- Operations

	load_first_state (initial_state: EB_WIZARD_STATE_WINDOW) is
			-- Load first state.
		do
			proceed_with_new_state (initial_state)
			update_navigation
		end

feature -- Access

	wizard_page: EV_VERTICAL_BOX
			-- Page on which is displayed the information
			-- needed to be completed by the user in order
			-- to be performed.

feature {NONE} -- Implementation

	previous_b, next_b, cancel_b: EV_BUTTON
			-- Button ensuring the navigation.

	wizard_info_page: EV_VERTICAL_BOX
			-- Page to be completed by the user
			-- to give the information about the current state

	is_final: BOOLEAN
			-- Is it the final state?

feature {EB_WIZARD_STATE_WINDOW} -- Basic Operations	

	set_final_state (text: STRING_GENERAL) is
			-- Current state is final, hence a special process.
		do
			next_b.set_text(text)
			is_final := True
		end

	set_intermediary_state is
			-- Current state is intermediate.
		do
			is_final := False
		end

	disable_next_button is
			-- Disable the Next/Finish button
		do
			next_b.disable_sensitive
		end

	enable_next_button is
			-- Enable the Next/Finish button
		do
			next_b.enable_sensitive
		end

	disable_back_button is
			-- Enable the Next/Finish button
		do
			previous_b.disable_sensitive
		end

feature -- Basic Operations

	previous_page is
			-- Go to the previous page.
		do
			if history.count > 1 then
				back
			end
			update_navigation
		end

	update_navigation is
			-- Update navigation buttons.
		do
			if history.count < 1 or else history.isfirst  then
				previous_b.disable_sensitive
			elseif is_final then
				previous_b.enable_sensitive
			else
				previous_b.enable_sensitive
				next_b.set_text(interface_names.b_Next)
			end
		end

	next_page is
			-- Go to next page if possible.
		do
			if not history.after then
				next
			end
			update_navigation
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

end -- class WIZARD_WINDOW
