indexing
	description	: "Controls execution of debugged application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

class APPLICATION_EXECUTION_CLASSIC

inherit

	APPLICATION_EXECUTION_IMP
		redefine
			make,
			apply_critical_stack_depth
		end

	OBJECT_ADDR
		export
			{NONE} all
		end

	IPC_SHARED
		export
			{NONE} all
		end

create {APPLICATION_EXECUTION}
	make

feature {APPLICATION_EXECUTION} -- Initialization

	make is
			--
		do
			Precursor
		end

feature -- Properties

	status: APPLICATION_STATUS_CLASSIC is
			-- Status of the running application
		do
			Result ?= Application.status
		end

feature {APPLICATION_EXECUTION} -- Properties

	is_valid_object_address (addr: STRING): BOOLEAN is
			-- Is object address `addr' valid?
			-- (i.e Does bench know about it)
		do
			Result := is_object_kept (addr)
		end

feature -- Execution

	run (args, cwd: STRING) is
			-- Run application with arguments `args' in directory `cwd'.
			-- If `is_running' is false after the
			-- execution of this routine, it means that
			-- the application was unable to be launched
			-- due to the time_out (see `eiffel_timeout_message').
			-- Before running the application you must check
			-- to see if the debugged information is up to date.
		local
			app: STRING
			l_status: APPLICATION_STATUS
		do
			app := Eiffel_system.application_name (True)
			if args /= Void then
				app.extend (' ')
				app.append (args)
			end
			run_request.set_application_name (app)
			run_request.set_working_directory (cwd)
			run_request.send
			l_status := status
			if l_status /= Void then
					-- Application was able to be started
				l_status.set_is_stopped (False)
			end
		end

	continue_ignoring_kept_objects is
		do
			cont_request.send_breakpoints
			status.set_is_stopped (False)
			cont_request.send_rqst_3_integer (Rqst_resume, Resume_cont, Application.interrupt_number, application.critical_stack_depth)
		end

	interrupt is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
		do
			quit_request.make (Rqst_interrupt)
			quit_request.send
		end

	notify_newbreakpoint is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
			-- in order to record the new breakpoint(s) before
			-- automatically resuming its execution.
		do
			quit_request.make (Rqst_new_breakpoint)
			quit_request.send
		end

	kill is
			-- Ask the application to terminate itself.
		do
			Application.process_termination

			quit_request.make (Rqst_kill)
			quit_request.send;

				-- Don't wait until the next event loop to
				-- to process the actual termination of the application.
				-- `recv_dead' will process all other messages sent by
				-- the application until the application is dead.
			from
			until
				quit_request.recv_dead
			loop
			end
		ensure then
			app_is_not_running: not Application.is_running
		end

	process_termination is
			-- Process the termination of the executed
			-- application. Also execute the `termination_command'.
		do
			release_all_objects
		end

feature -- Change

	apply_critical_stack_depth (d: INTEGER) is
			-- Call stack depth at which we warn the user against a possible stack overflow.
			-- -1 never warns the user.
		do
			if status /= Void and then status.is_stopped then
				send_rqst_3_integer (Rqst_overflow_detection, 0, 0, d)
			end
		end

feature -- Query

	onces_values (flist: LIST [E_FEATURE]; a_addr: STRING; a_cl: CLASS_C): ARRAY [ABSTRACT_DEBUG_VALUE] is
		local
			i: INTEGER
			err_dv: DUMMY_MESSAGE_DEBUG_VALUE
			once_r: ONCE_REQUEST
			odv: ABSTRACT_DEBUG_VALUE
			l_feat: E_FEATURE
			l_addr: STRING
			l_class: CLASS_C
		do
			l_addr := a_addr
			l_class := a_cl
			from
				create once_r.make
--				once_r := Application.debug_info.Once_request
				i := 1
				create Result.make (i, i + flist.count - 1)
				flist.start
			until
				flist.after
			loop
				l_feat := flist.item
				if once_r.already_called (l_feat) then
					fixme ("[
								JFIAT: update the runtime to avoid evaluate the once
								For now, we evaluate the once function as any expression
								which is not very smart/efficient
							]")
--					odv := once_r.once_result (l_feat)
--					l_item := debug_value_to_tree_item (odv)
					if l_feat.argument_count > 0 then
						create err_dv.make_with_name  (l_feat.name)
						err_dv.set_message ("Could not evaluate once with arguments...")
						odv := err_dv
					else
						odv := once_r.once_eval_result (l_addr, l_feat, l_class)
						if odv /= Void then
							odv.set_name (l_feat.name)
						else
							create err_dv.make_with_name  (l_feat.name)
							err_dv.set_message ("Could not retrieve information (once is being called or once failed)")
						end
					end
				else
					create err_dv.make_with_name  (l_feat.name)
					err_dv.set_message (Interface_names.l_Not_yet_called)
					err_dv.set_display_kind (Void_value)
					odv := err_dv
				end
				Result.put (odv, i)
				i := i + 1
				flist.forth
			end
		end

	dump_value_at_address_with_class (a_addr: STRING; a_cl: CLASS_C): DUMP_VALUE is
		do
			create Result.make_object (a_addr, a_cl)
		end

	debug_value_at_address_with_class (a_addr: STRING; a_cl: CLASS_C): ABSTRACT_DEBUG_VALUE is
		do
--			debugged_object_manager.classic_debugged_object_with_class (a_addr, a_cl)
--			Result := dump_value_at_address_with_class (a_addr, a_cl).
			to_implement ("Need to be implemented, but for now this is not used.")
			check FALSE end
		end

feature {RUN_REQUEST} -- Implementation

	invoke_launched_command (successful: BOOLEAN) is
			-- Process after the launch of the application according
			-- to `successful' and the execute `application_launch_command'.
		do
		end

feature {APPLICATION_STATUS}

	quit_request: EWB_REQUEST is
		once
			create Result.make (Rqst_quit)
		end

	run_request: RUN_REQUEST is
		once
			create Result.make (Rqst_application)
		end

	cont_request: EWB_REQUEST is
		once
			create Result.make (Rqst_cont)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class APPLICATION_EXECUTION_CLASSIC

