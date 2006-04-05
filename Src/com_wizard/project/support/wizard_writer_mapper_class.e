indexing
	description: "Mapper class writer associated with an id"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			add_import (alias_c_writer.header_file_name)
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
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
