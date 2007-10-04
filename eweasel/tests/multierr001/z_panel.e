class
	Z_PANEL [reference G -> FILE_NAME create make_empty end]

inherit
	Y_PANEL [G]
		redefine
			panel_variable
		end

feature

	panel_variable: Z_PANEL_VARIABLE [TARGET [G]]

	bar: Z_PANEL_VARIABLE [TARGET [G]]

end
