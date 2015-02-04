note
	description: "Mock objects for worker result aggregation."
	author: "Florian Besser, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	AGGREGATOR

feature

	receive_worker (worker: separate WORKER)
			-- Receive the result from `worker'.
		local
			retried: BOOLEAN
			sync: INTEGER
		do
			if not retried then
					-- Although `worker' suffered an exception, it should not propagate here, because
					-- the processor that was initially client when it happened released the lock afterwards.
				sync := worker.counter
			end
		rescue
			print ("ERROR: In rescue of {AGGREGATOR}.receive_worker.%N")
			retried := True
			retry
		end

end
