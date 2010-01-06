class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			print (f (256).out)
			io.new_line
			print (f (255).out)
			io.new_line
			print (f (768).out)
			io.new_line
		end

feature -- Test
	
	f (x: INTEGER): BOOLEAN is external "C inline"
		alias
			"return $x & 256;"
		end
			
		
end -- class TEST
