--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Rectangle (with or without scrollbars) which contains a list of
-- selectable strings.

indexing

	date: "$Date$";
	revision: "$Revision$"

class SCROLL_LIST 

inherit

	FONTABLE
		rename
			implementation as font_implementation
		end;

	PRIMITIVE
		redefine
			implementation, is_fontable
		end;

	LIST_MAN
		rename
			implementation as list_imp
		end

creation

	make

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a scrolled list with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := a_name.duplicate;
			implementation := toolkit.scroll_list (Current);
			list_imp.set_single_selection;
			set_default
		ensure
			Parent_set: parent = a_parent;
			Ientifier_set: identifier.is_equal (a_name)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: SCROLL_L_I;
			-- Implementation of list

feature {G_ANY, G_ANY_I, WIDGET_I}

	is_fontable: BOOLEAN is true;
			-- Is current widget an heir of FONTABLE?

feature {NONE}

	set_default is
			-- Set default values to current scroll list.
		do
		end

end
