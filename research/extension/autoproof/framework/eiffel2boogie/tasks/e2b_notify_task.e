note
	description: "Task notifying observers when verification is finished."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_NOTIFY_TASK

inherit

	ROTA_TASK_I

create
	make

feature {NONE} -- Initialization

	make (a_verify_task: E2B_VERIFY_TASK)
			-- Initialize task.
		do
			verify_task := a_verify_task
			create notification_agents.make
			has_next_step := True
		end

feature -- Access

	notification_agents: LINKED_LIST [PROCEDURE [E2B_RESULT]]
			-- List of notification agents.

	verify_task: E2B_VERIFY_TASK
			-- Verify task that produces result.

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature -- Element change

	add_notification_agent (a_agent: PROCEDURE [E2B_RESULT])
			-- Add `a_agent' to `notification_agents'.
		require
			a_agent_attached: attached a_agent
		do
			notification_agents.extend (a_agent)
		end

feature {ROTA_S, ROTA_TASK_I} -- Basic operations

	step
			-- <Precursor>
		do
			across notification_agents as i loop
--				i.item.call ([verify_task.verifier_result])
			end
			has_next_step := False
		end

	cancel
			-- <Precursor>
		do
			has_next_step := False
		end

end
