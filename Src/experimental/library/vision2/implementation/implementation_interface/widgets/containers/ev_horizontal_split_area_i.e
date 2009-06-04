note
	description:
		"Displays two widgets side by side, seperated by an adjustable divider."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_HORIZONTAL_SPLIT_AREA_I

inherit

	EV_SPLIT_AREA_I
		redefine
			interface
		end

feature

	minimum_split_position: INTEGER
			-- Minimum position the splitter can have.
		do
			if first_visible and then attached first as l_first then
				Result := l_first.minimum_width
			end
		end

	maximum_split_position: INTEGER
			-- Maximum position the splitter can have.
		local
			a_sec_width: INTEGER
		do
			if second_visible and then attached second as l_second then
				a_sec_width := l_second.minimum_width
			end
			Result := width - a_sec_width - splitter_width
			if Result < minimum_split_position then
				Result := minimum_split_position
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_HORIZONTAL_SPLIT_AREA note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_HORIZONTAL_SPLIT_AREA_I








