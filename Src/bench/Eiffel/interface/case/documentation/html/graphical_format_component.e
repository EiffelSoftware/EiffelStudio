indexing
	description: "Component that allows selecting a format."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_FORMAT_COMPONENT

inherit
	GRAPHICAL_COMPONENT[STRING]

	rename
		entity as format
	redefine
		format,make
	end

creation
	make

feature -- Initialization

	make (cont: EV_CONTAINER; caller: EC_EDITOR_WINDOW[STRING]) is
			-- Initialize
		require else
			-- 
		local
			h4: EV_HORIZONTAL_BOX
		do
			precursor (cont, caller)

			!! h4.make(cont)
			!! combo.make_horizontal (h4,"Graphical Format: ")
			combo.insert("Bitmap")
			combo.insert("Postscript")
			combo.insert("GIF")
			combo.combo.set_minimum_width_in_characters(13)
			combo.combo.set_expand(FALSE)
		end

feature -- Access

	format: STRING
		-- format that Current edits 

feature -- Implementation

	combo: SMART_COMBO_BOX	

feature -- Updates

	Update_from (new_path: STRING) is
			-- Update from 'ent'
		do
		end

	update is 	
		do
		end

	clear is 
		-- Clear all fields/buttons of Current
		do
		end

end -- class GRAPHICAL_FORMAT_COMPONENT
