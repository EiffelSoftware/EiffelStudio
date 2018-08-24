note
	description: "Composite task of verifying Eiffel using the Boogie verifier."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	E2B_VERIFY_TASK

inherit

	ROTA_TIMED_TASK_I
		export
			{ANY} cancel
		end

	E2B_SHARED_CONTEXT

feature -- Status report

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature -- Access

	notification_agents: LINKED_LIST [PROCEDURE [E2B_RESULT]]
			-- List of notification agents.

feature -- Element change

	reset_global_state
			-- Reset state for one run of AutoProof.
		do
			result_handlers.wipe_out
			autoproof_errors.wipe_out
			options.routines_to_inline.wipe_out
		end

	reset_local_state
			-- Reset state for one translation.
		do
			boogie_universe_cell.put (create {IV_UNIVERSE}.make)
			helper.reset
			translation_pool.reset
		end

	add_notification_agents (a_agents: LINKED_LIST [PROCEDURE [E2B_RESULT]])
			-- Set `notification_agents' to `a_agents'.
		do
			if notification_agents = Void then
				create notification_agents.make
			end
			notification_agents.append (a_agents)
		end

feature -- Basic operations

	notifiy_with_result (a_result: E2B_RESULT)
			-- Notify agents with result `a_result'.
		do
			if notification_agents /= Void then
				across notification_agents as i loop
					i.item.call ([a_result])
				end
			end
		end

end
