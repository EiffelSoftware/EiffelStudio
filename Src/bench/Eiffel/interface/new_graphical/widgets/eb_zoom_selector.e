indexing
	description: "Objects that lets the user select a zoom level"
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ZOOM_SELECTOR
	
inherit
	EV_COMBO_BOX

create
	make_default

feature -- Initialization

	make_default is
			-- Initialize with "DEFAULT" as selected view.
		do
			make_with_strings (Initial_strings)
			remove_selection
			set_text ("100%%")
			set_minimum_width (60) 
			return_actions.extend (agent on_zoom_level_typed)
		end
		
feature -- Element change

	show_as_text (i: INTEGER) is
			-- Replace and show `i' %.
		require
			i_in_range: i > 0
		local
			l_text: like text
		do			
			remove_selection
			l_text := i.out + "%%"
			set_text (l_text)
		end

	add_and_show (i: INTEGER) is
			-- Add and show `i' %.
		require
			i_in_range: i > 0
		local
			tmp: LINKED_LIST [STRING]
			l_text: like text
		do
			l_text := i.out + "%%"
			tmp := strings
			tmp.compare_objects
			if tmp.has (l_text) then
				tmp.prune_all (l_text)
			end 
			tmp.put_front (l_text)
			set_strings (tmp)
		end

feature {NONE} -- Events

	on_zoom_level_typed is
			-- A view name was typed in `Current' text field.
		local
			l_text: like text
			new_val: INTEGER
		do
			l_text := text.twin
			
			if l_text.is_integer then
				new_val := l_text.to_integer
				if new_val > 5 then
					add_and_show (new_val)
				end
			end
		end

feature {NONE} -- Implementation

	initial_strings: ARRAY [STRING] is
			-- Initial list items.
		once
			create Result.make (1, 9)
			Result.put ("1000%%", 1)
			Result.put ("500%%", 2)
			Result.put ("250%%", 3)
			Result.put ("200%%", 4)
			Result.put ("100%%", 5)
			Result.put ("75%%", 6)
			Result.put ("50%%", 7)
			Result.put ("25%%", 8)
			Result.put ("10%%", 9)
		end

end -- class EB_ZOOM_SELECTOR
