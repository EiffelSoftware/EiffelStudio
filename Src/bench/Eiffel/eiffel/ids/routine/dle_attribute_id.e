-- DC-set attribute ids.

class DLE_ATTRIBUTE_ID

inherit

	DLE_ROUTINE_ID
		undefine
			is_attribute
		end;
	ATTRIBUTE_ID
		undefine
			is_dynamic, compilation_id
		end

creation

	make

end -- class DLE_ATTRIBUTE_ID
