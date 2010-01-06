class
	Y_PANEL [reference G -> STRING]

inherit
	X_PANEL [G]
		redefine
			panel_variable
		end

feature

	panel_variable: Y_PANEL_VARIABLE [G, TARGET [G]]

end
