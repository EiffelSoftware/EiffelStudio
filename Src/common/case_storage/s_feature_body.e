indexing
	description: "body of feature for the case storage"
	date: "$Date$"
	revision: "$Revision$"

class
	S_FEATURE_BODY

inherit
	
	S_FREE_TEXT_DATA

creation
	make

feature -- settings

	set_text ( st : STRING ) is
		do
			if count >0 then
				wipe_out
			end
			extend(st)
		end
	
end -- class S_FEATURE_BODY
