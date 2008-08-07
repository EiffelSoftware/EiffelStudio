indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	XML2WIKITEXT_APPLICATION

inherit
	EV_APPLICATION

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch is
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		do
			default_create
			create main_window
			main_window.show
			launch
		end

feature {NONE} -- Implementation

	main_window: XML2WIKITEXT_WINDOW
		-- Main window of `Current'.	

end
