note
	description: "Root class for the producer/consumer example."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PRODUCER_CONSUMER

inherit
	CP_STARTABLE_UTILS

create
	make

feature {NONE} -- Initialization

	make
			-- Launch the producer and consumers.
		local
				-- Note the choice of types: We want to copy strings across processor boundaries,
				-- therefore we use a CP_STRING_IMPORTER.
				-- An alternative would be to avoid copies with CP_NO_IMPORT, but then a new
				-- processor has to be created for every string object.
			l_queue: separate CP_QUEUE [STRING, CP_STRING_IMPORTER]
			l_producer: separate PRODUCER
			l_consumer: separate CONSUMER
		do
			print ("%NStarting producer/consumer example. %N%N")

				-- Create a shared bounded queue for data exchange.
			create l_queue.make_bounded (queue_size)

				-- Create and launch the consumers.
			across 1 |..| consumer_count as i loop
				create l_consumer.make (l_queue, i.item, items_per_consumer)
				async_start (l_consumer)
			end

				-- Create and launch the producers.
			across 1 |..| producer_count as i loop
				create l_producer.make (l_queue, i.item, items_per_producer)
				async_start (l_producer)
			end

		end


feature -- Constants

	queue_size: INTEGER = 5

	producer_count: INTEGER = 10

	consumer_count: INTEGER = 10

	items_per_producer: INTEGER = 20

	items_per_consumer: INTEGER = 20

invariant
	equal_values: producer_count * items_per_producer = consumer_count * items_per_consumer
end
