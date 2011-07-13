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

	make_with_buffer (a_buffer: separate BOUNDED_BUFFER [INTEGER]; a_id: INTEGER)
			-- Initialize with identity `a_id' to consume from `a_buffer'.
		require
			valid_id: a_id > 0
		do
			buffer := a_buffer
			id := a_id
		ensure
			id_set: id = a_id
		end

feature -- Basic operations

	consume (n: INTEGER)
			-- Consume n elements.
		local
			l_element: INTEGER
		do
			across (1 |..| n) as ic
			loop
				print ("%NCONSUMER " + id.out + ": Attempting to consume from shared buffer ... ")
				l_element := consumed_from_buffer (buffer)
				print ("%NCONSUMER " + id.out + ": I've just consumed element " + l_element.out + ".")
			end
		end

	consumed_from_buffer (a_buffer: separate BOUNDED_BUFFER [INTEGER]): INTEGER
			-- Element consumed from buffer.
		require
			buffer_not_empty: not a_buffer.is_empty
		do
			a_buffer.consume
			Result := a_buffer.last_consumed_item
		ensure
			correct_buffer_count: a_buffer.count = old a_buffer.count - 1
		end

feature {NONE} -- Implementation

	buffer: separate BOUNDED_BUFFER [INTEGER]
			-- Shared product buffer.

	id: INTEGER
			-- Unique consumer identifier.

invariant
	valid_id: id > 0

end -- class CONSUMER

