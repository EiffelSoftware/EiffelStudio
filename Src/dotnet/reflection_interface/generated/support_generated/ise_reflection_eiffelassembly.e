indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "ISE.Reflection.EiffelAssembly"

external class
	ISE_REFLECTION_EIFFELASSEMBLY

inherit
	ISE_REFLECTION_SUPPORT

create
	make_eiffelassembly

feature {NONE} -- Initialization

	frozen make_eiffelassembly is
		external
			"IL creator use ISE.Reflection.EiffelAssembly"
		end

feature -- Access

	frozen EmitterVersionNumber: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"EmitterVersionNumber"
		end

	frozen AssemblyDescriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		external
			"IL field signature :ISE.Reflection.AssemblyDescriptor use ISE.Reflection.EiffelAssembly"
		alias
			"AssemblyDescriptor"
		end

	frozen EiffelClusterPath: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"EiffelClusterPath"
		end

	frozen XmlElements: ISE_REFLECTION_XMLELEMENTS is
		external
			"IL field signature :ISE.Reflection.XmlElements use ISE.Reflection.EiffelAssembly"
		alias
			"XmlElements"
		end

feature -- Basic Operations

	Make (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; a_path: STRING; a_number: STRING) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor, System.String, System.String): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"Make"
		end

	Types: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.EiffelAssembly"
		alias
			"Types"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"_invariant"
		end

	TypesRetrievalFailed: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelAssembly"
		alias
			"TypesRetrievalFailed"
		end

	TypesRetrievalFailedMessage: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelAssembly"
		alias
			"TypesRetrievalFailedMessage"
		end

end -- class ISE_REFLECTION_EIFFELASSEMBLY
