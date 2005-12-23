indexing
	description: "Safe list of actions for multithreaded system."
	date: "$Date$"
	revision: "$Revision$"

class
	MT_ACTION_QUEUE

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize current
		do
			create mutex
			create actions.make (20)
		end

feature -- Element change

	extend (an_action: ROUTINE [ANY, TUPLE]) is
			-- Extend `an_action' to `actions'.
		require
			an_action_not_void: an_action /= Void
		do
			mutex.lock
			actions.extend (an_action)
			mutex.unlock
		end

	removed_element: ROUTINE [ANY, TUPLE] is
			-- Remove and return last element from `actions', if any.
			-- Otherwise do nothing and return Void.
			--| Not following CQS principle since it would not be thread safe.
		do
			mutex.lock
			if not actions.is_empty then
				actions.finish
				Result := actions.item
				actions.remove
			end
			mutex.unlock
		end

feature -- Status report

	count: INTEGER is
			-- Number of elements in `actions'.
		do
			mutex.lock
			Result := actions.count
			mutex.unlock
		ensure
			count_non_negative: Result >= 0
		end

feature {NONE} -- Implementation: access

	mutex: MUTEX
			-- Mutex used for protecting access to `actions'.

	actions: ARRAYED_LIST [ROUTINE [ANY, TUPLE]]
			-- List of actions being executed.

invariant
	mutex_not_void: mutex /= Void
	actions_not_void: actions /= Void

end
