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
			project_location: STRING
			project_name: STRING
		do
				-- Cached variables.
			project_location := wizard_information.project_location
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
			create dir.make (project_location + "\pixmaps")
			dir.create_dir
			create dir.make (project_location + "\src")
			dir.create_dir
			create dir.make (project_location + "\resources")
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

				from_template_to_project (wizard_resources_path, "template_wizard_state.e", project_location + "/src", class_name + ".e", l)
			end

			create tuple1.make
			tuple1.put ("<FL_WIZARD_NAME>", 1)
			tuple1.put (project_name, 2)
			create l.make
			l.extend (tuple1)
			from_template_to_project (wizard_resources_path, "template_wizard_initial_state.e", project_location + "/src", "wizard_initial_state.e", l)
			from_template_to_project (wizard_resources_path, "template_wizard_final_state.e",   project_location + "/src", "wizard_final_state.e", l)

			copy_file ("wizard_information", 	"e",   project_location + "/src")
			copy_file ("project_wizard_shared",	"e",   project_location + "/src")
			copy_file ("eiffel_wizard_icon", 	"bmp", project_location + "/pixmaps")
			copy_file ("eiffel_wizard", 		"bmp", project_location + "/pixmaps")
		end

end -- class WIZARD_PROJECT_GENERATOR
