
-- Button represented with a pixmap.

indexing

	date: "$Date$";
	revision: "$Revision$"

class PICT_COLOR_B 

inherit

	BUTTON
		redefine
			implementation
		end

creation

	make
	
feature -- Creation 

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a draw button with `a_name' as identifier
			-- and `a_parent' as parent.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void;
			Parent_not_menu_bar: is_valid (a_parent)
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			implementation:= toolkit.pict_color_b (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifier_set: identifier.is_equal (a_name)
		end;

feature -- Pixmap 

	pixmap: PIXMAP is
			-- Pixmap used
		do
			Result := implementation.pixmap
		ensure
			Result.is_valid
		end;

	set_pixmap (a_pixmap: PIXMAP) is
			-- Draw `a_pixmap' into the picture_button.
		require
			a_pixmap_exists: not (a_pixmap = Void);
			a_pixmap_valid: a_pixmap.is_valid
		do
			implementation.set_pixmap (a_pixmap)
		ensure
			pixmap = a_pixmap
		end;

	set_pixmap_by_name (a_pixmap_name: STRING) is
			-- Draw `a_pixmap_name' into the picture_button.
		require
			a_pixmap_name_exist: not (a_pixmap_name = Void)
		local
			a_pixmap: PIXMAP;
		do
			!!a_pixmap.make;
			a_pixmap.read_from_file (a_pixmap_name);
			set_pixmap (a_pixmap);
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: PICT_COL_B_I;
			-- Implementation of draw button
	
feature {NONE}

	set_default is
			-- Set default values to current drawing button.
		do
		end;

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
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
