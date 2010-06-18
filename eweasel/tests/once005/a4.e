class A

create
	make

feature
	
	make
		do
		end

feature -- Conflict

	o_process_thread: STRING
		indexing
			once_status: global
		once ("THREAD")
			Result := "o_process_thread"
		end

end
