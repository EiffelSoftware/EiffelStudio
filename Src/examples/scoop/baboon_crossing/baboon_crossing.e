note
	description	: "System's root class"
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	BABOON_CROSSING

inherit
	SHARED_RANDOM

create
	make

feature -- Initialization

	make
		-- Creation procedure.
	local
		t_baboon: separate BABOON
		i: INTEGER
	do
		create random.set_seed (max_baboons + 1)
		from
			i := 1
		invariant
			i >= 1
			i <= max_baboons + 1
		variant
			max_baboons - i + 1
		until
			i > max_baboons
		loop
			create t_baboon.make_with_rope (i, rope)
			launch_baboon (t_baboon)
			-- put some delay between baboons generation
			random.forth;
			(create {EXECUTION_ENVIRONMENT}).sleep (random_integer (100, 300) * 1000000)
			i := i + 1
		end
	end

feature {NONE} -- Implementation

	rope: separate ROPE
			-- Reference to separate rope
		once -- Only one rope will be created
			create Result
		end

	max_baboons: INTEGER = 30
			-- Maximum number of baboons

	launch_baboon(a_baboon: separate BABOON)
			-- Launch the baboon.
		do
			a_baboon.live
		end

end
