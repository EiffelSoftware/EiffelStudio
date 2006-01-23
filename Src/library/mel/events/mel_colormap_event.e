indexing
	description: 
		"Implementation of XColormapEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_COLORMAP_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

	colormap: MEL_COLORMAP is
			-- Color map 
		local
			id: POINTER	
		do
			id := c_event_colormap (handle)
			if id /= default_pointer then
				create Result.make_from_existing (id)
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




end -- class MEL_COLORMAP_EVENT


