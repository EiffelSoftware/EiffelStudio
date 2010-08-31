
class TEST1 [G -> ANY create default_create end]
feature
	value: ANY
		once
			create {G} Result
		end

end

