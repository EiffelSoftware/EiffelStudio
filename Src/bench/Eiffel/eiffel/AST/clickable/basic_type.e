indexing

	description: "Abstract class for Eiffel basic types. Bench version."
	date: "$Date$"
	revision: "$Revision$"

deferred class BASIC_TYPE

inherit
	TYPE
		redefine
			format, append_to
		end

	CLICKABLE_AST
		redefine
			is_class, associated_eiffel_class
		end

feature {AST_FACTORY} -- Initialization

	initialize is
			-- Create a new BASIC_TYPE AST node.
		do
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Properties

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

feature -- Signature

	append_to (st: STRUCTURED_TEXT) is
		do
			actual_type.append_to (st)
		end

feature -- Stoning

	associated_eiffel_class (reference_class: CLASS_C): CLASS_C is
		do
			Result := actual_type.associated_class
		end

feature -- Formatting

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_classi (actual_type.associated_class.lace_class)
		end

end -- class BASIC_TYPE
