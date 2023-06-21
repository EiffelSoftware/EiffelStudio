note
	description: "Summary description for {PE_STRING_HEAP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_STRING_HEAP

inherit
	PE_HEAP

	PE_VISITABLE

create
	make

feature -- Initialization

	read (pe: PE_FILE)
		local
			i,n: NATURAL_32
			str: PE_STRING_ITEM
			ch: CHARACTER_8
			sz: NATURAL_32
			i_decl_addr: NATURAL_32
			b: INTEGER
			mp: MANAGED_POINTER
		do
			create items.make (100)
			create map.make (items.count)
			b := pe.position

			sz := 0

			i_decl_addr := pe.position.to_natural_32
				-- The first entry is always the empty string '%U'
			ch := pe.read_character_8
			check ch = '%U' end
			create str.make (i_decl_addr, i_decl_addr, i_decl_addr, create {MANAGED_POINTER}.make (0), "0")
			check str.size = 0 end
			items.force (str)
			sz := sz + 1

			from
				i := 2 -- First empty string is already read.
				n := size
			until
				sz >= size or pe.position - b > size.to_integer_32
			loop
				str := pe.read_null_ended_string_item (i.out)
				ch := pe.read_character_8
				sz := sz + str.size + 1

				if sz < size then
					if str.is_empty then
						mp := pe.read_bytes ((b + size.to_integer_32 - pe.position).to_natural_32)
						sz := sz + mp.count.to_natural_32
						if has_only_null_characters (mp) then
								-- Expected bytes alignment to 4
						else
							-- ERROR
							items.force (str)
							map[str.declaration_address - b.to_natural_32] := str
							str.report_error (create {PE_USER_ERROR}.make ("Unexpected empty string"))
							check unexpected_empty_string: False end
						end
					else
						items.force (str)
						map[str.declaration_address - b.to_natural_32] := str
					end
				else
					check str.is_empty end
				end
				i := i + 1
			end
		end

	has_only_null_characters (mp: MANAGED_POINTER): BOOLEAN
		local
			i,n : INTEGER
		do
			Result := True
			from
				i := 0
				n := mp.count
			until
				i >= n or not Result
			loop
				if
					mp.read_natural_8 (i) /= {NATURAL_8} 0
				then
					Result := False
				end
				i := i + 1
			end
		end

feature -- Access

	items: ARRAYED_LIST [PE_STRING_ITEM]

	map: HASH_TABLE [PE_STRING_ITEM, NATURAL_32]

	item_at_offset alias "[]" (i: NATURAL_32): detachable PE_STRING_ITEM
		local
			str: PE_STRING_ITEM
			prev: PE_STRING_ITEM
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

	count: INTEGER
		do
			Result := items.count
		end

--	valid_index (i: NATURAL_32): BOOLEAN
--		do
--			Result := map.has (i) -- items.valid_index (i.to_integer_32)
--		end

feature -- Visit

	accepts (v: PE_VISITOR)
		do
			v.visit_string_heap (Current)
		end

end
