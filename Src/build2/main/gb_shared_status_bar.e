indexing
	description: "Objects that represent shared status bar features.%
		%Should only be inherited."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_SHARED_STATUS_BAR
	
feature {NONE} -- Access

	status_text: STRING is
			-- `Result' is text of `status_bar_label'.
		do
			Result := status_bar_label.text
		end
		

feature {NONE} -- Status setting

	set_status_text (a_text: STRING) is
			-- Assign `a_text' to `status_bar_label'.
		do
			status_bar_label.set_text (a_text)
			if timed_text_timer /= Void then
				timed_text_timer.destroy
				timed_text_timer := Void
			end
		end
		
	set_timed_status_text (a_text: STRING) is
			-- Assign `a_text' to `status_bar_label' which
			-- will be displayed for a set period of time.
		do
			if timed_text_timer /= Void then
				timed_text_timer.destroy
				timed_text_timer := Void
			end
			set_status_text (a_text)
			create timed_text_timer.make_with_interval (timed_text_duration)
			timed_text_timer.actions.extend (agent clear_status_bar)
		end

	clear_status_bar is
			-- Clear text of `status_bar_label'.
		do
			status_bar_label.remove_text
			if timed_text_timer /= Void then
				timed_text_timer.destroy
				timed_text_timer := Void		
			end
		end
		
feature {NONE} -- Implementation

	status_bar_label: EV_LABEL is
			-- `Result' is label for status bar.
			-- All status bar text is displayed here.
		once
			create Result
			Result.align_text_left
		end

	clear_status_during_transport (an_x, a_y: INTEGER; a_target: EV_ABSTRACT_PICK_AND_DROPABLE) is
			-- Clear status bar if `a_target' is Void.
		do
			if a_target = Void then
				clear_status_bar
			end
		end
		
	clear_status_after_transport (a: ANY) is
			-- Clear `status_bar'.
		do
			clear_status_bar
		end
		
	timed_text_timer: EV_TIMEOUT
		-- Timer for removing timed texts.
		
	timed_text_duration: INTEGER is 1000
		-- Length of time for timed texts to be displayed
		-- on status bar.


end -- class GB_SHARED_STATUS_BAR
