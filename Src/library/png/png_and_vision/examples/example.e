class EXAMPLE

creation
	make

feature -- Init
	make is 
		local
			fi: FILE_NAME
			i: INTEGER
		do 
			Create ex1
			ex1.process	

			Create ex2
			ex2.process
		end


feature -- Access
	
	ex1: EXAMPLE1
		-- Example which create, then draws basic figures on a png image.
		-- Save it at the end.

	ex2: EXAMPLE2
		-- Example which create, then displays 3-d tunnel on a png image.
		-- Save it at the end

end -- EXAMPLE