-- Precompiled attribute ids.

class P_ATTRIBUTE_ID

inherit

	P_ROUTINE_ID
		undefine
			is_attribute
		end;
	ATTRIBUTE_ID
		rename
			make as make_id
		undefine
			compilation_id, prefix_string
		end

creation

	make

end -- class P_ATTRIBUTE_ID
