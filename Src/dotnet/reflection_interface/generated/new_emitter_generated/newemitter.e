indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "NewEmitter"

external class
	NEWEMITTER

inherit
	NEWGLOBALS

create
	make_newemitter

feature {NONE} -- Initialization

	frozen make_newemitter is
		external
			"IL creator use NewEmitter"
		end

feature -- Basic Operations

	PrepareEmitFromAssembly (assembly: SYSTEM_REFLECTION_ASSEMBLY) is
		external
			"IL signature (System.Reflection.Assembly): System.Void use NewEmitter"
		alias
			"PrepareEmitFromAssembly"
		end

	PrepareEmitFromFilename (FileName: STRING) is
		external
			"IL signature (System.String): System.Void use NewEmitter"
		alias
			"PrepareEmitFromFilename"
		end

feature {NONE} -- Implementation

	LoadExternalAssemblies (assembly: SYSTEM_REFLECTION_ASSEMBLY): SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (System.Reflection.Assembly): System.Collections.ArrayList use NewEmitter"
		alias
			"LoadExternalAssemblies"
		end

end -- class NEWEMITTER
