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
