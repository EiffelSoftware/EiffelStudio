note
	description	: "Objects that describe a waiting room"
	author		: "Robin Stoll"
	date		: "2009/5/16"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	SHOP

create
	make

feature -- Initialization

	make (chair_count: INTEGER)
			-- Initialize shop with `chair_count' chairs.
		require
			chair_count > 0
		do
			max_chairs := chair_count
			free_chairs := chair_count
		end

feature -- Access

	free_chairs: INTEGER
			-- Unoccupied chairs.

feature -- Basic operations

	enter
			-- Enter shop and sit.
		require
			an_unoccupied_chair: free_chairs > 0
		do
			free_chairs := free_chairs - 1
		ensure
			one_fewer_free_chairs: free_chairs = old free_chairs - 1
		end

	leave
			-- Leave the shop.
		do
			free_chairs := free_chairs + 1
		ensure
			free_chairs = old free_chairs + 1
			max_chairs >= free_chairs
		end

feature {NONE} -- Implementation

	max_chairs: INTEGER
			-- Chairs in shop

invariant
	valid_free_chair_count: free_chairs >= 0 and then max_chairs >= free_chairs

end
