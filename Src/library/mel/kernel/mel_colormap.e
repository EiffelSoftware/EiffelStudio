indexing

	description: 
		"Implementation of Colormap."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_COLORMAP

create
	make_from_existing

create {MEL_SCREEN} 

	make_default

feature {NONE} -- Initialization

	make_from_existing (an_id: like identifier) is
			-- Initialize `identifier' with C pointer `an_id'.
		require
			id_not_null: an_id /= default_pointer
		do
			identifier := an_id
		ensure
			set: identifier = an_id
		end;

	make_default (a_screen: MEL_SCREEN) is
			-- Initialize to default colormap of `screen'.
		require
			valid_screen: a_screen /= Void and then a_screen.is_valid
		do
			identifier := DefaultColormapOfScreen (a_screen.handle);
		end;

feature -- Access

	identifier: POINTER;
			-- Associated C identifier

	is_valid: BOOLEAN is
			-- Is the resource valid?
		do
			Result := identifier /= default_pointer
		ensure
			valid_result: Result implies identifier /= default_pointer
		end;

feature {NONE} -- External features

	DefaultColormapOfScreen (a_screen: POINTER): POINTER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_POINTER"
		alias
			"DefaultColormapOfScreen"
		end;

invariant

	identifier_not_null: identifier /= default_pointer

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




end -- class MEL_COLORMAP


