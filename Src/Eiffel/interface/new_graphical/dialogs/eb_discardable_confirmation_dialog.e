indexing
	description	: "Dialog asking the user if he really wants to start a command"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DISCARDABLE_CONFIRMATION_DIALOG

inherit
	STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		rename
			interface_names as pre_interface_names,
			layout_constants as pre_layout_constants
		redefine
			dialog_title,
			ok_button_label,
			no_button_label,
			cancel_button_label
		end

	EB_CONSTANTS
		undefine
			default_create,
			copy
		end

create
	make_initialized

feature -- Title

	dialog_title: STRING_GENERAL is
			-- Title for this confirmation dialog
		do
			Result := interface_names.t_confirmation
		end

feature -- Labels

	ok_button_label: STRING_GENERAL is
			-- Label for the Ok/Yes button.
		do
			if buttons_count >= 3 then
				Result := interface_names.b_yes
			else
				Result := interface_names.b_ok
			end
		end

	no_button_label: STRING_GENERAL is
			-- Label for the No button.
		do
			Result := interface_names.b_no
		end

	cancel_button_label: STRING_GENERAL is
			-- Label for the Cancel/No button.
		do
			Result := interface_names.b_cancel
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
