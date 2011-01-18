note
	description : "Class representing a rope."
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	ROPE

feature -- Access

	direction: BOOLEAN
			-- shows the current direction of baboons on the rope
			-- true: left
			-- false: right

	is_secure: BOOLEAN
			-- true if the rope is secure to pass
		do
			Result := baboons < capacity and not changing
		end

feature -- Basic operations

	announce (a_baboon: separate BABOON)
			-- Each baboon should announce the rope first
		do
			-- If nobody else is waiting to use the rope
			if directions.is_empty then
				-- Check if the direction of newly announced baboon is the same as the others on the rope
				if baboons > 0 then
					changing := direction /= a_baboon.direction
				end
				-- Set the direction of the rope to his direction for next usage
				direction := a_baboon.direction

			end
			-- add his direction to the queue
			directions.extend (a_baboon.direction)
		end

	mount
			-- Mount the baboon on the rope
		do
			-- increment the number of baboons on the rope
			baboons := baboons + 1
			-- remove the direction of baboon who is mounted now
			directions.remove
			-- if other baboons are waiting to use the rope,
			if not directions.is_empty then
				-- we have two cases:
				-- if the next baboon wants to pass in the same direction, changing would be false
				-- else if he wants to pass in the opposite direction, changing would be true
				changing := direction /= directions.item
				-- set the rope direction in a way that the next baboon can use it
				direction := directions.item
			end
		end

	unmount (a_baboon: separate BABOON)
			-- Unmount the baboon from the rope
		do
			-- decrement the baboons amount who are passing the rope
			baboons := baboons - 1
			-- if there is no more baboon on the rope and we have been waiting to change the direction
			if baboons = 0 and changing then
				-- it is now time to change the direction. (by setting the changing to true, the rope will be safe to pass)
				changing := False
			end
		end

feature {NONE} -- Implementation

	capacity: INTEGER = 5
			-- Maximum number of baboons on rope

	baboons: INTEGER
			-- Actual number of baboons on rope

	changing: BOOLEAN
			-- Are we changing direction? Should we wait to free the rope and change the direction

	directions: LINKED_QUEUE [BOOLEAN]
			-- List of announced directions
			-- Each baboon who wants to use the rope should add his direction to this queue.
		once
			create Result.make
		end

invariant

	rope_safety: baboons <= capacity and baboons >= 0

end
