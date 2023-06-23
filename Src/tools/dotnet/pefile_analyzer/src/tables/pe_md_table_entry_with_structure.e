note
	description: "Summary description for {PE_MD_TABLE_ENTRY_WITH_STRUCTURE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

inherit
	PE_MD_TABLE_ENTRY
		redefine
			make,
			dump,
			to_string, to_string_array,
			description, description_as_array,
			has_error,
			errors
		end

feature {NONE} -- Initialization

	make (pe: PE_FILE)
		do
			initialize_structure
			Precursor (pe)
		end

	initialize_structure
		deferred
		end

feature -- Access

	structure: PE_STRUCTURE

	read (pe: PE_FILE)
		do
			structure.read (pe)
		end

	has_error: BOOLEAN
		do
			Result := structure.has_error
		end

	errors: ARRAYED_LIST [PE_ERROR]
		do
			Result := structure.errors
		end

feature -- Display

	to_string_array: ARRAY [like to_string]
		do
			Result := structure.to_string_array
		end

	to_string: STRING_32
		do
			Result := structure.to_string
		end

	to_link_string: STRING_32
		do
			Result := {STRING_32} "{" + structure.label + "}"
		end

	description_as_array: ARRAY [READABLE_STRING_GENERAL]
		do
			Result := structure.description_as_array
		end

	description: STRING_8
		do
			Result := structure.description
		end

	dump: STRING_8
		do
			Result := structure.dump
		end

end
