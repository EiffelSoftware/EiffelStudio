note
	manual_inv: True

class
	EB2_TESTER

feature -- Hash tables

	test_hash_table
			-- Test `V_HASH_TABLE'.
		local
			t1: V_HASH_TABLE [EB2_KEY, B_BASIC]
			i, j, k: EB2_KEY
			lock: V_HASH_LOCK [EB2_KEY]
			x, y: B_BASIC
		do
			create lock

			create t1.make (lock)
			check t1.map.is_empty end

			create i.set_value (1)
			create j.set_value (2)
			create k.set_value (1)
			check i.inv; j.inv; k.inv end
			lock.lock (i)
			lock.lock (j)
			lock.lock (k)
			check lock.owns [i] end

			t1.extend (Void, i)
			check t1.has_key (i) end
			check t1.count = 1 end
			x := t1.item (i)
			check x = Void end
			x := t1.item (k)
			check x = Void end

			create y
			t1.put (y, k)
			check t1.count = 1 end
			x := t1.item (i)
			check x = y end

			t1.force (Void, j)
			check t1.map.domain [i] end
			check t1.map.domain [j] end
			check t1.count = 2 end

			check t1.key (k) = i end
			t1.remove (k)
			check not t1.has_key (k) end

			t1.wipe_out
			check t1.count = 0 end
		end

end
