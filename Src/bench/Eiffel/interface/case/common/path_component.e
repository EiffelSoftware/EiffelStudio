indexing
	description: "Component which allows selecting a path"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	PATH_COMPONENT

inherit
	GRAPHICAL_COMPONENT[STRING]
		rename
			entity as path
		redefine
			path,make
		end

creation
	make

feature -- Initialization

	make (cont: EV_CONTAINER; caller: EC_EDITOR_WINDOW [ANY]) is
			-- Initialize
		require else
			-- 
		local
			h4: EV_HORIZONTAL_BOX
		do
			precursor (cont, caller)

			!! h4.make(cont)
			!! path_t.make_horizontal(h4,"Path")
			path_t.text_field.set_vertical_resize(FALSE)
			path_t.text_field.set_expand(FALSE)
			path_t.text_field.set_minimum_width_in_characters(30)
			!! browse_b.make_with_text(h4,"Browse")
			browse_b.set_vertical_resize(FALSE)
			browse_b.set_expand(FALSE) 

		end

feature -- Access

	path: STRING
		-- Path that Current edits 

feature -- Implementation

	path_t: SMART_TEXT_FIELD

	browse_b: EV_BUTTON

feature -- Updates

	set_insensitive(b: BOOLEAN) is
		do
			path_t.text_field.set_insensitive(b)
			browse_b.set_insensitive(b)
		end

	Update is
			-- Update from 'ent'
		do
		end

	clear is 
		-- Clear all fields/buttons of Current
		do
		end


end -- class PATH_COMPONENT
