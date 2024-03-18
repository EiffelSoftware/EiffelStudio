note
	description: "Summary description for {PDB_SEQUENCE_POINTS_BLOB_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PDB_SEQUENCE_POINTS_BLOB_ITEM

inherit
	PE_BLOB_ITEM
		redefine
			to_string
		end

create
	make_from_item

convert
	dump: {READABLE_STRING_8, STRING_8}

feature -- Additional access

	associated_pdb_file: detachable PDB_FILE

	set_associated_pdb_file (pe: like associated_pdb_file)
		do
			associated_pdb_file := pe
		end

	associated_table_entry: detachable PDB_MD_TABLE_ENTRY

	set_associated_table_entry (e: like associated_table_entry)
		do
			associated_table_entry := e
		end

feature -- Conversion

	to_sequence_points (pdb: PDB_FILE; e: PDB_MD_TABLE_METHOD_DEBUG_INFORMATION_ENTRY): detachable TUPLE [local_token: NATURAL_32; points: ARRAYED_LIST [MD_SEQUENCE_POINT]; has_error: BOOLEAN]
		local
			offset: INTEGER
			k: INTEGER_8
			l_reader: PE_MD_SEQUENCE_POINTS_READER

			l_il_offset: NATURAL_32
			l_delta_start_lines,
			l_delta_start_cols: INTEGER_32

			l_start_line, l_start_col,
			l_end_line, l_end_col: NATURAL_32
			l_local_token: NATURAL_32
			l_is_first: BOOLEAN
			l_prev_non_hidden_start_line,
			l_prev_non_hidden_start_col: NATURAL_32
			l_prev_offset: NATURAL_32
			pt: MD_SEQUENCE_POINT
			points: ARRAYED_LIST [MD_SEQUENCE_POINT]
		do
			create l_reader.make (pointer, pdb, e)
			create points.make (1)
			l_local_token := l_reader.uncompressed_value.to_natural_32
--				Result.append (" LocalSignature=" + n32.to_hex_string)
--				if
--					not attached e.document_row_id as d
--					or else d.is_null_index
--				then
--					n32 := l_reader.uncompressed_value.to_natural_32
--					if n32 /= 0 then
--						Result.append (" InitialDocument=" + n32.to_hex_string)
--					end
--				end

			l_is_first := True
			from
			until
				l_reader.exhausted
			loop
				l_il_offset := l_prev_offset + l_reader.uncompressed_value.to_natural_32
				l_delta_start_lines := l_reader.uncompressed_value
				l_delta_start_cols := l_reader.uncompressed_value
				if l_delta_start_lines = 0 and l_delta_start_cols = 0 then
--							hidden-sequence-point-record
					l_start_line := 0x00FE_EFEE
					l_end_line := 0x00FE_EFEE
				else
--							sequence-point-record
					if l_is_first then
						l_is_first := False
						l_start_line := l_reader.uncompressed_value.to_natural_32
						l_start_col := l_reader.uncompressed_value.to_natural_32
					else
						l_start_line := (l_prev_non_hidden_start_line.to_integer_32 + l_reader.uncompressed_signed_value).to_natural_32
						l_start_col := (l_prev_non_hidden_start_col.to_integer_32 + l_reader.uncompressed_signed_value).to_natural_32
					end
					l_end_line := (l_start_line.to_integer_32 + l_delta_start_lines).to_natural_32
					l_end_col := (l_start_col.to_integer_32 + l_delta_start_cols).to_natural_32

					l_prev_non_hidden_start_line := l_start_line
					l_prev_non_hidden_start_col := l_start_col
				end
				create pt.make (l_il_offset.to_natural_32, l_start_line, l_start_col, l_end_line, l_end_col)
				points.force (pt)
				l_prev_offset := l_il_offset
			end
			Result := [l_local_token, points, False]
		rescue
			if points = Void then
				create points.make (0)
			end
			Result := [l_local_token, points, True]
		end

	to_string_using_method_debug_information_entry (e: PDB_MD_TABLE_METHOD_DEBUG_INFORMATION_ENTRY): STRING_32
		local
			offset: INTEGER
			k: INTEGER_8
			l_reader: PE_MD_SEQUENCE_POINTS_READER

			l_il_offset: NATURAL_32
			l_delta_start_lines,
			l_delta_start_cols: INTEGER_32

			l_start_line, l_start_col,
			l_end_line, l_end_col: NATURAL_32
			n32: NATURAL_32
			l_is_first: BOOLEAN
			l_prev_non_hidden_start_line,
			l_prev_non_hidden_start_col: NATURAL_32
			l_prev_offset: NATURAL_32
		do
			if Result = Void then
				create l_reader.make (pointer, associated_pdb_file, e)
				create Result.make_empty
				n32 := l_reader.uncompressed_value.to_natural_32
				Result.append (" LocalSignature=" + n32.to_hex_string)
				if
					not attached e.document_row_id as d
					or else d.is_null_index
				then
					n32 := l_reader.uncompressed_value.to_natural_32
					if n32 /= 0 then
						Result.append (" InitialDocument=" + n32.to_hex_string)
					end
				end

				l_is_first := True
				from
				until
					l_reader.exhausted
				loop
					l_il_offset := l_prev_offset + l_reader.uncompressed_value.to_natural_32
					l_delta_start_lines := l_reader.uncompressed_value
					l_delta_start_cols := l_reader.uncompressed_value
					if l_delta_start_lines = 0 and l_delta_start_cols = 0 then
--							hidden-sequence-point-record
						Result.append (" (#" + l_il_offset.to_natural_32.out)
						Result.append (" hidden)")
					else
--							sequence-point-record
						Result.append (" (#")
						Result.append (l_il_offset.to_natural_32.out)
						if l_is_first then
							l_is_first := False
							l_start_line := l_reader.uncompressed_value.to_natural_32
							l_start_col := l_reader.uncompressed_value.to_natural_32
						else
							l_start_line := (l_prev_non_hidden_start_line.to_integer_32 + l_reader.uncompressed_signed_value).to_natural_32
							l_start_col := (l_prev_non_hidden_start_col.to_integer_32 + l_reader.uncompressed_signed_value).to_natural_32
						end
						l_end_line := (l_start_line.to_integer_32 + l_delta_start_lines).to_natural_32
						l_end_col := (l_start_col.to_integer_32 + l_delta_start_cols).to_natural_32
						Result.append (" ")
						Result.append (l_start_line.out + ";" + l_start_col.out)
						Result.append ("->")
						Result.append (l_end_line.out + ";" + l_end_col.out)
						Result.append (")")
						l_prev_non_hidden_start_line := l_start_line
						l_prev_non_hidden_start_col := l_start_col
					end
					l_prev_offset := l_il_offset
				end
			end
			if Result [1] = ' ' then
				Result.remove_head (1)
			end
		rescue
			Result := "!<<" + dump + ">>"
			if attached {EXCEPTION_MANAGER}.last_exception as err then
				Result.append_string (err.tag)
				if attached err.message as mesg then
					Result.append_string (" %"")
					Result.append_string (mesg)
					Result.append_string ("%"")
				end
			end
			retry
		end

	to_string: STRING_32
		local
			l_reader: PE_MD_SEQUENCE_POINTS_READER
		do
			if Result = Void then
				create l_reader.make (pointer, associated_pdb_file, associated_table_entry)
				Result := {STRING_32} " <<" + l_reader.dump + ">>"
			end
			if Result [1] = ' ' then
				Result.remove_head (1)
			end
		rescue
			Result := "!<<" + dump + ">>"
			retry
		end

end

