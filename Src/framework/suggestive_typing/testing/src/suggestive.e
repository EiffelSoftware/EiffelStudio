note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	SUGGESTIVE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			app: EV_APPLICATION
		do
			create app
			create main_window.make
			main_window.show
			app.launch
		end

feature -- Access

	main_window: SUGGESTIVE_WINDOW

invariant

end
