--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Separator Gadget.

indexing

	date: "$Date$";
	revision: "$Revision$"

class SEPARATOR_G 

inherit

	SEPARATOR
		rename
			make as separator_make
		redefine
			set_action, remove_action,
			background_color, set_background_color,
			background_pixmap, set_background_pixmap,
			foreground, set_foreground,
			implementation
		end

creation

	make
	
feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a separator gadget with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := a_name.duplicate;
			implementation := toolkit.separator_g (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifier_set: identifier.is_equal (a_name)
		end;

feature -- Callback (adding and removing)

	remove_action (a_translation: STRING) is
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		require else
			no_translation_on_gadgets: false
		do
		end;

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Set `a_command' to be executed when `a_translation' occurs.
			-- `a_translation' is specified with Xtoolkit convention.
		require else
			no_translation_on_gadgets: false
		do
		end;

feature -- Color

	background_color: COLOR is
			-- Background color of widget
		do
		end;

	foreground: COLOR is
			-- Foreground color of primitive widget
		do
		end; 

	set_background_color (new_color: COLOR) is
			-- Set background color to `new_color'.
		require else
			argument_not_void: not (new_color = Void)
		do
		end;

	set_foreground (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		require else
			color_not_void: not (new_color = Void)
		do
		end 

feature 

	background_pixmap: PIXMAP is
			-- Background pixmap of widget
		do
		end; 

	set_background_pixmap (new_pixmap: PIXMAP) is
			-- Set background pixmap to `new_pixmap'.
		require else
			argument_not_void: not (new_pixmap = Void)
		do
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: SEPARATO_G_I;
			-- Implementation of current separator gadget

end
