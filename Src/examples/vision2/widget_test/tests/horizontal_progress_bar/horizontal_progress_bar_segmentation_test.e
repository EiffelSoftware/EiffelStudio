indexing
	description: "Objects that test EV_HORIZONTAL_PROGRESS_BAR."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_PROGRESS_BAR_SEGMENTATION_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
			label: EV_LABEL
		do
			create vertical_box
			
			create progress_bar
			progress_bar.set_value (50)
			progress_bar.set_minimum_width (250)
			progress_bar.pointer_button_press_actions.force_extend (agent adjust_segmentation)
			
			vertical_box.extend (progress_bar)
			vertical_box.disable_item_expand (progress_bar)
			create label.make_with_text ("Click bar to change segmentation")
			vertical_box.extend (label)
			vertical_box.disable_item_expand (label)
			
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	progress_bar: EV_HORIZONTAL_PROGRESS_BAR
	
	adjust_segmentation is
			-- Toggle segmentation of `progress_bar'.
		do
			if progress_bar.is_segmented then
				progress_bar.disable_segmentation
			else
				progress_bar.enable_segmentation
			end
		end

end -- class HORIZONTAL_PROGRESS_BAR_SEGMENTATION_TEST
