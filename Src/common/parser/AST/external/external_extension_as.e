indexing
	description: "Encapsulation of an external extension."
	date: "$Date$"
	revision: "$Revision$"

deferred class EXTERNAL_EXTENSION_AS

feature -- Properties

	argument_types: ARRAY [INTEGER]
			-- Types of the arguments (extracted from the C signature)

	return_type: INTEGER
			-- Return type (extracted from the C signature)

	header_files: ARRAY [INTEGER]
			-- Header files to include

feature -- Conveniences

	is_macro: BOOLEAN is
			-- Is this a macro extension?
		do
		end

	is_struct: BOOLEAN is
			-- Is this a struct extension?
		do
		end

	is_dll: BOOLEAN is
			-- Is this a dll extension?
		do
		end

	has_signature: BOOLEAN is
			-- Does the extension define a c_signature?
		do
			Result := return_type > 0 or else argument_types /= Void
		end

feature {NONE} -- Implementation

	c_signature: STRING
			-- Signature

	include_files: STRING
			-- Include files

	special_part: STRING
			-- Special part

end -- class EXTERNAL_EXTENSION_AS
