note
	description: "Summary description for {PE_TYPEDEF_TABLE_ENTRY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TYPEDEF_TABLE_ENTRY

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

	make_with_data (a_flags: INTEGER; a_type_name_index: NATURAL; a_type_name_space_index: NATURAL;
					a_extends: PE_TYPEDEF_OR_REF; a_field_index: NATURAL; a_method_index: NATURAL)
		do
			flags := a_flags
			create type_name_index.make_with_index (a_type_name_index)
			create type_name_space_index.make_with_index (a_type_name_space_index)
			extends := a_extends
			create fields.make_with_index (a_field_index)
			create methods.make_with_index (a_method_index)
		end


feature -- Access

	flags: INTEGER

	type_name_index: PE_STRING

	type_name_space_index: PE_STRING

	extends: PE_TYPEDEF_OR_REF

	fields: PE_FIELD_LIST

	methods: PE_METHOD_LIST

feature -- Enum: Flags

		-- Visibility

	VisibilityMask: INTEGER = 0x00000007

	NotPublic: INTEGER = 0x00000000
	Public: INTEGER = 0x00000001

	NestedPublic: INTEGER = 0x00000002
	NestedPrivate: INTEGER = 0x00000003
	NestedFamily: INTEGER = 0x00000004
	NestedAssembly: INTEGER = 0x00000005
	NestedFamANDAssem: INTEGER = 0x00000006
	NestedFamORAssem: INTEGER = 0x00000007

		-- layout

	LayoutMask: INTEGER = 0x00000018

	AutoLayout: INTEGER = 0x00000000
	SequentialLayout: INTEGER = 0x00000008
	ExplicitLayout: INTEGER = 0x00000010

		-- semantics

	ClassSemanticsMask: INTEGER = 0x00000060

	Class_: INTEGER = 0x00000000
	Interface: INTEGER = 0x00000020

		-- other attributes

	Abstract: INTEGER = 0x00000080
	Sealed: INTEGER = 0x00000100
	SpecialName: INTEGER = 0x00000400
	Import: INTEGER = 0x00001000
	Serializable: INTEGER = 0x00002000

		-- string format

	StringFormatMask: INTEGER = 0x00030000

	AnsiClass: INTEGER = 0x00000000
	UnicodeClass: INTEGER = 0x00010000
	AutoClass: INTEGER = 0x00020000
	CustomFormatClass: INTEGER = 0x00030000

		-- valid for custom format class but undefined

	CustomFormatMask: INTEGER = 0x00C00000

	BeforeFieldInit: INTEGER = 0x00100000
	Forwarder: INTEGER = 0x00200000

		-- runtime
	ReservedMask: INTEGER = 0x00040800
	RTSpecialName: INTEGER = 0x00000800

	HasSecurity: INTEGER = 0x00040000

feature -- Operations


	table_index: INTEGER
		do
			Result := {PE_TABLES}.ttypedef.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		do
			to_implement  ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		do
			to_implement ("Add implementation")
		end

end
