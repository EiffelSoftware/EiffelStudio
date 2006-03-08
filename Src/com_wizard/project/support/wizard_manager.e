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
			l_tasks: ARRAYED_LIST [WIZARD_PROGRESS_REPORTING_TASK]
		do
			if not l_retried then
				message_output.clear
				environment.set_error_data (Void)
				setup_environment
				if not environment.abort then
					message_output.add_title ("Processing  %"" + environment.project_name + "%"")
					create l_tasks.make (9)
					l_tasks.extend (create {WIZARD_INITIALIZATION_TASK})
					if environment.cleanup then
						l_tasks.extend (create {WIZARD_CLEANUP_TASK})
					end
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
							run_tasks (l_tasks)
						end
					end
				end
				if not environment.abort then
					if environment.compile_c then
						create l_tasks.make (1)
						l_tasks.extend (create {WIZARD_CODE_COMPILATION_TASK})
						run_tasks (l_tasks)
					end
					clean_all
					set_system_descriptor (Void)
				end
			end
			if environment.abort then
				message_output.display_error
				message_output.add_message ("%R%N%R%N")
			else
				message_output.add_title ("Processing finished successfully")
				message_output.add_message ("%R%N")
			end
			progress_report.finish
		rescue
			if not l_retried then
				environment.set_abort (Exception_raised)
				environment.set_error_data (tag_name + ":%N" + exception_trace)
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

	setup_environment is
			-- Setup environment variables for compilation
		local
			l_vs_setup: VS_SETUP
			l_path, l_platform: STRING
		do
			if Eiffel_installation_dir_name = Void or else Eiffel_installation_dir_name.is_empty then
				environment.set_abort (No_ise_eiffel)
			else
				l_platform := env.get ("ISE_PLATFORM")
				env.put (l_platform, "ISE_PLATFORM")
				l_path := env.get ("PATH")
				l_path.append (";")
				l_path.append (Eiffel_installation_dir_name)
				l_path.append ("\studio\spec\windows\bin")
				env.put (l_path, "PATH")
				if use_bcb then
					l_path := env.get ("PATH")
					l_path.append (";")
					l_path.append (Eiffel_installation_dir_name)
					l_path.append ("\BCC55\Bin")
					env.put (l_path, "PATH")
				end
				if not use_bcb then
					if smart_checking then
						create l_vs_setup.make
						if not l_vs_setup.valid_vcvars then
							Environment.set_abort (No_c_compiler)
						end
					end
				end
			end
		end

	smart_checking: BOOLEAN is
			-- smart_checking value in config.eif file
		local
			l_file: PLAIN_TEXT_FILE
			l_content, l_value: STRING
			l_index, l_index2: INTEGER
		do
			Result := True
			create l_file.make (Eiffel_installation_dir_name + "\studio\config\windows\msc\config.eif")
			if l_file.exists then
				l_file.open_read
				l_file.read_stream (l_file.count)
				l_content := l_file.last_string
				l_file.close
				l_index := l_content.substring_index ("%Nsmart_checking:", 1)
				if l_index > 0 then
					l_index2 := l_content.index_of ('%N', l_content.count.min (l_index + 17))
					if l_index2 > 0 then
						l_value := l_content.substring (l_index + 17, l_index2)
						l_value.right_adjust
						l_value.left_adjust
						if l_value.is_boolean then
							Result := l_value.to_boolean
						end
					end
				end
			end
		end

	event_raiser: ROUTINE [ANY, TUPLE [EV_THREAD_EVENT]]
			-- Agent used to raise events

end -- class WIZARD_MANAGER

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
