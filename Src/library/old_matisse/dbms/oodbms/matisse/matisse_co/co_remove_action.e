indexing
    description:"Actions used during a traversal of COMPOSED_OBJECTs to remove the objects from the database."
    keywords:	""
    revision:	"%%A%%"
    source:	"%%P%%"
    requirements: ""

class CO_REMOVE_ACTION

    inherit 

    TYPES
        export {NONE} 
		   all
	   undefine
		   is_real, is_integer, is_character, is_double, is_string
        end 
	---------------------------------------------------------------------------------

	TRAVERSAL_ACTION
		redefine
			closure_init_action, closure_finish_action,
			normal_object_action, special_object_action,
			normal_object_test, special_object_test
	    end

    feature -- Actions
	closure_init_action (es:EXT_STORABLE; instance_count:INTEGER) is
			-- perform once at start of traversing closure
		do
		end

	closure_finish_action (es:EXT_STORABLE) is
			-- perform once at end of traversing closure
		do
			debug("matisse-trav")
				-- Display class name
				io.putstring(" REMOVE CLOSURE FINISH - ")
				io.putstring(class_name(es))
				io.putstring(" - remove IDF table ... ")
			end

		end

	normal_object_action (object: ANY; is_exp:BOOLEAN) is
		-- Perform action on object inspected
		do
			debug ("matisse-trav")
				-- Display class name
				io.putstring(" NORMAL REMOVE ACTION:")
				io.putstring(class_name(object))
				io.new_line
			end          

			if not is_exp then
			    storer.item.remove_object(object)
			end
		end

--	normal_object_test (object: ANY):BOOLEAN is
-- TEMP: DYN TYPE handling; revert to commented version when fixed.
	normal_object_test (object: ANY; fld_num:INTEGER):BOOLEAN is
		-- decide whether object should have action executed on it
		do  
			debug("matisse-trav")
				-- Display class name
				io.putstring(" NORMAL TEST: ")
--				io.putstring(class_name(object))
				io.putstring(class_name(field(fld_num,object)))
        		end
			
			Result := not is_db_implemented_type(object, fld_num)

			debug("matisse-trav")
				if Result then
					io.putstring(" passed ")
				else
					io.putstring(" failed ")
				end
				io.new_line;
        		end
		end

	special_object_action (object: ANY) is
		-- Perform action on object inspected
		do 
			debug ("matisse-trav")
			    -- Display class name
			    io.putstring(" SPECIAL ACTION:")
			    io.putstring(class_name(object))
			    io.new_line;
			end              
 
			-- do the database storage action
			if not is_special_simple($object) then
				storer.item.remove_object(object)
			end

		end

	special_object_test (object: ANY):BOOLEAN is
		-- decide whether object should have action executed on it
		do  
			debug("matisse-trav")
				-- Display class name
				io.putstring(" SPECIAL TEST: ")
				io.putstring(class_name(object))
        		end

			Result := True  

			debug("matisse-trav")
				if Result then
					io.putstring(" passed ")
				else
					io.putstring(" failed ")
				end
				io.new_line;
        		end
		end

end

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------