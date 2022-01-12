note
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_SHARED_CONTEXT

feature {NONE} -- Access: stateful

	translation_pool: E2B_TRANSLATION_POOL
			-- Shared translation pool.
		once
			create Result.make
		end

	boogie_universe: IV_UNIVERSE
			-- Shared boogie universe.
		do
			Result := boogie_universe_cell.item
		end

	autoproof_errors: LINKED_LIST [E2B_AUTOPROOF_ERROR]
			-- List of autoproof errors.
		once
			create Result.make
			Result.compare_objects
		end

	result_handlers: HASH_TABLE [PROCEDURE [E2B_BOOGIE_PROCEDURE_RESULT, E2B_RESULT_GENERATOR], STRING]
			-- List of Boogie verification result handlers.
		once
			create Result.make (100)
		end

feature {NONE} -- Access: stateless

	name_translator: E2B_NAME_TRANSLATOR
			-- Shared global name translator.
		once
			create Result
		end

	translation_mapping: E2B_SPECIAL_MAPPING
			-- Shared mapping for special translations.
		once
			create Result.make
		end

	messages: E2B_MESSAGES
			-- Messages used in AutoProof.
		once
			create Result
		end

feature -- Access (public)

	options: E2B_OPTIONS
			-- Shared translation options.
		once
			create Result.make
		ensure
			class
		end

	helper: E2B_HELPER
			-- Shared helper.
		once
			create Result
		end

feature -- Status notification.

	status_notifier_agent_cell: CELL [PROCEDURE [READABLE_STRING_GENERAL]]
			-- Once cell holding status update agent.
		once
			create Result.put (Void)
		end

	set_status (a_message: READABLE_STRING_32)
			-- Set status message.
		do
			if status_notifier_agent_cell.item /= Void then
				status_notifier_agent_cell.item.call ([a_message])
			end
		end

feature {NONE} -- Implementation

	boogie_universe_cell: CELL [IV_UNIVERSE]
			-- Once cell holding shared boogie universe instance.
		once
			create Result.put (Void)
		end

	timer: DT_SHARED_SYSTEM_CLOCK
			-- Timer for debugging.
		once
			create Result
		end

	start_time: ARRAYED_STACK [DT_TIME]
			-- Start time set by calling 'start'.
		once
			create Result.make (5)
		end

	start_timer
		local
			l_time: DT_TIME
		do
			l_time := timer.system_clock.time_now
			start_time.extend (l_time)
		end

	stop_timer
		do
			start_time.remove
		end

	current_timer: INTEGER
		local
			l_time: DT_TIME
		do
			l_time := start_time.item
			Result := timer.system_clock.time_now.time_duration (l_time).millisecond_count
		end

end
