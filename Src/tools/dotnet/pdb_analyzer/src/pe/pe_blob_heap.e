note
	description: "Summary description for {PE_BLOB_HEAP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_BLOB_HEAP

inherit
	PE_HEAP

	PE_VISITABLE

create
	make

feature -- Initialization

	read (pe: PDB_FILE)
		local
			i,n: NATURAL_32
			str: PE_BLOB_ITEM
			ch: CHARACTER_8
			sz: NATURAL_32
			b: INTEGER
			n1,x,y,z, n8: NATURAL_8
			i_start_addr,
			nb: NATURAL_32
		do
			create items.make (100)
			create map.make (items.count)
			b := pe.position

			i_start_addr := pe.position.to_natural_32


			debug ("pe_analyze")
				io.error.put_string ("Read Blob Heap at 0x"+ i_start_addr.to_hex_string +"%N")
			end

			ch := pe.read_character_8 --Single Byte 0x0
			check ch = '%U' end
			create str.make (i_start_addr, b.to_natural_32, b.to_natural_32, create {MANAGED_POINTER}.make (0), "0")
			items.force (str)
			sz := sz + 1

			from
				i := 1
				n := size
			until
				sz >= size or pe.position - b > size.to_integer_32
			loop
				i_start_addr := pe.position.to_natural_32
				n1 := pe.read_natural_8
				if (n1 & 0b1000_0000) = 0 then
					nb := n1.to_natural_32
					sz := sz + 1
				elseif (n1 & 0b1100_0000) = 0b1000_0000 then
					x := pe.read_natural_8
					nb := ((n1 & 0b0011_1111).to_natural_32 |<< 8)
						+ x
					sz := sz + 2
				elseif (n1 & 0b1110_0000) = 0b1100_0000 then
					y := pe.read_natural_8
					z := pe.read_natural_8
					nb := 	(
								(
									((n1 & 0b0001_1111).to_natural_32 |<< 24)
									+ x
								) |<< 16
							) + y |<< 8
							+ z
					sz := sz + 3
				else
					check should_not_occurred: False end
				end
				str := pe.read_blob_item (i.out, nb.to_natural_32, i_start_addr)
				sz := sz + str.size --+ 1
				items.force (str)
				map[str.declaration_address - b.to_natural_32] := str
				i := i + 1
			end
		end

feature -- Access

	items: ARRAYED_LIST [PE_BLOB_ITEM]

	map: HASH_TABLE [PE_BLOB_ITEM, NATURAL_32]

	item_at_offset alias "[]" (i: NATURAL_32): detachable PE_BLOB_ITEM
		local
			str: PE_BLOB_ITEM
			prev: PE_BLOB_ITEM
			diff: NATURAL_32
		do
			Result := map [i] --items.i_th (i.to_integer_32)
			if Result = Void then
				across
					items as ic
				until
					Result /= Void
				loop
					str := ic.item
					if
						prev /= Void and then
						offset (prev) < i and then i < offset (str)
					then
						Result := prev
					end
					prev := str
				end
				if Result /= Void then
					diff := i - (Result.declaration_address - address)
					Result := Result.sub_item_at (diff, i.to_hex_string)
				end
			end
		end

--	item alias "[]" (i: NATURAL_32): PE_BLOB_ITEM
--		do
--			Result := items.i_th (i.to_integer_32)
--		end

	count: INTEGER
		do
			Result := items.count
		end

feature -- Visit

	accepts (v: PE_VISITOR)
		do
			v.visit_blob_heap (Current)
		end

end
