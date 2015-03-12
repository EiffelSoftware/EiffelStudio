note
	description	: "System's root class"

class
	CLASS_STRUCTURE_EDITOR

inherit
	ARGUMENTS_32

	STRING_HANDLER

create
	make,
	make_with_filename,
	make_with_path

feature {NONE} -- Initialization

	make
		do
			initialize
			execute
		end

	make_with_filename (fn: STRING)
		do
			make_with_path (create {PATH}.make_from_string (fn))
		end

	make_with_path (p: PATH)
		do
			initialize
			class_structure.get_structure (p)
			class_structure.display_structure
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
			l_filename: STRING_32
			f: RAW_FILE
		do
			if argument_count < 1 then
				io.error.put_string ("Specify a eiffel class file.")
				io.error.put_new_line
			else
				i := 1
				l_filename := (create {ENV_INTERP}).interpreted_string_32 (argument (i))
				create f.make_with_name (l_filename)
				if f.exists then
					class_structure.get_structure (f.path)
					class_structure.display_structure
				end
			end
		end

invariant
	class_structure_attached: class_structure /= Void

end
