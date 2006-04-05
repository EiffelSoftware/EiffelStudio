indexing
	description: "warning dialog for the dialog"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "david_s"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WARNING

inherit
	EV_WARNING_DIALOG


create
	make

feature -- Initialization

	make (s: STRING) is
		local
			ok_button: EV_BUTTON
			cancel_button: EV_BUTTON
		do
			default_create
			
			set_buttons_and_actions (<<"Ok", "Cancel">>, <<~ok, ~cancel>>)
			ok_button:= button ("Ok")
			cancel_button:= button ("Cancel")
			set_default_push_button(ok_button)
			set_default_cancel_button(cancel_button)

			set_text (s)
		end

feature -- Actions

	ok is
		do
			ok_pushed:= True
		end

	cancel is
		do
			ok_pushed:= False
		end

feature -- Access

	ok_pushed: BOOLEAN;

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
end -- class WIZARD_WARNING
