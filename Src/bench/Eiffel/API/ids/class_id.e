-- Class ids.

class CLASS_ID

inherit

	COMPILER_ID
		export
			{COMPILER_EXPORTER} all;
			{ANY} is_equal;
			{CLASS_C_SERVER} internal_id, compilation_id
		end

creation

	make

feature {COMPILER_EXPORTER} -- Access

	packet_number: INTEGER is
			-- Packet in which the file for the corresponding 
			-- class will be generated
		do
			if System.in_final_mode then
				Result := id // System.makefile_generator.Packet_number + 1
			else
				Result :=
					internal_id // System.makefile_generator.Packet_number + 1
			end
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
		do
			Result := System.class_counter.item (compilation_id)
		end

end -- class CLASS_ID
