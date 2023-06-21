note
	description: "Delegate to MD_EMIT object."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_EMIT_BRIDGE

feature {NONE} -- Access

	md_emit: MD_EMIT
		deferred
		end

	pe_writer: PE_GENERATOR --  PE_WRITER
			-- helper class to generate the PE file.
			--| using as a helper class to access needed features.
		do
			Result := md_emit.pe_writer
		end

feature {NONE} -- Bridge to MD_EMIT		

	frozen extract_table_type_and_row (a_token: INTEGER): TUPLE [table_type_index: NATURAL_32; table_row_index: NATURAL_32]
		do
			Result := md_emit.extract_table_type_and_row (a_token)
		end

	frozen create_implementation (a_token: INTEGER; a_index: NATURAL_32): PE_IMPLEMENTATION
			-- Create a new PE_IMPLEMENTATION instance with the given `a_token' and `a_index'.
		do
			Result := md_emit.create_implementation (a_token, a_index)
		end

	frozen hash_blob (a_blob_data: ARRAY [NATURAL_8]; a_blob_len: NATURAL_32): NATURAL_32
			-- Computes the hash of a blob `a_blob_data'
			-- if the blob already exists in a heap, returns the index of the existing blob
			-- otherwise computes the hash and returns the index of the new blob.
		do
			Result := md_emit.hash_blob (a_blob_data, a_blob_len)
		end

feature {NONE} -- Change tables

	frozen add_table_entry (a_entry: PE_TABLE_ENTRY_BASE): NATURAL_32
			-- Index in related MD_TABLE
			-- add an entry to one of the tables
			-- note the data for the table will be a class inherited from TableEntryBase,
			--  and this class will self-report the table index to use
		require
			valid_entry_table_index: md_emit.tables.valid_index (a_entry.table_index.to_integer_32)
		do
			Result := md_emit.add_table_entry (a_entry)
		end

end
