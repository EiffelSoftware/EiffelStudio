class TRAVERSAL_ACTION 

inherit 
	SHARED_ODB_ACCESS
		export
			{NONE} all
		end

	EXT_INTERNAL
		export {NONE} all
	end

	STORE_HANDLE

feature -- Actions
	closure_init_action (object:ANY; instance_count:INTEGER) is
			-- perform once at start of traversing closure
		do
			debug("matisse-trav")
				io.putstring(generator) io.put_string(".closure_init_action: ")
				io.putstring(class_name(object)) io.new_line
			end
		end

	closure_finish_action (object:ANY) is
			-- perform once at end of traversing closure
		do
			debug("matisse-trav")
				io.putstring(generator) io.put_string(".closure_finish_action: ")
				io.putstring(class_name(object)) io.new_line
			end
		end

	normal_object_action (object: ANY; is_exp:BOOLEAN) is
			-- Perform action on object inspected
		do  
			debug("matisse-trav")
				io.putstring(generator) io.put_string(".normal_object_action: ")
				io.putstring(class_name(object)) io.new_line
        	end          
		end

	special_object_action (object: ANY) is
			-- Perform action on object inspected
		do 
			debug("matisse-trav")
				io.putstring(generator) io.put_string(".special_object_action: ")
				io.putstring(class_name(object)) io.new_line 
			end              
		end

	field_action(i:INTEGER;object : ANY) is
			-- Perform action on field inspected
		do
			debug("matisse-trav")
				io.putstring(generator) io.put_string(".field_action: ")
        		io.putstring("Object ")
				io.putstring(field_name(i,object))
				io.putstring(":")
        		io.putstring(i_th_type_name(field_type(i,object)))
				io.new_line
			end
		end

feature -- Tests
	closure_proceed(object:ANY):BOOLEAN is
			-- decide whether to process this closure; typical use: override in 
			-- descendants for testing dirty markers etc for storage
		do
			Result := True
		end

	--	normal_object_test (object: ANY):BOOLEAN is
	-- TEMP: DYN TYPE handling; revert to commented version when fixed.
	normal_object_test (object: ANY; fld_num:INTEGER):BOOLEAN is
			-- decide whether object should have action executed on it
		do  
			debug("matisse-trav")
				io.putstring(generator) io.put_string(".normal_object_test: ")
				io.putstring(class_name(field(fld_num,object))) io.new_line
        	end
			Result := True
		end

	special_object_test (object: ANY):BOOLEAN is
			-- decide whether object should have action executed on it
		do  
			debug("matisse-trav")
				io.putstring(generator) io.put_string(".special_object_test: ")
				io.putstring(class_name(object))
        	end          		
			Result := True
			debug("matisse-trav")
				if Result then io.putstring(" passed ") else io.putstring(" failed ") end
				io.new_line
       		end
		end


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
		end

feature {NONE} -- External C
	is_special_simple(object : POINTER) : BOOLEAN  is
			-- Is current object a special of pointers ?
		external 
			"C"
 		alias
			"c_is_special_simples"
		end

end
