class 
	MT_PROPERTY 

inherit
	MT_METASCHEMA
		
	MT_PROPERTY_EXTERNAL
		undefine 
			is_equal 
		end

feature -- Status Report

	check_property (one_object: MT_OBJECT): BOOLEAN  is
			-- Is property ok?
		do
			Result := c_check_property (id, one_object.oid)
		end -- check

feature  -- Access

	id: INTEGER is
		do
			Result := oid
		end

	eiffel_name: STRING is
		local
			i: INTEGER
			mt_name: STRING
		do
			mt_name := clone (name)
			mt_name.to_lower
			i := mt_name.substring_index ("__", 1)
			if i = 0 then
				i := mt_name.substring_index ("::", 1)
			end
			if i = 0 then
				Result := mt_name
			else
				!! Result.make (mt_name.count - i - 1)
				Result.set (mt_name, i + 2, mt_name.count)
			end
		end

feature -- Schema

	eif_field_index: INTEGER
		-- The current property corresponds to field_index-th field of Eiffel object
	
	set_field_index (i: INTEGER) is
			-- Assign `i' to `eif_field_index'
		do
			eif_field_index := i
		end

	class_oid: INTEGER
		-- 'class_id' is oid of the class where the current property (attribute 
		-- or relationship) is defined.
		-- At the moment, this is used only by relationship. 98.11.21 K. Nakao
	
	set_class_oid (an_id: INTEGER) is
		do
			class_oid := an_id
		end
end -- class MT_PROPERTY
