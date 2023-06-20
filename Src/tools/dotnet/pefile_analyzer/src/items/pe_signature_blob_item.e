note
	description: "[
			Signature Blob heap item
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_SIGNATURE_BLOB_ITEM

inherit
	PE_BLOB_ITEM
		redefine
			to_string,
			make_from_item
		end

create
	make,
	make_from_item

convert
	dump: {READABLE_STRING_8, STRING_8}

feature {NONE} -- Initialization	

	make_from_item (a_item: PE_ITEM)
		do
			Precursor (a_item)
		end

feature -- Conversion

	to_string: STRING_32
		local
			tok: NATURAL_32
		do
--			tok := uncompressed_token (uncompressed_data (pointer))
			Result := {STRING_32} "Sig<" + dump.to_string_32 + ">"
		end

--	uncompressed_data (v: like pointer): INTEGER
--		local
--			i1, i2, i3, i4: INTEGER_32
--		do
--			i1 := v.read_integer_8 (0).to_integer_32
--			if v.count = 1 then
--				Result := i1
--			else
--				i2 := v.read_integer_8 (1).to_integer_32
--				if v.count = 2 then
--					Result := (i1 |<< 8)
--							+ i2
--							- 0x0000_8000
--				elseif v.count = 4 then
--					i3 := v.read_integer_8 (2).to_integer_32
--					i4 := v.read_integer_8 (3).to_integer_32

--					Result := (i1 |<< 24)
--							+ (i2 |<< 16)
--							+ (i3 |<< 8)
--							+ (i4)
--							- 0xC000_0000
--				end
--			end
--		end

--	uncompressed_token (v: INTEGER): NATURAL_32
--		local
--			enc: INTEGER
--			val: NATURAL_32
--			tag: NATURAL_32
--		do
--			enc := (v & 0x0000_00FF)
--			val := (v |>> 2).to_natural_32
--			inspect
--				enc
--			when 0 then
--					-- TypeDef Token
--				tag := {PE_TABLES}.ttypedef
--			when 1 then
--					-- Typeref Token
--				tag := {PE_TABLES}.ttyperef
--			when 2 then
--					-- TypeSpec Token
--				tag := {PE_TABLES}.ttypespec
--			else
--				check known: False end
--				tag := {PE_TABLES}.ttypedef
--			end
--			Result := (tag |<< 6) + val
--		end

end
