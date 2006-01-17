indexing
	description	: "Dialog warning the user that the breakpoints will be ignored."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONFIRM_IGNORE_ALL_BREAKPOINTS_DIALOG

inherit
	EB_DISCARDABLE_CONFIRMATION_DIALOG

	EB_GENERAL_DATA
		export
			{NONE} all
		undefine
			default_create
		end

create
	default_create

feature -- Access
	
	Buttons_count: INTEGER is 2

feature {NONE} -- Deferred Constants

	check_button_label: STRING is
			-- Label for `check_button'.
		do
			Result := Interface_names.l_Dont_ask_me_again
		end

	confirmation_message_label: STRING is
			-- Label for the confirmation message.
		do
			Result := Warning_messages.w_Ignoring_all_stop_points
		end

feature {NONE} -- Deferred Implementation

	assume_ok: BOOLEAN is
			-- Should `Ok' be assumed as selected?
		do
			Result := not confirm_ignore_all_breakpoints
		end

	save_check_button_state (check_button_checked: BOOLEAN)is
			-- Save the preferences according to the state of the check button.
		do
			set_confirm_ignore_all_breakpoints (not check_button_checked)
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

end -- class EB_CONFIRM_IGNORE_ALL_BREAKPOINTS_DIALOG
