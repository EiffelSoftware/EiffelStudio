note
	description : "Class representing a baboon."
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	BABOON

inherit
	SHARED_RANDOM
		redefine
			out
		end

create {BABOON_CROSSING}

	make_with_rope

feature {NONE} -- Initialization

	make_with_rope (a_id: INTEGER; a_rope: separate ROPE)
			-- Creation procedure.
		require
			a_id_positive: a_id > 0
			a_rope_not_void: a_rope /= Void
		do
			id := a_id
			rope := a_rope
			-- set the direction randomly
			create random.set_seed (id)
			random.forth
			direction := random_integer (1, 4) /= 1
			io.put_string (out + " brought to life%N")
		ensure
			id_set: id = a_id
			rope_set: rope = a_rope
		end

feature -- Access

	id: INTEGER
			-- ID of baboon

	direction: BOOLEAN
			-- Direction of baboon passing the rope
			-- true: left
			-- false: right

	out: STRING
			-- How to print this?
		once
			if direction then
				Result := "Baboon-" + id.out + "[left]"
			else
				Result := "Baboon-" + id.out + "[right]"
			end
		end

feature {BABOON_CROSSING} -- Basic operations

	live
			-- Live.
		do
			-- announce the rope
			announce (rope)
			-- mount on the rope
			mount (rope)
			-- traverse the rope
			traverse
			-- unmount from the rope
			unmount (rope)
		end

feature {NONE} -- Implementation

	announce (a_rope: separate ROPE)
			-- Announce.
		do
			io.put_string (out + " announcing%N")
			a_rope.announce (Current)
		end

	mount (a_rope: separate ROPE)
			-- Mount on rope.
		require
			-- wait until the rope is safe
			a_rope.is_secure
			-- check if the rope is ready for you to pass according to your direction
			a_rope.direction = direction
		do
			io.put_string (out + " mounting on rope%N")
			a_rope.mount
		end

	traverse
			-- Traverse the rope.
		do
			io.put_string (out + " traversing%N")
			-- wait randomly sometime for your traverse
			random.forth;
			(create {EXECUTION_ENVIRONMENT}).sleep (random_integer (500, 1500) * 1000000)
		end

	unmount (a_rope: separate ROPE)
			-- Unmount from the rope.
		do
			io.put_string (out + " unmounting%N")
			a_rope.unmount (Current)
		end

	rope: separate ROPE
			-- Reference to separate rope

invariant

	id_positive: id > 0

	rope_not_void: rope /= Void

end
