note

	description: "Toggle button. Gadget"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class TOGGLE_BG 

obsolete
		"Use TOGGLE_B instead."
inherit

	TOGGLE_B
		redefine
			make, make_unmanaged, create_ev_widget,
			set_action, remove_action,
			background_color, set_background_color,
			background_pixmap, set_background_pixmap,
			foreground_color, set_foreground_color,
			implementation
		end

create

	make, make_unmanaged

feature {NONE} -- Creation

	make (a_name: STRING; a_parent: COMPOSITE)
			-- Create a toggle button gadget with `a_name' as label;
			-- 'a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, True)
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE)
			-- Create an unmanaged toggle button gadget with `a_name' as label;
			-- 'a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, False)
		end; 

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN)
			-- Create a toggle button gadget with `a_name' as label;
			-- 'a_parent' as parent and call `set_default'.
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
			implementation:= ot.toggle_bg (Current, man, a_parent);
			set_default
		end; 

feature -- Callback (adding and removing)

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY)
			-- Set `a_command' to be executed when `a_translation' occurs.
			-- `a_translation' is specified with Xtoolkit convention.
		do
		end;

	remove_action (a_translation: STRING)
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		do
		end;

feature -- Color

	background_color: COLOR
			-- Background color of widget
		do
		end;

	foreground_color: COLOR
			-- Foreground color of primitive widget
		do
		end;

	set_background_color (new_color: COLOR)
			-- Set background color to `new_color'.
		do
		end;

	set_foreground_color (new_color: COLOR)
			-- Set foreground color to `new_color'.
		do
		end 

feature -- Background pixmap

	set_background_pixmap (new_pixmap: PIXMAP)
			-- Set background pixmap to `new_pixmap'.
		do
		end; 

	background_pixmap: PIXMAP
			-- Background pixmap of widget
		do
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: TOGGLE_BG_I;;
			-- Implementation of toggle button gadget

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




end 

