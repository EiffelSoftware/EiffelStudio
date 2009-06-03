note

	description: "Button represented with a pixmap"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	PICT_COLOR_B

inherit

	BUTTON
		redefine
			implementation
		end

create

	make, make_unmanaged

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE)
			-- Create a draw button with `a_name' as identifier
			-- and `a_parent' as parent.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void;
			parent_not_menu_bar: is_valid (a_parent)
		do
			create_ev_widget (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE)
			-- Create an unmanaged draw button with `a_name' as identifier
			-- and `a_parent' as parent.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void;
			parent_not_menu_bar: is_valid (a_parent)
		do
			create_ev_widget (a_name, a_parent, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN)
			-- Create a draw button with `a_name' as identifier
			-- and `a_parent' as parent.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			if a_name /= Void then
				identifier := a_name.twin
			else
				identifier := Void
			end
			create {PICT_COLOR_B_IMP} implementation.make (Current, a_parent, man);
			implementation.set_widget_default;
			set_default
		end;

feature -- Access

	pixmap: PIXMAP
			-- Pixmap used
		require
			exists: not destroyed
		do
			Result := implementation.pixmap
		ensure
			valid_result: Result /= Void and then Result.is_valid
		end;

feature -- Status report

	is_valid (other: COMPOSITE): BOOLEAN
			-- Is `other' a valid parent?
		local
			a_bar: BAR
		do
			a_bar ?= other;
			Result := (a_bar = Void)
		end;

	is_pressed: BOOLEAN
			-- Is the pict color button pressed?
		do
			Result := implementation.is_pressed
		end

feature -- Element change

	set_pixmap (a_pixmap: PIXMAP)
			-- Draw `a_pixmap' into the picture_button.
		require
			exists: not destroyed;
			a_pixmap_exists: a_pixmap /= Void;
			a_pixmap_valid: a_pixmap.is_valid
		do
			implementation.set_pixmap (a_pixmap)
		ensure
			pixmap_changed: pixmap = a_pixmap
		end;

	set_pixmap_by_name (a_pixmap_name: STRING)
			-- Draw `a_pixmap_name' into the picture_button.
		require
			exists: not destroyed;
			a_pixmap_name_exist: a_pixmap_name /= Void
		local
			a_pixmap: PIXMAP;
		do
			create a_pixmap.make;
			a_pixmap.read_from_file (a_pixmap_name);
			set_pixmap (a_pixmap);
		end;

	set_pressed (b: like is_pressed)
			-- Set `is_pressed' to `b'.
		do
			implementation.set_pressed (b)
		ensure
			set: b = is_pressed
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: PICT_COLOR_B_I;
			-- Implementation of draw button

feature {NONE} -- Implementation

	set_default
			-- Set default values to current drawing button.
		do
		end;

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




end -- class PICT_COLOR_B

