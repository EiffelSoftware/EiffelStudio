-- DC-set class Ids

class DLE_CLASS_ID

inherit

	DLE_COMPILER_ID;
	CLASS_ID
		undefine
			is_dynamic, compilation_id
		redefine
			packet_number, counter, class_array
		end

creation

	make

feature -- Access

	packet_number: INTEGER is
			-- Packet in which the file for the corresponding
			-- class will be generated
		do
			Result := internal_id // System.makefile_generator.Packet_number + 1
		end

feature {NONE} -- Implementation

	counter: CLASS_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Class_counter.item (Dle_compilation)
		end

	class_array: ARRAY [CLASS_C] is
			-- Classes compiled during compilation `compilation_id'
		once
			Result := System.classes.item (Dle_compilation)
		end

end -- class DLE_CLASS_ID
