class A

create
	make

feature
	
	make
		do
		end

feature -- Conflict

	o_free_key: STRING
		once ("THREAD", "foobar")
		end

end
