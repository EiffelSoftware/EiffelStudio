indexing

	description: 
		"Free form text notion where no checks are made for%
		%its content";
	date: "$Date$";
	revision: "$Revision $"

class S_FREE_TEXT_DATA

inherit

	S_ELEMENT_DATA
		undefine
			consistent, copy, 
			setup, is_equal
		end;
	FIXED_LIST [STRING]
		rename
			make	as make_fixed_list
		end
--		redefine
--			make
--		end

creation

	make,make_filled -- pascalf

-- pascalf
feature -- initialization                                                                                    
                                                                                                             
    make (n: INTEGER) is                                                                                     
            -- Replace `make' by `make_filled' from FIXED_LIST in order                                      
            -- to minimize the change on the compiler due to the new FIXED_LIST                              
        do                                                                                                   
		make_filled (n)
      end                                                                                                  
            


end -- class S_FREE_TEXT_DATA
