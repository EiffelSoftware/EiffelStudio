note
	description: "Objects that produce strings and put them in a shared buffer."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PRODUCER

inherit
	CP_STARTABLE

create
	make

feature {NONE} -- Initialization

	make (a_queue: separate CP_QUEUE [STRING, CP_STRING_IMPORTER]; a_identifier: INTEGER; a_item_count: INTEGER)
			-- Initialization for `Current'.
		do
			identifier := a_identifier
			item_count := a_item_count
			create queue_wrapper.make (a_queue)
		end

	queue_wrapper: CP_QUEUE_PROXY [STRING, CP_STRING_IMPORTER]
			-- A wrapper object to a separate queue.

	identifier: INTEGER
			-- Identifier of `Current'.

	item_count: INTEGER
			-- Number of items to produce.

feature -- Basic operations

	start
			-- Produce `item_count' items.
		local
			i: INTEGER
			item: STRING
		do
			from
				i := 1
			until
				i > item_count
			loop
					-- Note that there's no need to declare `item' as separate, because
					-- it will be imported anyway.
				item := "Producer: " + identifier.out + ": item " + i.out
				queue_wrapper.put (item)
				i := i + 1
			end
		end

end
