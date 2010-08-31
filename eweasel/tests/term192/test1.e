
class TEST1 [G -> ANY create default_create end]
feature
	value: G
		once ("OBJECT")
			create Result
		end

end

