note
	description: "Slave clock whose time must not exceed its master's."
	explicit: "all"

class F_MC_CLOCK_D

create
	make

feature {NONE} -- Initialization

	make (m: F_MC_MASTER_D)
			-- Create a slave clock with master `m'.
		note
			status: creator
		require
			m_exists: m /= Void
			default_arg_wrapped: m.is_wrapped
			modify (Current)
			modify_field (["observers", "closed"], m)
		do
			master := m
			local_time := master.time
			set_subjects ([m])

			m.unwrap
			m.set_observers (m.observers + [Current])
			m.wrap
			wrap
		ensure
			master_set: master = m
			time_synchronized: local_time = m.time
			observing_master: m.observers = old m.observers + [Current]
			default_wrapped: is_wrapped
			default_arg_wrapped: m.is_wrapped
		end

feature -- Access

	master: F_MC_MASTER_D
			-- Master of this clock.

	local_time: INTEGER
			-- Local copy of master's time.

feature -- Update

	sync
			-- Sync clock to master.			
		require
			free: is_free
			partially_holds: inv_without ("time_weakly_synchronized")
			master_wrapped: master.is_wrapped
			modify_field (["local_time", "closed"], Current)
		do
			if closed then
				unwrap
			end
			local_time := master.time
			wrap
		ensure
			time_synchronized: local_time = master.time
			wrapped: is_wrapped
		end

invariant
	master_exists: attached master
	subjects_structure: subjects = [master]
	time_non_negative: 0 <= local_time
	time_weakly_synchronized: local_time <= master.time
	master_aware: master.observers [Current]
	default_owns: owns = []
	default_observers: observers = []

end
