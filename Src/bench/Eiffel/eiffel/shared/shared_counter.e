class SHARED_COUNTER

inherit

	SHARED_WORKBENCH

feature {NONE} -- Counters

	Class_counter: CLASS_COUNTER is
			-- Counter of classes
		once
			Result := System.class_counter
		end

	Routine_id_counter: ROUTINE_COUNTER is
			-- Counter for routine ids
		once
			Result := System.routine_id_counter
		end
	
	Static_type_id_counter: TYPE_COUNTER is
			-- Counter of instances of CLASS_TYPE
		once
			Result := System.static_type_id_counter
		end

	Body_index_counter: BODY_INDEX_COUNTER is
			-- Body index counter
		once
			Result := System.body_index_counter
		end

	Feature_as_counter: COMPILER_COUNTER is
			-- Counter of instances of FEATURE_AS
		once
			Result := System.feature_as_counter
		end

	Real_body_id_counter: REAL_BODY_ID_COUNTER is
			-- Counter for real body id
		once
			Result := System.execution_table.counter
		end

	File_counter: FILE_COUNTER is
			-- Counter for server file id
		once
			Result := System.server_controler.file_counter
		end

	Pattern_id_counter: COMPILER_COUNTER is
			-- Counter for pattern id
		once
			Result := System.pattern_table.pattern_id_counter
		end

	Invalid_index: INTEGER is 65535
			-- Invalid real body index used to mark
			-- empty invariants (max uint16)

end -- class SHARED_COUNTER
