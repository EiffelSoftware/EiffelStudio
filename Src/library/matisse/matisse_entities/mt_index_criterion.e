indexing
	description: "Represents an Matisse index criterion"
	
class 
	MT_INDEX_CRITERION 

inherit
	MT_CONSTANTS

	MT_NAME_EXTERNAL
	
	INTERNAL
		export 
			{NONE} all 
		end
	
creation
	make

feature -- Initialization

	make (an_oid, a_type, a_size, an_ordering: INTEGER) is
		require
			ascend_or_descend: an_ordering = Mt_Ascend or else an_ordering = Mt_Descend
		do
			attr_oid := an_oid
			type := a_type
			size := a_size
			ordering := an_ordering
		end

feature -- Status Report

	type: INTEGER 

	size: INTEGER 

	ordering: INTEGER 
		-- Ordering of the indexation for the criterion as described in the meta-schema

	attribute_name: STRING is
		do
			!! Result.make (0)
			Result.from_c (c_object_mt_name (attr_oid))
		end

feature -- Criterion values

	start_value: ANY
	
	end_value: ANY
	
feature -- Setting criterion value

	set_start_value (s_value: ANY) is
		do
			start_value := clone (s_value)
		end

	set_end_value (e_value: ANY) is
		do
			end_value := clone (e_value)
		end

feature {MT_INDEX_STREAM} -- Implementation

	copy_values_to_c (i: INTEGER) is
		local
			one_string: STRING
			c_one_string: ANY
		do
			if start_value /= void then
				one_string ?= start_value
				if one_string /= void then
					c_one_string := one_string.to_c
				else 
					inspect dynamic_type (start_value)
					when Integer_type then
					when Real_type then
					when Double_type then
					else
					end
				end
				
			end
		end

feature {NONE}

	attr_oid: INTEGER -- Attribute identifier in database

end -- class MT_INDEX_CRITERION
