class TEST
inherit
	EXCEPTIONS
	MEM_CONST
creation
	make
feature
	make (args: ARRAY [STRING]) is
		local
			k, count: INTEGER;
		do
			count := args.item (1).to_integer;
			from 
				k := 1; 
			until 
				k > count 
			loop
				try (args.item (2).to_integer);
				k := k + 1;
			end
		end

	first_trace: STRING
	second_trace: STRING

	try (max: INTEGER) is
		local
			count: INTEGER;
		do
			if count < max then
				weasel;
			end
		rescue
			count := count + 1;
			if first_trace = Void then
				first_trace := exception_trace
			elseif second_trace = Void then
				second_trace := exception_trace
				if not first_trace.is_equal (second_trace) then
					print ("Not the same trace%N")
					die (1)
				end
			end
			retry;
		end
	
	weasel is
		local
			x: TEST1;
			y: INTEGER;
		do
			create x
			y := x.wimp;
		end
	
end
