indexing
	description: "External methods for class MT_INDEX."

class 
	MT_INDEX_EXTERNAL 

feature {NONE} -- Implementation MT_INDEX

	c_get_index (index_name: POINTER): INTEGER is
			-- Use MtGetIndex.
		external
			"C"
		end

	c_index_entries_count (iid: INTEGER): INTEGER is
			-- Use MtGetIndexInfo.
		external
			"C"
		end

	c_load_index_info (iid: INTEGER) is
			-- Use MtGetIndexInfo.
		external
			"C"
		end

	c_get_index_criteria_count: INTEGER is
		external
			"C"
		end
	c_get_index_criterion_attr_oid (i: INTEGER): INTEGER is
		external
			"C"
		end
	
	c_get_index_criterion_type (i: INTEGER): INTEGER is
		external
			"C"
		end
	
	c_get_index_criterion_size (i: INTEGER): INTEGER is
		external
			"C"
		end
	
	c_get_index_criterion_order (i: INTEGER): INTEGER is
		external
			"C"
		end
	
	c_get_index_classes_count: INTEGER is
		external
			"C"
		end
	
	c_get_index_class (i: INTEGER): INTEGER is
		external
			"C"
		end
	
end -- class MT_INDEX_EXTERNAL
