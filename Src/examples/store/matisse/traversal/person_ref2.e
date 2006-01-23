indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

    name : STRING;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class PERSON_REF2

