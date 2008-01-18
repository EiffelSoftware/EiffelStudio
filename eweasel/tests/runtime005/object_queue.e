indexing
	description: "Safe list of actions for multithreaded system."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_QUEUE

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize current
		do
			create mutex.make
			create protected_objects.make (1000)
			create frozen_objects.make (1000)
		end

feature -- Element change

	push_protected (an_object: POINTER) is
			-- Insert element in queue.
		require
			an_object_not_null: an_object /= default_pointer
		do
			mutex.lock
			protected_objects.extend (an_object)
			mutex.unlock
		end

	push_frozen (an_object: ANY) is
			-- Insert element in queue.
		require
			an_object_not_null: an_object /= Void
		do
			mutex.lock
			frozen_objects.extend (an_object)
			mutex.unlock
		end

feature -- Statu

	pop_protected: POINTER is
			-- Return last element of queue.
		do
			mutex.lock
			if protected_objects.readable then
				Result := protected_objects.item
				protected_objects.remove
			end
			mutex.unlock
		end

	pop_frozen: ANY is
			-- Return last element of `frozen_objects'.
		do
			mutex.lock
			if frozen_objects.readable then
				Result := frozen_objects.item
				frozen_objects.remove
			end
			mutex.unlock
		end

feature {NONE} -- Implementation: access

	mutex: MUTEX
			-- Mutex used for protecting access to `protected_objects'.

	protected_objects: ARRAYED_QUEUE [POINTER]
			-- List of actions being executed.

	frozen_objects: ARRAYED_QUEUE [ANY]
			-- List of actions being executed.

invariant
	mutex_not_void: mutex /= Void
	actions_not_void: protected_objects /= Void

end
