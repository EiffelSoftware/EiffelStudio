note
	description: "[
		A task that can be executed whenever there are free computing resources.

		This is an emulation of a real workload where an agent is created in a passive region and is registered for execution in a given processor pool.
		The class is used solely for illustrative purposes to demonstrate that some computation in a passive region can be automatically scheduled for execution by an active processor.
	]"

class TASK

create
	make

feature {NONE} -- Creation

	make (p: separate PROCESSOR_POOL; m: NATURAL_64; i: NATURAL_32)
			-- Create a task of number `i` that will execute an action for `m` milliseconds on a free processor the from processor pool `p`.
		do
			p.add_task (agent (d: NATURAL_64; n: NATURAL_32)
				do
					print ("Starting task #" + n.out + "%N")
					{EXECUTION_ENVIRONMENT}.sleep ((d * 1_000_000).as_integer_64)
					print ("Finishing task #" + n.out + "%N")
				end (m, i))
		end

note
	author: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2018, Eiffel Software"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
