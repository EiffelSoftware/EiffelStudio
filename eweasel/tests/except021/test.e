class TEST
inherit
	EXCEPTIONS

create
	make

feature -- Initialization

	make (args: ARRAY [STRING]) is
		do
			if not retried then
				limit := args.item (1).to_integer
				test (1)
			end
		rescue
			retried := True
			retry
		end

	test (n: INTEGER) is
		do
			raise (Portly_stoat)
		rescue
			if rep_name = Void then
				rep_name := recipient_name
				c_name := class_name
			else
				if not recipient_name.is_equal (rep_name) or else not class_name.is_equal (c_name) then
					print ("Wrong recipient name or class name.%N")
					print ("n is " + n.out + "%N")
					limit := n
				end
			end
			if n < limit then
				test (n + 1)
			end
		end

	Portly_stoat: STRING = "Portly_stoat"

	limit: INTEGER
	
	retried: BOOLEAN
	
	rep_name: STRING
	
	c_name: STRING
end
