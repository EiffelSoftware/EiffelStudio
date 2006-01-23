indexing 
	description:
		"[
			Interactive horizontal range widget. A sliding thumb displays the
			current `value' and allows it to be adjusted.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			+-------------+
			|  |#|        |
			+-------------+
		]"
	status: "See notice at end of class."
	keywords: "range, slide, adjust"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_RANGE

inherit
	EV_RANGE
		redefine
			implementation
		end

create
	default_create,
	make_with_value_range

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_HORIZONTAL_RANGE_I
			-- Platform dependent access.
			
feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of horizontal range.
		do
			create {EV_HORIZONTAL_RANGE_IMP} implementation.make (Current)
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




end -- class EV_HORIZONTAL_RANGE

