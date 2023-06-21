note
	description: "[
			Signature Blob heap item
			See II.32.2 Blobs and signatures
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_SIGNATURE_BLOB_ITEM

inherit
	PE_BLOB_ITEM
		redefine
			to_string
		end

create
--	make_from_item,
	make_type_from_item,
	make_method_from_item,
	make_field_from_item,
	make_locals_from_item,
	make_field_or_method_from_item,
	make_method_or_locals_from_item

convert
	dump: {READABLE_STRING_8, STRING_8}

feature {NONE} -- Initialization

	make_type_from_item (a_item: PE_BLOB_ITEM)
		do
			make_from_item (a_item)
			kind := type_kind
		end

	make_method_from_item (a_item: PE_BLOB_ITEM)
		do
			make_from_item (a_item)
			kind := method_kind
		end

	make_field_from_item (a_item: PE_BLOB_ITEM)
		do
			make_from_item (a_item)
			kind := field_kind
		end

	make_locals_from_item (a_item: PE_BLOB_ITEM)
		do
			make_from_item (a_item)
			kind := locals_kind
		end

	make_field_or_method_from_item (a_item: PE_BLOB_ITEM)
		do
			make_from_item (a_item)
			kind := field_or_method_kind
		end

	make_method_or_locals_from_item (a_item: PE_BLOB_ITEM)
		do
			make_from_item (a_item)
			kind := method_or_locals_kind
		end

	type_kind: NATURAL_8 = 1
	method_kind: NATURAL_8 = 2
	field_kind: NATURAL_8 = 3
	locals_kind: NATURAL_8 = 4
	field_or_method_kind: NATURAL_8 = 5
	method_or_locals_kind: NATURAL_8 = 6

	kind: NATURAL_8

feature -- Status report	

	is_type_signature: BOOLEAN
		do
			Result := kind = type_kind
		end

	is_method_signature: BOOLEAN
		do
			Result := kind = method_kind
		end

	is_field_signature: BOOLEAN
		do
			Result := kind = field_kind
		end

	is_field_or_method_signature: BOOLEAN
		do
			Result := kind = field_or_method_kind
		end

feature -- Conversion

	prefix_name: STRING_32
		do
			inspect kind
			when type_kind then
				Result := {STRING_32} "T-Sig"
			when method_kind then
				Result := {STRING_32} "M-Sig"
			when field_kind then
				Result := {STRING_32} "F-Sig"
			when locals_kind then
				Result := {STRING_32} "L-Sig"
			when field_or_method_kind then
				Result := {STRING_32} "FM-Sig"
			when method_or_locals_kind then
				Result := {STRING_32} "ML-Sig"
			else
				Result := {STRING_32} "Sig"
			end
		end

	to_string: STRING_32
		local
			tok: NATURAL_32
			offset: INTEGER
			k: NATURAL_8
		do
			if Result = Void then
				if is_type_signature then
					tok := uncompressed_type_token (uncompressed_data (pointer, 0, pointer.count))
				else
					k := pointer.read_natural_8_le (0)
					-- DEFAULT: 0x0
					-- VARARGS: 0x5
					-- FIELD (FieldSig): 0x6
					-- GENERIC: 0x10
					tok := uncompressed_type_token (uncompressed_data (pointer, 1, pointer.count - 1))
				end
				if tok & 0xff00_0000 = 0xFF00_0000 then
--					Result := {STRING_32} "!" + prefix_name + "<" + dump + ">"
					Result := {STRING_32} "<" + dump + ">"
				elseif tok = 0x0200_0000 then
					Result := "void"
				else
					Result := "0x" + tok.to_hex_string
				end
			end
		rescue
			Result := prefix_name + "!<" + dump + ">"
			retry
		end

	uncompressed_data (v: MANAGED_POINTER; pos: INTEGER; nb: INTEGER): INTEGER_32
		local
			i1, i2, i3, i4: NATURAL_32
			n32: NATURAL_32
		do
			i1 := v.read_natural_8 (pos + 0)
			if nb = 1 then
				n32 := i1
			else
				i2 := v.read_natural_8 (pos + 1)
				if nb = 2 then
					n32 := (i1 |<< 8)
							+ i2
							- 0x0000_8000
				elseif nb = 4 then
					i3 := v.read_natural_8 (pos + 2)
					i4 := v.read_natural_8 (pos + 3)

					n32 := (i1 |<< 24).to_natural_32
							+ (i2 |<< 16).to_natural_32
							+ (i3 |<< 8).to_natural_32
							+ (i4).to_natural_32
							- 0xC000_0000
				end
			end
			Result := n32.to_integer_32
		ensure
			class
		end

	uncompressed_type_token (v: INTEGER): NATURAL_32
		local
			enc: INTEGER
			val: NATURAL_32
			tag: NATURAL_32
		do
			enc := (v & 0x0000_0003)
			val := (v |>> 2).to_natural_32
			inspect
				enc
			when 0 then
					-- TypeDef Token
				tag := {PE_TABLES}.ttypedef
			when 1 then
					-- Typeref Token
				tag := {PE_TABLES}.ttyperef
			when 2 then
					-- TypeSpec Token
				tag := {PE_TABLES}.ttypespec
			else
--				check known: False end
				tag := 0xFF -- {PE_TABLES}.ttypedef
			end
			if tag = 0xFF then
				Result := 0xFF00_1111
			else
				Result := ((tag |<< 24) | val)
			end
		ensure
			class
		end

end
