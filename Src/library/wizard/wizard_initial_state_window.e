indexing
	description: ""
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_INITIAL_STATE_WINDOW

inherit
	WIZARD_STATE_WINDOW
		export
			{NONE} all
		end

feature -- Basic Operations

	display is
			-- Display Current State
		do
			build
		end

	build is
			-- Special display box for the first and the last state
		local
			text: EV_LABEL
			h1: EV_HORIZONTAL_BOX
			v1, v2: EV_VERTICAL_BOX
			sep_v: EV_VERTICAL_SEPARATOR
		do
			Create h1
			Create text.make_with_text(message)
			Create sep_v
			h1.extend(pixmap)
			h1.extend(sep_v)
			h1.extend(text)
			h1.disable_child_expand(sep_v)
			main_box.extend(h1)			
		end

end -- class WIZARD_INITIAL_STATE_WINDOW
