indexing
	description	: "System's root class"

class
	TEST

create
	make

feature -- Initialization 

	make is
		local
			mem: MEMORY
			a: A [INTEGER]
			b: A3
		do
			create b
			b.f
		end 
		
	printf (i: INTEGER) is
			-- 
		external
			"C inline use <stdio.h>"
		alias
			"printf (%"Value is  %%d\n%", $i);"
		end
		

end -- class ROOT_CLASS
