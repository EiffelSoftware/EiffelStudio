note
	description: "Objects that consume strings form a shared buffer."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMER

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

				-- Note: You cannot place the main loop of a consumer
				-- within its creaton procedure, because otherwise it will
				-- hold a lock on `a_queue' throughout its lifecycle.
		end

	queue_wrapper: CP_QUEUE_PROXY [STRING, CP_STRING_IMPORTER]
			-- A wrapper object to a separate queue.

	identifier: INTEGER
			-- Identifier of `Current'.

	item_count: INTEGER
			-- Number of items to consume.

feature -- Basic operations

	start
			-- Consume `item_count' items.
		local
			i: INTEGER
			item: STRING
		do
			from
				i := 1
			until
				i > item_count
			loop
				queue_wrapper.consume

				check attached queue_wrapper.last_consumed_item as l_item then

						-- Note that `item' is not declared as separate, because it has been
						-- imported automatically.
					item := l_item
					print (item + " // Consumer " + identifier.out + ": item " + i.out + "%N")
				end
				i := i + 1
			end
		end

end
