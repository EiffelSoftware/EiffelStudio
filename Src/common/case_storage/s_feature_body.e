indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	S_FEATURE_BODY

inherit
	S_FREE_TEXT_DATA

creation
	make, make_filled

feature -- Initialization

feature -- Setting

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

	set_body ( l:s_free_text_data ) is
		do
			if l/= Void then
				from
					l.start
					start
					wipe_out
				until
					l.after
				loop
					put_i_th(l.item, l.index)
					l.forth
				end	
			end		
		end


end -- class S_FEATURE_BODY
