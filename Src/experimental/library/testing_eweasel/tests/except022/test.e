class TEST
inherit
	EXCEPTIONS

create
	make

feature -- Initialization

	make (args: ARRAY [STRING]) is
		local
			tried: BOOLEAN
		do
			if not tried then
				limit := args.item (1).to_integer
				test (1)
			else
				print ("Unexpected place printing.%N")
			end
		rescue
			tried := True
			retry
		end

	test (n: INTEGER) is
		local
			retried: BOOLEAN
		do
			if not retried then
				raise (Portly_stoat)
			end
		rescue
			if n < limit then
				test (n + 1)
			end
			retried := True
			retry
		end

	Portly_stoat: STRING = "Portly_stoat"

	limit: INTEGER
end
