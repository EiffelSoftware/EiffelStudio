indexing
	description: "Class identifiers."
	date: "$Date$"
	revision: "$Revision $"

class
	CLASS_ID

inherit
	COMPILER_ID
		export
			{COMPILER_EXPORTER} all
			{ANY} is_equal
			{CLASS_C_SERVER} internal_id, compilation_id
		end

creation
	make

feature -- Access

	is_valid: BOOLEAN is
			-- Is the Id valid (i.e is it within the array class range)?
		do
			Result := internal_id > 0 and then internal_id <= class_array.count
		end

	associated_eclass: CLASS_C is
			-- Class associated with current id
		require
			is_valid: is_valid
		do
			Result := class_array.item (internal_id)
		end

feature {COMPILER_EXPORTER} -- Access

	packet_number: INTEGER is
			-- Packet in which the file for the corresponding 
			-- class will be generated
		do
			if System.in_final_mode then
				Result := id // System.makefile_generator.Packet_number + 1
			else
				Result := internal_id // System.makefile_generator.Packet_number + 1
			end
		end

	generated_id (f: INDENT_FILE) is
			-- Generate textual representation of class id
			-- in generated C code
		do
			f.putint (id)
		end

	associated_class: CLASS_C is
			-- Class associated with current id
		do
			Result := class_array.item (internal_id)
		end

feature {COMPILER_EXPORTER} -- Status report

	protected: BOOLEAN is
			-- Is the class associated with id protected?
			-- Protected classes are GENERAL, ANY, DOUBLE, REAL,
			-- INTEGER, BOOLEAN, CHARACTER, ARRAY, BIT, POINTER, STRING
		do
		end

feature {NONE} -- Implementation

	counter: CLASS_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Class_counter.item (Normal_compilation)
		end

	class_array: ARRAY [CLASS_C] is
			-- Classes compiled during compilation `compilation_id'
		once
			Result := System.classes.item (Normal_compilation)
		end

end -- class CLASS_ID
