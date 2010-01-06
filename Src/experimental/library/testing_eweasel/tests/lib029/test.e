class TEST

inherit
	ARGUMENTS

create
	make

feature

	make is
		do
			create f.make ("file.txt")
			read_integer
			read_double
			read_real
		end

feature {NONE} -- Implementation

	f: PLAIN_TEXT_FILE

	read_integer is
		local
			retried: BOOLEAN
		do
			if not retried then
				f.open_read
				f.read_integer
				io.put_string ("Failure in read_integer%N")
			end
			f.close
		rescue
			if not retried then
				retried := True
				retry
			end
		end

	read_double is
		local
			retried: BOOLEAN
		do
			if not retried then
				f.open_read
				f.read_double
				io.put_string ("Failure in read_double%N")
			end
			f.close
		rescue
			if not retried then
				retried := True
				retry
			end
		end

	read_real is
		local
			retried: BOOLEAN
		do
			if not retried then
				f.open_read
				f.read_real
				io.put_string ("Failure in read_real%N")
			end
			f.close
		rescue
			if not retried then
				retried := True
				retry
			end
		end

end
