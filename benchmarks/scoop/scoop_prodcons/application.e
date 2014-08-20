class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	max_workers: INTEGER

	make
		local
			producer: separate PRODUCER
			producers: LINKED_LIST [separate PRODUCER]
			consumer: separate CONSUMER
			consumers: LINKED_LIST [separate CONSUMER]
			shared: separate SHARED_QUEUE [INTEGER]
			i: INTEGER
			max: INTEGER
		do
			max := argument (1).to_integer_32
			max_workers := argument (2).to_integer_32
			create shared.make
			create producers.make
			from
				i := 1
			until
				i > max_workers
			loop
				create producer.make (shared, max)
				run_producer (producer)
				producers.extend (producer)
				i := i + 1
			end
			create consumers.make
			from
				i := 1
			until
				i > max_workers
			loop
				create consumer.make (shared, max)
				run_consumer (consumer)
				consumers.extend (consumer)
				i := i + 1
			end
			from
				i := 1
			until
				i > max_workers
			loop
				run_consumer (consumers [i])
				run_producer (producers [i])
				i := i + 1
			end
			wait_producers (producers)
			wait_consumers (consumers)
		end

	run_consumer (worker: separate CONSUMER)
		do
			worker.live
		end

	run_producer (worker: separate PRODUCER)
		do
			worker.live
		end

	wait_consumers (workers: LIST [separate CONSUMER])
		do
			across
				workers as wc
			loop
				wait_consumer (wc.item)
			end
		end

	wait_consumer (worker: separate CONSUMER)
		require
			worker.generator /= Void
		do
			print ("Consumer done%N")
		end

	wait_producers (workers: LIST [separate PRODUCER])
		do
			across
				workers as wc
			loop
				wait_producer (wc.item)
			end
		end

	wait_producer (worker: separate PRODUCER)
		require
			worker.generator /= Void
		do
			print ("Producer done%N")
		end

end
