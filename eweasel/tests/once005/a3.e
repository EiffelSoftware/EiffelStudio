class A

create
	make

feature
	
	make
		do
		end

feature -- Conflict

	o_process_thread: STRING
		once ("PROCESS", "THREAD")
		end

end
