indexing
	description: "All possible types of metadata token"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TOKEN_TYPES

feature -- Access

	module: INTEGER is 0x00000000
	type_ref: INTEGER is 0x01000000
	type_def: INTEGER is 0x02000000
	field_def: INTEGER is 0x04000000
	method_def: INTEGER is 0x06000000
	param_def: INTEGER is 0x08000000
	interface_impl: INTEGER is 0x09000000
	member_ref: INTEGER is 0x0a000000
	custom_attribute: INTEGER is 0x0c000000
	permission: INTEGER is 0x0e000000
	signature: INTEGER is 0x11000000
	event: INTEGER is 0x14000000
	property: INTEGER is 0x17000000
	module_ref: INTEGER is 0x1a000000
	type_spec: INTEGER is 0x1b000000
	assembly: INTEGER is 0x20000000
	assembly_ref: INTEGER is 0x23000000
	file: INTEGER is 0x26000000
	exported_type: INTEGER is 0x27000000
	manifest_resource: INTEGER is 0x28000000
	string: INTEGER is 0x70000000
	name: INTEGER is 0x71000000
			-- All possible types of tokens.

	base_type: INTEGER is 0x72000000
			--  Leave this on the high end value. This does not correspond to metadata table
	
end -- class MD_TOKEN_TYPES
