indexing

	description:
			"Dialog shell."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_DIALOG_SHELL

inherit

	MEL_TRANSIENT_SHELL
		redefine
			make
		end

create
	make, 
	make_from_existing

feature -- Initilization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a motif dialog shell.
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			check
				same_display_as_parent: screen.display = parent.screen.display
			end;
			screen_object := xm_create_dialog_shell 
					(a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add_popup_shell (Current);
			set_default
		end;

feature {MEL_COMPOSITE} -- Implementation

	remove_from_popup_list is
			-- Remove current shell from popup list in parent
		do
			parent.remove_popup_child (Current)
		end;

feature {NONE} -- Implementation

	xm_create_dialog_shell (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/DialogS.h>"
		alias
			"XmCreateDialogShell"
		end

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




end -- class MEL_DIALOG_SHEL


