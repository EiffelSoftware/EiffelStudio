indexing

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	FONT_BOX_D 

inherit

	FONT_BOX
		rename
			make as font_box_make
		undefine
			raise, lower
		redefine
			implementation
		end;

	DIALOG
		rename
			implementation as dialog_imp
		end

create

	make
	
feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a font box with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			create {FONT_BOX_D_IMP} implementation.make (Current, a_parent);
			set_default
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name)
		end; 

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: FONT_BOX_D_I;;
			-- Implementation of current font box

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




end -- class FONT_BOX_D

