note
	description: "Summary description for {PE_MD_TABLE_ENTRY_WITH_STRUCTURE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

inherit
	PDB_MD_TABLE_ENTRY
		redefine
			make,
			dump,
			to_string, to_string_array, binary_byte_sizes_string_array,
			description, description_as_array
		end

feature {NONE} -- Initialization

	make (pe: PDB_FILE)
		do
			initialize_structure
			Precursor (pe)
		end

	initialize_structure
		deferred
		end

feature -- Access

	structure: PE_STRUCTURE

	read (pe: PDB_FILE)
		do
			structure.read (pe)
			if structure.has_error then
				across
					structure.errors as ic
				loop
					report_error (ic.item)
				end

			end
		end

feature -- Display

	binary_byte_sizes_string_array: ARRAY [like to_string]
		do
			Result := structure.binary_byte_sizes_string_array
		end

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

feature -- Helpers

	index_is_less_than (i1, i2: detachable PE_INDEX_ITEM): BOOLEAN
			-- Is `i1` object less than `i2`?
		do
			if i1 /= Void then
				if i2 /= Void then
					Result := i1 < i2
				else
					Result := False -- i1 (attached) is not less than i2 (Void)
				end
			elseif i2 /= Void then
					-- i1 = Void
				Result := True -- i1 (Void) is less than attached i2
			else
				Result := False -- Void = Void
			end
		end

end
