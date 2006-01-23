indexing

	description:
		"MEL Implementation of a font box."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FONT_DIALOG

inherit

	MEL_FONT_BOX
		rename 
			make as font_make,
			make_no_auto_unmanage as font_make_no_auto_unmanage
		export
			{NONE} font_make, font_make_no_auto_unmanage
		undefine
			create_widget, created_dialog_automatically
		redefine
			parent
		end;

	MEL_FORM_DIALOG
		undefine
			set_foreground_color, set_background_color, 
			set_foreground, set_background
		redefine
			make, parent
		select
			form_make_no_auto_unmanage, form_make
		end

create
	make

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a motif form dialog.
		local
			widget_name: ANY
		do
			widget_name := a_name.to_c;
			handle := font_box_create ($widget_name,
						a_parent.screen_object, True);
			screen_object := font_box_form (handle)
			create parent.make_from_existing (xt_parent (screen_object), a_parent);
			Mel_widgets.add (Current);
			create button_form.make_from_existing (xt_parent 
					(font_box_ok_button (handle)), Current);
			set_default
		end;

feature -- Access

	parent: MEL_DIALOG_SHELL;;
			-- Dialog shell

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




end -- class MEL_FONT_DIALOG


