indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "EiffelCreationRoutine"

external class
	EIFFEL_CREATION_ROUTINE

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (inf: CONSTRUCTOR_INFO) is
		external
			"IL creator signature (System.Reflection.ConstructorInfo) use EiffelCreationRoutine"
		end

	frozen make_1 (other: EIFFEL_CREATION_ROUTINE) is
		external
			"IL creator signature (EiffelCreationRoutine) use EiffelCreationRoutine"
		end

end -- class EIFFEL_CREATION_ROUTINE
