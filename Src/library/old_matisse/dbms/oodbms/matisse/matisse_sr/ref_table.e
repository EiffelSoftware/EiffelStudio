indexing
    description: "Abstract reference table for store and retrieve.%
        %Manipulates a table of the form:%
        %%
        %       <'target oid', target pointer>%
        %       <'field-name', source pointer>%
        %       <'field-name', source pointer>%
        %       <'spec-field-num', source pointer>%
        %       <'spec-field-num', source pointer>%
        %       <'field-name', source pointer>%
        %       ...."


class REF_TABLE

    inherit
        STORER_EXTERNAL
	    export 
		{NONE} all;
		{ANY} default_pointer
	    end

    feature -- Initialisation
        make_target(an_oid:INTEGER; an_object_ptr:POINTER) is
                -- set target and wipe out reference list
            do
		target_oid := an_oid
                target_object_ptr := an_object_ptr
                !!references.make(0)
            ensure
                Target_set: target_oid = an_oid and target_object_ptr = an_object_ptr
                References_cleared: empty
            end

    feature -- Modification
        add_ref(a_field_name:STRING; an_object_ptr:POINTER) is
                -- add a reference to the end of the list
            require
                Valid_field: a_field_name /= Void and not a_field_name.empty
                Object_exists: an_object_ptr /= default_pointer
            local
                ref_elem: REF_ELEMENT
            do
                !!ref_elem.make
		ref_elem.put_field_name(a_field_name)
                ref_elem.put_object_ptr(an_object_ptr)
                references.finish
                references.extend(ref_elem)
            ensure
                Has_reference: has(an_object_ptr)
            end

    feature -- Access
        target_oid:INTEGER

        target_object_ptr:POINTER

    feature -- Status
	has(an_object_ptr:POINTER):BOOLEAN is
	    local
		csr:CURSOR
	    do
		csr := references.cursor
		from start until off or Result loop
		    Result := item_object_ptr = an_object_ptr
		    forth
		end
		references.go_to(csr)
	    end

    feature -- List
        empty:BOOLEAN is
            do
                Result := references.empty
            end

        start is
            do
                references.start
            end

        off:BOOLEAN is
            do
                Result := references.off
            end

        forth is
            do
                references.forth
            end

        item_object_ptr:POINTER is
            do
                Result := references.item.object_ptr
            end

        item_field_name:STRING is
            do
                Result := references.item.field_name
            end

        is_item_object_special:BOOLEAN is
            do
                Result := item_field_name.is_integer
            end

    feature {NONE} -- Implementation
        references:ARRAYED_LIST [REF_ELEMENT]

end

