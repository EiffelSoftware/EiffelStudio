indexing
	description: "Code generation manager."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_MANAGER

inherit
	WIZARD_CLEANER	
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end

	WIZARD_RESCUABLE
		export
			{NONE} all
		end

	WIZARD_ERRORS
		export
			{NONE} all
		end

feature -- Access

	Analysis_title: STRING is "Analysing Type Library"
			-- Analysis title.

feature -- Basic Operations

	run is
			-- Start generation.
		local
			l_retried: BOOLEAN
			l_vs_setup: VS_SETUP
			l_tasks: ARRAYED_LIST [WIZARD_PROGRESS_REPORTING_TASK]
		do
			if not l_retried then
				message_output.clear
				environment.set_error_data (Void)
				create l_vs_setup.make
				if not l_vs_setup.valid_vcvars then
					Environment.set_abort (No_c_compiler)					
				else
					if Eiffel_installation_dir_name = Void or else Eiffel_installation_dir_name.is_empty then
						Environment.set_abort (No_ise_eiffel)
					end
				end			
				if not environment.abort then
					message_output.add_title ("Processing  %"" + environment.project_name + "%"")
	
					create l_tasks.make (7)
					if environment.is_eiffel_interface then
						l_tasks.extend (create {WIZARD_IDL_GENERATION_TASK})
					end
					if environment.idl then
						l_tasks.extend (create {WIZARD_IDL_COMPILATION_TASK})
					end
					l_tasks.extend (create {WIZARD_DIRECTORY_INITIALIZATION_TASK})
					run_tasks (l_tasks)
					
					if not environment.abort then
						l_tasks.wipe_out
						l_tasks.extend (create {WIZARD_TYPE_LIBRARY_ANALYSIS_TASK})
						run_tasks (l_tasks)
					
						if not environment.abort then
							l_tasks.wipe_out
							l_tasks.extend (create {WIZARD_CODE_GENERATION_TASK})
							if environment.compile_c then
								l_tasks.extend (create {WIZARD_CODE_COMPILATION_TASK})
							end
							run_tasks (l_tasks)
						end	
					end
					clean_all
					set_system_descriptor (Void)
				end
			end
			if environment.abort then
				message_output.display_error
			else
				message_output.add_title ("Processing finished successfully")
			end
			progress_report.finish
		rescue
			if not l_retried then
				environment.set_abort (Exception_raised)
				environment.set_error_data (tag_name + ":%R%N" + exception_trace)
				l_retried := True
				retry
			end
		end

	run_tasks (a_tasks: LIST [WIZARD_PROGRESS_REPORTING_TASK]) is
			-- Run tasks in list `a_tasks'.
		require
			non_void_tasks: a_tasks /= Void
		local
			l_ranges: ARRAY [INTEGER]
			l_task: WIZARD_PROGRESS_REPORTING_TASK
			l_total, i, l_count: INTEGER
		do
			from
				a_tasks.start
				create l_ranges.make (1, a_tasks.count)
				i := 1
			until
				a_tasks.after or environment.abort
			loop
				l_count := a_tasks.item.steps_count
				l_total := l_total + l_count
				l_ranges.put (l_count, i)
				i := i + 1
				a_tasks.forth
			end
			if not environment.abort then
				progress_report.set_range (l_total)
				progress_report.start
				from
					a_tasks.start
				until
					a_tasks.after or environment.abort
				loop
					l_task := a_tasks.item
					progress_report.set_title (l_task.title)
					l_task.execute
					a_tasks.forth
				end
			end
		end
		
feature {NONE} -- Implementation

	event_raiser: ROUTINE [ANY, TUPLE [EV_THREAD_EVENT]]
			-- Agent used to raise events
		
end -- class WIZARD_MANAGER

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
