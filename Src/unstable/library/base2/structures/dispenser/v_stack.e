note
	description: "Dispensers where the latest added element is accessible."
	author: "Nadia Polikarpova"
	model: sequence

deferred class
	V_STACK [G]

inherit
	V_DISPENSER [G]
		redefine
			is_equal,
			extend
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is stack made of the same values in the same order as `other'?
			-- (Use reference comparison.)
		local
			i, j: V_ITERATOR [G]
		do
			if other = Current then
				Result := True
			elseif count = other.count then
				from
					Result := True
					i := new_cursor
					j := other.new_cursor
				until
					i.after or not Result
				loop
					Result := i.item = j.item
					i.forth
					j.forth
				end
			end
		ensure then
			definition: Result = (sequence |=| other.sequence)
		end

feature -- Extension

	extend (v: G)
			-- Push `v' on the stack.
		deferred
		ensure then
			sequence_effect: sequence |=| old sequence.prepended (v)
		end
end
