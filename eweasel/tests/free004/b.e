class B

inherit
	A
		redefine
			g
		end

feature

	g: Y
			-- <Precursor>
		note
			option: instance_free
		do
			create Result
		end

end