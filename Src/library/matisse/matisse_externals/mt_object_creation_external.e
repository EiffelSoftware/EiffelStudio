indexing
	description: "external methods for class MT_OBJECT_CREATION."

class
	MT_OBJECT_CREATION_EXTERNAL

feature {NONE} -- Implementation

	c_dynamic_create_eif_object (mt_handle: INTEGER): MT_STORABLE is
		external
			"C"
		end

	c_generic_type_id (c_string: POINTER): INTEGER is
		external
			"C"
		end


	c_create_empty_rs_container (a_type_id, pred_oid, rel_oid: INTEGER): MT_RS_CONTAINABLE is
		external
			"C"
		end
	
	c_create_object_from_cid (class_oid: INTEGER) : INTEGER is
			-- Create new MATISSE object using MtCreateObject ().
			-- Return new oid.
		external
			"C"
		end

end -- class MT_OBJECT_CREATION_EXTERNAL
