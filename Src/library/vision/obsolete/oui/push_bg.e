indexing

	description: "Push button Gadget";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PUSH_BG 

obsolete
	"Use PUSH_B instead."

inherit

	PUSH_B
		redefine
			make, make_unmanaged, create_ev_widget,
			set_action, remove_action,
			background_color, set_background_color,
			background_pixmap, set_background_pixmap,
			foreground_color, set_foreground_color,
			implementation, is_valid
		end

create

	make

feature {NONE} -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a push button gadget with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, True)
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged push button gadget with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, False)
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a push button gadget with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		local
			ot: OBSOLETE_TOOLKIT
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			ot ?= toolkit;
			check
				obsolete_toolkit_instantiated: ot /= Void
			end;
			implementation:= ot.push_bg (Current, man, a_parent);
			set_default
		end;

feature -- Callback (adding and removing)

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Set `a_command' to be executed when `a_translation' occurs.
			-- `a_translation' is specified with Xtoolkit convention.
		require else
			no_translation_on_gadgets: false
		do
		end;

	remove_action (a_translation: STRING) is
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		require else
			no_translation_on_gadgets: false
		do
		end;

feature -- Color

	background_color: COLOR is
			-- Background color of widget
		do
		end;

	foreground_color: COLOR is
			-- Foreground color of primitive widget
		do
		end;

	set_background_color (new_color: COLOR) is
			-- Set background color to `new_color'.
		do
		end;

	set_foreground_color (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		do
		end

feature -- Background Pixmap
	
	background_pixmap: PIXMAP is
			-- Background pixmap of widget
		do
		end;

	set_background_pixmap (new_pixmap: PIXMAP) is
			-- Set background pixmap to `new_pixmap'.
		do
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: PUSH_BG_I;
			-- Implementation of push button gadget

feature 

	is_valid (other: COMPOSITE): BOOLEAN is
			-- Is `other' a valid parent?
		local
			a_bar: BAR
		do
			a_bar ?= other;
			Result := (a_bar = Void)
		end;

end

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

