note
	description: "Object to generate a project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [aranud@mail.dotcom.fr]", "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROJECT_GENERATOR

inherit
	BENCH_WIZARD_PROJECT_GENERATOR
		redefine
			generate_code
		end

	WIZARD_PROJECT_SHARED

create
	make

feature -- Basic operations

	generate_code
			-- Generate code for the project.
		local
			dir: DIRECTORY
			map: HASH_TABLE [STRING_32, STRING]
			class_name: STRING
			i: INTEGER
			next_state: STRING
			project_location: PATH
			pixmap_location: PATH
			rsc_location: PATH
			project_name: like {BENCH_WIZARD_INFORMATION}.project_name
			l_uuid: UUID_GENERATOR
		do
			Precursor
				-- Cached variables.
			project_location := wizard_information.project_location
			project_name := wizard_information.project_name

			create dir.make_with_path (project_location)
			if dir.exists then
				dir.delete_content
			else
				dir.create_dir
			end
			pixmap_location := project_location.extended ("pixmaps")
			create dir.make_with_path (pixmap_location)
			dir.create_dir
			rsc_location := project_location.extended ("resources")
			create dir.make_with_path (rsc_location)
			dir.create_dir

			create map.make (10)
			map.force (project_name, "${FL_WIZARD_NAME}")
			map.force (project_location.name, "${FL_WIZARD_PATH}")
			create l_uuid
			map.force (l_uuid.generate_uuid.out.as_string_32, "${FL_UUID}")

			from_template_to_project (wizard_resources_path, "template_config.ecf", project_location, project_name.as_lower + ".ecf", map)

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

				create map.make (10)
				map.force (class_name, "${FL_WIZARD_CLASS_NAME}")
				map.force (i.out.as_string_32, "${FL_STATE_NUMBER}")

					-- Prepare next step
				list_of_name.forth
				i := i + 1

				if i > wizard_information.number_state then
					next_state := "WIZARD_FINAL_STATE"
				else
					next_state := "WIZARD_"+list_of_name.item+"_STATE"
				end
				map.force (next_state, "${FL_NEXT_STATE}")

				from_template_to_project (wizard_resources_path, "template_wizard_state.e", project_location, class_name + ".e", map)
			end

			create map.make (10)
			map.force (project_name, "${FL_WIZARD_NAME}")
			from_template_to_project (wizard_resources_path, "template_wizard_initial_state.e", project_location, "wizard_initial_state.e", map)
			from_template_to_project (wizard_resources_path, "template_wizard_final_state.e",   project_location, "wizard_final_state.e", map)
			from_template_to_project (wizard_resources_path, "application_factory.e",   project_location, "application_factory.e", map)
			from_template_to_project (wizard_resources_path, "application.e",   project_location, "application.e", map)

			copy_file ("wizard_information.e",   project_location)
			copy_file ("wizard_project_shared.e",   project_location)
			copy_file ("eiffel_wizard_icon" + pixmap_extension, pixmap_location)
			copy_file ("eiffel_wizard" + pixmap_extension, pixmap_location)
		end

feature {NONE} -- Access

	target_files: TRAVERSABLE [STRING_GENERAL]
			-- All target files that will be created during generation
		local
			i: INTEGER
			r: ARRAYED_LIST [STRING_GENERAL]
		do
			create r.make_from_array (<<
				wizard_information.project_name.as_lower + ".ecf",
				"wizard_initial_state.e",
				"wizard_final_state.e",
				"application_factory.e",
				"application.e",
				"wizard_information.e",
				"wizard_project_shared.e",
				"pixmaps\eiffel_wizard_icon" + pixmap_extension,
				"pixmaps\eiffel_wizard" + pixmap_extension
			>>)
			Result := r
			from
				i := 1
				list_of_name.start
			until
				i > wizard_information.number_state
			loop
				if list_of_name.after then
					list_of_name.start
				end
				r.extend (("WIZARD_" + list_of_name.item + "_STATE").as_lower + ".e")
					-- Prepare next step
				list_of_name.forth
				i := i + 1
			end
		end

	list_of_name: LINKED_LIST [STRING]
		once
			create Result.make
			list_of_name.extend ("FIRST")
			list_of_name.extend ("SECOND")
			list_of_name.extend ("THIRD")
			list_of_name.extend ("FOURTH")
			list_of_name.extend ("FIFTH")
			list_of_name.extend ("SIXTH")
			list_of_name.extend ("SEVENTH")
			list_of_name.extend ("EIGHTH")
			list_of_name.extend ("NINETH")
			list_of_name.extend ("TENTH")
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
