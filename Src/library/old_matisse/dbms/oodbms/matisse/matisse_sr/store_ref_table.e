indexing
    description: "This class implements a table which contains the reverse%
        %references of other objects to the target object. Each reverse%
        %reference is notionally a <field-name, POINTER> pair, meaning%
        %that the object referred to by POINTER either has a field called%
        %field-name, whose value is me (i.e. the 'target' of this class),%
        %or else it is a SPECIAL whose field number (really its field name)%
        %is me.%
        %%
        %The information contained in this data structure is as follows%
        %('xxx' indicates a STRING):%
        %       <'target oid', target pointer>%
        %       <'field-name', source pointer>%
        %       <'field-name', source pointer>%
        %       <'spec-field-num', source pointer>%
        %       <'spec-field-num', source pointer>%
        %       <'field-name', source pointer>%
        %       ...."


class STORE_REF_TABLE

	inherit
	   REF_TABLE

    creation
        make_target, make_target_from_i_th_field

    feature -- Initialisation
        make_target_from_i_th_field(i:INTEGER; an_object_ptr:POINTER) is
                -- set target to object at 'i'-th field of 'an_object_ptr'
            require
                Args_valid: i > 0 and an_object_ptr /= default_pointer
            do
                target_object_ptr := pointer_inside_field(i-1,an_object_ptr)
                !!references.make(0)
            ensure
                Target_set: target_object_ptr = pointer_inside_field(i-1,an_object_ptr)
		Oid_not_set: target_oid = 0
                References_empty: empty
            end

    feature -- Modification
        set_target_oid(an_oid:INTEGER) is
                -- set target and wipe out reference list
            require
                Args_valid: an_oid /= 0
            do
        	       target_oid := an_oid
            ensure
                Target_set: target_oid = an_oid
            end

        add_reverse_ref(i:INTEGER; an_object_ptr:POINTER) is
                -- add a reverse reference to the end of the list
            require
                Args_valid: an_object_ptr /= default_pointer and i > 0
            do
		if c_is_special(an_object_ptr) then
                    add_ref(i.out,an_object_ptr)
		else
                    add_ref(c_field_name(i-1,an_object_ptr), an_object_ptr)
		end
            ensure
                Has_reference: has(an_object_ptr)
            end

    feature -- Status
	is_target_stored:BOOLEAN is
	    do
		Result := target_oid /= 0
	    end

end

