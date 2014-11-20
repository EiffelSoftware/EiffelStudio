class
	TEST

inherit
	SERIALIZATION_HELPER

create
	make

feature {NONE} -- Initialization

	make
		local
			l_file: RAW_FILE
			l_objects: like retrieved_objects
			retried: BOOLEAN
		do
			if not retried then
				create t1.make
					-- If we encounter a QAT that cannot be resolved an exception will be raised.
				set_is_discarding_qat (True)
				store_object (t1, "stored")
			else
				io.put_string ("Failure%N")
			end
		rescue
			retried := True
			retry
		end

	t1: TEST1 [STRING]

end
