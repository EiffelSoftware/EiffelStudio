class
	C

inherit
	B1
		select
			foo
		end

	B2
		rename
			foo as bar
		redefine
			bar
		end

feature

	bar
		do
			Precursor
			Precursor {B2}
			
			print ("C%N")
		end

end
