indexing
	description: "Actions used during a traversal of COMPOSED_OBJECTs to store the objects to the database.%
                   %Should have the same effect as the original ISE code in DATABASE_STORER.store_one_object()."
	keywords:	""
	revision:	"%%A%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	copyright:   "See notice at end of class"

class CO_STORE_ACTION 

inherit 
	TRAVERSAL_ACTION
		redefine
			closure_proceed,
			closure_init_action, closure_finish_action,
			normal_object_action, special_object_action,
			normal_object_test
	    end

feature -- Actions
	closure_init_action (co:COMPOSED_OBJECT; instance_count:INTEGER) is
		local
			idf_proxy:PROXY_IDF_TABLE 
		do
			debug("matisse-trav")
				io.putstring(generator) io.put_string(".closure_init_action: ")
				io.putstring(class_name(co)) 
				io.putstring(" - make IDF table ... ")
				io.new_line
			end

			!!idf_proxy.make(instance_count, 0)

			storer.item.idf_proxy_stack.extend(idf_proxy)
		end

	closure_finish_action (co:COMPOSED_OBJECT) is
		do
			debug("matisse-trav")
				io.putstring(generator) io.put_string(".closure_finish_action: ")
				io.putstring(class_name(co))
				io.putstring(" (save IDF table)")
				io.new_line
			end

			storer.item.idf_proxy.save
			storer.item.idf_proxy_stack.remove

			-- ********** FIXME: mark_for_store needs to go in EXT_STORABLE **********
			co.co_unmark_for_store
		end

	normal_object_action (object:ANY; is_exp:BOOLEAN) is
		local
			co:COMPOSED_OBJECT
		do
			debug("matisse-trav")
				io.putstring(generator) io.put_string(".normal_object_action: ")
				io.putstring(class_name(object)) io.new_line
        	end          

			-- write internal key to stored_key attribute
			co ?= object
			if co /= Void then
		        co.pre_store_action
			end

			-- do the database storage action
			if not is_exp then
				storer.item.put_object(object)
			end

		end

	special_object_action (object: ANY) is
		do 
			debug("matisse-trav")
				io.putstring(generator) io.put_string(".special_object_action: ")
				io.putstring(class_name(object)) io.new_line 
			end              
 
			-- do the database storage action
			if not is_special_simple($object) then
				storer.item.put_object(object)
			end
		end

feature -- Tests
	closure_proceed(co:COMPOSED_OBJECT):BOOLEAN is
			-- decide whether to process this closure; typical use: override in 
			-- descendants for testing dirty markers etc for storage
		do
			Result := co.co_marked_for_store
		end

	normal_object_test (object: ANY; fld_num:INTEGER):BOOLEAN is
		do  
			debug("matisse-trav")
				io.putstring(generator) io.put_string(".normal_object_test: ")
				io.putstring(class_name(field(fld_num,object))) io.new_line
        	end
			
			Result := not odb_schema.is_db_implemented_type(object, fld_num)

			debug("matisse-trav")
				if Result then io.putstring(" passed ") else io.putstring(" failed ") end
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
