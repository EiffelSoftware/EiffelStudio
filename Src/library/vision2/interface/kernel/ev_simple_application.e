indexing
	description: 
		"Eiffel Vision Simple application.%N%
		%Base for root class in a simple application.%N%
		%Inherit and define `prepare'."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			post_launch_actions.extend (agent prepare)
			launch
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




end -- class EV_SIMPLE_APPLICATION

