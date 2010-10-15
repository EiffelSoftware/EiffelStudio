indexing
	description	: "System's root class"
	author		: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski."
	date		: "$Date: 18.05.2007$"
	revision	: "1.0.0"

class
	APPLICATION

create
	make

feature -- Initialization

	make
			-- Creation procedure.
		local
			i: INTEGER
			producer: separate PRODUCER
			consumer: separate CONSUMER
		do
			create buffer.make_with_capacity (15)

			from
				i := 1
			until
				i > 2
			loop
				create producer.make_with_buffer (buffer, i)
				launch_producer (producer)
				i := i + 1
			end
			from
				i := 1
			until
				i > 3
			loop
				create consumer.make_with_buffer (buffer, i)
				launch_consumer (consumer)
				i := i + 1
			end

		end

feature -- Implementation

	buffer: separate BOUNDED_BUFFER [INTEGER]

	launch_producer (a_producer: separate PRODUCER) is
			-- Launch `a_producer'.
		do
			a_producer.produce (900)
		end

	launch_consumer (a_consumer: separate CONSUMER) is
			-- Launch `a_consumer'.
		do
			a_consumer.consume (600)
		end

end -- class APPLICATION
