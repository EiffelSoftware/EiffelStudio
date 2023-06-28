note
	description: "Summary description for {MD_TABLE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_MD_TABLE [G -> PE_MD_TABLE_ENTRY]

inherit
	PE_VISITABLE

feature {NONE} -- Initialization

	make (a_tables: PE_MD_TABLES; pe: PE_FILE; tb_id: like table_id; nb: NATURAL_32)
		do
			tables := a_tables
			table_id := tb_id
			count := nb.to_integer_32
			create entries.make (count)
			read (pe)
		end

feature -- Access

	address: NATURAL_32

	size: NATURAL_32

	tables: PE_MD_TABLES

	entries: ARRAYED_LIST [G]

	entries_count: INTEGER
		do
			Result := entries.count
		end

	entry_list (idx: PE_INDEX_ITEM; nb: NATURAL_32): LIST [G]
		local
			i, n: NATURAL_32
		do
			create {ARRAYED_LIST [G]} Result.make (nb.to_integer_32)
			from
				n := nb
				i := idx.index
			until
				n = 0
			loop
				if valid_index (i) and then attached entry (i) as item then
					Result.force (item)
				end
				i := i + 1
				n := n - 1
			end
		ensure
			Result.count = nb.to_integer_32
		end

	count: INTEGER

	table_id: NATURAL_8

	is_error: BOOLEAN
			-- False by default
		do
			Result := False
		end

	first: detachable G
		do
			if not entries.is_empty then
				Result := entries.first
			end
		end

feature -- Read

	read (pe: PE_FILE)
		local
			i, n: INTEGER
			tok: NATURAL_32
		do
			address := pe.position.to_natural_32

			debug ("pe_analyze")
				io.error.put_string ("Read table " + {PE_MD_TABLES}.table_name (table_id) + "  " + table_id.to_hex_string + " (" + count.out + ") at 0x"+ address.to_hex_string +"%N")
			end

			entries.wipe_out
			from
				i := 1
				n := count
			until
				i > n
			loop
				if attached read_entry (pe) as e then
					debug ("pe_analyze")
						io.error.put_string_32 ({STRING_32} "  + " + e.to_string + "%N")
					end

					entries.force (e)
					tok := (table_id.to_natural_32 |<< 24) | i.to_natural_32
					e.set_token (tok)
				else
					check is_error end
				end
				i := i + 1
			end
		end

feature -- Access

	read_entry (pe: PE_FILE): like entry
		deferred
		end

	entry alias "[]" (idx: NATURAL_32): detachable G
		require
			valid_index (idx)
		do
			Result := entries.i_th (idx.to_integer_32)
		end

	valid_index (idx: NATURAL_32): BOOLEAN
		do
			Result := entries.valid_index (idx.to_integer_32)
		end

feature -- Visit

	accepts (v: PE_VISITOR)
		do
			v.visit_table (Current)
		end

end
