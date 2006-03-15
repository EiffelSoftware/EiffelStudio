indexing

	description: "Override shell which is not managed by current window manager"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	OVERRIDE_S

inherit

	POPUP_SHELL
		redefine
			implementation
		end

create

	make

feature {NONE} -- Initializatin

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an override shell with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.twin
			create {OVERRIDE_S_IMP} implementation.make (current, a_parent);
			set_default
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: OVERRIDE_S_I
			-- Implementation of override shell

feature {NONE} -- Implementation

	set_default is
			-- Set default values to current override shell.
		do
		end;

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




end -- class OVERRIDE_S

