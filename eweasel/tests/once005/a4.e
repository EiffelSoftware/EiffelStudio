class A

create
	make

feature
	
	make
		do
		end

feature -- Conflict

	o_process_thread: STRING
		note
			once_status: "global"
		once ("THREAD")
		end

end
