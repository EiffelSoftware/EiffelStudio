class PERSON_REF
inherit
	STORABLE
        rename basic_store as ise_basic_store,
		retrieve_by_name as ise_retrieve_by_name,
		general_store as ise_general_store, 
		class_name as ise_class_name 
		--, c_retrieved as ise_c_retrieved
		undefine out
    end

    EXT_STORABLE
		rename 
			store as sol_store,
		retrieve_by_name as sol_retrieve_by_name
		undefine out
		redefine default_actions
	end	

create
    make

feature {ANY} 

    make (arg_last_name,arg_first_name : STRING; arg_age : INTEGER; arg_job : STRING) is
    require
        last_name_not_void : arg_last_name /= Void
        first_name_not_void : arg_first_name /= Void
        arg_age_positive : arg_age > 0
        arg_job_not_void : arg_job /= Void    
    do
        last_name := arg_last_name
        first_name := arg_first_name
        age := arg_age
        job := arg_job
        create friends.make
		create one_ref2.make("Joseph")
    end

	set_friends(arg_friend1,arg_friend2 :PERSON_REF) is
	do
		friend1 := arg_friend1 friend2 := arg_friend2   
		friends.force(arg_friend1) friends.forth friends.force(arg_friend2)
	end

	out : STRING is
	do
		create Result.make(0);
	end 

	default_actions : SAMPLE_TRAVERSAL_ACTION is
	once
		create Result
	end

feature {ANY}

    last_name : STRING
    first_name : STRING
    age : INTEGER
    job : STRING
    friend1 : PERSON_REF
    friend2 : PERSON_REF
	friends :   LINKED_LIST[PERSON_REF]
	one_ref2 : PERSON_REF2
	
end -- class PERSON_REF

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

