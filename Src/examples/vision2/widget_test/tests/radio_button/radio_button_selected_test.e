indexing
	description: "Objects that demonstrate `select_actions'%
		%of EV_RADIO_BUTTON."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RADIO_BUTTON_SELECTED_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			radio_button: EV_RADIO_BUTTON
			counter: INTEGER
		do
			create vertical_box
			from
				counter := 1
			until
				counter > 6
			loop
				create radio_button.make_with_text (non_selected_text)
				radio_button.select_actions.extend (agent update_button_text (radio_button))
				vertical_box.extend (radio_button)
				counter := counter + 1
			end
	
			widget := vertical_box
		end
		
	update_button_text (radio_button: EV_RADIO_BUTTON) is
			-- Update `text' of radio_buttons to reflect `radio_button'
			-- becoming selected.
		local
			peers: LINKED_LIST [EV_RADIO_BUTTON]
		do
			peers := radio_button.peers
			from
				peers.start
			until
				peers.off
			loop
				if peers.item.text.is_equal (selected_text) then
					peers.item.set_text (non_selected_text)
				end
				peers.forth
			end
			radio_button.set_text (selected_text)
		end

feature {NONE} -- Implementation

	vertical_box: EV_VERTICAL_BOX
	
	selected_text: STRING is "Selected radio button"
	
	non_selected_text: STRING is "Radio button"

end -- class RADIO_BUTTON_SELECTED_TEST
