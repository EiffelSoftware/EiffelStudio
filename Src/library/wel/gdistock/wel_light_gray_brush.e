indexing
	description: "Light gray brush."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LIGHT_GRAY_BRUSH

inherit
	WEL_BRUSH

	WEL_GDI_STOCK

create
	make

feature {NONE} -- Implementation

	stock_id: INTEGER is
			-- GDI stock object identifier
		once
			Result := Ltgray_brush
		end

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




end -- class WEL_LIGHT_GRAY_BRUSH

