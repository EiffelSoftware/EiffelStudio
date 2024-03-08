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

feature {NONE} -- Implementation	

	was_hidden_sequence: BOOLEAN

	is_hidden_sequence_point (a_start_line, a_end_line: INTEGER_32; a_start_column, a_end_column: INTEGER_32): BOOLEAN
		do
			Result := a_start_line = a_end_line and then a_start_line = 0x00FE_EFEE and then (a_start_column = a_end_column) and then a_start_column = 0
		end

	sequence_points_count: INTEGER

	prev_il_offset: INTEGER_32
	prev_non_hidden_start_line: INTEGER_32
	prev_non_hidden_start_column: INTEGER_32

feature -- Change		

	put_sequence_point (a_il_offset, a_start_line, a_start_col, a_end_line, a_end_col: INTEGER_32)
		local
			l_delta_lines: INTEGER_32
		do
			if is_hidden_sequence_point (a_start_line, a_end_line, a_start_col, a_end_col) then
					-- Hidden-sequence-point-record
				was_hidden_sequence := True
				if sequence_points_count = 0 then
					put_il_offset (a_il_offset)
				else
					put_il_offset (a_il_offset - prev_il_offset)
				end
				put_lines (0)
				put_columns (0)
			else
					-- sequence-point-record (it seems it the same as hidden)
				if sequence_points_count = 0 then
					put_il_offset (a_il_offset)
				else
					put_il_offset (a_il_offset - prev_il_offset)
				end

				l_delta_lines := a_end_line - a_start_line
				put_lines (l_delta_lines)
				if l_delta_lines = 0 then
					put_columns (a_end_col - a_start_col)
				else
					put_signed_columns (a_end_col - a_start_col)
				end
				if
					was_hidden_sequence = True
					or else sequence_points_count = 0
				then
					put_start_line (a_start_line)
					put_start_column (a_start_col)
				else
					put_signed_start_line (a_start_line - prev_non_hidden_start_line)
					put_signed_start_column (a_start_col - prev_non_hidden_start_column)
				end

				prev_non_hidden_start_line := a_start_line
				prev_non_hidden_start_column := a_start_col
				was_hidden_sequence := False
			end
			prev_il_offset := a_il_offset
			sequence_points_count := sequence_points_count + 1
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
