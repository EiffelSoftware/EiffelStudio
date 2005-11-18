-- Byte code for deferred features

class DEF_BYTE_CODE

inherit

	BYTE_CODE
		redefine
			is_deferred
		end

feature

	is_deferred: BOOLEAN is True;
			-- Is the current byte code a byte code for deferred
			-- features ?

	make_body_code (ba: BYTE_ARRAY; a_generator: MELTED_GENERATOR) is
			-- Generate byte code for the feature body.
		do
			ba.append (Bc_deferred);
		end;

end
