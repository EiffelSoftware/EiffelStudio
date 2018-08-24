note
	description : "Test harness."
	explicit: "all"

class F_I_CLIENT

feature -- Test

	test
			-- Use collections and iterators.
		local
			c: F_I_COLLECTION
			i1, i2: F_I_ITERATOR
			v: INTEGER
		do
			create c.make (10)
			c.add (1)
			c.add (2)

			create i1.make (c)
			i1.forth
			if not i1.after then
				v := i1.item
			end

			create i2.make (c)
			i2.forth
			if not i2.after then
				v := i2.item
			end

			c.remove_last

			-- Comment out the following line to see that
			-- the client cannot access disabled iterators:
			create i1.make (c)
			if not i1.after then
				i1.forth
			end

		end

	test_d
			-- Use collections and iterators.
		local
			c: F_I_COLLECTION_D
			i1, i2: F_I_ITERATOR_D
			v: INTEGER
		do
			create c.make (10)
			c.add (1)
			c.add (2)

			create i1.make (c)
			i1.forth
			if not i1.after then
				v := i1.item
			end

			create i2.make (c)
			i2.forth
			if not i2.after then
				v := i2.item
			end

			c.remove_last

			-- Comment out the following line to see that
			-- the client cannot access disabled iterators:
			create i1.make (c)
			if not i1.after then
				i1.forth
			end

		end

invariant
	default_owns: owns.is_empty
	default_subjects: subjects.is_empty
	default_observers: observers.is_empty
end
