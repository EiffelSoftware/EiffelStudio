indexing
	description: 
		"Implementation of XColormapEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_COLORMAP_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Access

	colormap: MEL_COLORMAP is
			-- Color map 
		local
			id: POINTER	
		do
			id := c_event_colormap (handle)
			if id /= default_pointer then
				!! Result.make_from_existing (id)
			end
		end

	new: BOOLEAN is 
			-- Did the colormap change?
		do
			Result := c_event_new (handle)
		end

	state: INTEGER is
			-- State of colormap
		do
			Result := c_event_state (handle)
		ensure
			valid_result: is_colormap_installed or else
					is_colormap_uninstalled
		end;

	is_colormap_installed: BOOLEAN is
			-- Was the color map installed?
		do
			Result := state = ColormapInstalled
		end;

	is_colormap_uninstalled: BOOLEAN is
			-- Was the color map installed?
		do
			Result := state = ColormapUninstalled
		end;

feature {NONE} -- Implementation

	c_event_colormap (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XColormapEvent *): EIF_POINTER"
		end;

	c_event_new (event_ptr: POINTER): BOOLEAN is
		external
			"C [macro %"events.h%"] (XColormapEvent *): EIF_BOOLEAN"
		end;

	c_event_state (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XColormapEvent *): EIF_INTEGER"
		end;

end -- class MEL_COLORMAP_EVENT


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

