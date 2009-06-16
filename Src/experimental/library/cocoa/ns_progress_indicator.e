note
	description: "Wrapper for NSProgressIndicator."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PROGRESS_INDICATOR

inherit
	NS_VIEW
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make
		do
			make_from_pointer ({NS_PROGRESS_INDICATOR_API}.new)
		end

feature -- Access

	set_indeterminate (a_flag: BOOLEAN)
		do
			{NS_PROGRESS_INDICATOR_API}.set_indeterminate (item, a_flag)
		end

	set_min_value (a_value: DOUBLE)
		do
			{NS_PROGRESS_INDICATOR_API}.set_min_value (item, a_value)
		end

	set_max_value (a_value: DOUBLE)
		do
			{NS_PROGRESS_INDICATOR_API}.set_max_value (item, a_value)
		end

	set_double_value (a_double: DOUBLE)
		do
			{NS_PROGRESS_INDICATOR_API}.set_double_value (item, a_double)
		end

	start_animation
			-- Starts the animation of an indeterminate progress indicator.
			-- Does nothing for a determinate progress indicator.
		do
			{NS_PROGRESS_INDICATOR_API}.start_animation (item)
		end

	stop_animation
			-- Stops the animation of an indeterminate progress indicator.
			-- Does nothing for a determinate progress indicator.
		do
			{NS_PROGRESS_INDICATOR_API}.stop_animation (item)
		end

end
