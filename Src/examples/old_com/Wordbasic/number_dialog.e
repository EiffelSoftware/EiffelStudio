indexing 
	description: "NUMBER_DIALOG class created by Resource Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class 
	NUMBER_DIALOG

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

	make (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Create dialog.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			make_by_id (a_parent, Number_dialog_constant)
			create number_edit.make_by_id (Current, Number_edit_constant)
			create id_ok.make_by_id (Current, Idok)
		end

feature -- Behavior

	on_ok is
			-- Action to be executed when user clicks OK:
			-- store integer entry into `number'.
		do
			number := number_edit.text.to_integer
			terminate (Idok)
		end

feature -- Access

	number_edit: WEL_SINGLE_LINE_EDIT
			-- Field for entering number
	
	id_ok: WEL_PUSH_BUTTON
			-- OK button
	
	number: INTEGER;
			-- Number entered by user

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class NUMBER_DIALOG

