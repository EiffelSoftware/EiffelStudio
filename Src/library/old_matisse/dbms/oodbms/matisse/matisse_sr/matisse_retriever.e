class MATISSE_RETRIEVER 

inherit

	DATABASE_RETRIEVER
		export {NONE} all
		redefine anchor
	end

	MATISSE_TABLES
		export {NONE} all
	end

	MEMORY
		export {NONE} all
	end

feature -- Retrieval

	retrieve(key: like anchor) : EXT_STORABLE is
		-- Use key ( INTEGER ) to retrieve objects in database
		require else 
			key_positive : key.item > 0
		local
			one_table : MATISSE_IDF_TABLE
			i : INTEGER
			f : PLAIN_TEXT_FILE
			retrieved_object : ANY
			is_collecting : BOOLEAN
			a_special : TO_SPECIAL[ANY]
		do
			is_collecting := collecting collection_off
			if key.item > 0 then 
				--oid_ct.clear_all -- fct.clear_all 
				ct.clear_all 
				!!one_table.make(0,key.item) idf_table.put(one_table)
				one_table.load
				from
					i := 0
				until
					i>= one_table.flags_index
				loop
					--fct.put(True,one_table.ith_oid(i)) 
					if one_table.is_ith_special(i) then
						retrieved_object ?= one_table.ith_special(i) 
						--oid_ct.put($retrieved_object,one_table.ith_oid(i))
						update_table(i,retrieved_object)
						update_references_in_special(i,retrieved_object,False)
					else
						retrieved_object ?= one_table.ith_normal(i) 
						--oid_ct.put($retrieved_object,one_table.ith_oid(i))
						update_table(i,retrieved_object)
						update_references_in_normal(i,retrieved_object,False)
					end -- if
					i:=i+1
				end -- loop
				Result ?= retrieved_object
				if is_collecting then collection_on end
			end -- if
		end --  retrieve

	update_table(i : INTEGER;object : ANY) is
		-- Insert object in table
		local
			one_element : CT_ELEMENT
			object_list : ARRAYED_LIST[CT_ELEMENT]
			rtu : POINTER
        	do
			-- Is object referenced in table ?
			object_list := ct.item(idf_table.item.ith_oid(i))
			if object_list = Void then 
				-- Put element in list
				!!one_element.make one_element.put_second($object) one_element.put_first(idf_table.item.ith_oid(i).out)
				!!object_list.make(0) object_list.start object_list.put_left(one_element)
				ct.put(object_list,(idf_table.item.ith_oid(i)))
			else
				!!one_element.make one_element.put_second($object) one_element.put_first(idf_table.item.ith_oid(i).out)
				object_list.start object_list.put(one_element)
				from
					object_list.start object_list.forth
				until        
					object_list.off
				loop
					rtu := object_list.item.second_item
					change_inside_field($object,rtu)
					object_list.forth
				end -- loop            
			end -- if 
	end -- update_table

	update_references_in_special(i:INTEGER;object : ANY;is_exp : BOOLEAN)  is
		-- Special case
		local
			one_object : MT_OBJECT
			one_rel  : MT_RELATIONSHIP
			successors : ARRAY[MT_OBJECT]
			j : INTEGER one_element : CT_ELEMENT field_list : ARRAYED_LIST[CT_ELEMENT] sobject : SPECIAL[ANY]
		do
			sobject ?= object
			!!one_object.make(idf_table.item.ith_oid(i))
			!!one_rel.make("area")
			successors := one_object.successors(one_rel)
			from
				j:= successors.lower
			until 
				j>successors.upper
			loop
				if ct.item(successors.item(j).oid) /= Void and then  ct.item(successors.item(j).oid).first.first_item/=Void then 
					change_inside_field(ct.item(successors.item(j).oid).first.second_item,pointer_on_special_item(j-1,$object))
				else    
					if ct.item(successors.item(j).oid)/=Void then
						!!one_element.make one_element.put_first(j.out)  one_element.put_second(pointer_on_special_item(j-1,$object))
						field_list := ct.item(successors.item(j).oid) field_list.finish field_list.put_right(one_element)
					else
						-- We want an object never seen before --> create its list
						!!one_element.make
						!!field_list.make(0) field_list.start field_list.put_left(one_element) 
						!!one_element.make one_element.put_first(j.out)  one_element.put_second(pointer_on_special_item(j-1,$object))
						field_list.put_left(one_element)
						ct.put(field_list,successors.item(j).oid)
					end -- if
				end -- if
				j:=j+1
			end -- loop
		end -- update_references_in_special

	update_references_in_normal(i:INTEGER;object : ANY;is_exp : BOOLEAN)  is
		-- Normal case
		local
			nb_field,j,ftype,mtype : INTEGER
			object_field : ANY
			one_integer_value : INTEGER_REF 
			one_double_value : DOUBLE_REF 
			one_real_value : REAL_REF 
			one_char_value : CHARACTER_REF 
			one_reference_value : ANY
			one_attribute : MT_ATTRIBUTE
			one_object : MT_OBJECT
			field_list : ARRAYED_LIST[CT_ELEMENT]
			one_element : CT_ELEMENT
			fpointer : POINTER successors : ARRAY[MT_OBJECT] one_rel : MT_RELATIONSHIP
		do
			from
				nb_field := field_count (object)
				j := 1
			until
				j > nb_field
			loop 
				ftype := field_type(j,object)
				!!one_attribute.make(field_name(j,object))
				!!one_object.make(idf_table.item.ith_oid(i))
				inspect ftype
				when Reference_type then -- LIST or ARRAY [INTEGER,REAL,DOUBLE,STRING,CHARACTER]
					if one_attribute.aid /= 0 then
						mtype := one_attribute.type
						one_reference_value ?= one_attribute.value(one_object)
						if one_reference_value /= Void then set_reference_field(j,object,one_reference_value) end
					else -- REFERENCE 
						!!one_rel.make(field_name(j,object))
						successors := one_object.successors(one_rel)
						if ct.item(successors.item(successors.lower).oid) /= Void and then  ct.item(successors.item(successors.lower).oid).first.first_item/=Void then 
							change_inside_field(ct.item(successors.item(successors.lower).oid).first.second_item,pointer_on_field(j-1,$object))
						else 
							if ct.item(successors.item(successors.lower).oid)/=Void then
								!!one_element.make one_element.put_first(field_name(j,object))  
								one_element.put_second(pointer_on_field(j-1,$object))
								field_list := ct.item(successors.item(successors.lower).oid) 
								field_list.finish 
								field_list.put_right(one_element)
							else
								!!one_element.make
								!!field_list.make(0)
								field_list.start
								field_list.put_left(one_element) 
								!!one_element.make
								one_element.put_first(field_name(j,object))
								one_element.put_second(pointer_on_field(j-1,$object))
								field_list.put_left(one_element)
								ct.put(field_list,successors.item(successors.lower).oid)
							end -- if
						end -- if
					end -- if  
				when Integer_type then -- INTEGER
					one_integer_value ?= one_attribute.value(one_object)
					if one_integer_value /= Void then set_integer_field (j,object,one_integer_value.item) end -- if
				when Real_type then -- REAL
					one_real_value ?= one_attribute.value(one_object)
					if one_real_value /= Void then set_real_field (j,object,one_real_value.item) end -- if
				when Double_type then -- DOUBLE
					one_double_value ?= one_attribute.value(one_object)
					if one_double_value /= Void then set_double_field (j,object,one_double_value.item) end -- if
				when Character_type then -- CHARACTER
					one_char_value ?= one_attribute.value(one_object)
					if one_char_value /= Void then set_character_field (j,object,one_char_value.item) end -- if
				when Boolean_type then -- BOOLEAN
					one_integer_value ?= one_attribute.value(one_object)
					if one_integer_value /= Void and one_integer_value.item = 1 then set_boolean_field (j,object,True) end -- if
				else
					-- Do not know how to store this type  (POINTER, BIT N) 
				end -- inspect
				j :=j + 1
			end -- loop
		end -- update_references_in_normal

	--oid_ct : HASH_TABLE[POINTER,INTEGER] is once !!Result.make(0) end -- oid_ct

feature {NONE} -- Implementation

	ct : HASH_TABLE[ARRAYED_LIST[CT_ELEMENT],INTEGER]is once !!Result.make(0) end -- ct

	anchor : INTEGER_REF

end -- class MATISSE_RETRIEVER

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

