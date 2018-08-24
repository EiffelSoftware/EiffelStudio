note
	description: "Test harness."
	explicit: "all"

class F_DLL_CLIENT

feature -- Test

	test
			-- Using doubly-linked list nodes.
		local
			n1, n2: F_DLL_NODE
		do
			create n1.make
			check n1_singleton: n1.left = n1 end

			n1.insert_right (n1)
			check n1_singleton: n1.left = n1 end

			create n2.make
			n1.insert_right (n2)
			check connected: n1.left = n2 and n2.left = n1 end

			n2.remove
			check n2_singleton: n2.left = n2 end
			check n1_singleton: n1.left = n1 end
		end

	test_d
			-- Using doubly-linked list nodes.
		local
			n1, n2: F_DLL_NODE_D
		do
			create n1.make
			check n1_singleton: n1.left = n1 end

			n1.insert_right (n1)
			check n1.inv end
			check n1_singleton: n1.left = n1 end

			create n2.make
			n1.insert_right (n2)
			check connected: n1.left = n2 and n2.left = n1 end

			n2.remove
			check n2_singleton: n2.left = n2 end
			check n1_singleton: n1.left = n1 end
		end

invariant
	default_owns: owns.is_empty
	default_subjects: subjects.is_empty
	default_observers: observers.is_empty
end
