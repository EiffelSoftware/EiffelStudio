class REFERENCE 
inherit
    STORABLE
        rename basic_store as ise_basic_store,retrieve_by_name as ise_retrieve_by_name,general_store as
        ise_general_store, class_name as ise_class_name
		--, c_retrieved as ise_c_retrieved
    end

    EXT_STORABLE
        rename store as sol_store
    end    

feature

	set(i:INTEGER) is
		-- Fill object's fields
	do
		a:=i
		create one_array.make(1,2)
	end -- set

    set2 is
    do
        a:=0
        one_string := Void
		a_ref := Void
		one_array := Void
		one_integer_array := Void
		one_double_array := Void
		one_real_array := Void
		lli := Void
		lld := Void
		llr := Void
		lls := Void
    end -- set

	set_ref(one_ref : REFERENCE) is
	do
		a_ref := one_ref 	
		if one_array/= Void then 
			one_array.put(current,1)  
            one_array.put(a_ref,2)  
		end
		one_integer_array := <<1,2,3,4,5,6,7,8,9,10>> one_double_array := <<1/2,1/3,1/4,1/5,1/6>> one_real_array:=<<0.1,0.2,0.3>>
		create lli.make  lli.start lli.put_left(34) lli.put_left(56)
        create lld.make  lld.start lld.put_left(0.70707564564) 
        create llr.make  llr.start llr.put_left(1/23) llr.put_left(2/726291)
        create lls.make  lls.start lls.put_left("ASCII") lls.put_left("EBCD") lls.put_left("REFERENCE")
		one_string := "INSTANCE OF CLASS REFERENCE"
	end

	one_string : STRING
	a : INTEGER
	a_ref : REFERENCE
	one_array : ARRAY[REFERENCE]
	one_integer_array : ARRAY[INTEGER]
	one_double_array   : ARRAY[DOUBLE]
	one_real_array : ARRAY[REAL]
	lli : LINKED_LIST[INTEGER]
	lld : LINKED_LIST[DOUBLE]
	llr : LINKED_LIST[REAL]
	lls : LINKED_LIST[STRING]

end -- class REFERENCE

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

