indexing
	description: "Generator which uses a progress bar for progress report.%
		%To use inherit and put generation specific code in `internal generate'."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GENERATOR

inherit
	SHARED_OBJECTS

feature -- Commands
	
	generate is
			-- Generate
		local			
			l_time: TIME_DURATION			
			l_output_file: PLAIN_TEXT_FILE
		do
			l_output_file := Shared_constants.Application_constants.Script_output
			l_output_file.open_append
			io.putstring ("%N" + progress_title)					
			l_output_file.putstring ("%N" + progress_title)
			l_output_file.close
			initialize_generator
			internal_generate
			if gui_mode then
				progress_dialog.destroy	
			else
				l_output_file.open_append
				l_time := generation_time
				io.putstring ("...complete.  ")
				l_output_file.putstring ("...complete.  ")
				io.putstring ("(Time taken: " + l_time.hour.out + ":" + l_time.minute.out + ":" + l_time.second.out + ")")
				l_output_file.putstring ("(Time taken: " + l_time.hour.out + ":" + l_time.minute.out + ":" + l_time.second.out + ")")
				l_output_file.close
			end
		end

	initialize_generator is
			-- Setup and render the progress dialog for operation
		do			
			create start_time.make_now
			if gui_mode then
				create progress_dialog
				progress_dialog.set_title (progress_title)
				progress_dialog.progress_bar.value_range.adapt (Lower_range_value |..| upper_range_value)
				progress_dialog.show_relative_to_window (Application_window)
			end
		end	
	
	redraw is
			-- Redraw Current
		do
			(create {EV_ENVIRONMENT}).application.process_events
		end		

feature -- Access

	generation_time: TIME_DURATION is
			-- Time taken to perform generatio
		local
			l_interval: INTERVAL [TIME]
		do
			create l_interval.make (start_time, create {TIME}.make_now)
			Result ?= l_interval.duration
		end		

feature {NONE} -- Commands

	update_progress_report is
			-- Update progress report
		local
			l_constants: APPLICATION_CONSTANTS
		do			
			increment := increment + 1
			if gui_mode then
				progress_dialog.progress_bar.set_value (increment)
				redraw
			end			
		end
	
feature {NONE} -- Access

	internal_generate is
			-- Child specific generation processing
		deferred
		end		

	progress_dialog: PROGRESS_DIALOG
			-- Progress display dialog

	progress_title: STRING is deferred end
			-- Title for progress report

	lower_range_value: INTEGER is 1
			-- Lower range value for `progress_bar' rendering
			
	upper_range_value: INTEGER is deferred end
			-- Upper range value for `progress_bar' rendering
			
	increment: INTEGER
			-- Current increment for progress report
			
	start_time: TIME
			-- Start and end time		
			
	gui_mode: BOOLEAN is
			-- Is progress report for gui or command prompt?
		once
			Result := Shared_constants.Application_constants.is_gui_mode
		end		
			
end -- class GENERATOR
