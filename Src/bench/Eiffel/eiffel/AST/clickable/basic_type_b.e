indexing

	description: "Abstract class for Eiffel basic types. Bench version.";
	date: "$Date$";
	revision: "$Revision$"

deferred class BASIC_TYPE_B

inherit

	BASIC_TYPE
		undefine
			is_deep_equal, same_as
		end;

	STONABLE;

	TYPE_B
		redefine 
			format, append_clickable_signature
		end

feature -- Signature

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
		do
			actual_type.append_clickable_signature (a_clickable)
		end;

feature -- Stoning

	stone (reference_class: E_CLASS): CLASSC_STONE is
		do
			!!Result.make (actual_type.associated_eclass)
		end;

feature -- Formatting

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.put_class_name (actual_type.associated_class);
		end;

end -- class BASIC_TYPE_B
