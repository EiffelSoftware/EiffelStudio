indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Policy.Evidence"

frozen external class
	SYSTEM_SECURITY_POLICY_EVIDENCE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_COLLECTIONS_IENUMERABLE

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (host_evidence: ARRAY [ANY]; assembly_evidence: ARRAY [ANY]) is
		external
			"IL creator signature (System.Object[], System.Object[]) use System.Security.Policy.Evidence"
		end

	frozen make is
		external
			"IL creator use System.Security.Policy.Evidence"
		end

	frozen make_1 (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE) is
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

	frozen get_sync_root: ANY is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.Evidence"
		alias
			"ToString"
		end

	frozen get_host_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
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

	frozen add_host (id: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Security.Policy.Evidence"
		alias
			"AddHost"
		end

	frozen merge (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE) is
		external
			"IL signature (System.Security.Policy.Evidence): System.Void use System.Security.Policy.Evidence"
		alias
			"Merge"
		end

	frozen get_assembly_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Security.Policy.Evidence"
		alias
			"GetAssemblyEnumerator"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.Evidence"
		alias
			"Equals"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Security.Policy.Evidence"
		alias
			"GetEnumerator"
		end

	frozen add_assembly (id: ANY) is
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

end -- class SYSTEM_SECURITY_POLICY_EVIDENCE
