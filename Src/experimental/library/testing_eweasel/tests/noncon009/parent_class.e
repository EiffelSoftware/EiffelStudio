class
	PARENT_CLASS

inherit
	GRAND_PARENT_CLASS
		redefine
			f
		end

feature

	f: INTEGER is
		do
			Result := 1
		end
end
