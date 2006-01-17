indexing 
	description: "REGISTER_PROMPT class created by Resource Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class 
	REGISTER_PROMPT

inherit
	WEL_MODAL_DIALOG
		redefine
			on_ok,
			on_cancel
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: SHAREWARE_PROMPT; license: LICENSE) is
			-- Create the dialog.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			make_by_id (a_parent, Idd_register_constant)
			create id_ok.make_by_id (Current, Idok)
			create idc_user.make_by_id (Current, Idc_user_constant)
			create idc_key.make_by_id (Current, Idc_key_constant)
			create id_cancel.make_by_id (Current, Idcancel)

			license_info := license
			previous_dialog := a_parent
		end

feature -- Behavior

	on_ok is
		local
			error_box: WEL_MSG_BOX
		do
			license_info.set_username (idc_user.text)
			license_info.set_password (idc_key.text)
			license_info.verify_current_user
			if license_info.licensed then
				previous_dialog.set_registered_user (True)
				destroy
			else
				previous_dialog.set_registered_user (False)
				create error_box.make
				error_box.error_message_box (Current, "Invalid key.%NPlease make sure you typed it correctly and try again.", "Registration Error")
			end
		end

	on_cancel is
		do
			license_info.set_username (Void)
			license_info.set_password (Void)
			destroy
		end

feature -- Access

	id_ok: WEL_PUSH_BUTTON
	idc_user: WEL_SINGLE_LINE_EDIT
	idc_key: WEL_SINGLE_LINE_EDIT
	id_cancel: WEL_PUSH_BUTTON

	license_info: LICENSE
			-- License information

	previous_dialog: SHAREWARE_PROMPT;
			-- Parent of Current.

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

end -- class REGISTER_PROMPT

