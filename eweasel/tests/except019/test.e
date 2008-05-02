class
	TEST
	
inherit
	MEMORY
	
	EXCEPTIONS

create
	make

feature -- Initialization

	make (args: ARRAY [STRING]) is
		do
			count := args.item (1).to_integer;
			create e
			info := memory_statistics (Total_memory)
			test
		end

	test is
		local
			i: INTEGER
			l_mem: INTEGER
			l_retried: BOOLEAN
		do
			if i < count then
				if l_retried then
					full_collect
					io.standard_default.flush
					info.update (total_memory)
					l_mem := info.used
				end
				if l_mem = mem or i = 1 then
					mem := l_mem
					e.raise
				else
					print ("Memory leak at iteration: " + i.out)
					io.put_new_line
				end
			end
		rescue
			i := i + 1
			l_retried := True
			retry
		end
		
	info: MEM_INFO

	e: DEVELOPER_EXCEPTION
	
	count: INTEGER
	
	mem: INTEGER

end -- class APPLICATION
