class TEST
inherit
	EXCEPTIONS

create
	make

feature -- Initialization

	make (args: ARRAY [STRING]) is
		local
			tried: BOOLEAN
			l_trace: STRING
			n: INTEGER
		do
			if not tried then
				limit := args.item (1).to_integer
				test (1)
			else
				n := number_of_portly_stoats (l_trace)
				if n /= limit then
					print ("Expected number of occurrences of " + Portly_stoat + " in trace: " + limit.out + "%N")
					print ("Actual   number of occurrences of " + Portly_stoat + " in trace: " + n.out + "%N")
					print ("%N")
					print ("Here is the exception trace:%N%N")
					print (l_trace)
				end
			end
		rescue
			l_trace := exception_trace
			tried := True
			retry
		end

	test (n: INTEGER) is
		do
			raise (Portly_stoat)
		rescue
			if n < limit then
				test (n + 1)
			end
		end

	number_of_portly_stoats (s: STRING): INTEGER
		local
			pos, len: INTEGER
		do
			from
				len := Portly_stoat.count
				pos := 1
			until
				pos <= 0
			loop
				pos := s.substring_index (Portly_stoat, pos)
				if pos > 0 then
					Result := Result + 1
					pos := pos + len
				end
			end
		end

	Portly_stoat: STRING = "Portly_stoat"

	limit: INTEGER
end
