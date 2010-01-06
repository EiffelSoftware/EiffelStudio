class
	TEST

inherit
	ARGUMENTS

create
	make

feature -- Initialization

	make is
			-- Run application.
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := 100
			until
				i > nb
			loop
				retrieve
				i := i + 1
		end
		end


	save is
			-- Routine only used once for creating the object that should always be retrievable.
		local
			l_file: RAW_FILE
			retried: BOOLEAN
			l_spec: ARRAY [A [ANY]]
			i, nb: INTEGER
		do
			if not retried then
				create l_spec.make (1, 100)
				from
					i := 1
					nb := 100
				until
					i > nb
				loop
					l_spec.put (create {A [ANY]}.make (create {ANY}), i)
					i := i + 1
				end
				create l_file.make_create_read_write (file_name)
				l_file.independent_store (l_spec.area)
				l_file.close
			end
		rescue
			print ("Exception caught.%N")
			retried := True
			retry
		end

	retrieve is
		local
			a: ANY
			l_file: RAW_FILE
			retried: BOOLEAN
			l_spec: SPECIAL [A [ANY]]
		do
			if not retried then
				create l_file.make_open_read (file_name)
				a := l_file.retrieved
				l_spec ?= a
				l_file.close
				if l_spec = Void or else l_spec.count /= 100 then
					print ("ERROR%N")
				end
			end
		rescue
			print ("Exception caught.%N")
			retried := True
			retry
		end

	file_name: STRING is "data54"

end
