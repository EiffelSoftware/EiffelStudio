indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "Emitter"
	assembly: "ISE.Reflection.Emitter", "1.0.0.62252", "neutral", "30914072a1caac"

external class
	EMITTER

inherit
	GLOBALS

create
	make_emitter

feature {NONE} -- Initialization

	frozen make_emitter is
		external
			"IL creator use Emitter"
		end

feature -- Basic Operations

	prepare_emit_from_assembly (assembly: SYSTEM_REFLECTION_ASSEMBLY) is
		external
			"IL signature (System.Reflection.Assembly): System.Void use Emitter"
		alias
			"PrepareEmitFromAssembly"
		end

	prepare_emit_from_filename (file_name: STRING) is
		external
			"IL signature (System.String): System.Void use Emitter"
		alias
			"PrepareEmitFromFilename"
		end

feature {NONE} -- Implementation

	load_external_assemblies (assembly: SYSTEM_REFLECTION_ASSEMBLY): SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (System.Reflection.Assembly): System.Collections.ArrayList use Emitter"
		alias
			"LoadExternalAssemblies"
		end

end -- class EMITTER
