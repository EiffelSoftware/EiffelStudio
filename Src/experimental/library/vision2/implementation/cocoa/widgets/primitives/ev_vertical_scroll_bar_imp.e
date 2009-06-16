note
	description: "Eiffel Vision vertical scroll bar. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SCROLL_BAR_IMP

inherit
	EV_VERTICAL_SCROLL_BAR_I
		redefine
			interface
		end

	EV_SCROLL_BAR_IMP
		redefine
			interface,
			cocoa_set_size,
			make
		end

create
	make

feature -- Initialization

	old_make (an_interface: like interface)
			-- Create the separator control.
		do
			assign_interface (an_interface)
		end

	make
		do
			create scroller.make_with_frame (0, 0, 5, 10)
			cocoa_item := scroller
			scroller.set_enabled (True)

			change_actions_internal := create_change_actions
			scroller.set_action (agent
				do
					set_proportion (scroller.double_value)
					change_actions_internal.call ([value])
				end)
		end

feature -- Minimum size

   	set_default_minimum_size
   			-- Platform dependant initializations.
   		do
			internal_set_minimum_width ({NS_SCROLLER}.scroller_width)
 		end

	cocoa_set_size (a_x_position, a_y_position, a_width, a_height: INTEGER_32)
		local
			l_x_position: INTEGER
			l_width: INTEGER
			l_scroller_width: INTEGER
		do
			l_scroller_width := {NS_SCROLLER}.scroller_width
			if a_width <= l_scroller_width then
				l_x_position := a_x_position
				l_width := a_width
			else
				l_x_position := a_x_position + ((a_width - l_scroller_width) // 2)
				l_width := l_scroller_width
			end
			Precursor {EV_SCROLL_BAR_IMP} (l_x_position, a_y_position, l_width, a_height)
		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_SCROLL_BAR note option: stable attribute end;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_VERTICAL_SCROLL_BAR_IMP

