indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ASSEMBLY_DESCRIPTOR"

deferred external class
	ASSEMBLY_DESCRIPTOR

inherit
	HASHABLE

feature -- Basic Operations

	culture: STRING is
		external
			"IL deferred signature (): STRING use ASSEMBLY_DESCRIPTOR"
		alias
			"culture"
		end

	a_set_culture (culture2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use ASSEMBLY_DESCRIPTOR"
		alias
			"_set_culture"
		end

	make (a_name: STRING; a_version: STRING; a_culture: STRING; a_public_key: STRING) is
		external
			"IL deferred signature (STRING, STRING, STRING, STRING): System.Void use ASSEMBLY_DESCRIPTOR"
		alias
			"make"
		end

	version: STRING is
		external
			"IL deferred signature (): STRING use ASSEMBLY_DESCRIPTOR"
		alias
			"version"
		end

	make_empty is
		external
			"IL deferred signature (): System.Void use ASSEMBLY_DESCRIPTOR"
		alias
			"make_empty"
		end

	name: STRING is
		external
			"IL deferred signature (): STRING use ASSEMBLY_DESCRIPTOR"
		alias
			"name"
		end

	a_set_name (name2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use ASSEMBLY_DESCRIPTOR"
		alias
			"_set_name"
		end

	a_set_public_key (public_key2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use ASSEMBLY_DESCRIPTOR"
		alias
			"_set_public_key"
		end

	make_from_assembly (a_dot_net_assembly: ASSEMBLY) is
		external
			"IL deferred signature (System.Reflection.Assembly): System.Void use ASSEMBLY_DESCRIPTOR"
		alias
			"make_from_assembly"
		end

	public_key: STRING is
		external
			"IL deferred signature (): STRING use ASSEMBLY_DESCRIPTOR"
		alias
			"public_key"
		end

	a_set_version (version2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use ASSEMBLY_DESCRIPTOR"
		alias
			"_set_version"
		end

end -- class ASSEMBLY_DESCRIPTOR
