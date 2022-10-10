note
	description: "This is the main class for generating a PE file"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_WRITER

create
	make

feature {NONE} -- Initialization

	make (is_exe: BOOLEAN; is_gui: BOOLEAN; a_snk_file: STRING_32)
		do
			dll := not is_exe
			gui := is_gui

		end

feature -- Access

	snk_base: NATURAL assign set_snk_base
			-- `snk_base'
		attribute check False then end end --| Remove line when `snk_base' is initialized in creation procedure.

	cor_base: NATURAL assign set_cor_base
			-- `cor_base'
		attribute check False then end end --| Remove line when `cor_base' is initialized in creation procedure.

	pe_base: NATURAL assign set_pe_base
			-- `pe_base'
		attribute check False then end end --| Remove line when `pe_base' is initialized in creation procedure.

	snk_len: NATURAL assign set_snk_len
			-- `snk_len'
		attribute check False then end end --| Remove line when `snk_len' is initialized in creation procedure.

	snk_file: STRING_32
			-- `snk_file'
		attribute check False then end end --| Remove line when `snk_file' is initialized in creation procedure.

	tables_header: detachable DOTNET_META_TABLES_HEADER
			-- `tables_header'

	cor20_header: detachable DOTNET_COR20_HEADER
			-- `cor20_header'

	pe_object: detachable PE_OBJECT
			-- `pe_object'

	pe_header: detachable PE_HEADER
			-- `pe_header'

	language: NATURAL
			-- `language'
		attribute check False then end end --| Remove line when `language' is initialized in creation procedure.

	image_base: NATURAL assign set_image_base
			-- `image_base'
		attribute check False then end end --| Remove line when `image_base' is initialized in creation procedure.

	object_align: NATURAL assign set_object_align
			-- `object_align'
		attribute check False then end end --| Remove line when `object_align' is initialized in creation procedure.

	file_align: NATURAL assign set_file_align
			-- `file_align'
		attribute check False then end end --| Remove line when `file_align' is initialized in creation procedure.

	param_attribute_data: NATURAL assign set_param_attribute_data
			-- `param_attribute_data'
		attribute check False then end end --| Remove line when `param_attribute_data' is initialized in creation procedure.

	param_attribute_type: NATURAL assign set_param_attribute_type
			-- `param_attribute_type'
		attribute check False then end end --| Remove line when `param_attribute_type' is initialized in creation procedure.

	entry_point: NATURAL assign set_entry_point
			-- `entry_point'
		attribute check False then end end --| Remove line when `entry_point' is initialized in creation procedure.

	system_index: NATURAL assign set_system_index
			-- `system_index'
		attribute check False then end end --| Remove line when `system_index' is initialized in creation procedure.

	enum_base: NATURAL assign set_enum_base
			-- `enum_base'
		attribute check False then end end --| Remove line when `enum_base' is initialized in creation procedure.

	value_base: NATURAL assign set_value_base
			-- `value_base'
		attribute check False then end end --| Remove line when `value_base' is initialized in creation procedure.

	object_base: NATURAL assign set_object_base
			-- `object_base'
		attribute check False then end end --| Remove line when `object_base' is initialized in creation procedure.

	gui: BOOLEAN assign set_gui
			-- `gui'

	dll: BOOLEAN assign set_dll
			-- `dll'



feature -- Element change

	set_snk_base (a_snk_base: like snk_base)
			-- Assign `snk_base' with `a_snk_base'.
		do
			snk_base := a_snk_base
		ensure
			snk_base_assigned: snk_base = a_snk_base
		end

	set_cor_base (a_cor_base: like cor_base)
			-- Assign `cor_base' with `a_cor_base'.
		do
			cor_base := a_cor_base
		ensure
			cor_base_assigned: cor_base = a_cor_base
		end

	set_pe_base (a_pe_base: like pe_base)
			-- Assign `pe_base' with `a_pe_base'.
		do
			pe_base := a_pe_base
		ensure
			pe_base_assigned: pe_base = a_pe_base
		end

	set_snk_len (a_snk_len: like snk_len)
			-- Assign `snk_len' with `a_snk_len'.
		do
			snk_len := a_snk_len
		ensure
			snk_len_assigned: snk_len = a_snk_len
		end

	set_snk_file (a_snk_file: like snk_file)
			-- Assign `snk_file' with `a_snk_file'.
		do
			snk_file := a_snk_file
		ensure
			snk_file_assigned: snk_file = a_snk_file
		end

	set_tables_header (a_tables_header: like tables_header)
			-- Assign `tables_header' with `a_tables_header'.
		do
			tables_header := a_tables_header
		ensure
			tables_header_assigned: tables_header = a_tables_header
		end

	set_cor20_header (a_cor20_header: like cor20_header)
			-- Assign `cor20_header' with `a_cor20_header'.
		do
			cor20_header := a_cor20_header
		ensure
			cor20_header_assigned: cor20_header = a_cor20_header
		end

	set_pe_object (a_pe_object: like pe_object)
			-- Assign `pe_object' with `a_pe_object'.
		do
			pe_object := a_pe_object
		ensure
			pe_object_assigned: pe_object = a_pe_object
		end

	set_pe_header (a_pe_header: like pe_header)
			-- Assign `pe_header' with `a_pe_header'.
		do
			pe_header := a_pe_header
		ensure
			pe_header_assigned: pe_header = a_pe_header
		end

	set_language (a_language: like language)
			-- Assign `language' with `a_language'.
		do
			language := a_language
		ensure
			language_assigned: language = a_language
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

	set_param_attribute_data (a_param_attribute_data: like param_attribute_data)
			-- Assign `param_attribute_data' with `a_param_attribute_data'.
		do
			param_attribute_data := a_param_attribute_data
		ensure
			param_attribute_data_assigned: param_attribute_data = a_param_attribute_data
		end

	set_param_attribute_type (a_param_attribute_type: like param_attribute_type)
			-- Assign `param_attribute_type' with `a_param_attribute_type'.
		do
			param_attribute_type := a_param_attribute_type
		ensure
			param_attribute_type_assigned: param_attribute_type = a_param_attribute_type
		end

	set_entry_point (an_entry_point: like entry_point)
			-- Assign `entry_point' with `an_entry_point'.
		do
			entry_point := an_entry_point
		ensure
			entry_point_assigned: entry_point = an_entry_point
		end

	set_system_index (a_system_index: like system_index)
			-- Assign `system_index' with `a_system_index'.
		do
			system_index := a_system_index
		ensure
			system_index_assigned: system_index = a_system_index
		end

	set_enum_base (an_enum_base: like enum_base)
			-- Assign `enum_base' with `an_enum_base'.
		do
			enum_base := an_enum_base
		ensure
			enum_base_assigned: enum_base = an_enum_base
		end

	set_value_base (a_value_base: like value_base)
			-- Assign `value_base' with `a_value_base'.
		do
			value_base := a_value_base
		ensure
			value_base_assigned: value_base = a_value_base
		end

	set_object_base (an_object_base: like object_base)
			-- Assign `object_base' with `an_object_base'.
		do
			object_base := an_object_base
		ensure
			object_base_assigned: object_base = an_object_base
		end

	set_gui (a_gui: like gui)
			-- Assign `gui' with `a_gui'.
		do
			gui := a_gui
		ensure
			gui_assigned: gui = a_gui
		end

	set_dll (a_dll: like dll)
			-- Assign `dll' with `a_dll'.
		do
			dll := a_dll
		ensure
			dll_assigned: dll = a_dll
		end

feature -- Constants

	MAX_PE_OBJECTS: INTEGER = 4
			-- the maximum number of PE objects we will generate
			-- this includes the following:
			-- 	.text / cildata
			-- 	.reloc (for the single necessary reloc entry)
			-- 	.rsrc (not implemented yet, will hold version info record)

end
