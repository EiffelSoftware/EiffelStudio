class B [G]

inherit
	A
		redefine
			data,
			set_data
		end

feature

	data: G

	set_data (a_data: like data) is
		do
			Precursor (a_data)
		end

end
