indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DomainUpDown+DomainUpDownItemCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DOMAIN_UP_DOWN_ITEM_COLLECTION_IN_WINFORMS_DOMAIN_UP_DOWN

inherit
	ARRAY_LIST
		redefine
			remove_at,
			remove,
			insert,
			add,
			set_item,
			get_item
		end
	ILIST
		rename
			copy_to as copy_to_array_int32
		end
	ICOLLECTION
		rename
			copy_to as copy_to_array_int32
		end
	IENUMERABLE
	ICLONEABLE

create {NONE}

feature -- Access

	get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.DomainUpDown+DomainUpDownItemCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.DomainUpDown+DomainUpDownItemCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	remove_at (item: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DomainUpDown+DomainUpDownItemCollection"
		alias
			"RemoveAt"
		end

	add (item: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.DomainUpDown+DomainUpDownItemCollection"
		alias
			"Add"
		end

	remove (item: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.DomainUpDown+DomainUpDownItemCollection"
		alias
			"Remove"
		end

	insert (index: INTEGER; item: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.DomainUpDown+DomainUpDownItemCollection"
		alias
			"Insert"
		end

end -- class WINFORMS_DOMAIN_UP_DOWN_ITEM_COLLECTION_IN_WINFORMS_DOMAIN_UP_DOWN
