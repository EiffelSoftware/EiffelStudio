class MATISSE_STORER 

inherit

	DATABASE_STORER
		export {NONE} all
		redefine make_idf_table
		end	

	DATABASE_STORER
		export {ANY} store, store_one_object
		end	

	MATISSE_CONST
		export {NONE} ALL
		end

	MATISSE_TABLES
		export {NONE} ALL
		end

feature -- Element change

	putobject,put_object( object : ANY ) is
		-- Append object o
		do
			-- Create new object in database
			update_table(object) 
			if is_special(object) then
				put_special_object(object)
			else
				put_normal_object(object)
			end -- if
    		end -- putobject, put_object

feature {NONE} -- Implementation

	update_table(object : ANY) is
		local
			object_list : ARRAYED_LIST[CT_ELEMENT]
			one_element : CT_ELEMENT
			field_to_update : STRING
			one_class : MT_CLASS
			one_object,other_object : MT_OBJECT
			one_rel : MT_RELATIONSHIP
			one_attribute : MT_ATTRIBUTE
			oid1, one_integer : INTEGER
			special_object : SPECIAL[ANY]
		do
			-- Is object referenced in table ?
			object_list := ct.item($object)
			if object_list = Void then 
				-- Put element in list
				!!one_element.make one_element.put_second($object)
				!!object_list.make(0) object_list.start object_list.put_left(one_element)
				ct.put(object_list,$object)
				-- Create object in database
				!!one_class.make(class_name(object)) one_object := one_class.new_instance
				object_list.start object_list.item.put_first(one_object.oid.out)
				idf_table.item.put_flag(object)
				idf_table.item.put_oid(one_object.oid)
				if c_is_special_object($object) then
					special_object ?= object check special_object /= Void end
			        	!!one_attribute.make("eif_size")
 					one_attribute.set_value(one_object,Mts32,c_size_of_special($object))
					!!one_attribute.make("eif_count")
					one_attribute.set_value(one_object,Mts32,special_object.count)
				end -- if
			else
				-- Update references on that object ( list items after first ) in database
				!!one_element.make one_element.put_second($object)
				object_list.start object_list.put(one_element) 
				-- Create object in database
				!!one_class.make(class_name(object)) one_object := one_class.new_instance
				object_list.start object_list.item.put_first(one_object.oid.out)
				idf_table.item.put_flag(object) idf_table.item.put_oid(one_object.oid)
				if c_is_special_object($object) then
					special_object ?= object check special_object /= Void end
					!!one_attribute.make("eif_size") one_attribute.set_value(one_object,Mts32,c_size_of_special($object))
					!!one_attribute.make("eif_count") one_attribute.set_value(one_object,Mts32,special_object.count)
				end -- if
				from
					object_list.start object_list.forth
				until        
					object_list.off
				loop
 					-- Change field in database
					if object_list.item.first_item.is_integer  then
						-- Element of special area
						oid1 := ct.item(object_list.item.second_item).first.first_item.to_integer
						!!other_object.make(oid1) 
						!!one_rel.make("area") 
						other_object.append_successor(one_rel,one_object)
					else	
						oid1 := ct.item(object_list.item.second_item).first.first_item.to_integer
						!!one_rel.make(object_list.item.first_item) 
						!!other_object.make(oid1) 
						other_object.remove_all_successors(one_rel)
						other_object.append_successor(one_rel,one_object)
					end
 					object_list.forth
				end -- loop            
			end -- if 
		end -- update_table

	put_normal_object(object : ANY) is
		local
			nb_field,j,ftype, oid1, oid2,a_boolean, k, dt, one_l_integer : INTEGER one_integer : INTEGER_REF
			object_field : ANY
			field_list : ARRAYED_LIST[CT_ELEMENT] one_element : CT_ELEMENT
			one_object, other_object : MT_OBJECT
			one_rel : MT_RELATIONSHIP one_attribute : MT_ATTRIBUTE
			one_boolean : BOOLEAN_REF 
			one_area : SPECIAL[ANY] one_item : ANY one_array : ARRAY[ANY]
		do
			from
				nb_field := field_count (object)
				j := 1
			until
				j > nb_field
			loop 
				-- Is there anything to store ?
				object_field := field(j,object)
				if object_field /= Void then
					ftype := field_type(j,object)
					!!one_attribute.make(field_name(j,object))
					!!one_object.make(ct.item($object).first.first_item.to_integer)
					inspect ftype
 					when Reference_type then -- REFERENCE
						one_array ?= object_field  
						if one_array /= Void then one_area ?= one_array.area end
						if is_linked_list_double(object_field) then -- LINKED_LIST[DOUBLE]
							one_attribute.set_value(one_object,Mtdouble_list,object_field)
						elseif is_linked_list_real(object_field) then -- LINKED_LIST[REAL]
							one_attribute.set_value(one_object,Mtfloat_list,object_field)
						elseif is_linked_list_integer(object_field)   then -- LINKED_LIST[INTEGER]
							one_attribute.set_value(one_object,Mts32_list,object_field)
						elseif is_linked_list_string(object_field)   then -- LINKED_LIST[STRING]
							one_attribute.set_value(one_object,Mtstring_list,object_field)
						elseif is_string(object_field) then -- STRING
							one_attribute.set_value(one_object,Mtstring,object_field)
						elseif one_array=Void or else not(is_special_simple($one_area)) then  
							-- Is tc list of pointer inside field empty ?
							field_list := ct.item(pointer_inside_field(j-1,$object))
							if field_list /=Void then -- REFERENCE or ARRAY[REFERENCE]
								-- Has object in field already been stored ? 
								if ct.item(pointer_inside_field(j-1,$object)).first.second_item/=default_pointer then
									-- Object in field is already in database -> update database for object's field
									oid2 := ct.item($object).first.first_item.to_integer
									oid1 := ct.item(ct.item(pointer_inside_field(j-1,$object)).first.second_item).first.first_item.to_integer
									!!one_rel.make(field_name(j,object))  !!one_object.make(oid2) !!other_object.make(oid1) 
									one_object.remove_all_successors(one_rel)
									one_object.append_successor(one_rel,other_object)
								else    
									!!one_element.make one_element.put_first(field_name(j,object))  one_element.put_second($object)
									field_list.finish field_list.put_right(one_element)
								end -- if
							else
								-- We want an object never seen before --> create its list
								!!one_element.make
								!!field_list.make(0) field_list.start field_list.put_left(one_element) 
								!!one_element.make one_element.put_first(field_name(j,object))  one_element.put_second($object)
								field_list.put_left(one_element)
								ct.put(field_list,pointer_inside_field(j-1,$object))
							end -- if
						elseif is_array_integer(object_field)   then -- ARRAY[INTEGER]
							one_attribute.set_value(one_object,Mts32_array,object_field)
						elseif is_array_double(object_field)   then -- ARRAY[DOUBLE]
							one_attribute.set_value(one_object,Mtdouble_array,object_field)
						elseif is_array_real(object_field)   then -- ARRAY[REAL]
							one_attribute.set_value(one_object,Mtfloat_array,object_field)
						end -- if
					when Integer_type then -- INTEGER
						one_attribute.set_value(one_object,Mts32,object_field)
					when Real_type then -- REAL
						one_attribute.set_value(one_object,Mtfloat,object_field)
					when Double_type then -- DOUBLE
						one_attribute.set_value(one_object,Mtdouble,object_field)
					when Character_type then -- CHARACTER
						one_attribute.set_value(one_object,Mtchar,object_field)
					when Boolean_type then -- BOOLEAN
						one_boolean ?= field(j,object) check one_boolean/= Void end
						if one_boolean.item then a_boolean := 1 else a_boolean := 0 end
							one_attribute.set_value(one_object,Mts32,a_boolean)
						else
							-- Do not know how to store this type  (POINTER, BIT N) 
					end -- inspect
				end -- if  
				j :=j + 1
			end -- loop
		end -- put_normal_object

	put_special_object(object : ANY) is
		local
			a_special : SPECIAL[ANY]
			nb_field,j,ftype, oid1, oid2 : INTEGER
			object_field : ANY
			field_list : ARRAYED_LIST[CT_ELEMENT]
			one_element : CT_ELEMENT
			one_object, other_object : MT_OBJECT
			one_rel : MT_RELATIONSHIP one_attribute : MT_ATTRIBUTE
		do
			a_special ?= object
			check a_special /= Void end
			from
				nb_field := a_special.count
				j := 0
			until
				j >= nb_field
			loop
				-- Is there anything to store ?
				object_field := a_special.item(j)
				if object_field /= Void then
					-- Is tc list of pointer inside field empty ?
					field_list := ct.item(pointer_inside_special_item(j,$a_special))
					if field_list /=Void then
						-- Has object in field already been stored ? 
						if ct.item(pointer_inside_special_item(j,$a_special)).first.second_item/=default_pointer then
							-- Object in field is already in database -> update database for object's field
							oid2 := ct.item($object).first.first_item.to_integer
							oid1 := ct.item(ct.item(pointer_inside_special_item(j,$a_special)).first.second_item).first.first_item.to_integer
							!!one_rel.make("area")  !!one_object.make(oid2) !!other_object.make(oid1) 
							one_object.append_successor(one_rel,other_object)
						else    
							!!one_element.make one_element.put_first((j+1).out)  one_element.put_second($object)
							field_list.finish field_list.put_right(one_element)
						end -- if
					else
						-- We want an object never seen before --> create its list
						!!one_element.make
						!!field_list.make(0) field_list.start field_list.put_left(one_element) 
						!!one_element.make one_element.put_first((j+1).out)  one_element.put_second($object)
						field_list.put_left(one_element)
						ct.put(field_list,pointer_inside_special_item(j,$a_special))
					end -- if
				end -- if  
				j :=j + 1
			end -- loop
		end -- put_special_object

	make_idf_table(count:INTEGER;key:INTEGER_REF) is
		local
			table_class : MT_CLASS
			one_table : MT_OBJECT
			an_idf_table : MATISSE_IDF_TABLE
		do
			if key.item <=0 then
				!!table_class.make(idf_table_name)
				one_table := table_class.new_instance
				!!an_idf_table.make(count,one_table.oid)
			else
				!!an_idf_table.make(count,key.item)
			end -- if
			idf_table.put(an_idf_table)
			id_cell.put(an_idf_table.oid)
		ensure then 
			table_exists : idf_table.item /= Void
		end -- make_idf_table

	save_idf_table is 
		do
			idf_table.item.save
		end -- save_idf_table

end -- class MATISSE_STORER

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

