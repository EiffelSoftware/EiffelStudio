indexing
	description: "Objects that represent shared status bar features.%
		%Should only be inherited."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_STATUS_BAR

feature {NONE} -- Access

	set_status_text (a_text: STRING) is
			-- Assign `a_text' to `status_bar_label'.
		do
			status_bar_label.set_text (a_text)
		end
		
		
	clear_status_bar is
			-- Clear text of `status_bar_label'.
		do
			status_bar_label.remove_text
		end
		
feature {NONE} -- Implementation

	status_bar_label: EV_LABEL is
			-- `Result' is label for status bar.
			-- All status bar text is displayed here.
		once
			create Result
			Result.align_text_left
		end
		

end -- class GB_SHARED_STATUS_BAR
