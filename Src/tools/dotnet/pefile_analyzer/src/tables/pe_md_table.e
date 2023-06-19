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

	tables: PE_MD_TABLES

	entries: ARRAYED_LIST [G]

	count: INTEGER

	table_id: NATURAL_32

	is_error: BOOLEAN
			-- False by default
		do
			Result := False
		end

feature -- Read

	read (pe: PE_FILE)
		local
			i, n: INTEGER
		do
			address := pe.position.to_natural_32
			
			entries.wipe_out
			from
				i := 1
				n := count
			until
				i > n
			loop
				if attached read_entry (pe) as e then
					entries.force (e)
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
