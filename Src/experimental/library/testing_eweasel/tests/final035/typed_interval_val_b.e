deferred class TYPED_INTERVAL_VAL_B [H]

inherit
	INTERVAL_VAL_B

feature

	type_of_interval: STRING is
		deferred
		end

	generate is
		do
			print (type_of_interval)
		end

end
