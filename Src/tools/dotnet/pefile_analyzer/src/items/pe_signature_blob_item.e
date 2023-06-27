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
	make_type_specification_from_item,
	make_method_from_item,
	make_field_from_item,
	make_property_from_item,
	make_locals_from_item,
	make_field_or_method_from_item,
	make_method_or_locals_from_item

convert
	dump: {READABLE_STRING_8, STRING_8}

feature {NONE} -- Initialization

	make_type_specification_from_item (a_item: PE_BLOB_ITEM)
		do
			make_from_item (a_item)
			kind := type_specification_kind
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

	make_property_from_item (a_item: PE_BLOB_ITEM)
		do
			make_from_item (a_item)
			kind := property_kind
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

	type_specification_kind: NATURAL_8 = 1
	method_kind: NATURAL_8 = 2
	field_kind: NATURAL_8 = 3
	locals_kind: NATURAL_8 = 4
	field_or_method_kind: NATURAL_8 = 5
	method_or_locals_kind: NATURAL_8 = 6
	property_kind: NATURAL_8 = 7

	kind: NATURAL_8

feature -- Status report	

	is_type_specification_signature: BOOLEAN
		do
			Result := kind = type_specification_kind
		end

	is_method_signature: BOOLEAN
		do
			Result := kind = method_kind
		end

	is_field_signature: BOOLEAN
		do
			Result := kind = field_kind
		end

	is_property_signature: BOOLEAN
		do
			Result := kind = property_kind
		end

	is_field_or_method_signature: BOOLEAN
		do
			Result := kind = field_or_method_kind
		end

feature -- Conversion

	prefix_name: STRING_32
		do
			inspect kind
			when type_specification_kind then
				Result := {STRING_32} "T-Sig"
			when method_kind then
				Result := {STRING_32} "M-Sig"
			when field_kind then
				Result := {STRING_32} "F-Sig"
			when property_kind then
				Result := {STRING_32} "P-Sig"
			when locals_kind then
				Result := {STRING_32} "L-Sig"
			when field_or_method_kind then
				Result := {STRING_32} "FM-Sig"
			when method_or_locals_kind then
				Result := {STRING_32} "ML-Sig"
			else
				Result := {STRING_32} "<"+ kind.out +">Sig"
			end
		end

	to_string: STRING_32
		local
			tok: NATURAL_32
			offset: INTEGER
			k: INTEGER_8
			l_reader: PE_MD_SIGNATURE_READER
		do
			if Result = Void then
				create l_reader.make (pointer)
				Result := {STRING_32} " <<" + dump + ">>"

				inspect kind
				when type_specification_kind then
					Result := l_reader.typespecsig + " " + Result
				when method_kind then
					Result := l_reader.methoddefsig + " " + Result
				when field_or_method_kind, method_or_locals_kind then
					if
						attached l_reader.decoded_value as dv
					then
						Result := dv + Result
					else
						l_reader.reset_position
						Result := l_reader.methoddefsig + " " + Result
					end
				else
					if attached l_reader.decoded_value as dv then
						Result := dv + Result
					else
						Result := {STRING_32} "ERROR:NotFullyImplemented("+ prefix_name +") "
								+ Result
					end
				end
			end
			if Result [1] = ' ' then
				Result.remove_head (1)
			end
		rescue
			Result := prefix_name + "!<<" + dump + ">>"
			retry
		end

end
