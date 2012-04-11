note
	description: "Iterators to read from and update mutable sequences."
	author: "Nadia Polikarpova"
	model: target, sequence, index

deferred class
	V_MUTABLE_SEQUENCE_ITERATOR [G]

inherit
	V_SEQUENCE_ITERATOR [G]

	V_IO_ITERATOR [G]

feature -- Access

	target: V_MUTABLE_SEQUENCE [G]
		deferred
		end

end
