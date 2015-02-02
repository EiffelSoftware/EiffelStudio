class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			bool_local: BOOLEAN
		do
			bool_local := True

			if bool_local and then bool_constant then
				print ("(1) This text should not appear.%N")
			end

			if bool_local and then bool_once then
				print ("(2) This text should not appear.%N")
			end

			if bool_local and bool_constant then
				print ("(3) This text should not appear.%N")
			end

			if bool_local and bool_once then
				print ("(4) This text should not appear.%N")
			end
		end

feature {ANY} -- Access

	bool_constant: BOOLEAN = False
	bool_once: BOOLEAN once Result := False end

end

