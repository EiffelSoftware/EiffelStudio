indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.AssemblyName"

external class
	SYSTEM_REFLECTION_ASSEMBLYNAME

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
	SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Reflection.AssemblyName"
		end

feature -- Access

	get_flags: INTEGER is
		external
			"IL signature (): enum System.Reflection.AssemblyNameFlags use System.Reflection.AssemblyName"
		alias
			"get_Flags"
		ensure
			valid_assembly_name_flags: Result = 0 or Result = 1
		end

	get_hash_algorithm: INTEGER is
		external
			"IL signature (): enum System.Configuration.Assemblies.AssemblyHashAlgorithm use System.Reflection.AssemblyName"
		alias
			"get_HashAlgorithm"
		ensure
			valid_assembly_hash_algorithm: Result = 0 or Result = 32771 or Result = 32772
		end

	get_version_compatibility: INTEGER is
		external
			"IL signature (): enum System.Configuration.Assemblies.AssemblyVersionCompatibility use System.Reflection.AssemblyName"
		alias
			"get_VersionCompatibility"
		ensure
			valid_assembly_version_compatibility: Result = 1 or Result = 2 or Result = 3
		end

	get_culture_info: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Reflection.AssemblyName"
		alias
			"get_CultureInfo"
		end

	get_key_pair: SYSTEM_REFLECTION_STRONGNAMEKEYPAIR is
		external
			"IL signature (): System.Reflection.StrongNameKeyPair use System.Reflection.AssemblyName"
		alias
			"get_KeyPair"
		end

	get_code_base: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyName"
		alias
			"get_CodeBase"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyName"
		alias
			"get_Name"
		end

	get_version: SYSTEM_VERSION is
		external
			"IL signature (): System.Version use System.Reflection.AssemblyName"
		alias
			"get_Version"
		end

	get_full_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyName"
		alias
			"get_FullName"
		end

feature -- Element Change

	set_version_compatibility (value: INTEGER) is
			-- Valid values for `value' are:
			-- SameMachine = 1
			-- SameProcess = 2
			-- SameDomain = 3
		require
			valid_assembly_version_compatibility: value = 1 or value = 2 or value = 3
		external
			"IL signature (enum System.Configuration.Assemblies.AssemblyVersionCompatibility): System.Void use System.Reflection.AssemblyName"
		alias
			"set_VersionCompatibility"
		end

	set_key_pair (value: SYSTEM_REFLECTION_STRONGNAMEKEYPAIR) is
		external
			"IL signature (System.Reflection.StrongNameKeyPair): System.Void use System.Reflection.AssemblyName"
		alias
			"set_KeyPair"
		end

	set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.AssemblyName"
		alias
			"set_Name"
		end

	set_flags (value: INTEGER) is
			-- Valid values for `value' are a combination of the following values:
			-- None = 0
			-- PublicKey = 1
		require
			valid_assembly_name_flags: (0 + 1) & value = 0 + 1
		external
			"IL signature (enum System.Reflection.AssemblyNameFlags): System.Void use System.Reflection.AssemblyName"
		alias
			"set_Flags"
		end

	set_version (value: SYSTEM_VERSION) is
		external
			"IL signature (System.Version): System.Void use System.Reflection.AssemblyName"
		alias
			"set_Version"
		end

	set_hash_algorithm (value: INTEGER) is
			-- Valid values for `value' are:
			-- None = 0
			-- MD5 = 32771
			-- SHA1 = 32772
		require
			valid_assembly_hash_algorithm: value = 0 or value = 32771 or value = 32772
		external
			"IL signature (enum System.Configuration.Assemblies.AssemblyHashAlgorithm): System.Void use System.Reflection.AssemblyName"
		alias
			"set_HashAlgorithm"
		end

	set_code_base (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.AssemblyName"
		alias
			"set_CodeBase"
		end

	set_culture_info (value: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL signature (System.Globalization.CultureInfo): System.Void use System.Reflection.AssemblyName"
		alias
			"set_CultureInfo"
		end

feature -- Basic Operations

	frozen set_public_key_token (publicKeyToken: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Reflection.AssemblyName"
		alias
			"SetPublicKeyToken"
		end

	frozen get_public_key: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Reflection.AssemblyName"
		alias
			"GetPublicKey"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.AssemblyName"
		alias
			"Equals"
		end

	frozen get_operating_systems: ARRAY [SYSTEM_OPERATINGSYSTEM] is
		external
			"IL signature (): System.OperatingSystem[] use System.Reflection.AssemblyName"
		alias
			"GetOperatingSystems"
		end

	frozen get_public_key_token: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Reflection.AssemblyName"
		alias
			"GetPublicKeyToken"
		end

	frozen get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Reflection.AssemblyName"
		alias
			"GetObjectData"
		end

	frozen set_processors (processor_ids: INTEGER) is
			-- Valid values for `processor_ids' are:
			-- INTEL_386 = 386
			-- INTEL_486 = 486
			-- INTEL_PENTIUM = 586
			-- MIPS_R4000 = 4000
			-- ALPHA_21064 = 21064
			-- PPC_601 = 601
			-- PPC_603 = 603
			-- PPC_604 = 604
			-- PPC_620 = 620
			-- HITACHI_SH3 = 10003
			-- HITACHI_SH3E = 10004
			-- HITACHI_SH4 = 10005
			-- MOTOROLA_821 = 821
			-- SHx_SH3 = 103
			-- SHx_SH4 = 104
			-- STRONGARM = 2577
			-- ARM720 = 1824
			-- ARM820 = 2080
			-- ARM920 = 2336
			-- ARM_7TDMI = 70001
		require
			valid_processor_id: processor_ids = 386 or processor_ids = 486 or processor_ids = 586 or processor_ids = 4000 or processor_ids = 21064 or processor_ids = 601 or processor_ids = 603 or processor_ids = 604 or processor_ids = 620 or processor_ids = 10003 or processor_ids = 10004 or processor_ids = 10005 or processor_ids = 821 or processor_ids = 103 or processor_ids = 104 or processor_ids = 2577 or processor_ids = 1824 or processor_ids = 2080 or processor_ids = 2336 or processor_ids = 70001
		external
			"IL signature (System.Configuration.Assemblies.ProcessorID[]): System.Void use System.Reflection.AssemblyName"
		alias
			"SetProcessors"
		end

	clone: ANY is
		external
			"IL signature (): System.Object use System.Reflection.AssemblyName"
		alias
			"Clone"
		end

	frozen set_operating_systems (operatingSystems: ARRAY [SYSTEM_OPERATINGSYSTEM]) is
		external
			"IL signature (System.OperatingSystem[]): System.Void use System.Reflection.AssemblyName"
		alias
			"SetOperatingSystems"
		end

	on_deserialization (sender: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Reflection.AssemblyName"
		alias
			"OnDeserialization"
		end

	frozen get_processors: INTEGER is
		external
			"IL signature (): System.Configuration.Assemblies.ProcessorID[] use System.Reflection.AssemblyName"
		alias
			"GetProcessors"
		end

	frozen set_public_key (publicKey: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Reflection.AssemblyName"
		alias
			"SetPublicKey"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyName"
		alias
			"ToString"
		end

	frozen get_assembly_name (assemblyFile: STRING): SYSTEM_REFLECTION_ASSEMBLYNAME is
		external
			"IL static signature (System.String): System.Reflection.AssemblyName use System.Reflection.AssemblyName"
		alias
			"GetAssemblyName"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.AssemblyName"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Reflection.AssemblyName"
		alias
			"Finalize"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYNAME
