
feature {NONE} -- StatusBar Implementation

	standard_status_bar: EV_STATUS_BAR
			-- Standard status bar for this window

	standard_status_label: EV_LABEL
			-- Label situated in the standard status bar.
			--
			-- Note: Call `standard_status_label.set_text (...)' to change the text
			--       displayed in the status bar.

	build_standard_status_bar
			-- Populate the standard toolbar.
		do
				-- Initialize the status bar.
			standard_status_bar.set_border_width (2)
			
				-- Populate the status bar.
			standard_status_label.align_text_left
			standard_status_bar.extend (standard_status_label)
		end
