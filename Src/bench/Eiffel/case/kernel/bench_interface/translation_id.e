indexing
	description: "Translation table for the ID in the new EiffelCase 4.3";
	date: "$Date$";
	revision: "$Revision$"

class 
	TRANSLATION_ID

feature -- processing

	from_string_to_id ( s: STRING ): INTEGER is 
		-- principle : unicity thanks to the use of the first numbers 
		--require
		--	s /= Void
		local
			i, translat : INTEGER
			c : CHARACTER
			compt : INTEGER
		do
			from 
				compt := 1
				i := 0
			until 
				compt = s.count or compt >13
			loop
				translat := s.item_code ( compt )
				i := i+ translate ( translat, compt )
				compt := compt + 1
			end
			Result := i
		end
				
	translate ( i : INTEGER; compt : INTEGER ): INTEGER	is
		-- notice : the use of an array would be here useful. Yet,
		-- it allows here an inheritance without a creation routine ...
		--require
		--	i /= Void
		do
			inspect compt
				when 1 then Result := 2
				when 2 then Result := 3
				when 3 then Result := 5
				when 4 then Result := 7
				when 5 then Result := 11
				when 6 then Result := 13
				when 7 then Result := 17
				when 8 then Result := 19
				when 9 then Result := 23
				when 10 then Result := 29
				when 11 then Result := 31
				when 12 then Result := 37
				when 13 then Result := 43
			else
				Result := 0
			end
			Result := (Result*i)
	end
								

end -- class TRANSLATION_ID
