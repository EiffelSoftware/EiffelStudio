indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NAVIGATE_CMD

inherit
	COMMAND

creation
	make

feature -- creation

	make (other: TEXT_FIELD) is
		local
			rtf: ROUTINE_TEXT_FIELD
			ctf: ROUTINE_CLASS_TEXT_FIELD
		do
			ctf ?= other
			if ctf = Void then
				rtf ?= other
				imp ?= rtf.implementation
			else
				imp ?= ctf.implementation
			end
		end

	imp: TEXT_FIELD_IMP

feature -- Execution

	execute (argument: ANY) is
			-- set the focus to the next text field
		do
			xm_set_focus (imp.screen_object)
		end;

feature -- external

	xm_set_focus (widget: POINTER) is
		external
			"C"
		alias
			"c_xm_set_focus"
		end;



end -- class NAVIGATE_CMD
