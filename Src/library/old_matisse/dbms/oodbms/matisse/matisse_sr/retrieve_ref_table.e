indexing
    description: "This class implements a table which contains the reverse%
        %references of other objects to the target object. Each reverse%
        %reference is a <field-name, POINTER> pair, where the field-name%
        %is the name of the field of another object, whose value is me,%
        %and the POINTER is a pointer to that field, which can be used to%
        %write the address of me in, when I have been retrieved.%
        %%
        %The information contained in this data structure is as follows%
        %('xxx' indicates a STRING):%
        %       <'target oid', target pointer>%
        %       <'field-name', field pointer>%
        %       <'field-name', field pointer>%
        %       <'spec-field-num', field pointer>%
        %       <'spec-field-num', field pointer>%
        %       <'field-name', field pointer>%
        %       ...."


class RETRIEVE_REF_TABLE

	inherit
	   REF_TABLE

    creation
        make_target, make_target_from_oid

    feature -- Initialisation
        make_target_from_oid(an_oid:INTEGER) is
                -- set target to object denoted by 'oid'
            require
                Args_valid: an_oid /= 0
            do
                target_oid := an_oid
                !!references.make(0)
            ensure
                Target_set: target_oid = an_oid
                References_empty: empty
            end

    feature -- Modification
        set_target_object_ptr(an_object_ptr:POINTER) is
            require
                Args_valid: an_object_ptr /= default_pointer
            do
        	       target_object_ptr := an_object_ptr
            ensure
                Target_set: target_object_ptr = an_object_ptr
            end

        add_reverse_ref(i:INTEGER; an_object_ptr:POINTER) is
                -- add a reverse reference to the end of the list
            require
                Args_valid: an_object_ptr /= default_pointer and i > 0
            do
		if c_is_special(an_object_ptr) then
                add_ref(i.out, object_field_ptr(i, an_object_ptr))
		else
                add_ref(c_field_name(i-1,an_object_ptr), object_field_ptr(i, an_object_ptr))
		end
            ensure
                Has_reference: has(object_field_ptr(i, an_object_ptr))
            end

    feature -- Conversion
	object_field_ptr(i:INTEGER; an_object_ptr:POINTER):POINTER is
		-- return a pointer on the 'i'th field of 'an_object_ptr', regardless
		-- of whether it is a normal or a SPECIAL object
	    do
		if c_is_special(an_object_ptr) then
                    Result := pointer_on_special_item(i-1,an_object_ptr)
		else
                    Result := pointer_on_field(i-1, an_object_ptr)
		end
	    end

    feature -- Status
	is_target_retrieved:BOOLEAN is
	    do
		Result := target_object_ptr /= default_pointer
	    end

end

