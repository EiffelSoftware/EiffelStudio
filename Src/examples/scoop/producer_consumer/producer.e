note
	description	: "Objects that implement producers."
	author		: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski."
	date		: "$Date: 18.05.2007$"
	revision	: "1.0.0"

class
	PRODUCER

create
	make_with_buffer

feature -- Initialization

	make_with_buffer (a_buffer: separate BOUNDED_BUFFER [INTEGER]; a_id: INTEGER)
			-- Initialize with identifier `a_id' to produce into `a_buffer'.
		require
			valid_id: a_id > 0
		do
			buffer := a_buffer
			id := a_id
			create random.make
		ensure
			id_set: id = a_id
		end

feature -- Basic operations

	produce (n: INTEGER)
			-- Produce n elements.
		require
			valid_n: n >= 0
		local
			l_element: INTEGER
		do
			across (1 |..| n) as ic
			loop
				l_element := random.next_random (l_element + id)
				print ("%NPRODUCER " + id.out + ": Attempting to store element " + l_element.out + " ...")
				store (buffer, l_element)
				print ("%NPRODUCER " + id.out + ": I've just stored element " + l_element.out + ".")
			end
		end

feature {NONE}

	store (a_buffer: separate BOUNDED_BUFFER [INTEGER]; an_element: INTEGER)
			-- Store `an_element' into `a_buffer'.
		require
			not a_buffer.is_full
		do
			a_buffer.put (an_element)
		ensure
			not a_buffer.is_empty
			a_buffer.count = old a_buffer.count + 1
		end

feature {NONE} -- Implementation

	buffer: separate BOUNDED_BUFFER [INTEGER]
			-- Shared product buffer.

	id: INTEGER
			-- Unique identifier.

	random: RANDOM
			-- Pseudo-random sequence.

invariant
	valid_id: id > 0

end -- class PRODUCER

