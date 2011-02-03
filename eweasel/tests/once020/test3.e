
class TEST3 [G -> ANY create default_create end]
feature

	weasel: G
		once ("OBJECT")
			create Result
		end
end
