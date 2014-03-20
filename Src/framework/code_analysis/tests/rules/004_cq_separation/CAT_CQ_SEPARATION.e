class
	CAT_CQ_SEPARATION
	
feature {NONE} -- Test

	cq_1: INTEGER
		do
			proc
			
			Result := 3
		end
		
	cq_2: INTEGER
		do
			int := 7
		
			Result := 3
		end
		
	cq_3: BOOLEAN
		do
			create list.make
		
			Result := True
		end
		
	proc
		do
			int := 4
		end
		
	int: INTEGER
	
	list: LINKED_LIST [BOOLEAN]
	
end
