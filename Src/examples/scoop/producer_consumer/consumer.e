note
	description	: "Objects that implement consumers."
	author		: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski."
	date		: "$Date: 18.05.2007$"
	revision	: "1.0.0"

class
	CONSUMER

create
	make_with_buffer

feature -- Initialization

	make_with_buffer (a_buffer: separate BOUNDED_BUFFER [INTEGER]; an_id: INTEGER)
			-- Creation procedure.
		require
			a_buffer /= void
		do
			buffer := a_buffer
			id := an_id
		end

feature -- Basic operations

	consume (n: INTEGER)
			-- Consume n elements		
		local
			i, an_element: INTEGER
		do
			from
				i := 1
			until
				i > n
			loop
				an_element := consumed_from_buffer (buffer)
				io.put_string  ("%NCONSUMER " + id.out + ": I've just consumed element " + an_element.out)
				i := i + 1
			end
		end

	consumed_from_buffer (a_buffer: separate BOUNDED_BUFFER [INTEGER]): INTEGER
			-- Element consumed from buffer.
		require
			a_buffer /= void
			not a_buffer.is_empty
		do
			Result := a_buffer.get
		ensure
			a_buffer.count = old a_buffer.count - 1
		end

feature {NONE} -- Implementation

	buffer: separate BOUNDED_BUFFER [INTEGER]

	id: INTEGER

invariant
	buffer_not_void: buffer /= void

end -- class CONSUMER
