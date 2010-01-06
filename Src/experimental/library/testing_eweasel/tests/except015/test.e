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
				first_trace := Void
				second_trace := Void
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
				first_trace.replace_substring_all ("Resumption attempt failed.", "Routine failure.          ")
			elseif second_trace = Void then
				second_trace := exception_trace
				second_trace.replace_substring_all ("Resumption attempt failed.", "Routine failure.          ")
				if first_trace.count /= second_trace.count then
					print ("Not the same trace%N")
					io.new_line
					print ("First trace:%N")
					print (first_trace)
					io.new_line
					print ("Second trace:%N")
					print (second_trace)
					die (0)
				end
				first_trace := second_trace
				second_trace := Void
			end
			retry;
		end
	
	weasel is
		do
			dev_ex.raise
		end
		
	dev_ex: DEVELOPER_EXCEPTION is
		once
			create Result
			Result.set_message ("WEASEL")
		end
	
end
