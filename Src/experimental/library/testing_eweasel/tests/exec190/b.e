class B [G]

inherit
	A [G]
$REPLICATION		select
$REPLICATION			thread_storage,
$REPLICATION			process_storage,
$REPLICATION			thread_constant_storage
$REPLICATION		end

$REPLICATION	A [G]
$REPLICATION		rename
$REPLICATION			thread_storage as thread_storage_2,
$REPLICATION			process_storage as process_storage_2,
$REPLICATION			thread_constant_storage as thread_constant_storage_2
$REPLICATION		end

feature -- Access

	thread_item_2: INTEGER is
			-- Current thread-specific value
		do
			Result := thread_storage_2.item
		end

	process_item_2: INTEGER is
			-- Current process-wide value
		do
			Result := process_storage_2.item
		end

	thread_constant_2: INTEGER is
			-- Current thread-specific constant value
		do
			Result := thread_constant_storage_2.item (1).code
		end

feature -- Modification

	set_thread_item_2 (new_item: like thread_item_2) is
		do
			thread_storage_2.set_item (new_item)
		ensure
			thread_item_2_set: thread_item_2 = new_item
		end

	set_process_item_2 (new_item: like process_item_2) is
		do
			process_storage_2.set_item (new_item)
		ensure
			process_item_2_set: process_item_2 = new_item
		end

	set_thread_constant_2 (new_item: like thread_constant_2) is
		require
			not_negative: new_item >= 0
			small: new_item <= 127
		do
			thread_constant_storage_2.put (new_item.to_character_8, 1)
		ensure
			thread_constant_2_set: thread_constant_2 = new_item
		end

feature {NONE} -- Storage

$NO_REPLICATION	thread_storage_2: INTEGER_REF is
$NO_REPLICATION		once
$NO_REPLICATION			create Result
$NO_REPLICATION		end

$NO_REPLICATION	process_storage_2: INTEGER_REF is
$NO_REPLICATION		indexing
$NO_REPLICATION			once_status: "global"
$NO_REPLICATION		once
$NO_REPLICATION			create Result
$NO_REPLICATION		end

$NO_REPLICATION	thread_constant_storage_2: STRING is "%/0/"

end
