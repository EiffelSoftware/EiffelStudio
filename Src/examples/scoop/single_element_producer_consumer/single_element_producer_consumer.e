note
	description: "Application root class"
	date       : "$Date$"
	revision   : "$Revision$"

class
	SINGLE_ELEMENT_PRODUCER_CONSUMER

create
	make

feature {NONE} -- Initialization

	make
		do
			create inventory.make
			create single_producer.make (item_count, inventory)
			create single_consumer.make (item_count, inventory)
			run (single_producer, single_consumer)
		end

feature -- Access

	single_producer: separate PRODUCER
			-- Single producer

	single_consumer: separate CONSUMER
			-- Single consumer

	inventory: separate INVENTORY
			-- Single element inventory

	item_count: INTEGER = 1500
			-- Items to produce and consume

feature -- Basic operations

	run (l_p: separate PRODUCER; l_c: separate CONSUMER)
		do
			l_p.live
			l_c.live
		end

end
