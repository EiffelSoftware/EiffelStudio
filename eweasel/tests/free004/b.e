class B

inherit
	A
		redefine
			g
		end

feature

	g: Y
			-- <Precursor>
		do
			create Result
		ensure then
			is_instance_free: class
		end

end