indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.ICollection"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICOLLECTION

inherit
	IENUMERABLE

feature -- Access

	get_is_synchronized: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Collections.ICollection"
		alias
			"get_IsSynchronized"
		end

	get_sync_root: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.Collections.ICollection"
		alias
			"get_SyncRoot"
		end

	get_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Collections.ICollection"
		alias
			"get_Count"
		end

feature -- Basic Operations

	copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL deferred signature (System.Array, System.Int32): System.Void use System.Collections.ICollection"
		alias
			"CopyTo"
		end

end -- class ICOLLECTION
