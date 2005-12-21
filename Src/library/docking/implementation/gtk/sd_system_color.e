indexing
	description: "System color on Unix."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SYSTEM_COLOR

feature -- Access

	mdi_back_ground_color: EV_COLOR is
			-- Background color of Multiple Document Interface (MDI) Applications.
		local
			l_colors: EV_STOCK_COLORS
		do
			create l_colors
			Result := l_colors.Color_3d_shadow
		end

feature {NONE} -- Initialization

end
