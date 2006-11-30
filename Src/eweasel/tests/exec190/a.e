class A [G]

feature -- Access

	thread_item: INTEGER is
			-- Current thread-specific value
		do
			Result := thread_storage.item
		end

	process_item: INTEGER is
			-- Current process-wide value
		do
			Result := process_storage.item
		end

	thread_constant: INTEGER is
			-- Current thread-specific constant value
		do
			Result := thread_constant_storage.item (1).code
		end

feature -- Modification

	set_thread_item (new_item: like thread_item) is
		do
			thread_storage.set_item (new_item)
		ensure
			thread_item_set: thread_item = new_item
		end

	set_process_item (new_item: like process_item) is
		do
			process_storage.set_item (new_item)
		ensure
			process_item_set: process_item = new_item
		end

	set_thread_constant (new_item: like thread_item) is
		require
			not_negative: new_item >= 0
			small: new_item <= 127
		do
			thread_constant_storage.put (new_item.to_character_8, 1)
		ensure
			thread_constant_set: thread_constant = new_item
		end

feature {NONE} -- Storage

	thread_storage: INTEGER_REF is
		once
			create Result
		end

	process_storage: INTEGER_REF is
		indexing
			once_status: "global"
		once
			create Result
		end

	thread_constant_storage: STRING is "%/0/"

end
