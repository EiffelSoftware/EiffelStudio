note
	description : "Test harness."
	explicit: "all"

class F_MC_CLIENT

feature -- Test

	test
			-- Use master and slave clocks.
		local
			m: F_MC_MASTER
			c1, c2: F_MC_CLOCK
		do
			create m.make
			create c1.make (m)
			create c2.make (m)

			m.tick
			-- Still weakly synchronized, according to the invariant
			check c1_in_synch: c1.local_time <= m.time end
			check c2_in_synch: c2.local_time <= m.time end

			c1.sync
			c2.sync

			unwrap_all ([c1, c2])
			m.reset
			-- sync can be called on both wrapped and open clocks:
			c1.sync
			c2.sync

			-- Synchronized again, thanks to sync
			check c1_in_synch: c1.local_time <= m.time end
			check c2_in_synch: c2.local_time <= m.time end
		end

	test_d
			-- Use master and slave clocks.
		local
			m: F_MC_MASTER_D
			c1, c2: F_MC_CLOCK_D
		do
			create m.make
			create c1.make (m)
			create c2.make (m)

			m.tick
			-- Still weakly synchronized, according to the invariant
			check c1_in_synch: c1.local_time <= m.time end
			check c2_in_synch: c2.local_time <= m.time end

			c1.sync
			c2.sync

			unwrap_all ([c1, c2])
			m.reset
			-- sync can be called on both wrapped and open clocks:
			c1.sync
			c2.sync

			-- Synchronized again, thanks to sync
			check c1_in_synch: c1.local_time <= m.time end
			check c2_in_synch: c2.local_time <= m.time end
		end

invariant
	default_owns: owns.is_empty
	default_subjects: subjects.is_empty
	default_observers: observers.is_empty

end
