class TRAVERSAL_ACTION 

inherit 
	EXT_INTERNAL
		export {NONE} all
	end

feature -- Actions
    
	normal_object_action (object: ANY) is
		-- Perform action on object inspected
		do  
			debug 
				-- Display class name
				io.putstring(" ")
				io.putstring(class_name(object))
				io.new_line;
        		end          
		end -- normal_object_action

	special_object_action (object: ANY) is
		-- Perform action on object inspected
		do 
			debug
				-- Display class name
				io.putstring(" ")
				io.putstring(class_name(object))
				io.new_line;
			end              
		end -- special_object_action

	field_action(i:INTEGER;object : ANY) is
		-- Perform action on field inspected
		do
			debug
				-- Display name and field type
        			io.putstring("Object ");
				io.putstring(field_name(i,object));
				io.putstring(" : ");
        			io.putstring(i_th_type_name(field_type(i,object))); 
			end
		end -- field_action


feature {NONE} -- Type management

	i_th_type_name(type_number:INTEGER) : STRING is
		-- Type name of which type_number is the (see INTERNAL for codes)
		require 
			-- Type number correct
		do
			inspect type_number
				when Pointer_type   then Result := "Pointer"
				when Reference_type then Result := "Reference to"
				when Character_type then Result := "Character"
				when Boolean_type   then Result := "Boolean"
				when Integer_type   then Result := "Integer"
				when Real_type      then Result := "Real"
				when Double_type    then Result := "Double"
				when Expanded_type  then Result := "Expanded"
 				when Bit_type       then Result := "Bit"
			end -- inspect
    		end -- i_th_type_name

	is_simple_type (object:ANY) : BOOLEAN is
		-- Is type of object equal to char,bool,int,real,double, pointer or bit ?
		require
			object_not_void : object /= Void
		local
			dt : INTEGER
		do
 			dt:= dynamic_type(object)
			Result:= (dt=Character_type) or else
				(dt=Boolean_type) or else
				(dt=Integer_type) or else
				(dt=Character_type) or else
				(dt=Real_type) or else
				(dt=Double_type) or else
				(dt=Bit_type) or else
				(dt=Pointer_type)
		end -- is_simple_type

feature {NONE} -- External C

	is_special_simple(object : POINTER) : BOOLEAN  is
		-- Is current object a special of pointers ?
		external 
			"C"
 		alias
			"c_is_special_simples"
	end -- is_special_simple

end -- class TRAVERSAL_ACTION

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

