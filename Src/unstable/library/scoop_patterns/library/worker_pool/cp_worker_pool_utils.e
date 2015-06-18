note
	description: "Utility functions to access a separate CP_WORKER_POOL."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_WORKER_POOL_UTILS [G]

inherit
	CP_QUEUE_UTILS [G]

feature -- Access

	wp_preset_worker_count (pool: separate CP_WORKER_POOL [G, CP_IMPORT_STRATEGY [G]]): INTEGER
			-- Preset worker count in `pool'.
		do
			Result := pool.preset_worker_count
		end

	wp_actual_worker_count (pool: separate CP_WORKER_POOL [G, CP_IMPORT_STRATEGY [G]]): INTEGER
			-- Actual worker count in `pool'.
		do
			Result := pool.actual_worker_count
		end

feature -- Basic operations

	wp_set_worker_count (pool: separate CP_WORKER_POOL [G, CP_IMPORT_STRATEGY [G]]; count: INTEGER)
			-- Set the preset worker cound in `pool' to `count'.
		do
			pool.set_worker_count (count)
		end

	wp_stop (pool: separate CP_WORKER_POOL [G, CP_IMPORT_STRATEGY [G]])
			-- Stop `pool'.
		do
			pool.stop
		end

end
