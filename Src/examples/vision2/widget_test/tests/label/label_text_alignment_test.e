indexing
	description: "Objects that test text_alignment of EV_LABEL."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LABEL_TEXT_ALIGNMENT_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
			combo_box: EV_COMBO_BOX
			list_item: EV_LIST_ITEM
		do
				-- Create `label' using `make_with_text'.
			create label.make_with_text ("A Label")
			label.set_minimum_size (200, 200)
			
			create vertical_box
			vertical_box.extend (label)
			
			create combo_box
			create list_item.make_with_text ("Alignment left")
			list_item.select_actions.extend (agent label.align_text_left)
			combo_box.extend (list_item)
			create list_item.make_with_text ("Alignment center")
			list_item.select_actions.extend (agent label.align_text_center)
			combo_box.extend (list_item)
			create list_item.make_with_text ("Alignment right")
			list_item.select_actions.extend (agent label.align_text_right)
			combo_box.extend (list_item)
			
			vertical_box.extend (combo_box)
			vertical_box.disable_item_expand (combo_box)
			
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	label: EV_LABEL

end -- class LABEL_TEXT_ALIGNMENT_TEST
