class WINDOWS

inherit
	GRAPHICS
		redefine
			init_toolkit
		end

feature 

	application_screen: SCREEN is
		once
			!! Result.make ("")
		end

	init_toolkit: TOOLKIT_IMP is
		once
			!! Result.make ("")
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
			!! Result.make ("Perm_wind1", application_screen)
		end

end -- class WINDOWS
