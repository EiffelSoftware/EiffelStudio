note
	description: 
		"[
			Displays two widgets one above the other separated by an adjustable
			divider.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			---------------
			|             |
			|    first    |
			|             |
			|_____________|
			|-------------|
			|             |
			|    second   |
			|             |
			---------------
		]"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SPLIT_AREA

inherit
	EV_SPLIT_AREA
		redefine
			implementation
		end 
	
create
	default_create

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_VERTICAL_SPLIT_AREA_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_VERTICAL_SPLIT_AREA_IMP} implementation.make (Current)
		end

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




end -- class EV_VERTICAL_SPLIT_AREA 

