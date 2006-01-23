indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class WINDOWS

inherit
	GRAPHICS
		redefine
			init_toolkit
		end

feature 

	application_screen: SCREEN is
		once
			create Result.make ("")
		end

	init_toolkit: TOOLKIT_IMP is
		once
			create Result.make ("")
		end

	init_windowing is
		do
			if (init_toolkit = void) then
			end
			if (toolkit = void) then
			end
			perm_wind1.realize
			iterate
		end

	perm_wind1: PERM_WIND1 is
		once
			create Result.make ("Perm_wind1", application_screen)
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


end -- class WINDOWS
