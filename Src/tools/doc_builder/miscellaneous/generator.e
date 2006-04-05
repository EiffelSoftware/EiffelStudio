indexing
	description: "Generator which uses a progress bar for progress report."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GENERATOR

inherit
	SHARED_OBJECTS

feature -- Status Setting

	set_title (a_title: STRING) is
			-- Set title
		require
			title_not_void: a_title /= Void
			title_not_empty: not a_title.is_empty
		do
			description := a_title
		ensure
			description_set: description = a_title
		end		

	set_procedure (a_procedure: PROCEDURE [ANY, TUPLE]) is
			-- Set procedure
		require
			procedure_not_void: a_procedure /= Void
		do
			generation_routine := a_procedure
		ensure
			procedure_set : generation_routine = a_procedure
		end		

	set_graphical_mode (a_flag: BOOLEAN) is
			-- Set graphical mode
		do
			graphical_mode := a_flag
		ensure
			mode_set: graphical_mode = a_flag
		end		

	set_heading_text (a_text: STRING) is
			-- Change the current heading text to indicate precise nature
			-- of present generation specific task
		require
			text_not_void: a_text /= void
		do
			heading_text := a_text
		ensure
			text_set: heading_text.is_equal (a_text)
		end	

	set_status_text (a_text: STRING) is
			-- Change the current status text to indicate precise nature
			-- of present generation specific task
		require
			text_not_void: a_text /= void
		do
			status_task_text := a_text
		ensure
			text_set: status_task_text.is_equal (a_text)
		end		

	set_upper_range (a_value: INTEGER) is
			-- Set top range value
		require
			valid_value: a_value > 0
		do
			upper_range_value := a_value
		ensure
			value_set: upper_range_value = a_value
		end		

	set_update_timer (an_interval: INTEGER) is
			-- Set update timer.  Call `reset_timer' to prevent timer
			-- from firing when done.
		require
			valid_interval: an_interval > 0
		do
			create timer.make_with_interval (an_interval)
			timer.actions.extend (agent update_progress_report)
		end		

	reset_timer is
			-- Reset `timer'
		do
			if timer /= Void then
				timer.set_interval (0)	
			end
		end		

	suppress_progress_bar (a_flag: BOOLEAN) is
			-- Suppress the progress bar
		do
			show_bar := not a_flag
		ensure
			bar_mode_set: show_bar = not a_flag
		end		

feature -- Commands

	display is
			-- Display graphical widgets
		do
			build_interface
			progress_dialog.show_relative_to_window (Application_window)	
		end	
		
	close is
			-- Close
		do
			progress_dialog.hide	
			reset_timer
		end		

	generate is
			-- Run `generation_routine'.  Output stored in `last_output_report'
		require
			has_description: description /= Void
			can_generate: generation_routine /= Void
		do
			create last_output_report.make_from_string ("%N" + description)
			
					-- Build interface if applicable
			if graphical_mode then
				build_interface
				display
			end
			
			create start_time.make_now
			generation_routine.call (Void)
			generation_finished
		end		

	update_progress_report is
			-- Update progress report
		local
			l_stat_text,
			l_heading_text: STRING
			l_new_lines, cnt: INTEGER
		do			
			if graphical_mode then
						-- Bar
				if show_bar then
					increment := increment + 1
					progress_dialog.progress_bar.set_value (increment)
				end			
						-- Status Text
				if status_task_text = Void then
					create status_task_text.make_empty
				end
				
				l_stat_text := status_task_text.twin
				l_new_lines := (status_task_text.count / 65).floor
				if l_new_lines > 0 then
					from
						cnt := 1
					until
						cnt > l_new_lines
					loop
						l_stat_text.insert_character ('%N', cnt * 65)
						cnt := cnt + 1
					end
				end
				progress_dialog.status_label.set_text (l_stat_text)
				
						-- Heading Text
				if heading_text /= Void then
					l_heading_text := heading_text.twin
					progress_dialog.heading_label.set_text (l_heading_text)
				end				
				redraw
			end			
		end

feature -- Query

	last_generation_duration: TIME_DURATION
			-- Time taken for last complete execution of `generation_routine'	

	last_output_report: STRING
			-- Textual description of last execution of `generation_routine'	
	
feature -- Access

	description: STRING
			-- Description title for generation
	
	generation_routine: PROCEDURE [ANY, TUPLE]
			-- Routine to call on generation start
	
feature {NONE} -- Access	

	heading_text: STRING
			-- Heading text to indicate generation specific task information	

	status_task_text: STRING
			-- Text to indicate generation specific task information		

	lower_range_value: INTEGER is 1
			-- Lower range value for progress status reporting
			
	upper_range_value: INTEGER
			-- Upper range value for progress status reporting
			
	increment: INTEGER
			-- Current increment for progress report (default: 1)

feature {NONE} -- Graphical Components

	graphical_mode: BOOLEAN
			-- Is Current in graphical mode? (default: true)

	progress_dialog: PROGRESS_DIALOG is
			-- Progress status display dialog
		once
			create Result
		end

	build_interface is
			-- Build graphical representation of Current
		require
			in_graphical_mode: graphical_mode
		do	
			progress_dialog.set_title (description)
			if show_bar then
				progress_dialog.progress_bar.show
				progress_dialog.progress_bar.value_range.adapt (Lower_range_value |..| upper_range_value)
			else				
				progress_dialog.progress_bar.hide
			end			
		end	

	redraw is
			-- Redraw Current
		do
			(create {EV_ENVIRONMENT}).application.process_events
		end

feature {NONE} -- Implementation

	timer: EV_TIMEOUT
			-- Timer used for automatic updating

	show_bar: BOOLEAN
			-- Should progress bar be visible?
			
	start_time: TIME
			-- Start time of generation	

	generation_finished is
			-- Call to `generation_routine' is complete
		local
			l_interval: INTERVAL [TIME]
		do
			create l_interval.make (start_time, create {TIME}.make_now)
			last_generation_duration ?= l_interval.duration
			if graphical_mode and show_bar then
				progress_dialog.hide	
			end
		end	

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class GENERATOR
