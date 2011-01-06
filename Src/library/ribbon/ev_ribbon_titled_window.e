note
	description: "[
					Same as EV_TITLED_WINDOW, and it works well with Ribbon
																			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_TITLED_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			implementation,
			create_implementation
		end

feature {NONE} -- Implementation

feature {EV_ANY, EV_ANY_I, EV_ANY_HANDLER} -- Implementation

	implementation: EV_TITLED_WINDOW_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- Responsible for interaction with native graphics toolkit.
		do
			create {EV_RIBBON_TITLED_WINDOW_IMP} implementation.make
		end

end
