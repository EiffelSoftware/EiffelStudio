note
	description	: "System's root class"

class
	CLASS_STRUCTURE_EDITOR

inherit
	ARGUMENTS

	STRING_HANDLER

	KL_SHARED_EXECUTION_ENVIRONMENT

create
	make,
	make_with_filename

feature {NONE} -- Initialization

	make
		do
			initialize
			execute
		end

	make_with_filename (fn: STRING)
		do
			initialize
			class_structure.get_structure (fn)
			class_structure.display_structure (class_structure.structure)
		end

	initialize
		do
			create class_structure.make
		end

	class_structure: EIFFEL_CLASS_STRUCTURE

feature {NONE} -- File discovering and processing

	execute
			-- Process all files under directories specified on the command line arguments.
		local
			i: INTEGER
			l_filename: STRING
			f: RAW_FILE
		do
			if argument_count < 1 then
				io.error.put_string ("Specify a eiffel class file.")
				io.error.put_new_line
			else
				i := 1
				l_filename := Execution_environment.interpreted_string (argument (i))
				create f.make (l_filename)
				if f.exists then
					class_structure.get_structure (l_filename)
					class_structure.display_structure
				end
			end
		end

invariant
	class_structure_attached: class_structure /= Void

end
