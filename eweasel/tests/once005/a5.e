class A

create
	make

feature
	
	make
		do
		end

feature -- Conflict

	o_free_key: STRING
		once ("foobar")
		end

end
