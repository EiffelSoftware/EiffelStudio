note
	description: "Summary description for {PE_FIELD_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FIELD_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flags: INTEGER; a_name_index: NATURAL; a_signature_index: NATURAL)
		do
			flags := a_flags
			create name_index.make_with_index (a_name_index)
			create singature_index.make_with_index (a_signature_index)
		end

feature -- Access

	flags: INTEGER

	name_index: PE_STRING

	singature_index: PE_BLOB

feature -- Enum: Flags

	FieldAccessMask: INTEGER = 0x0007

	PrivateScope: INTEGER = 0x0000
	Private: INTEGER = 0x0001
	FamANDAssem: INTEGER = 0x0002
	Assembly: INTEGER = 0x0003
	Family: INTEGER = 0x0004
	FamORAssem: INTEGER = 0x0005
	Public: INTEGER = 0x0006

		-- other attribs
	Static: INTEGER = 0x0010
	InitOnly: INTEGER = 0x0020
	Literal: INTEGER = 0x0040
	NotSerialized: INTEGER = 0x0080
	SpecialName: INTEGER = 0x0200

		-- pinvoke
	PinvokeImpl: INTEGER = 0x2000

		-- runtime
	ReservedMask: INTEGER = 0x9500
	RTSpecialName: INTEGER = 0x0400
	HasFieldMarshal: INTEGER = 0x1000
	HasDefault: INTEGER = 0x8000
	HasFieldRVA: INTEGER = 0x0100

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tfield.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement  ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end


end
