indexing
	description: "Text we can display on the wizard."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SMART_TEXT

inherit
	EV_VERTICAL_BOX
		
creation
	make

feature -- Initialization

	make(par: EV_BOX) is
			-- Initialize with box parent 'par'.
		do
			default_create
			par.extend(Current)
			par.disable_child_expand(Current)
		end

feature -- basic Operations 

	add_line(s: STRING) is
			-- Add a line to the text.
		require
			possible: s /= Void
		do
			extend(Create {EV_LABEL}.make_with_text(s))
		end

end -- class WIZARD_SMART_TEXT
