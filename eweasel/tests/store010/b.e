class B

inherit
	ANY
		redefine
			is_equal
		end
feature

	is_equal (other: like Current): BOOLEAN
		do
				-- Counter to ensure that we are indeed using object comparison.
			counter.put (counter.item + 1)
			Result := True
		end

	counter: CELL [INTEGER]
		once
			create Result.put (0)	
		end

end
