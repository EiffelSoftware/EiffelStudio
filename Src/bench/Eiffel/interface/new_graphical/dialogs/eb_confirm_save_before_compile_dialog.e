indexing
	description	: "Dialog asking the user if he wants to save all files before compiling"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONFIRM_SAVE_BEFORE_COMPILE_DIALOG

inherit
	EB_DISCARDABLE_CONFIRMATION_DIALOG

create
	default_create

feature -- Access

	Buttons_count: INTEGER is 3

feature {NONE} -- Deferred Constants

	check_button_label: STRING is
			-- Label for `check_button'.
		do
			Result := Interface_names.l_Discard_save_before_compile_dialog
		end

	confirmation_message_label: STRING is
			-- Label for the confirmation message.
		do
			Result := Warning_messages.w_Files_not_saved_before_compiling
		end

feature {NONE} -- Deferred Implementation

	assume_ok: BOOLEAN is
			-- Should `Ok' be assumed as selected?
		do
			Result := not confirm_save_before_compile
		end

	save_check_button_state (check_button_checked: BOOLEAN)is
			-- Save the preferences according to the state of the check button.
		do
			set_confirm_save_before_compile (not check_button_checked)
			resources.save
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

end -- class EB_CONFIRM_SAVE_BEFORE_COMPILE_DIALOG
