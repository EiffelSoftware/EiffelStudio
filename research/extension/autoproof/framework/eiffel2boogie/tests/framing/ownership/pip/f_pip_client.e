note
	description: "Test harness."
	explicit: "all"

class F_PIP_CLIENT

feature -- Test

	test
			-- Using PIP nodes.
		local
			c1, c2, c3: F_PIP_NODE
			a1, a2, a3: MML_SET [F_PIP_NODE]
		do
			create c1.make (1)
			create c2.make (2)
			create c3.make (0)

			a1 := << c1 >>
			c1.acquire (c2, a1)
			check c1.value = 2 end

			a2 := << c1, c2 >>
			c2.acquire (c3, a2)
			check c1.value = 2 end
			check c2.value = 2 end
			check c3.value = 0 end

			a3 := << c1, c2, c3 >>
			c3.acquire (c1, a3)
			check c1.value = c2.value end
			check c2.value = c3.value end
			check c3.value = 2 end
		end

	test_d
			-- Using PIP nodes.
		local
			c1, c2, c3: F_PIP_NODE_D
			a1, a2, a3: MML_SET [F_PIP_NODE_D]
		do
			create c1.make (1)
			create c2.make (2)
			create c3.make (0)

			a1 := << c1 >>
			c1.acquire (c2, a1)
			check c1.value = 2 end

			a2 := << c1, c2 >>
			c2.acquire (c3, a2)
			check c1.value = 2 end
			check c2.value = 2 end
			check c3.value = 0 end

			a3 := << c1, c2, c3 >>
			c3.acquire (c1, a3)
			check c1.value = c2.value end
			check c2.value = c3.value end
			check c3.value = 2 end
		end

invariant
	default_owns: owns.is_empty
	default_subjects: subjects.is_empty
	default_observers: observers.is_empty
end
