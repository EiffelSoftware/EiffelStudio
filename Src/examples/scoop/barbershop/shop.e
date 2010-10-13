indexing
	description	: "Objects that describe a waiting room"
	author		: "Robin Stoll"
	date		: "2009/5/16"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	SHOP

create
	make

feature -- Constructor

	make (count_chairs: INTEGER) is
			-- Initialization
			require
				count_chairs > 0
			do
				max_chairs := count_chairs -- used for validity check
				free_chairs := count_chairs
			end

feature

	enter: BOOLEAN is
			-- enter shop and try to sit
			do
				if free_chairs > 0 then
					free_chairs := free_chairs - 1
					Result := true
				else
					Result := false
				end
			ensure
				free_chairs = 0 or free_chairs = old free_chairs - 1 -- check validity of shop state
				(free_chairs = 0 and Result = false) or Result = true -- check validity of result
			end

	leave is
			-- leaves the shop
			do
				free_chairs := free_chairs + 1
			ensure
				free_chairs = old free_chairs + 1
				max_chairs >= free_chairs
			end

feature {NONE} -- Implementation

	max_chairs: INTEGER
	free_chairs: INTEGER

invariant

	free_chairs >= 0
	max_chairs >= free_chairs

end
