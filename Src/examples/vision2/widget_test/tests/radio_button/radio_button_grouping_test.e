indexing
	description: "Objects that demonstrate `merge_radio_button_groups'%
		%from EV_CONTAINER"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RADIO_BUTTON_GROUPING_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation


	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			horizontal_box: EV_HORIZONTAL_BOX
			radio_button: EV_RADIO_BUTTON
			counter: INTEGER
			frame: EV_FRAME
		do
			create vertical_box
			create horizontal_box
			vertical_box.extend (horizontal_box)
			create grouping_button.make_with_text ("Merge radio button groups?")
			grouping_button.select_actions.extend (agent update_merge)
			vertical_box.extend (grouping_button)
			vertical_box.disable_item_expand (grouping_button)
			create frame.make_with_text ("Group 1")
			horizontal_box.extend (frame)
			create group1
			frame.extend (group1)
			create frame.make_with_text ("Group 2")
			horizontal_box.extend (frame)
			create group2
			frame.extend (group2)
		
			from
				counter := 1
			until
				counter > 6
			loop
				create radio_button.make_with_text ("A radio button")
				group1.extend (radio_button)
				create radio_button.make_with_text ("A radio button")
				group2.extend (radio_button)
				counter := counter + 1
			end
	
			widget := vertical_box
		end
		
	update_merge is
			-- Merge or unmerge `group1' and `group2', based on
			-- status of `grouping_button'.
		do
			if grouping_button.is_selected  then
				group1.merge_radio_button_groups (group2)
			else
				group1.unmerge_radio_button_groups (group2)
			end
		end
		
		
feature {NONE} -- Implementation

	vertical_box: EV_VERTICAL_BOX
	
	grouping_button: EV_CHECK_BUTTON
	
	group1, group2: EV_VERTICAL_BOX

end -- class RADIO_BUTTON_GROUPING_TEST
