note
	description: "Interface to launch AutoProof."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_AUTOPROOF

create
	make

feature {NONE} -- Initialization

	make
			-- Intialize AutoProof.
		do
			reset
		end

feature -- Access

	input: E2B_TRANSLATOR_INPUT
			-- Input for translator.

feature -- Status report

	is_running: BOOLEAN
			-- Is verification running?
		do
			Result := verify_task /= Void and then verify_task.has_next_step
		end

	is_finished: BOOLEAN
			-- Is verification finished?
		do
			Result := verify_task = Void or else not verify_task.has_next_step
		end

feature -- Element change

	add_input (a_input: E2B_TRANSLATOR_INPUT)
			-- Add all classes and features from `a_input' to `input'.
		do
			across a_input.class_list as c loop add_class (c.item) end
			across a_input.feature_list as c loop add_feature (c.item) end
		end

	add_class (a_class: CLASS_C)
			-- Add class `a_class' to be verified.
		do
			input.add_class (a_class)
		end

	add_feature (a_feature: FEATURE_I)
			-- Add feature `a_feature' to be verified.
		do
			input.add_feature (a_feature)
		end

	add_notification (a_agent: PROCEDURE [E2B_RESULT])
			-- Add agent that gets notified when verification is finished.
		require
			a_agent_attached: attached a_agent
		do
			notification_agents.extend (a_agent)
		end

	clear_notifications
			-- Remove all notification agents.
		do
			notification_agents.wipe_out
		end

feature -- Basic operations

	reset
			-- Reset AutoProof.
		do
			create input.make
			create notification_agents.make
			verify_task := Void
		ensure
			not_running: not is_running
			no_notifiers: notification_agents.is_empty
		end

	verify
			-- Verify input.
		require
			not_running: not is_running
		do
			create {E2B_BULK_VERIFICATION_TASK} verify_task.make (input)
			start_verify_task
		ensure
			running_or_finished: is_running or is_finished
		end

	verify_forked
			-- Verify input.
		require
			not_running: not is_running
		do
			create {E2B_FORK_VERIFICATION_TASK} verify_task.make (input)
			start_verify_task
		ensure
			running_or_finished: is_running or is_finished
		end

	cancel
			-- Cancel verification.
		do
			if attached verify_task then
				verify_task.cancel
			end
		end

feature {NONE} -- Implementation

	verify_task: detachable E2B_VERIFY_TASK
			-- Verify task.

	start_verify_task
			-- Start Verification task.
		require
			verify_task_not_void: verify_task /= Void
		do
			if attached rota as l_rota then
				verify_task.reset_global_state
				verify_task.add_notification_agents (notification_agents)
				if not rota.has_task (verify_task) then
					rota.run_task (verify_task)
				end
			end
		end

	notification_agents: LINKED_LIST [PROCEDURE [E2B_RESULT]]
			-- List of notification agents.

	frozen rota: detachable ROTA_S
			-- Access to rota service.
		do
			Result := (create {SERVICE_CONSUMER [ROTA_S]}).service
			if attached Result and then not Result.is_interface_usable then
				Result := Void
			end
		end

end
