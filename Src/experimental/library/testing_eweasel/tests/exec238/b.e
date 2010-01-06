indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	B
inherit
	A
		rename
			to_be_renamed as renamed
		redefine 
			f
		end

feature
	f is do end


end
