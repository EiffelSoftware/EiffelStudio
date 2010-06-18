class A

create
	make

feature
	
	make
		do
		end

feature -- Conflict

	o_object_thread: STRING
		once ("OBJECT", "THREAD")
		end

end
