indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
		MULTI [G -> ANY rename default_create as better_name end create better_name end]
feature
	test: MULTI[G] is
			-- for testing
		local
			l_g: G
		do
			create l_g
			print (l_g.out)
			create l_g.better_name
			print (l_g.out)
			print ("%N")

		end


end
