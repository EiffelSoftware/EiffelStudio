indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.IList"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ILIST

inherit
	ICOLLECTION
	IENUMERABLE

feature -- Access

	get_is_fixed_size: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Collections.IList"
		alias
			"get_IsFixedSize"
		end

	get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Int32): System.Object use System.Collections.IList"
		alias
			"get_Item"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Collections.IList"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Int32, System.Object): System.Void use System.Collections.IList"
		alias
			"set_Item"
		end

feature -- Basic Operations

	contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.Collections.IList"
		alias
			"Contains"
		end

	index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL deferred signature (System.Object): System.Int32 use System.Collections.IList"
		alias
			"IndexOf"
		end

	remove_at (index: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Collections.IList"
		alias
			"RemoveAt"
		end

	add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL deferred signature (System.Object): System.Int32 use System.Collections.IList"
		alias
			"Add"
		end

	clear is
		external
			"IL deferred signature (): System.Void use System.Collections.IList"
		alias
			"Clear"
		end

	remove (value: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use System.Collections.IList"
		alias
			"Remove"
		end

	insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Int32, System.Object): System.Void use System.Collections.IList"
		alias
			"Insert"
		end

end -- class ILIST
