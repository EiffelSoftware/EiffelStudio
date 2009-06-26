note
	description: "Eiffel Vision horizontal scroll bar. Cocoa implementation."
	author:	"Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_SCROLL_BAR_IMP

inherit
	EV_HORIZONTAL_SCROLL_BAR_I
		redefine
			interface
		end

	EV_SCROLL_BAR_IMP
		redefine
			make,
			interface,
			cocoa_set_size
		end

create
	make

feature -- Initialization

	make
		do
			create scroller.make_with_frame (0, 0, 10, 5)
			cocoa_view := scroller
			Precursor {EV_SCROLL_BAR_IMP}
			disable_tabable_from
			disable_tabable_to
			scroller.set_enabled (True)

			change_actions_internal := create_change_actions
			scroller.set_action (agent
				do
					set_proportion (scroller.double_value)
					change_actions.call ([value])
				end)
		end

feature -- Minimum size

   	set_default_minimum_size
   			-- Platform dependant initializations.
   		do
			internal_set_minimum_height ({NS_SCROLLER}.scroller_width)
 		end

	cocoa_set_size (a_x_position, a_y_position, a_width, a_height: INTEGER_32)
		local
			l_y_position: INTEGER
			l_height: INTEGER
			l_scroller_width: INTEGER
		do
			l_scroller_width := {NS_SCROLLER}.scroller_width
			if a_height <= l_scroller_width then
				l_y_position := a_y_position
				l_height := a_height
			else
				l_y_position := a_y_position + ((a_height - l_scroller_width) // 2)
				l_height := l_scroller_width
			end
			Precursor {EV_SCROLL_BAR_IMP} (a_x_position, l_y_position, a_width, l_height)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_HORIZONTAL_SCROLL_BAR note option: stable attribute end;

end -- class EV_HORIZONTAL_SCROLL_BAR_IMP
