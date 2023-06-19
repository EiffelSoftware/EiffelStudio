note
	description: "Summary description for {PE_USER_STRING_HEAP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_USER_STRING_HEAP

inherit
	PE_HEAP

	PE_VISITABLE

create
	make

feature -- Initialization

	read (pe: PE_FILE)
		local
			i,n: NATURAL_32
			str: PE_UTF_16_STRING_ITEM
			ch: CHARACTER_8
			sz: NATURAL_32
			b: INTEGER
			n1,x,y,z, n8: NATURAL_8
			i_start_addr,
			nb: NATURAL_32
		do
			create items.make (100)
			b := pe.position

			i_start_addr := pe.position.to_natural_32
			ch := pe.read_character_8 --Single Byte 0x0
			check ch = '%U' end
			create str.make (i_start_addr, b.to_natural_32, b.to_natural_32, create {MANAGED_POINTER}.make (0), 0, "0")
--			str := pe.read_utf_16_string_item (i.out, 1)
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
				if n1 = 0 then
					create str.make (i_start_addr, i_start_addr, i_start_addr, create {MANAGED_POINTER}.make (0), 0, i.out)
					sz := sz + 1
				else
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
					if nb = 0 then
						create str.make (i_start_addr, pe.position.to_natural_32, pe.position.to_natural_32, create {MANAGED_POINTER}.make (0), 0, i.out)
						sz := sz + 1
					else
						if nb = 1 then
							create str.make (i_start_addr, pe.position.to_natural_32, pe.position.to_natural_32, create {MANAGED_POINTER}.make (0), 0, i.out)
						else
							str := pe.read_utf_16_string_item (i.out, nb.to_natural_32 - 1, i_start_addr)
						end
						n8 := pe.read_natural_8  -- Final 0, or 1
						check n8 = 0 or n8 = 1 end
						sz := sz + str.size + 1
					end
				end

				items.force (str)
				i := i + 1
			end
		end

feature -- Access

	items: ARRAYED_LIST [PE_UTF_16_STRING_ITEM]

	item alias "[]" (i: NATURAL_32): PE_UTF_16_STRING_ITEM
		require
			valid_index (i)
		do
			Result := items.i_th (i.to_integer_32)
		end

	count: INTEGER
		do
			Result := items.count
		end

	valid_index (i: NATURAL_32): BOOLEAN
		do
			Result := items.valid_index (i.to_integer_32)
		end

feature -- Visit

	accepts (v: PE_VISITOR)
		do
			v.visit_user_string_heap (Current)
		end

end
