indexing

	description: "Abstract class for Eiffel basic types. Bench version.";
	date: "$Date$";
	revision: "$Revision$"

deferred class BASIC_TYPE_B

inherit

	BASIC_TYPE
		undefine
			same_as
		redefine
			associated_eiffel_class,
			append_to
		end;
	TYPE_B
		redefine 
			format, append_to
		end

feature -- Signature

	append_to (st: STRUCTURED_TEXT) is
		do
			actual_type.append_to (st)
		end;

feature -- Stoning

	associated_eiffel_class (reference_class: CLASS_C): CLASS_C is
		do
			Result := actual_type.associated_eclass
		end;

feature -- Formatting

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.put_classi (actual_type.associated_class.lace_class);
		end;

end -- class BASIC_TYPE_B
