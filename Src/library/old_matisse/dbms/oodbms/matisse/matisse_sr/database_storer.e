deferred class DATABASE_STORER 

inherit

	DB_STATUS_USE
		export {NONE} all
	end

	DB_STATUS_USE
		export {ANY} is_connected 
	end

	STORER
		export {NONE} all
		undefine is_integer, is_real , is_double, is_character, is_string
	end

	MEMORY
        export {NONE} all
		undefine dispose
	end

	TYPES
        	export {NONE} all
	end 

feature

	store(one_object : ANY;medium : any) is
		-- Prepare storage and store objects reachable from 'one_object'
		local
			objects_count : INTEGER
				-- count objects while traversing
			was_collecting : BOOLEAN
				-- Was the garbage collector on ?
			es : EXT_STORABLE
		do
            		-- Stop garbage collector
            		was_collecting := collecting full_collect collection_off

            		--  Do the traversal : mark and count the objects to store
 			es ?= one_object check es /= Void end 
			objects_count := es.new_deep_traversal(one_object,0);
			!!ct.make(objects_count)
			make_idf_table(objects_count,0)
			--  Write objects to be stored in buffer
			store_one_object(one_object,dynamic_type(one_object)=Expanded_type);
			-- Save idf_table
			save_idf_table
            		--  Set the garbage collector            
            		if was_collecting then collection_on end
		end -- store

	store_one_object(object : ANY;is_exp : BOOLEAN)   is
		-- Write 'object' and its dependencies in database
		local 
			a_special : SPECIAL[ANY]
			number_of_fields,i : INTEGER
			a_linked_list :LINKED_LIST[ANY] 
			an_array_integer : ARRAY[INTEGER] 
			area : SPECIAL[ANY]
			current_field : ANY
			b_array_integer,b_array_double,b_array_real,b_array_string,b_linked_list_integer,
			b_linked_list_double ,b_linked_list_real,b_linked_list_string : BOOLEAN
		do
			-- if already unmarked then do not store
			if object/=Void and then (is_exp or else (is_marked(object)))  then
				-- unmark the object
				unmark(object) 
				-- Special object
				if is_special(object) then
					if not(is_special_simple($object)) then
					-- Special of references or Special of composites i.e objects with sub-objects
					a_special ?= object
					check a_special /= Void end
					from
						number_of_fields := a_special.count
						i := 0
					until
						i = number_of_fields
					loop
						if a_special.item(i) /= Void then 
							store_one_object(a_special.item(i),dynamic_type(a_special.item(i))=Expanded_type)
						end
						i := i+1
					end -- loop
				end -- if
			else
                    		from
					number_of_fields := field_count (object)
					i := 1
				until
		                        i > number_of_fields
				loop
					current_field := field(i,object)
					a_linked_list ?= field(i,object) 
					an_array_integer:= Void an_array_integer ?= field(i,object)
					if an_array_integer /= Void then area ?= an_array_integer.area else area := Void end                 
						if  not( is_array_integer(field(i,object)) or 
							is_array_double(field(i,object)) or 
							is_array_real(field(i,object))  or
							is_linked_list_integer(field(i,object))  or 
							is_linked_list_double(field(i,object)) or 
							is_linked_list_real(field(i,object)) or
							is_linked_list_string(field(i,object)) or is_string(field(i,object))  ) then 
							store_one_object(field (i, object),field_type(i, object)=Expanded_type) 
						end -- if
 					i := i+1
				end -- loop
			end -- if
			if not(is_exp) and then not(is_special_simple($object)) then putobject(object) end 
		else
			-- Object is already marked, do nothing
		end -- if    
	end -- store_one_object


feature {NONE} -- Implementation

	ct : HASH_TABLE[ARRAYED_LIST[CT_ELEMENT],POINTER]

	dispose is
		-- Do nothing
		do
		end

	make_idf_table(arg1 : INTEGER;arg2 : ANY) is deferred end -- make idf_table

	save_idf_table is deferred end -- save_id_table

invariant

	always_connected : is_connected

end -- class DATABASE_STORER

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

