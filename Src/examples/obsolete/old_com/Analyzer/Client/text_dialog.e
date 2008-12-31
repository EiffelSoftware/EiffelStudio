note 
	description: "TEXT_DIALOG class created by Resource Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"
	
class 
	TEXT_DIALOG

inherit
	WEL_MODAL_DIALOG
		redefine
			on_ok
		end

	APPLICATION_IDS
		export
			{NONE} all
		end
		
create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW)
			-- Create the dialog.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			make_by_id (a_parent, Text_dialog_constant)
			create id_ok.make_by_id (Current, Idok)
			create text_edit.make_by_id (Current, Text_edit_constant)
		end

feature -- Behavior

	on_ok
			-- Action to be executed when user clicks OK:
			-- store text entry into `user_text'.
		local
			msg_box: WEL_MSG_BOX
		do
			if text_edit.text.count /= 0 then
				user_text := text_edit.text
				terminate (Idok)
			else
				create msg_box.make
				msg_box.error_message_box (Current, "Text should not be empty !", "Input Error")
			end
		end

feature -- Access

	id_ok: WEL_PUSH_BUTTON
			-- OK button
			
	text_edit: WEL_SINGLE_LINE_EDIT
			-- Field for entering text
			
	user_text: STRING;
			-- Text entered by user

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class ENTER_TEXT_DIALOG

