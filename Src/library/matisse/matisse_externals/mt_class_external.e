indexing
	description: "External methods for class MT_CLASS."

class 
	MT_CLASS_EXTERNAL 

inherit
	MT_CREATE_OBJECT_EXTERNAL

feature {NONE} -- Implementation MT_CLASS

	c_get_class_from_name (name: POINTER): INTEGER is
		external 
			"C"
		end
	
	c_get_object_class (oid: INTEGER): INTEGER is
			-- Use MtGetClassFromObject.
		external 
			"C"
		end

	c_get_all_attributes (cid: INTEGER) is
			-- Use Mt_MGetAllAttributes.
		external 
			"C"
		end

	c_get_all_relationships (cid: INTEGER) is
			-- Use Mt_MGetAllRelationships.
		external 
			"C"
		end

	c_get_all_inverse_relationships (cid: INTEGER) is
			-- Use Mt_MGetAllIRelationships.
		external 
			"C"
		end

	c_get_all_subclasses (cid: INTEGER) is
			-- Use Mt_MGetAllISubclasses.
		external 
			"C"
		end

	c_get_all_superclasses (cid: INTEGER) is
			-- Use Mt_MGetAllSuperclasses.
		external 
			"C"
		end

	c_get_instances_number (cid: INTEGER): INTEGER is
			-- Use Mt_GetInstancesNumber.
		external 
			"C"
		end

	c_create_num_objects (n, oid: INTEGER)  is
			-- Use MtCreateNumObjects.
		external 
			"C"
		end

	c_get_eiffel_type_id_from_name (c_class_name: POINTER): INTEGER is
			-- This function should be moved to class MT_CLASS_EXTERNAL.
		external 
			"C"
		end

end -- class MT_CLASS_EXTERNAL
