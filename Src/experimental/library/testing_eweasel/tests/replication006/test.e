class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			b: B
		do
			print ("Creating {B}.%N")
			create b.make
			print ("Created  {B}.%N")
		end

end
