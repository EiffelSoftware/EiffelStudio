-- Abstract repesentation of a VOID type

class VOID_TYPE obsolete "none_type_as is the correct class"

inherit

	TYPE
		redefine
			simple_format
		end

feature

	set is
		do
			-- Do nothing
		end;

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.put_string (generator);
		end;

end
