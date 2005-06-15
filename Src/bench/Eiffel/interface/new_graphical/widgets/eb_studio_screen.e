indexing
	description: "Added functionality to EV_SCREEN which we do not want to export yet to EV_SCREEN."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_STUDIO_SCREEN
	
inherit
	EV_SCREEN
	
feature -- Status report

	virtual_width: INTEGER is
			-- Virtual width of screen
		do
			Result := implementation.virtual_width
		end	

	virtual_height: INTEGER is
			-- Virtual height of screen
		do
			Result := implementation.virtual_height
		end

	virtual_x: INTEGER is
			-- X position of virtual screen in main display coordinates
		do
			Result := implementation.virtual_x
		end

	virtual_y: INTEGER is
			-- Y position of virtual screen in main display coordinates
		do
			Result := implementation.virtual_y
		end
		
	virtual_left: INTEGER is
			-- Left position of virtual screen in main display coordinates
		do
			Result := virtual_x
		end
		
	virtual_top: INTEGER is
			-- Top position of virtual screen in main display coordinates
		do
			Result := virtual_y
		end
		
	virtual_right: INTEGER is
			-- Right position of virtual screen in main display coordinates
		do
			Result := virtual_x + virtual_width
		end

	virtual_bottom: INTEGER is
			-- Bottom position of virtual screen in main display coordinates
		do
			Result := virtual_y + virtual_height
		end
		
end
