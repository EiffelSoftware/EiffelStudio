indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.Evidence"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	EVIDENCE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICOLLECTION
	IENUMERABLE

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (host_evidence: NATIVE_ARRAY [SYSTEM_OBJECT]; assembly_evidence: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL creator signature (System.Object[], System.Object[]) use System.Security.Policy.Evidence"
		end

	frozen make is
		external
			"IL creator use System.Security.Policy.Evidence"
		end

	frozen make_1 (evidence: EVIDENCE) is
		external
			"IL creator signature (System.Security.Policy.Evidence) use System.Security.Policy.Evidence"
		end

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Policy.Evidence"
		alias
			"get_IsSynchronized"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Security.Policy.Evidence"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Policy.Evidence"
		alias
			"get_Count"
		end

	frozen get_locked: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Policy.Evidence"
		alias
			"get_Locked"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Policy.Evidence"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	frozen set_locked (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Policy.Evidence"
		alias
			"set_Locked"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.Evidence"
		alias
			"ToString"
		end

	frozen get_host_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Security.Policy.Evidence"
		alias
			"GetHostEnumerator"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Security.Policy.Evidence"
		alias
			"CopyTo"
		end

	frozen add_host (id: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Security.Policy.Evidence"
		alias
			"AddHost"
		end

	frozen merge (evidence: EVIDENCE) is
		external
			"IL signature (System.Security.Policy.Evidence): System.Void use System.Security.Policy.Evidence"
		alias
			"Merge"
		end

	frozen get_assembly_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Security.Policy.Evidence"
		alias
			"GetAssemblyEnumerator"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.Evidence"
		alias
			"Equals"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Security.Policy.Evidence"
		alias
			"GetEnumerator"
		end

	frozen add_assembly (id: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Security.Policy.Evidence"
		alias
			"AddAssembly"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Policy.Evidence"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Policy.Evidence"
		alias
			"Finalize"
		end

end -- class EVIDENCE
