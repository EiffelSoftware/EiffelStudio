indexing
	description	: "Object to generate a project."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_PROJECT_GENERATOR

inherit
	BENCH_WIZARD_PROJECT_GENERATOR

create
	make

feature -- Basic Operations

	generate_code is
			-- Generate code for the project.
		local
			dir: DIRECTORY
			l: LINKED_LIST [TUPLE [STRING, STRING]]
			list_of_name: LINKED_LIST [STRING]
			tuple1, tuple2: TUPLE [STRING, STRING]
			class_name: STRING
			i: INTEGER
			next_state: STRING
			project_location: FILE_NAME
			src_location: FILE_NAME
			pixmap_location: FILE_NAME
			rsc_location: FILE_NAME
			project_name: STRING
		do
				-- Cached variables.
			create project_location.make_from_string (wizard_information.project_location)
			project_name := wizard_information.project_name

			create list_of_name.make
			list_of_name.make
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
			src_location.extend ("src")
			create dir.make (src_location)
			dir.create_dir
			create rsc_location.make_from_string (project_location)
			rsc_location.extend ("resources")
			create dir.make (rsc_location)
			dir.create_dir

			create tuple1.make
			tuple1.put ("<FL_WIZARD_NAME>", 1)
			tuple1.put (project_name, 2)
			create tuple2.make
			tuple2.put ("<FL_WIZARD_PATH>", 1)
			tuple2.put (project_location, 2)
			create l.make
			l.extend (tuple1)
			l.extend (tuple2)
			from_template_to_project (wizard_resources_path, "Ace.ace", project_location, "Ace.ace", l)

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
				create tuple1.make
				tuple1.put ("<FL_WIZARD_CLASS_NAME>", 1)
				tuple1.put (class_name, 2)

				create tuple1.make
				tuple1.put ("<FL_WIZARD_CLASS_NAME>", 1)
				tuple1.put (class_name, 2)
				l.extend (tuple1)

				create tuple1.make
				tuple1.put ("<FL_STATE_NUMBER>", 1)
				tuple1.put (i.out, 2)
				l.extend (tuple1)

					-- Prepare next step
				list_of_name.forth 
				i := i + 1

				if i > wizard_information.number_state then
					next_state := "WIZARD_FINAL_STATE"
				else
					next_state := "WIZARD_"+list_of_name.item+"_STATE"
				end

				create tuple1.make
				tuple1.put ("<FL_NEXT_STATE>", 1)
				tuple1.put (next_state, 2)
				l.extend (tuple1)

				from_template_to_project (wizard_resources_path, "template_wizard_state.e", src_location, class_name + ".e", l)
			end

			create tuple1.make
			tuple1.put ("<FL_WIZARD_NAME>", 1)
			tuple1.put (project_name, 2)
			create l.make
			l.extend (tuple1)
			from_template_to_project (wizard_resources_path, "template_wizard_initial_state.e", src_location, "wizard_initial_state.e", l)
			from_template_to_project (wizard_resources_path, "template_wizard_final_state.e",   src_location, "wizard_final_state.e", l)

			copy_file ("wizard_information", 	"e",   src_location)
			copy_file ("wizard_project_shared",	"e",   src_location)
			copy_file ("eiffel_wizard_icon", 	pixmap_extension, pixmap_location)
			copy_file ("eiffel_wizard", 		pixmap_extension, pixmap_location)
		end

end -- class WIZARD_PROJECT_GENERATOR
