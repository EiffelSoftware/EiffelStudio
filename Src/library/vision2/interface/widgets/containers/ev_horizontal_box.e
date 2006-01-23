indexing
	description:
		"[
			Horizontal linear widget container.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			---------------------------------------------
			|             |              |              |
			|    first    |     ....     |     last     |
			|             |              |              |
			---------------------------------------------
		]"
	status: "See notice at end of class."
	keywords: "container, horizontal, box"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_HORIZONTAL_BOX

inherit
	EV_BOX
		redefine			
			implementation
		end
	
create
	default_create

feature {EV_ANY, EV_ANY_I} -- Implementation
 	
	implementation: EV_HORIZONTAL_BOX_I
			-- Responsible for interaction with native graphics toolkit.
	
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_HORIZONTAL_BOX_IMP} implementation.make (Current)
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




end -- class EV_HORIZONTAL_BOX

