indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	A1 [G -> ANY rename f as bongo, bongo as f, coo as f, foo as f end create default_create end]


feature
	foo
		local
			l_g: G
		do
			create l_g
		end
feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
