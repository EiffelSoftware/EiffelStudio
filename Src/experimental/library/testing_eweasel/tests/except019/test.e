class
	TEST
	
inherit
	MEMORY

create
	make

feature -- Initialization

	make is
		do
			create e
			test
		end

	test is
		do
			if i < count then
				if l_retried then
					full_collect
					if info = Void then
						info := memory_statistics (Total_memory)
					end
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
		
	i: INTEGER
	l_mem: INTEGER
	l_retried: BOOLEAN
		
	info: MEM_INFO

	e: DEVELOPER_EXCEPTION
	
	count: INTEGER = 10000
	
	mem: INTEGER

end -- class APPLICATION
