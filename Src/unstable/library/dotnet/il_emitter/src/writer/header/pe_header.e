note
	description: "Summary description for {PE_HEADER}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_HEADER

feature -- Access

	signature: INTEGER assign set_signature
			-- `signature'

	cpu_type: INTEGER_16 assign set_cpu_type
			-- `cpu_type'

	num_objects: INTEGER_16 assign set_num_objects
			-- `num_objects'

	time: INTEGER assign set_time
			-- `time'

	symbol_ptr: INTEGER assign set_symbol_ptr
			-- `symbol_ptr'

	num_symbols: INTEGER assign set_num_symbols
			-- `num_symbols'

	nt_hdr_size: INTEGER_16 assign set_nt_hdr_size
			-- `nt_hdr_size'

	flags: INTEGER_16 assign set_flags
			-- `flags'

	magic: INTEGER_16 assign set_magic
			-- `magic'

	linker_major_version: NATURAL_8 assign set_linker_major_version
			-- `linker_major_version'

	linker_minor_version: NATURAL_8 assign set_linker_minor_version
			-- `linker_minor_version'

	code_size: INTEGER assign set_code_size
			-- `code_size'

	data_size: INTEGER assign set_data_size
			-- `data_size'

	bss_size: INTEGER assign set_bss_size
			-- `bss_size'

	entry_point: INTEGER assign set_entry_point
			-- `entry_point'

	code_base: INTEGER assign set_code_base
			-- `code_base'

	data_base: INTEGER assign set_data_base
			-- `data_base'

	image_base: INTEGER assign set_image_base
			-- `image_base'

	object_align: INTEGER assign set_object_align
			-- `object_align'

	file_align: INTEGER assign set_file_align
			-- `file_align'

	os_major_version: INTEGER_16 assign set_os_major_version
			-- `os_major_version'

	os_minor_version: INTEGER_16 assign set_os_minor_version
			-- `os_minor_version'

	user_major_version: INTEGER_16 assign set_user_major_version
			-- `user_major_version'

	user_minor_version: INTEGER_16 assign set_user_minor_version
			-- `user_minor_version'

	subsys_major_version: INTEGER_16 assign set_subsys_major_version
			-- `subsys_major_version'

	subsys_minor_version: INTEGER_16 assign set_subsys_minor_version
			-- `subsys_minor_version'

	uu_1: INTEGER assign set_uu_1
			-- `uu_1'

	image_size: INTEGER assign set_image_size
			-- `image_size'

	header_size: INTEGER assign set_header_size
			-- `header_size'

	chekcsum: INTEGER assign set_chekcsum
			-- `chekcsum'

	subsystem: INTEGER_16 assign set_subsystem
			-- `subsystem'

	dll_flags: INTEGER_16 assign set_dll_flags
			-- `dll_flags'

	stack_size: INTEGER assign set_stack_size
			-- `stack_size'

	stack_commit: INTEGER assign set_stack_commit
			-- `stack_commit'

	heap_size: INTEGER assign set_heap_size
			-- `heap_size'

	heap_commit: INTEGER assign set_heap_commit
			-- `heap_commit'

	loader_flags: INTEGER assign set_loader_flags
			-- `loader_flags'

	num_rvas: INTEGER assign  set_num_rvas
			-- `num_rvas'

	export_rva: INTEGER assign set_export_rva
			-- `export_rva'

	export_size: INTEGER assign set_export_size
			-- `export_size'

	import_rva: INTEGER assign set_import_rva
			-- `import_rva'

	import_size: INTEGER assign set_import_size
			-- `import_size'

	resource_rva: INTEGER assign set_resource_rva
			-- `resource_rva'

	resource_size: INTEGER assign set_resource_size
			-- `resource_size'

	exception_rva: INTEGER assign set_exception_rva
			-- `exception_rva'

	exception_size: INTEGER assign set_exception_size
			-- `exception_size'

	security_rva: INTEGER assign set_security_rva
			-- `security_rva'

	security_size: INTEGER assign set_security_size
			-- `security_size'

	fixup_rva: INTEGER assign set_fixup_rva
			-- `fixup_rva'

	fixup_size: INTEGER assign set_fixup_size
			-- `fixup_size'

	debug_rva: INTEGER assign set_debug_rva
			-- `debug_rva'

	debug_size: INTEGER assign set_debug_size
			-- `debug_size'

	desc_rva: INTEGER assign set_desc_rva
			-- `desc_rva'

	desc_size: INTEGER assign set_desc_size
			-- `desc_size'

	mspec_rva: INTEGER assign set_mspec_rva
			-- `mspec_rva'

	mspec_size: INTEGER assign set_mspec_size
			-- `mspec_size'

	tls_rva: INTEGER assign set_tls_rva
			-- `tls_rva'

	tls_size: INTEGER assign set_tls_size
			-- `tls_size'

	loadconfig_rva: INTEGER assign set_loadconfig_rva
			-- `loadconfig_rva'

	loadconfig_size: INTEGER assign set_loadconfig_size
			-- `loadconfig_size'

	boundimp_rva: INTEGER assign set_boundimp_rva
			-- `boundimp_rva'

	boundimp_size: INTEGER assign set_boundimp_size
			-- `boundimp_size'

	iat_rva: INTEGER assign set_iat_rva
			-- `iat_rva'

	iat_size: INTEGER assign set_iat_size
			-- `iat_size'

	delay_imports_size: INTEGER assign set_delay_imports_size
			-- `delay_imports_size'

	delay_imports_rva: INTEGER assign set_delay_imports_rva
			-- `delay_imports_rva'

	com_size: INTEGER assign set_com_size
			-- `com_size'

	com_rva: INTEGER assign set_com_rva
			-- `com_rva'

	res3_size: INTEGER assign set_res3_size
			-- `res3_size'

	res3_rva: INTEGER assign set_res3_rva
			-- `res3_rva'

feature -- Measurement

	new: ANY
			-- `new'
		attribute check False then end end --| Remove line when `new' is initialized in creation procedure.

feature -- Element change

	set_signature (a_signature: like signature)
			-- Assign `signature' with `a_signature'.
		do
			signature := a_signature
		ensure
			signature_assigned: signature = a_signature
		end

	set_cpu_type (a_cpu_type: like cpu_type)
			-- Assign `cpu_type' with `a_cpu_type'.
		do
			cpu_type := a_cpu_type
		ensure
			cpu_type_assigned: cpu_type = a_cpu_type
		end

	set_num_objects (a_num_objects: like num_objects)
			-- Assign `num_objects' with `a_num_objects'.
		do
			num_objects := a_num_objects
		ensure
			num_objects_assigned: num_objects = a_num_objects
		end

	set_time (a_time: like time)
			-- Assign `time' with `a_time'.
		do
			time := a_time
		ensure
			time_assigned: time = a_time
		end

	set_symbol_ptr (a_symbol_ptr: like symbol_ptr)
			-- Assign `symbol_ptr' with `a_symbol_ptr'.
		do
			symbol_ptr := a_symbol_ptr
		ensure
			symbol_ptr_assigned: symbol_ptr = a_symbol_ptr
		end

	set_num_symbols (a_num_symbols: like num_symbols)
			-- Assign `num_symbols' with `a_num_symbols'.
		do
			num_symbols := a_num_symbols
		ensure
			num_symbols_assigned: num_symbols = a_num_symbols
		end

	set_nt_hdr_size (a_nt_hdr_size: like nt_hdr_size)
			-- Assign `nt_hdr_size' with `a_nt_hdr_size'.
		do
			nt_hdr_size := a_nt_hdr_size
		ensure
			nt_hdr_size_assigned: nt_hdr_size = a_nt_hdr_size
		end

	set_flags (a_flags: like flags)
			-- Assign `flags' with `a_flags'.
		do
			flags := a_flags
		ensure
			flags_assigned: flags = a_flags
		end

	set_magic (a_magic: like magic)
			-- Assign `magic' with `a_magic'.
		do
			magic := a_magic
		ensure
			magic_assigned: magic = a_magic
		end

	set_linker_major_version (a_linker_major_version: like linker_major_version)
			-- Assign `linker_major_version' with `a_linker_major_version'.
		do
			linker_major_version := a_linker_major_version
		ensure
			linker_major_version_assigned: linker_major_version = a_linker_major_version
		end

	set_linker_minor_version (a_linker_minor_version: like linker_minor_version)
			-- Assign `linker_minor_version' with `a_linker_minor_version'.
		do
			linker_minor_version := a_linker_minor_version
		ensure
			linker_minor_version_assigned: linker_minor_version = a_linker_minor_version
		end

	set_code_size (a_code_size: like code_size)
			-- Assign `code_size' with `a_code_size'.
		do
			code_size := a_code_size
		ensure
			code_size_assigned: code_size = a_code_size
		end

	set_data_size (a_data_size: like data_size)
			-- Assign `data_size' with `a_data_size'.
		do
			data_size := a_data_size
		ensure
			data_size_assigned: data_size = a_data_size
		end

	set_bss_size (a_bss_size: like bss_size)
			-- Assign `bss_size' with `a_bss_size'.
		do
			bss_size := a_bss_size
		ensure
			bss_size_assigned: bss_size = a_bss_size
		end

	set_entry_point (an_entry_point: like entry_point)
			-- Assign `entry_point' with `an_entry_point'.
		do
			entry_point := an_entry_point
		ensure
			entry_point_assigned: entry_point = an_entry_point
		end

	set_code_base (a_code_base: like code_base)
			-- Assign `code_base' with `a_code_base'.
		do
			code_base := a_code_base
		ensure
			code_base_assigned: code_base = a_code_base
		end

	set_data_base (a_data_base: like data_base)
			-- Assign `data_base' with `a_data_base'.
		do
			data_base := a_data_base
		ensure
			data_base_assigned: data_base = a_data_base
		end

	set_image_base (an_image_base: like image_base)
			-- Assign `image_base' with `an_image_base'.
		do
			image_base := an_image_base
		ensure
			image_base_assigned: image_base = an_image_base
		end

	set_object_align (an_object_align: like object_align)
			-- Assign `object_align' with `an_object_align'.
		do
			object_align := an_object_align
		ensure
			object_align_assigned: object_align = an_object_align
		end

	set_file_align (a_file_align: like file_align)
			-- Assign `file_align' with `a_file_align'.
		do
			file_align := a_file_align
		ensure
			file_align_assigned: file_align = a_file_align
		end

	set_os_major_version (an_os_major_version: like os_major_version)
			-- Assign `os_major_version' with `an_os_major_version'.
		do
			os_major_version := an_os_major_version
		ensure
			os_major_version_assigned: os_major_version = an_os_major_version
		end

	set_os_minor_version (an_os_minor_version: like os_minor_version)
			-- Assign `os_minor_version' with `an_os_minor_version'.
		do
			os_minor_version := an_os_minor_version
		ensure
			os_minor_version_assigned: os_minor_version = an_os_minor_version
		end

	set_user_major_version (an_user_major_version: like user_major_version)
			-- Assign `user_major_version' with `an_user_major_version'.
		do
			user_major_version := an_user_major_version
		ensure
			user_major_version_assigned: user_major_version = an_user_major_version
		end

	set_user_minor_version (an_user_minor_version: like user_minor_version)
			-- Assign `user_minor_version' with `an_user_minor_version'.
		do
			user_minor_version := an_user_minor_version
		ensure
			user_minor_version_assigned: user_minor_version = an_user_minor_version
		end

	set_subsys_major_version (a_subsys_major_version: like subsys_major_version)
			-- Assign `subsys_major_version' with `a_subsys_major_version'.
		do
			subsys_major_version := a_subsys_major_version
		ensure
			subsys_major_version_assigned: subsys_major_version = a_subsys_major_version
		end

	set_subsys_minor_version (a_subsys_minor_version: like subsys_minor_version)
			-- Assign `subsys_minor_version' with `a_subsys_minor_version'.
		do
			subsys_minor_version := a_subsys_minor_version
		ensure
			subsys_minor_version_assigned: subsys_minor_version = a_subsys_minor_version
		end

	set_uu_1 (an_uu_1: like uu_1)
			-- Assign `uu_1' with `an_uu_1'.
		do
			uu_1 := an_uu_1
		ensure
			uu_1_assigned: uu_1 = an_uu_1
		end

	set_image_size (an_image_size: like image_size)
			-- Assign `image_size' with `an_image_size'.
		do
			image_size := an_image_size
		ensure
			image_size_assigned: image_size = an_image_size
		end

	set_header_size (a_header_size: like header_size)
			-- Assign `header_size' with `a_header_size'.
		do
			header_size := a_header_size
		ensure
			header_size_assigned: header_size = a_header_size
		end

	set_chekcsum (a_chekcsum: like chekcsum)
			-- Assign `chekcsum' with `a_chekcsum'.
		do
			chekcsum := a_chekcsum
		ensure
			chekcsum_assigned: chekcsum = a_chekcsum
		end

	set_subsystem (a_subsystem: like subsystem)
			-- Assign `subsystem' with `a_subsystem'.
		do
			subsystem := a_subsystem
		ensure
			subsystem_assigned: subsystem = a_subsystem
		end

	set_dll_flags (a_dll_flags: like dll_flags)
			-- Assign `dll_flags' with `a_dll_flags'.
		do
			dll_flags := a_dll_flags
		ensure
			dll_flags_assigned: dll_flags = a_dll_flags
		end

	set_stack_size (a_stack_size: like stack_size)
			-- Assign `stack_size' with `a_stack_size'.
		do
			stack_size := a_stack_size
		ensure
			stack_size_assigned: stack_size = a_stack_size
		end

	set_stack_commit (a_stack_commit: like stack_commit)
			-- Assign `stack_commit' with `a_stack_commit'.
		do
			stack_commit := a_stack_commit
		ensure
			stack_commit_assigned: stack_commit = a_stack_commit
		end

	set_heap_size (a_heap_size: like heap_size)
			-- Assign `heap_size' with `a_heap_size'.
		do
			heap_size := a_heap_size
		ensure
			heap_size_assigned: heap_size = a_heap_size
		end

	set_heap_commit (a_heap_commit: like heap_commit)
			-- Assign `heap_commit' with `a_heap_commit'.
		do
			heap_commit := a_heap_commit
		ensure
			heap_commit_assigned: heap_commit = a_heap_commit
		end

	set_loader_flags (a_loader_flags: like loader_flags)
			-- Assign `loader_flags' with `a_loader_flags'.
		do
			loader_flags := a_loader_flags
		ensure
			loader_flags_assigned: loader_flags = a_loader_flags
		end

	set_num_rvas (a_num_rvas: like num_rvas)
			-- Assign `num_rvas' with `a_num_rvas'.
		do
			num_rvas := a_num_rvas
		ensure
			num_rvas_assigned: num_rvas = a_num_rvas
		end

	set_export_rva (an_export_rva: like export_rva)
			-- Assign `export_rva' with `an_export_rva'.
		do
			export_rva := an_export_rva
		ensure
			export_rva_assigned: export_rva = an_export_rva
		end

	set_export_size (an_export_size: like export_size)
			-- Assign `export_size' with `an_export_size'.
		do
			export_size := an_export_size
		ensure
			export_size_assigned: export_size = an_export_size
		end

	set_import_rva (an_import_rva: like import_rva)
			-- Assign `import_rva' with `an_import_rva'.
		do
			import_rva := an_import_rva
		ensure
			import_rva_assigned: import_rva = an_import_rva
		end

	set_import_size (an_import_size: like import_size)
			-- Assign `import_size' with `an_import_size'.
		do
			import_size := an_import_size
		ensure
			import_size_assigned: import_size = an_import_size
		end

	set_resource_rva (a_resource_rva: like resource_rva)
			-- Assign `resource_rva' with `a_resource_rva'.
		do
			resource_rva := a_resource_rva
		ensure
			resource_rva_assigned: resource_rva = a_resource_rva
		end

	set_resource_size (a_resource_size: like resource_size)
			-- Assign `resource_size' with `a_resource_size'.
		do
			resource_size := a_resource_size
		ensure
			resource_size_assigned: resource_size = a_resource_size
		end

	set_exception_rva (an_exception_rva: like exception_rva)
			-- Assign `exception_rva' with `an_exception_rva'.
		do
			exception_rva := an_exception_rva
		ensure
			exception_rva_assigned: exception_rva = an_exception_rva
		end

	set_exception_size (an_exception_size: like exception_size)
			-- Assign `exception_size' with `an_exception_size'.
		do
			exception_size := an_exception_size
		ensure
			exception_size_assigned: exception_size = an_exception_size
		end

	set_security_rva (a_security_rva: like security_rva)
			-- Assign `security_rva' with `a_security_rva'.
		do
			security_rva := a_security_rva
		ensure
			security_rva_assigned: security_rva = a_security_rva
		end

	set_security_size (a_security_size: like security_size)
			-- Assign `security_size' with `a_security_size'.
		do
			security_size := a_security_size
		ensure
			security_size_assigned: security_size = a_security_size
		end

	set_fixup_rva (a_fixup_rva: like fixup_rva)
			-- Assign `fixup_rva' with `a_fixup_rva'.
		do
			fixup_rva := a_fixup_rva
		ensure
			fixup_rva_assigned: fixup_rva = a_fixup_rva
		end

	set_fixup_size (a_fixup_size: like fixup_size)
			-- Assign `fixup_size' with `a_fixup_size'.
		do
			fixup_size := a_fixup_size
		ensure
			fixup_size_assigned: fixup_size = a_fixup_size
		end

	set_debug_rva (a_debug_rva: like debug_rva)
			-- Assign `debug_rva' with `a_debug_rva'.
		do
			debug_rva := a_debug_rva
		ensure
			debug_rva_assigned: debug_rva = a_debug_rva
		end

	set_debug_size (a_debug_size: like debug_size)
			-- Assign `debug_size' with `a_debug_size'.
		do
			debug_size := a_debug_size
		ensure
			debug_size_assigned: debug_size = a_debug_size
		end

	set_desc_rva (a_desc_rva: like desc_rva)
			-- Assign `desc_rva' with `a_desc_rva'.
		do
			desc_rva := a_desc_rva
		ensure
			desc_rva_assigned: desc_rva = a_desc_rva
		end

	set_desc_size (a_desc_size: like desc_size)
			-- Assign `desc_size' with `a_desc_size'.
		do
			desc_size := a_desc_size
		ensure
			desc_size_assigned: desc_size = a_desc_size
		end

	set_mspec_rva (a_mspec_rva: like mspec_rva)
			-- Assign `mspec_rva' with `a_mspec_rva'.
		do
			mspec_rva := a_mspec_rva
		ensure
			mspec_rva_assigned: mspec_rva = a_mspec_rva
		end

	set_mspec_size (a_mspec_size: like mspec_size)
			-- Assign `mspec_size' with `a_mspec_size'.
		do
			mspec_size := a_mspec_size
		ensure
			mspec_size_assigned: mspec_size = a_mspec_size
		end

	set_tls_rva (a_tls_rva: like tls_rva)
			-- Assign `tls_rva' with `a_tls_rva'.
		do
			tls_rva := a_tls_rva
		ensure
			tls_rva_assigned: tls_rva = a_tls_rva
		end

	set_tls_size (a_tls_size: like tls_size)
			-- Assign `tls_size' with `a_tls_size'.
		do
			tls_size := a_tls_size
		ensure
			tls_size_assigned: tls_size = a_tls_size
		end

	set_loadconfig_rva (a_loadconfig_rva: like loadconfig_rva)
			-- Assign `loadconfig_rva' with `a_loadconfig_rva'.
		do
			loadconfig_rva := a_loadconfig_rva
		ensure
			loadconfig_rva_assigned: loadconfig_rva = a_loadconfig_rva
		end

	set_loadconfig_size (a_loadconfig_size: like loadconfig_size)
			-- Assign `loadconfig_size' with `a_loadconfig_size'.
		do
			loadconfig_size := a_loadconfig_size
		ensure
			loadconfig_size_assigned: loadconfig_size = a_loadconfig_size
		end

	set_boundimp_rva (a_boundimp_rva: like boundimp_rva)
			-- Assign `boundimp_rva' with `a_boundimp_rva'.
		do
			boundimp_rva := a_boundimp_rva
		ensure
			boundimp_rva_assigned: boundimp_rva = a_boundimp_rva
		end

	set_boundimp_size (a_boundimp_size: like boundimp_size)
			-- Assign `boundimp_size' with `a_boundimp_size'.
		do
			boundimp_size := a_boundimp_size
		ensure
			boundimp_size_assigned: boundimp_size = a_boundimp_size
		end

	set_iat_rva (an_iat_rva: like iat_rva)
			-- Assign `iat_rva' with `an_iat_rva'.
		do
			iat_rva := an_iat_rva
		ensure
			iat_rva_assigned: iat_rva = an_iat_rva
		end

	set_iat_size (an_iat_size: like iat_size)
			-- Assign `iat_size' with `an_iat_size'.
		do
			iat_size := an_iat_size
		ensure
			iat_size_assigned: iat_size = an_iat_size
		end

	set_delay_imports_size (a_delay_imports_size: like delay_imports_size)
			-- Assign `delay_imports_size' with `a_delay_imports_size'.
		do
			delay_imports_size := a_delay_imports_size
		ensure
			delay_imports_size_assigned: delay_imports_size = a_delay_imports_size
		end

	set_delay_imports_rva (a_delay_imports_rva: like delay_imports_rva)
			-- Assign `delay_imports_rva' with `a_delay_imports_rva'.
		do
			delay_imports_rva := a_delay_imports_rva
		ensure
			delay_imports_rva_assigned: delay_imports_rva = a_delay_imports_rva
		end

	set_com_size (a_com_size: like com_size)
			-- Assign `com_size' with `a_com_size'.
		do
			com_size := a_com_size
		ensure
			com_size_assigned: com_size = a_com_size
		end

	set_com_rva (a_com_rva: like com_rva)
			-- Assign `com_rva' with `a_com_rva'.
		do
			com_rva := a_com_rva
		ensure
			com_rva_assigned: com_rva = a_com_rva
		end

	set_res3_size (a_res3_size: like res3_size)
			-- Assign `res3_size' with `a_res3_size'.
		do
			res3_size := a_res3_size
		ensure
			res3_size_assigned: res3_size = a_res3_size
		end

	set_res3_rva (a_res3_rva: like res3_rva)
			-- Assign `res3_rva' with `a_res3_rva'.
		do
			res3_rva := a_res3_rva
		ensure
			res3_rva_assigned: res3_rva = a_res3_rva
		end

feature -- Measurement

	size_of: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_HEADER
			l_size: INTEGER
		do
			create l_obj
			create l_internal
			n := l_internal.field_count (l_obj)
			across 1 |..| n as ic loop
				if attached l_internal.field (ic, l_obj) as l_field then
					if attached {INTEGER_32} l_field then
						Result := Result + {PLATFORM}.integer_32_bytes
					elseif attached {INTEGER_16} l_field then
						Result := Result + {PLATFORM}.integer_16_bytes
					elseif attached {NATURAL_8} l_field then
						Result := Result + {PLATFORM}.natural_8_bytes
					end
				end
			end
		ensure
			instance_free: class
		end

end
