note
	description:
		"[
			An import strategy that copies separate objects to the local processor.
			
			Use this strategy for small objects where the cost of a copy is smaller
			than the creation of a new thread.
			
			Note: In order to actually achieve a performance gain, objects which
			are passed to a component making use of this importer should be non-separate
			with respect to the client of such a component.
			
			E.g. `task' should not be declared separate in the following example:
			
				put_new_task (pool: separate CP_WORKER_POOL [MY_TASK, CP_IMPORT [MY_TASK]])
						-- Add a new task in `pool'.
					local
						task: MY_TASK
					do
						create task
						pool.put (task)
					end

			(`pool' is the component, `Current' is a client to `pool', and `task' is the object.)
		]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CP_IMPORTER [G]

inherit
	CP_IMPORT_STRATEGY [G]

feature

	import (object: separate G): G
			-- Copy `object' to the local processor.
		deferred
		end

end
