indexing
	description:"Menu common to every tools"
	author: "pascalf"

class EC_MENU

inherit 
	CONSTANTS 

creation
	make

feature -- Initialization

	make (parent: ECASE_WINDOW) is
			-- Initialize
		require
			exists : parent /= Void
		do
			-- Your instructions here
			!! menu_bar.make ( parent )
		end

feature -- Implementation

	menu_bar: EV_STATIC_MENU_BAR 

end
