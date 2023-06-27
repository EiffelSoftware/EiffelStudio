class
	PE_SIGNATURE_BLOB_INDEX

inherit
	PE_BLOB_INDEX
		redefine
			read
		end

create
	make_type_specification,
	make_method,
	make_field,
	make_field_or_method,
	make_method_or_locals,
	make_locals,
	make_property,
	make_custom_attribute_value

feature {NONE} -- Initialization

	make_type_specification (lab: like label)
		do
			make (lab)
			kind := type_specification_kind
		end

	make_method (lab: like label)
		do
			make (lab)
			kind := method_kind
		end

	make_field (lab: like label)
		do
			make (lab)
			kind := field_kind
		end

	make_field_or_method (lab: like label)
		do
			make (lab)
			kind := field_or_method_kind
		end

	make_method_or_locals (lab: like label)
		do
			make (lab)
			kind := method_or_locals_kind
		end

	make_locals (lab: like label)
		do
			make (lab)
			kind := locals_kind
		end

	make_property (lab: like label)
		do
			make (lab)
			kind := property_kind
		end

	make_custom_attribute_value (lab: like label)
		do
			make (lab)
			kind := custom_attribute_value_kind
		end

	kind: NATURAL_8

feature -- Constant

	type_specification_kind: NATURAL_8 = 1
	method_kind: NATURAL_8 = 2
	field_kind: NATURAL_8 = 3
	locals_kind: NATURAL_8 = 4
	method_or_locals_kind: NATURAL_8 = 5
	field_or_method_kind: NATURAL_8 = 6
	property_kind: NATURAL_8 = 7
	custom_attribute_value_kind: NATURAL_8 = 8

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

	is_locals_signature: BOOLEAN
		do
			Result := kind = locals_kind
		end

	is_field_or_method_signature: BOOLEAN
		do
			Result := kind = field_or_method_kind
		end

	is_method_or_locals_signature: BOOLEAN
		do
			Result := kind = method_or_locals_kind
		end

	is_custom_attribute_value_signature: BOOLEAN
		do
			Result := kind = custom_attribute_value_kind
		end

feature -- Read

	read (pe: PE_FILE): PE_BLOB_INDEX_ITEM
		do
			Result := pe.read_blob_index (label)
		end

end
