class TEST

inherit
	EXCEPTIONS

create
	make

feature

	make is
		do
			try ($VALUE)
		end

	try (a: INTEGER)
		local
			retried: INTEGER
		do
			if retried < 10 then
				inspect a
				$INSTRUCTIONS
				end
			end
		rescue
			retried := retried + 1
			retry
		end
	
end
