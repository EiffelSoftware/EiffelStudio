indexing

	description:
		"Top level shell which is used in an application that needs %
		%more than one root shell"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	TOP_SHELL

inherit

	TOP
		redefine
			implementation
		end

create

	make

feature {NONE} -- Initialization

	make  (a_name: STRING; a_screen: SCREEN) is
			-- Create a top_shell with `a_name' as identifier,
			-- only if `a_name' not void otherwise identifier
			-- will be defined as application name and call
			-- `set_default'.
		require
			non_void_screen: a_screen /= Void;
			valid_screen: a_screen.is_valid
		do
			depth := 0;
			screen := a_screen;
			if a_name /= Void then
				identifier := a_name.twin
			else
				identifier := Void
			end
			widget_manager.new (Current, Void);
			create {TOP_SHELL_IMP} implementation.make (Current);
			set_default
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: TOP_SHELL_I
			-- Implementation of top_shell

feature {NONE} -- Implementation

	set_default is
			-- Set default values of current top shell.
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




end -- class TOP_SHELL

