note
	description	: "System's root class"
	author		: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski."
	date		: "$Date: 18.05.2007$"
	revision	: "1.0.0"

class
	PRODUCER_CONSUMER

create
	make

feature -- Initialization

	make
			-- Create and launch separate objects.
		local
			l_producer: separate PRODUCER
			l_consumer: separate CONSUMER
		do
			create buffer.make_with_capacity (buffer_capacity)

			across (1 |..| number_of_producers) as ic loop
				create l_producer.make_with_buffer (buffer, ic.item)
				launch_producer (l_producer)
			end

			across (1 |..| number_of_consumers) as ic loop
				create l_consumer.make_with_buffer (buffer, ic.item)
				launch_consumer (l_consumer)
			end

		end

feature {NONE} -- Implementation

	buffer: separate BOUNDED_BUFFER [INTEGER]
			-- Shared product buffer.

	launch_producer (a_producer: separate PRODUCER)
			-- Launch `a_producer'.
		do
			a_producer.produce (items_per_producer)
		end

	launch_consumer (a_consumer: separate CONSUMER)
			-- Launch `a_consumer'.
		do
			a_consumer.consume (items_per_consumer)
		end


	buffer_capacity: INTEGER = 16
			-- Buffer capacity.

	number_of_producers: INTEGER = 2
			-- Producer count.

	items_per_producer: INTEGER = 900
			-- Production count per producer.

	number_of_consumers: INTEGER = 3
			-- Consumer count.

	items_per_consumer: INTEGER = 600
			-- Consumption per consumer.

end -- class PRODUCER_CONSUMER

