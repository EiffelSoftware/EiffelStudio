indexing
	description: "Wizard customnized rich edit."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RICH_EDIT 

inherit
	WEL_RICH_EDIT
		redefine
			default_style
		end

creation
	make,
	make_by_id

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Es_savesel + Es_multiline
		end

end -- class WIZARD_RICH_EDIT


