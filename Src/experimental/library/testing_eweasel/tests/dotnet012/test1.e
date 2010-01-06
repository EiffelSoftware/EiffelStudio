class
	TEST1

inherit
	ICLONEABLE

feature

	clone: like Current is
		do
			Result := twin
		end

end
