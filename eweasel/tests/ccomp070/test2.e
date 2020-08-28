expanded class TEST2
inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature 
	default_create
		do
			b := "Totot"
		end

feature
	s: INTEGER

	b: STRING
	
end
