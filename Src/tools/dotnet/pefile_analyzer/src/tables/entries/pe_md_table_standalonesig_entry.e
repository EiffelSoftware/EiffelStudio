class
	PE_MD_TABLE_STANDALONESIG_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (1, "StandAloneSig")
			structure := struct
			struct.add_method_or_locals_signature_blob_index ("Signature")
		end

feature -- Access

	table_id: NATURAL_32
		once
			Result := {PE_TABLES}.tstandalonesig
		end

end
