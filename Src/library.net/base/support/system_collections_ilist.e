indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Collections.IList"

deferred external class
	SYSTEM_COLLECTIONS_ILIST

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_COLLECTIONS_IENUMERABLE

feature -- Access

	get_is_read_only: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Collections.IList"
		alias
			"get_IsReadOnly"
		end

	get_is_fixed_size: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Collections.IList"
		alias
			"get_IsFixedSize"
		end

	get_item (index: INTEGER): ANY is
		external
			"IL deferred signature (System.Int32): System.Object use System.Collections.IList"
		alias
			"get_Item"
		end

feature -- Element Change

	put_i_th (index: INTEGER; value: ANY) is
		external
			"IL deferred signature (System.Int32, System.Object): System.Void use System.Collections.IList"
		alias
			"set_Item"
		end

feature -- Basic Operations

	clear is
		external
			"IL deferred signature (): System.Void use System.Collections.IList"
		alias
			"Clear"
		end

	index_of (value: ANY): INTEGER is
		external
			"IL deferred signature (System.Object): System.Int32 use System.Collections.IList"
		alias
			"IndexOf"
		end

	extend (value: ANY): INTEGER is
		external
			"IL deferred signature (System.Object): System.Int32 use System.Collections.IList"
		alias
			"Add"
		end

	insert (index: INTEGER; value: ANY) is
		external
			"IL deferred signature (System.Int32, System.Object): System.Void use System.Collections.IList"
		alias
			"Insert"
		end

	has (value: ANY): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.Collections.IList"
		alias
			"Contains"
		end

	prune_i_th (index: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Collections.IList"
		alias
			"RemoveAt"
		end

	remove (value: ANY) is
		external
			"IL deferred signature (System.Object): System.Void use System.Collections.IList"
		alias
			"Remove"
		end

end -- class SYSTEM_COLLECTIONS_ILIST
