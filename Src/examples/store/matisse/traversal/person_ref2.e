class PERSON_REF2
inherit

    STORABLE
        rename 
			basic_store as ise_basic_store,
			retrieve_by_name as ise_retrieve_by_name,
			general_store as ise_general_store, 
			class_name as ise_class_name
			--, c_retrieved as ise_c_retrieved
    end

    EXT_STORABLE
        rename store as sol_store
	--	retrieve_by_name as sol_retrieve_by_name
		redefine default_actions
    end
    
create
    make

feature {ANY} 

    make (arg_name : STRING) is
    require
        name_not_void : arg_name /= Void
    do
        name := arg_name
    end

    default_actions : SAMPLE_TRAVERSAL_ACTION2 is
    once
        create Result
    end

feature {ANY}

    name : STRING

end -- class PERSON_REF2

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

