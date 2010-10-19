note
	description: "[
					Class POOL MANAGER supports the resource pooling mechanism accessible
					through call m out of n in class CONCURRENCY.
																							]"
	author: "Piotr Nienaltowski"
	date: "$Date$"
	revision: "$Revision$"

class
	POOL_MANAGER

inherit
	CONCURRENCY

create
	make

feature {NONE} -- Initialization

	make (a_feature : separate ROUTINE [ANY, TUPLE]; i: INTEGER)
			-- Creation procedure.
		require
			i > 0
		do
--			feature_to_apply := a_feature.import -- Non?separate copy
			feature_to_apply := a_feature.deep_twin -- Non?separate copy
			m := i
		ensure
			m = i
			count = 0
		end

feature {LOCKER} -- Feature application

	try_to_apply_feature (a_target : separate ANY)
			-- Apply feature to apply to a target .
			-- Do nothing if already applied the required number of times .
		local
			envoy: separate EXECUTOR
--			envoy: separate <a_target.handler> EXECUTOR
			-- Non?separate from a target. Needed because open?target
			-- agents cannot be applied to separate targets.
		do
			if count < m then
				create envoy.apply_to_target (feature_to_apply, a_target)
				count := count + 1
			end
		end

feature {NONE} -- Implementation

	feature_to_apply: ROUTINE [ANY, TUPLE]
			-- Feature to apply

	m: INTEGER
			-- Requested number of executions

	count: INTEGER
		-- Number of executions already performed

invariant
	m > 0
	count >= 0 and then count <= m
end
