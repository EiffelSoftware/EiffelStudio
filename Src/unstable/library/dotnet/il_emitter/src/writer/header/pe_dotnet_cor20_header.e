note
	description: "CLI HEADER"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_DOTNET_COR20_HEADER

inherit

	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create metadata.make_filled (0, 1, 2)
			create resources.make_filled (0, 1, 2)
			create strong_name_signature.make_filled (0, 1, 2)
			create code_manager_table.make_filled (0, 1, 2)
			create vtable_fixup.make_filled (0, 1, 2)
			create export_address_table_jumps.make_filled (0, 1, 2)
			create managed_native_header.make_filled (0, 1, 2)
		end


feature -- Access

	cb: NATURAL assign set_cb
			-- `cb'

	major_runtime_version: NATURAL_16 assign set_major_runtime_version
			-- `major_runtime_version'

	minor_runtime_version: NATURAL_16 assign set_minor_runtime_version
			-- `minor_runtime_version'

	metadata: ARRAY [NATURAL] assign set_metadata
			-- `metadata'

	flags: NATURAL assign set_flags
			-- `flags'

	entry_point_token: NATURAL assign set_entry_point_token
			-- `entry_point_token'

	resources: ARRAY [NATURAL] assign set_resources
			-- `resources'

	strong_name_signature: ARRAY [NATURAL] assign set_strong_name_signature
			-- `strong_name_signature'

	code_manager_table: ARRAY [NATURAL] assign set_code_manager_table
			-- `code_manager_table'

	VTable_fixup: ARRAY [NATURAL] assign set_VTable_fixup
			-- `VTable_fixup'

	export_address_table_jumps: ARRAY [NATURAL] assign set_export_address_table_jumps
			-- `export_address_table_jumps'

	managed_native_header: ARRAY [NATURAL] assign set_managed_native_header
			-- `managed_native_header'

feature -- Element change

	set_cb (a_cb: like cb)
			-- Assign `cb' with `a_cb'.
		do
			cb := a_cb
		ensure
			cb_assigned: cb = a_cb
		end

	set_major_runtime_version (a_major_runtime_version: like major_runtime_version)
			-- Assign `major_runtime_version' with `a_major_runtime_version'.
		do
			major_runtime_version := a_major_runtime_version
		ensure
			major_runtime_version_assigned: major_runtime_version = a_major_runtime_version
		end

	set_minor_runtime_version (a_minor_runtime_version: like minor_runtime_version)
			-- Assign `minor_runtime_version' with `a_minor_runtime_version'.
		do
			minor_runtime_version := a_minor_runtime_version
		ensure
			minor_runtime_version_assigned: minor_runtime_version = a_minor_runtime_version
		end

	set_metadata (a_metadata: like metadata)
			-- Assign `metadata' with `a_metadata'.
		do
			metadata := a_metadata
		ensure
			metadata_assigned: metadata = a_metadata
		end

	set_flags (a_flags: like flags)
			-- Assign `flags' with `a_flags'.
		do
			flags := a_flags
		ensure
			flags_assigned: flags = a_flags
		end

	set_entry_point_token (an_entry_point_token: like entry_point_token)
			-- Assign `entry_point_token' with `an_entry_point_token'.
		do
			entry_point_token := an_entry_point_token
		ensure
			entry_point_token_assigned: entry_point_token = an_entry_point_token
		end

	set_resources (a_resources: like resources)
			-- Assign `resources' with `a_resources'.
		do
			resources := a_resources
		ensure
			resources_assigned: resources = a_resources
		end

	set_strong_name_signature (a_strong_name_signature: like strong_name_signature)
			-- Assign `strong_name_signature' with `a_strong_name_signature'.
		do
			strong_name_signature := a_strong_name_signature
		ensure
			strong_name_signature_assigned: strong_name_signature = a_strong_name_signature
		end

	set_code_manager_table (a_code_manager_table: like code_manager_table)
			-- Assign `code_manager_table' with `a_code_manager_table'.
		do
			code_manager_table := a_code_manager_table
		ensure
			code_manager_table_assigned: code_manager_table = a_code_manager_table
		end

	set_VTable_fixup (a_VTable_fixup: like VTable_fixup)
			-- Assign `VTable_fixup' with `a_VTable_fixup'.
		do
			VTable_fixup := a_VTable_fixup
		ensure
			VTable_fixup_assigned: VTable_fixup = a_VTable_fixup
		end

	set_export_address_table_jumps (an_export_address_table_jumps: like export_address_table_jumps)
			-- Assign `export_address_table_jumps' with `an_export_address_table_jumps'.
		do
			export_address_table_jumps := an_export_address_table_jumps
		ensure
			export_address_table_jumps_assigned: export_address_table_jumps = an_export_address_table_jumps
		end

	set_managed_native_header (a_managed_native_header: like managed_native_header)
			-- Assign `managed_native_header' with `a_managed_native_header'.
		do
			managed_native_header := a_managed_native_header
		ensure
			managed_native_header_assigned: managed_native_header = a_managed_native_header
		end

feature -- Measurement

	size_of: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_DOTNET_COR20_HEADER
		do
			create l_obj
			create l_internal
			n := l_internal.field_count (l_obj)
			across 1 |..| n as ic loop
				if attached l_internal.field (ic, l_obj) as l_field then
					if attached {NATURAL_16} l_field then
						Result := Result + {PLATFORM}.natural_16_bytes
					elseif attached {NATURAL_32} l_field then
						Result := Result + {PLATFORM}.natural_32_bytes
					elseif attached {ARRAY [NATURAL]} l_field as l_arr then
						Result := Result + (l_arr.count * {PLATFORM}.natural_32_bytes)
					end
				end
			end
		ensure
			instance_free: class
		end


invariant
	valid_metadata_capacity: metadata.capacity = 2
	valid_resources_capacity: resources.capacity = 2
	valid_strong_name_signature_capacity: strong_name_signature.capacity = 2
	valid_code_manager_table_capacity: code_manager_table.capacity = 2
	valid_vtable_fixup_capacity: vtable_fixup.capacity = 2
	valid_export_address_table_jumps_capacity: export_address_table_jumps.capacity = 2
	valid_managed_native_header_capacity: managed_native_header.capacity = 2
end
