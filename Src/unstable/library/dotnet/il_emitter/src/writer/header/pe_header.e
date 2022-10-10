note
	description: "Summary description for {PE_HEADER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_HEADER


--    struct PEHeader
--    {
--        int signature;
--        short cpu_type;
--        short num_objects;
--        int time;
--        int symbol_ptr;
--        int num_symbols;
--        short nt_hdr_size;
--        short flags;
--        short magic;
--        unsigned char linker_major_version;
--        unsigned char linker_minor_version;
--        int code_size;
--        int data_size;
--        int bss_size;
--        int entry_point;
--        int code_base;
--        int data_base;
--        int image_base;
--        int object_align;
--        int file_align;
--        short os_major_version;
--        short os_minor_version;
--        short user_major_version;
--        short user_minor_version;
--        short subsys_major_version;
--        short subsys_minor_version;
--        int uu_1;
--        int image_size;
--        int header_size;
--        int chekcsum;
--        short subsystem;
--        short dll_flags;
--        int stack_size;
--        int stack_commit;
--        int heap_size;
--        int heap_commit;
--        int loader_flags;
--        int num_rvas;
--        int export_rva;
--        int export_size;
--        int import_rva;
--        int import_size;
--        int resource_rva;
--        int resource_size;
--        int exception_rva;
--        int exception_size;
--        int security_rva;
--        int security_size;
--        int fixup_rva;
--        int fixup_size;
--        int debug_rva;
--        int debug_size;
--        int desc_rva;
--        int desc_size;
--        int mspec_rva;
--        int mspec_size;
--        int tls_rva;
--        int tls_size;
--        int loadconfig_rva;
--        int loadconfig_size;
--        int boundimp_rva;
--        int boundimp_size;
--        int iat_rva;
--        int iat_size;
--        int delay_imports_rva, delay_imports_size;
--        int com_rva, com_size;
--        int res3_rva, res3_size;
--    };

end
