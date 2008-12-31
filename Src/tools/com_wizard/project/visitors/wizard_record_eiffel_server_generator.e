note
	description: "Record eiffel server generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RECORD_EIFFEL_SERVER_GENERATOR

inherit
	WIZARD_RECORD_EIFFEL_GENERATOR
		redefine
			generate
		end


feature -- Access

	generate (a_descriptor: WIZARD_RECORD_DESCRIPTOR)
			-- Generate eiffel server for record
		do
			if not standard_structures.has (a_descriptor.c_type_name) then
				Precursor (a_descriptor)
				Shared_file_name_factory.create_file_name (Current, eiffel_writer)
				eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)
			end

			eiffel_writer := Void
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY)
		do
			a_factory.process_record_eiffel_server
		end

			
note
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
end -- class WIZARD_RECORD_EIFFEL_SERVER_GENERATOR


