indexing
	description	: "Object to generate a project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_PROJECT_GENERATOR

inherit
	BENCH_WIZARD_PROJECT_GENERATOR

	WIZARD_PROJECT_SHARED

create
	make

feature -- Basic Operations

	generate_code is
			-- Generate code for the project.
		local
			dir: DIRECTORY
			l: LINKED_LIST [TUPLE [STRING, STRING]]
			list_of_name: LINKED_LIST [STRING]
			l_tuple: TUPLE [STRING, STRING]
			class_name: STRING
			i: INTEGER
			next_state: STRING
			project_location: FILE_NAME
			src_location: FILE_NAME
			pixmap_location: FILE_NAME
			rsc_location: FILE_NAME
			project_name: STRING
			l_uuid: UUID_GENERATOR
		do
				-- Cached variables.
			create project_location.make_from_string (wizard_information.project_location)
			project_name := wizard_information.project_name

			create list_of_name.make
			list_of_name.extend ("FIRST")
			list_of_name.extend ("SECOND")
			list_of_name.extend ("THIRD")
			list_of_name.extend ("FOURTH")
			list_of_name.extend ("FIFTH")
			list_of_name.extend ("SIXTH")
			list_of_name.extend ("SEVENTH")
			list_of_name.extend ("HEIGHT")
			list_of_name.extend ("NINETH")
			list_of_name.extend ("TENTH")


			create dir.make (project_location)
			if dir.exists then
				dir.delete_content
			else
				dir.create_dir
			end
			create pixmap_location.make_from_string (project_location)
			pixmap_location.extend ("pixmaps")
			create dir.make (pixmap_location)
			dir.create_dir
			create src_location.make_from_string (project_location)
			create rsc_location.make_from_string (project_location)
			rsc_location.extend ("resources")
			create dir.make (rsc_location)
			dir.create_dir

			create l.make
			create l_tuple
			l_tuple.put ("${FL_WIZARD_NAME}", 1)
			l_tuple.put (project_name, 2)
			l.extend (l_tuple)
			create l_tuple
			l_tuple.put ("${FL_WIZARD_PATH}", 1)
			l_tuple.put (project_location, 2)
			l.extend (l_tuple)
			create l_uuid
			create l_tuple
			l_tuple.put ("${FL_UUID}", 1)
			l_tuple.put (l_uuid.generate_uuid.out, 2)
			l.extend (l_tuple)
			from_template_to_project (wizard_resources_path, "template_config.acex", project_location, "Ace.acex", l)

			from
				i := 1
				list_of_name.start
			until
				i > wizard_information.number_state
			loop
				if list_of_name.after then
					list_of_name.start
				end
				class_name := "WIZARD_" + list_of_name.item + "_STATE"
				class_name.to_lower

				create l.make
				create l_tuple
				l_tuple.put ("${FL_WIZARD_CLASS_NAME}", 1)
				l_tuple.put (class_name, 2)

				create l_tuple
				l_tuple.put ("${FL_WIZARD_CLASS_NAME}", 1)
				l_tuple.put (class_name, 2)
				l.extend (l_tuple)

				create l_tuple
				l_tuple.put ("${FL_STATE_NUMBER}", 1)
				l_tuple.put (i.out, 2)
				l.extend (l_tuple)

					-- Prepare next step
				list_of_name.forth
				i := i + 1

				if i > wizard_information.number_state then
					next_state := "WIZARD_FINAL_STATE"
				else
					next_state := "WIZARD_"+list_of_name.item+"_STATE"
				end

				create l_tuple
				l_tuple.put ("${FL_NEXT_STATE}", 1)
				l_tuple.put (next_state, 2)
				l.extend (l_tuple)

				from_template_to_project (wizard_resources_path, "template_wizard_state.e", src_location, class_name + ".e", l)
			end

			create l_tuple
			l_tuple.put ("${FL_WIZARD_NAME}", 1)
			l_tuple.put (project_name, 2)
			create l.make
			l.extend (l_tuple)
			from_template_to_project (wizard_resources_path, "template_wizard_initial_state.e", src_location, "wizard_initial_state.e", l)
			from_template_to_project (wizard_resources_path, "template_wizard_final_state.e",   src_location, "wizard_final_state.e", l)
			from_template_to_project (wizard_resources_path, "application_factory.e",   src_location, "application_factory.e", l)
			from_template_to_project (wizard_resources_path, "application.e",   src_location, "application.e", l)

			copy_file ("wizard_information", 	"e",   src_location)
			copy_file ("wizard_project_shared",	"e",   src_location)
			copy_file ("eiffel_wizard_icon", 	pixmap_extension, pixmap_location)
			copy_file ("eiffel_wizard", 		pixmap_extension, pixmap_location)
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
end -- class WIZARD_PROJECT_GENERATOR
