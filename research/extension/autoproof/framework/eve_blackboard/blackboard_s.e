note
	description: "Service for accessing and controling the blackboard."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BLACKBOARD_S

inherit

	SERVICE_I

	ROTA_TIMED_TASK_I
		rename
			has_next_step as is_running,
			cancel as stop
		end

feature {NONE} -- Initalization

	initialize
			-- Initialize blackboard service.
		require
			data_attached: attached data
			control_attached: attached control
			tools_attached: attached tools
		local
			l_shared_project: SHARED_EIFFEL_PROJECT
		do
			create data_initialized_event
			create data_changed_event
			create tool_execution_changed_event
			create blackboard_started_event
			create blackboard_stopped_event

			create l_shared_project
			if l_shared_project.eiffel_project.manager.is_project_loaded then
				data.update_from_universe
				set_initialized
			else
				l_shared_project.eiffel_project.manager.load_agents.extend (agent data.update_from_universe)
				l_shared_project.eiffel_project.manager.load_agents.extend (agent set_initialized)
			end

			sleep_time := 200
		end

feature -- Access

	data: attached EBB_SYSTEM_DATA
			-- Blackboard data for system.
		deferred
		end

	tools: attached LIST [attached EBB_TOOL]
			-- Available tools for blackboard.
		deferred
		end

	control: attached EBB_CONTROL
			-- Blackboard control.
		deferred
		end

	executions: attached EBB_EXECUTIONS
			-- Tool executions working on blackboard data.
		deferred
		end

feature -- Status report

	is_initialized: BOOLEAN
			-- Is blackboard initialized?

	is_running: BOOLEAN
			-- Is blackboard service running?

feature -- Status setting

	start
			-- Start blackboard service.
		require
			interface_usable: is_interface_usable
		do
			is_running := True
			if attached rota as l_rota then
				if not rota.has_task (Current) then
					rota.run_task (Current)
				end

				blackboard_started_event.publish ([])
			end
		ensure
			running: attached rota implies is_running
		end

	stop
			-- Stop blackboard service.
		do
			is_running := False

			blackboard_stopped_event.publish ([])
		end

	set_initialized
			-- Set blackboard to be initialized.
		require
			not_initialized: not is_initialized
		do
			is_initialized := True
			data_initialized_event.publish ([])
		ensure
			initialized: is_initialized
		end

feature -- Element change

	set_control (a_control: attached like control)
			-- Set `control' to `a_control'.
		deferred
		ensure
			control_set: control = a_control
		end

feature -- Basic operations

	register_tool (a_tool: attached EBB_TOOL)
			-- Register `a_tool' for the blackboard.
		do
			if not tools.has (a_tool) then
				tools.extend (a_tool)
			end
		ensure
			tool_added: tools.has (a_tool)
		end

feature -- Events

	data_initialized_event: EVENT_TYPE [TUPLE]
			-- Event that blackboard data has been initialized.
			-- This happens when a project is loaded.

	data_changed_event: EVENT_TYPE [TUPLE]
			-- Event that some blackboard data has been changed.

	tool_execution_changed_event: EVENT_TYPE [TUPLE]
			-- Event that some tool execution changed.

	blackboard_started_event: EVENT_TYPE [TUPLE]
			-- Event that blackboard execution has started.

	blackboard_stopped_event: EVENT_TYPE [TUPLE]
			-- Event that blackboard executino has stopped.

feature {NONE} -- Implementation

	sleep_time: NATURAL
			-- <Precursor>

	step
			-- <Precursor>
		do
			executions.check_running_tool_executions
			if control.is_running then
				control.think
				control.create_new_tool_executions
			end
			executions.start_waiting_tool_executions
		end

	frozen rota: detachable ROTA_S
			-- Access to rota service.
		do
			Result := (create {SERVICE_CONSUMER [ROTA_S]}).service
			if attached Result and then not Result.is_interface_usable then
				Result := Void
			end
		end

end
