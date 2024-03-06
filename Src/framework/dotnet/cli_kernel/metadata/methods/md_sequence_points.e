note
	description: "Representation of a sequence points blob"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Sequence Points", "src=https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md#sequence-points-blob", "target=uri"

class
	MD_SEQUENCE_POINTS

inherit
	MD_BLOB_DATA

create
	make

feature -- Reset

	reset
			-- Reset current for new signature definition
		do
			current_position := 0
		ensure
			current_position_set: current_position = 0
		end
feature -- Setting		

	set_local_signature (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		do
			compress_unsigned_data (a_value)
		end

	set_document_id (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		do
			compress_unsigned_data (a_value)
		end

	put_il_offset (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value <= 0x20000000
		do
			compress_unsigned_data (a_value)
		end

	put_start_line (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value <= 0x20000000
		do
			compress_unsigned_data (a_value)
		end

	put_start_column (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value <= 0x10000
		do
			compress_unsigned_data (a_value)
		end

	put_signed_start_line (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value <= 0x20000000
		do
			compress_signed_data (a_value)
		end

	put_signed_start_column (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value <= 0x10000
		do
			compress_signed_data (a_value)
		end

	put_lines (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value >= 0
		do
			compress_unsigned_data (a_value)
		end

	put_columns (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value >= 0
		do
			compress_unsigned_data (a_value)
		end

	put_signed_columns (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value >= 0
		do
			compress_signed_data (a_value)
		end

	put_document_record (a_value: INTEGER_32)
		require
			valid_value: a_value <= 0x20000000
		do
			compress_unsigned_data (0) -- IL offset
			compress_unsigned_data (a_value)
		end

	put_signed (a_value: INTEGER_32)
		do
			compress_signed_data (a_value)
		end

	put_unsigned_value (a_value: INTEGER_32)
		do
			compress_unsigned_data (a_value)
		end


end
