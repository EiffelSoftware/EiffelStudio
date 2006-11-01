indexing
	description: "Objects that test EV_HORIZONTAL_PROGRESS_BAR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_PROGRESS_BAR_SEGMENTATION_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

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
		-- Widget that test is to be performed on.
	
	adjust_segmentation is
			-- Toggle segmentation of `progress_bar'.
		do
			if progress_bar.is_segmented then
				progress_bar.disable_segmentation
			else
				progress_bar.enable_segmentation
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class HORIZONTAL_PROGRESS_BAR_SEGMENTATION_TEST
