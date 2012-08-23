expanded class
	EXP

create
	default_create,
	make_from_array

feature {NONE} -- initialize

 	make_from_array (an_array: ARRAY [REAL_64])
		do
			swf.make_from_array (an_array)
		end

feature -- sampled waveform

	swf: NESTED_EXP

	count: INTEGER
		do
			Result := swf.count
		end

end
