indexing
	description: "Mapper class writer associated with an id"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_MAPPER_CLASS

inherit
	WIZARD_WRITER_CPP_CLASS
		redefine
			add_function
		end

create
	make_ec,
	make_ce

feature {NONE} -- Initialization

	make_ec is
			-- Initialize `id'.
		do
			make
			id := Ec_counter
			is_ec := True
			initialize
		end
		
	make_ce is
			-- Initialize `id'.
		do
			make
			id := Ce_counter
			initialize
		end
	
	initialize is
			-- Initialize instance according to `is_ec' and `id'.
		local
			l_header_file_name, l_header, l_source: STRING
			l_constructor: WIZARD_WRITER_CPP_CONSTRUCTOR
		do
			create variable_name.make (240)
			if is_ec then
				variable_name.append ("grt_ec_")
			else
				variable_name.append ("grt_ce_")
			end
			variable_name.append (environment.project_name)
			if environment.is_client then
				variable_name.append ("_c")
			end
			if id > 1 then
				variable_name.append_character ('_')
				variable_name.append (id.out)
			end

			create l_header_file_name.make (240)
			if is_ec then
				l_header_file_name.append ("ecom_gec_")
			else
				l_header_file_name.append ("ecom_gce_")
			end
			l_header_file_name.append (environment.project_name)
			if environment.is_client then
				l_header_file_name.append ("_c")
			end
			if id > 1 then
				l_header_file_name.append_character ('_')
				l_header_file_name.append (id.out)
			end

			create l_header.make (50)
			if is_ec then
				l_header.append ("Writer for generated Eiffel to C mappers class")
			else
				l_header.append ("Writer for generated C to Eiffel mappers class")
			end
			if id > 1 then
				l_header.append (" (")
				l_header.append (id.out)
				l_header.append (")")
			end
			set_header (l_header)
			
			set_name (l_header_file_name.twin)
			l_header_file_name.append (Header_file_extension)
			set_definition_header_file_name (l_header_file_name)
			create l_constructor.make
			l_constructor.set_signature ("")
			l_constructor.set_body ("")
			add_constructor (l_constructor)
			add_import ("ecom_rt_globals.h")
			add_import_after (ecom_generated_rt_globals_header_file_name)
			create l_source.make (100)
			l_source.append (name)
			l_source.append_character (' ')
			l_source.append (variable_name)
			l_source.append (semicolon)
			add_other_source (l_source)
		end
		
feature -- Access

	id: INTEGER
			-- Unique id

	is_ec: BOOLEAN
			-- Is mapper from Eiffel to C?

	variable_name: STRING
			-- Variable name
	
	functions_count: INTEGER
			-- Functions count

feature -- Basic Operations

	add_function (a_function: WIZARD_WRITER_C_FUNCTION; a_export_status: INTEGER) is
			-- Add `a_function' to functions.
		do
			functions_count := functions_count + 1
			Precursor {WIZARD_WRITER_CPP_CLASS} (a_function, a_export_status)
		end

feature {NONE} -- Implementation

	Ec_counter: INTEGER is
			-- Incremental counter
		do
			Result := Ec_counter_cell.item + 1
			Ec_counter_cell.set_item (Result)
		end
	
	Ec_counter_cell: INTEGER_REF is
			-- Cell for `Ec_counter'.
		once
			create Result
		end
		
	Ce_counter: INTEGER is
			-- Incremental counter
		do
			Result := Ce_counter_cell.item + 1
			Ce_counter_cell.set_item (Result)
		end
	
	Ce_counter_cell: INTEGER_REF is
			-- Cell for `Ce_counter'.
		once
			create Result
		end
		
end
