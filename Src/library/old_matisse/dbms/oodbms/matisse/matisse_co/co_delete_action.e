indexing
	description: "Actions used during a traversal of COMPOSED_OBJECTs to remove the objects from the database."
	keywords:    ""
	revision:    "%%A%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	copyright:   "See notice at end of class"

class CO_DELETE_ACTION

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
		    normal_object_action, special_object_action,
		    normal_object_test
	    end

feature -- Actions
	normal_object_action (object:ANY; is_exp:BOOLEAN) is
		    -- Perform action on object inspected
		local
			co:COMPOSED_OBJECT
		do
			co ?= object
			if co /= Void then
				debug("matisse-trav")
					io.putstring(generator) io.put_string(".normal_object_action: ")
					io.putstring(class_name(object)) io.new_line
	        	end          

				if not is_exp then
				    storer.item.delete_sub_closure(co)
				end
			end
		end

	special_object_action (object: ANY) is
		local
			co:COMPOSED_OBJECT
		do
			co ?= object
			if co /= Void then
				debug("matisse-trav")
					io.putstring(generator) io.put_string(".special_object_action: ")
					io.putstring(class_name(co)) io.new_line 
				end              
 
				-- do the database storage action
				storer.item.delete_sub_closure(co)
			end
		end

feature -- Tests
	normal_object_test (object: ANY; fld_num:INTEGER):BOOLEAN is
		do  
			debug("matisse-trav")
				io.putstring(generator) io.put_string(".normal_object_test: ")
				io.putstring(class_name(field(fld_num,object))) io.new_line
        	end
			
			Result := not odb_schema.is_db_implemented_type(object, fld_num)

			debug("matisse-trav")
				if Result then
					io.putstring(" passed ")
				else
					io.putstring(" failed ")
				end
				io.new_line
        	end
		end

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         |          support: info@deepthought.com.au         |
--         |                                                   |
--         +---------------------------------------------------+

