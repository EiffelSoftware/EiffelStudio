indexing
	description	: "A class that contains a stone."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_STONABLE

feature -- Access

	stone: STONE is
			-- Stone representing Current
		deferred
		end
	
feature -- Element change

	set_stone (new_stone: STONE) is
			-- Make `s' the new value of stone.
			-- Changes display as a consequence, to preserve the fact
			-- that the tool displays the content of the stone
			-- (when there is a stone).
		deferred
		ensure
--| FIXME VB set: equal (new_stone, stone)
		end

feature {NONE} -- implementation

	refresh is
			-- Synchronize Current with `stone'.
		deferred
		end

end -- class EB_STONABLE
