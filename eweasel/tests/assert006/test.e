class
	TEST

inherit
	EXCEPTIONS

create
	make

feature

	make
		local
			a: A
			retried: BOOLEAN
		do
			if not retried then
				create a.make
				a.f
			end
		rescue
			retried := True
			if exception = Precondition then
				io.put_string ("Got the expected precondition violation.")
				io.put_new_line
				retry
			end
		end

end
