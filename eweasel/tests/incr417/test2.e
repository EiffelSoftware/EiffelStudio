
deferred class TEST2
feature 
	value: like x
		deferred
		end
	
	x: like {TEST1}.value
end

