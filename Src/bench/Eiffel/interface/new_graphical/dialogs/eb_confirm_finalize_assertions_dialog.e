indexing
	description	: "Dialog asking the user if he wants to discard assertions when finalizing"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONFIRM_FINALIZE_ASSERTIONS_DIALOG

inherit
	DISCARDABLE_CONFIRMATION_DIALOG
		rename
			Interface_names as preferences_names,
			Layout_constants as preferences_layout_constants
		redefine
			assume_cancel,
			no_button_label,
			ok_button_label
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	EB_SHARED_PREFERENCES
		rename 
			preferences as studio_preferences
		export
			{NONE} all		
		undefine
			default_create, copy		
		end		

create
	default_create

feature -- Access
	
	Buttons_count: INTEGER is 3

feature {NONE} -- Deferred Constants

	check_button_label: STRING is
			-- Label for `check_button'.
		do
			Result := Interface_names.l_Discard_finalize_assertions
		end

	no_button_label: STRING is
			-- Label for the No button.
		do
			Result := Interface_names.b_Keep_assertions
		end

	ok_button_label: STRING is
			-- Label for the Cancel/No button.
		do
			Result := Interface_names.b_Discard_assertions
		end

	confirmation_message_label: STRING is
			-- Label for the confirmation message.
		do
			Result := Warning_messages.w_Assertion_warning
		end

feature {NONE} -- Deferred Implementation

	assume_cancel: BOOLEAN is False
			-- Should Keep assertions be assumed as selected?

	assume_ok: BOOLEAN is
			-- Should Discard assertions be assumed as selected?
		do
			Result := not studio_preferences.dialog_data.confirm_finalize_assertions
		end

	save_check_button_state (check_button_checked: BOOLEAN)is
			-- Save the preferences according to the state of the check button.
		do
			studio_preferences.dialog_data.confirm_finalize_assertions_preference.set_value (not check_button_checked)
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

end -- class EB_CONFIRM_FINALIZE_ASSERTIONS_DIALOG
