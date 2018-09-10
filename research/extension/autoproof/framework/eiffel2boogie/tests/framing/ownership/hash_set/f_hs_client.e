note
	description: "Client of hash sets."
	manual_inv: true

class
	F_HS_CLIENT

feature -- Test

	test
			-- Test typical operations on hash sets.
		local
			i, j, k: F_HS_KEY
			lock: F_HS_LOCK [F_HS_KEY]
			s1, s2: F_HS_SET [F_HS_KEY]
		do
			-- Create two sets that share the same lock
			-- (this would allow them to share elements).
			create lock

			create s1.make (lock)
			check s1.inv end
			lock.add_set (s1)

			create s2.make (lock)
			check s2.inv end
			lock.add_set (s2)

			-- Create some elements and add them to `s1'.

			create i.set_value (1)
			create j.set_value (2)
			lock.lock (i)
			lock.lock (j)
			check i.value = 1 end
			check j.value = 2 end

			s1.extend (i)
			check s1.set.count = 1 end
			check s1.set_has (i) end
			check not s1.set_has (j) end

			s1.extend (j)
			check s1.set_has (i) end
			check s1.set_has (j) end

			-- Add `j' to `s2'.

			s2.extend (j)
			check s2.set_has (j) end
			check not s2.set_has (i) end
			check s1.set_has (i) end
			check s1.set_has (j) end

			-- Join

			s2.join (s1)
			check s2.set_has (i) end
			check s2.set_has (j) end
			check s1.set_has (i) end
			check s1.set_has (j) end

			-- Duplicates

			s1.extend (i)
			check s1.set.count = 2 end

			create k.set_value (1)  	-- `k' is a duplicate of `i'...
			lock.lock (k)
			s1.extend (k)
			check s1.set_has (k) end
			check s1.set.count = 2 end 	-- so not really added

			-- Unlock

			s1.wipe_out
			s2.wipe_out
			lock.unlock (i) 			-- Not used by the sets anymore
			lock.unlock (j) 			-- so can now be unlocked
			check i.is_wrapped end		-- and reused for something else
			check j.is_wrapped end
		end

	test_modification
			-- Test mutation of set elements.
		local
			i, j: F_HS_KEY
			lock: F_HS_LOCK [F_HS_KEY]
			s: F_HS_SET [F_HS_KEY]
		do
			create lock
			create i.set_value (1)
			create j.set_value (2)
			lock.lock (i)
			lock.lock (j)

			create s.make (lock)
			check s.inv end
			lock.add_set (s)
			s.extend (i)

			lock.unwrap
			i.set_value (-1) 	-- OK, no_duplicates and valid_buckets invariants are preserved
			j.set_value (3) 	-- OK, `j' is not contained in any set
			lock.wrap

			s.wipe_out
			lock.unwrap
			i.set_value (3) 	-- OK, `i' is not contained in any set
			lock.wrap
		end

	test_modification_fail
			-- Test illegal mutation of set elements.
		local
			i: F_HS_KEY
			lock: F_HS_LOCK [F_HS_KEY]
			s: F_HS_SET [F_HS_KEY]
		do
			create lock
			create i.set_value (1)
			lock.lock (i)

			create s.make (lock)
			check s.inv end
			lock.add_set (s)
			s.extend (i)

			lock.unwrap
			i.set_value (3) 	-- Bad: `i' will be in a wrong bucket for `s'
			lock.wrap			-- so we cannot wrap the lock here
		end

end
