
-- We are not using ARRAY [STRING] because `is_equal' or `deep_equal' are not
-- what we want

class EXTERNALS_LIST

inherit
	ARRAY [STRING]

creation
	make

feature

	equiv (other: like Current): BOOLEAN is
		local
			i, nb: INTEGER
		do
			if
				other /= Void
			and then
				lower = other.lower
			and then
				upper = other.upper
			then
				from
					i := lower
					nb := upper
					Result := True
				until
					i > nb or else not Result
				loop
					Result := item (i).is_equal (other.item (i))
					i := i + 1
				end
			end
		end

end
