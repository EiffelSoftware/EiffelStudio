
feature {NONE} -- StatusBar Implementation

	standard_status_bar: EV_STATUS_BAR
			-- Standard status bar for this window

	standard_status_label: EV_LABEL
			-- Label situated in the standard status bar.
			--
			-- Note: Call `standard_status_label.set_text (...)' to change the text
			--       displayed in the status bar.

	build_standard_status_bar is
			-- Create and populate the standard toolbar.
		require
			status_bar_not_yet_created: 
				standard_status_bar = Void and then 
				standard_status_label = Void
		do
				-- Create the status bar.
			create standard_status_bar
			standard_status_bar.set_border_width (2)
			
				-- Populate the status bar.
			create standard_status_label.make_with_text ("Add your status text here...")
			standard_status_label.align_text_left
			standard_status_bar.extend (standard_status_label)
		ensure
			status_bar_created: 
				standard_status_bar /= Void and then 
				standard_status_label /= Void
		end
