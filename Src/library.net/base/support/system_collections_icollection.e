indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Collections.ICollection"

deferred external class
	SYSTEM_COLLECTIONS_ICOLLECTION

inherit
	SYSTEM_COLLECTIONS_IENUMERABLE

feature -- Access

	get_sync_root: ANY is
		external
			"IL deferred signature (): System.Object use System.Collections.ICollection"
		alias
			"get_SyncRoot"
		end

	get_is_synchronized: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Collections.ICollection"
		alias
			"get_IsSynchronized"
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

end -- class SYSTEM_COLLECTIONS_ICOLLECTION
