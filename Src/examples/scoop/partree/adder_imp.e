deferred class
	ADDER_IMP

inherit
	PAR_TREE [INTEGER]

feature
	
	trans (x: INTEGER): INTEGER
		do
			(create {EXECUTION_ENVIRONMENT}).sleep (1000*1000*1000)
			Result := x * 2
		end

	combine (x, y: INTEGER): INTEGER
		do
			Result := x + y
		end

end	

	
