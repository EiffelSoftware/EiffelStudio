indexing
	description: 
		"Eiffel Vision Simple application.%N%
		%Base for root class in a simple application.%N%
		%Inherit and define `prepare'."
	status: "See notice at end of class"
	keywords: "application, accelerator, event loop"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_SIMPLE_APPLICATION

inherit
	EV_APPLICATION

feature {NONE} -- Initialization

	prepare is
			-- Create initial windows and widgets.
			-- eg:
			-- prepare is
			--         -- Display hello world.
			--     local
			--         w: EV_WINDOW
			--         l: EV_LABEL
			--     do
			--         create w
			--         create l.make_with_text ("Hello World!")
			--         w.put (l)
			--         w.show
			--     end
		deferred
		end

	make is
			-- Launch the application.
		do
			default_create
			post_launch_actions.extend (~prepare)
			launch
		end

end -- class EV_SIMPLE_APPLICATION

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

