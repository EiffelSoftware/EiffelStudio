indexing
	description: "General notion of function (input or output) hole."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class ELMT_HOLE

inherit
	EB_BUTTON

creation
	make_with_editor

feature {NONE} -- Initialization

	make_with_editor (par: EV_TOOL_BAR; func: FUNC_EDITOR) is
		do
			make (par)
		end

	symbol: EV_PIXMAP is
			-- Symbol associated with current hole
		do
		end

end -- class ELMT_HOLE

