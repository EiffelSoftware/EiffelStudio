indexing
	description: "body of feature for the case storage"
	date: "$Date$"
	revision: "$Revision$"

class
	S_FEATURE_BODY

inherit
	
	S_FREE_TEXT_DATA

creation
	make, make_filled

feature -- settings

	set_text ( li_st : LINKED_LIST [STRING] ) is
		do
			if count >0 then
				wipe_out
			end
			from
				start
				li_st.start
			until
				li_st.after
			loop
				extend(li_st.item)
				li_st.forth
			end
		end
	
end -- class S_FEATURE_BODY
