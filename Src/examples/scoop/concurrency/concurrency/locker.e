note
	description: "[
		Class LOCKER is used by the resource pooling mechanism call m out of n.
		One instance of LOCKER is created for each element of the resource pool.
	]"
	author: "Piotr Nienaltowski"
	date: "$Date$"
	revision: "$Revision$"

class
	LOCKER

inherit
	EXECUTOR

create
--	try_to_lock
	lock_target

feature {NONE} -- Initialization

	lock_target (a_target: detachable separate ANY; a_pool_manager: detachable separate POOL_MANAGER)
			-- Creation procedure.
		require
			a_target /= Void
			a_pool_manager /= Void
		do
			if attached {separate POOL_MANAGER} a_pool_manager as p then
				pool_manager := p
			end
			if attached {separate ANY} a_target as t then
				lock_target_and_report ( t )
			end
		end

feature {NONE} -- Implementation

	lock_target_and_report (a_target: separate ANY)
			-- Lock a target and report to pool manager.
		do
			report (pool_manager, a_target)
		end

	report (a_pool_manager: separate POOL_MANAGER; a_target: separate ANY)
			-- Ask a pool manager to apply requested feature to a target .
		do
			a_pool_manager.try_to_apply_feature (a_target)
			-- Lock passing occurs here .
		end

	pool_manager: separate POOL_MANAGER
			-- Resource pool manager

end
