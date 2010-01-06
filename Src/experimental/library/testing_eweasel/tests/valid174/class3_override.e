indexing
	description: "Override class"

class CLASS3
feature
	make is
		local
			l_cl: CLASS2
		do
			create l_cl.make
		end
end
