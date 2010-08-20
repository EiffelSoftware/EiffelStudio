
expanded class TEST1
inherit
	ANY
		redefine
			default_create
		end
feature
	default_create
		do
			create value
		end

	try
		do
		end
	
	value: TEST2
	
invariant
	good: (agent value).item ([]).a = 0.0
end
