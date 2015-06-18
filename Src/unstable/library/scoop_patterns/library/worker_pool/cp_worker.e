note
	description: "Worker objects that are part of a worker pool."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CP_WORKER [G, IMPORTER -> CP_IMPORT_STRATEGY [G] create default_create end]

inherit
	CP_CONTINUOUS_PROCESS

feature {NONE} -- Initialization

	make (a_pool: separate CP_WORKER_POOL [G, IMPORTER])
			-- Initialization for `Current'.
		do
			pool := a_pool
			create importer
		ensure
			pool_set: pool = a_pool
		end

	importer: IMPORTER
			-- The import strategy for `Current'.

feature -- Access

	pool: separate CP_WORKER_POOL [G, IMPORTER]
			-- The worker pool of which `Curent' is a part of.

feature -- Basic operations

	step
			-- <Precursor>
		local
			l_item: detachable like importer.import
		do
			l_item := do_fetch (pool)
			if not is_stopped and attached l_item then
				do_work (l_item)
			end
		end

	do_work (a_item: like importer.import)
			-- Perform the work on `a_item'.
		deferred
		end

feature {NONE} -- Implementation

	do_fetch (a_pool: separate like pool): detachable like importer.import
			-- Fetch a new item.
		require
			wait_on_empty: not a_pool.is_empty or a_pool.is_stop_requested
		do
			if a_pool.is_stop_requested then
				is_stopped := True
				a_pool.remove_actual_worker
			else
				Result := importer.import (a_pool.item)
				a_pool.remove
			end
		end

end
