class TEST

create
	make

feature {NONE} -- Initialization

	make
		do
			string:= ("Test%N").as_string_8
			print (string)
		end

feature -- Access

	string: STRING_GENERAL
	
invariant
	string_is_8bit: {l_str: !STRING_8} string
	
end
