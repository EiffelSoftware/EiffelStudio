class
	PE_SIGNATURE_BLOB_INDEX

inherit
	PE_BLOB_INDEX
		redefine
			read
		end

create
	make

feature -- Read

	read (pe: PE_FILE): PE_SIGNATURE_BLOB_ITEM
		local
			idx: PE_INDEX_ITEM
		do
			idx := pe.read_blob_index (label)
			create Result.make_from_item (idx)
		end

end
