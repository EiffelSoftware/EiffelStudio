indexing
	description	: "Objects that implement producers."
	author		: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski."
	date		: "$Date: 18.05.2007$"
	revision	: "1.0.0"


class
	PRODUCER

create
	make_with_buffer

feature -- Initialization

	make_with_buffer (a_buffer: attached separate BOUNDED_BUFFER [INTEGER]; an_id: INTEGER)
			-- Creation procedure.
		require
			a_buffer /= void
		do
			buffer := a_buffer
			id := an_id
			create random.make
		end

feature -- Basic operations

	produce (n: INTEGER)
			-- Produce n elements		
		local
			i, an_element: INTEGER
		do
			from
				i := 1
			until
				i > n
			loop
				an_element := random.next_random (an_element + id)
				store (buffer, an_element)
				io.put_string  ("%NPRODUCER " + id.out + ": I've just stored element " + an_element.out)
				i := i + 1
			end
		end

feature {NONE}

	store (a_buffer: attached separate BOUNDED_BUFFER [INTEGER]; an_element: INTEGER)
			-- Store `an_element' into `a_buffer'.
		require
			a_buffer /= void
			not a_buffer.is_full
		do
			a_buffer.put (an_element)
		ensure
			not a_buffer.is_empty
			a_buffer.count = old a_buffer.count + 1
		end

feature {NONE} -- Implementation

	buffer: attached separate BOUNDED_BUFFER [INTEGER]

	id: INTEGER

	random: RANDOM

invariant
	buffer_not_void: buffer /= void

end -- class PRODUCER
