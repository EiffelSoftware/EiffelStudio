note
	description: "[
					Class EXECUTOR is used by asynch and resource pooling mechanisms; 
					it also serves as ancestor for EVALUATOR used in parallel wait and
					for LOCKER used in call m out of n
																						]"
	author: "Piotr Nienaltowski"
	date: "$Date$"
	revision: "$Revision$"

class
	EXECUTOR

inherit
	CONCURRENCY

create
	execute, apply_to_target

feature {NONE} -- Initialization

	execute (a_feature : ?separate ROUTINE [ANY, TUPLE])
			-- Execute a feature
		require
			a_feature /= Void
		do
			if {f : separate ROUTINE [ANY, TUPLE]}a_feature then
				call (f)
			end
		end

	apply_to_target (a_feature : separate ROUTINE [ANY, TUPLE]; a_target : ANY)
			-- Apply a feature to a target (synchronously) .
		do
--			a_feature.import.call ([a_target])
			a_feature.twin.call ([a_target])
		end

end
