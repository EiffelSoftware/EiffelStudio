indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DomainUpDown+DomainUpDownItemCollection"

external class
	DOMAINUPDOWNITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_DOMAINUPDOWN

inherit
	SYSTEM_COLLECTIONS_ILIST
		rename
			copy_to as copy_to_array_int32
		end
	SYSTEM_ICLONEABLE
	SYSTEM_COLLECTIONS_ARRAYLIST
		redefine
			remove_at,
			remove,
			insert,
			add,
			set_item,
			get_item
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as copy_to_array_int32
		end

create {NONE}

feature -- Access

	get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.DomainUpDown+DomainUpDownItemCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	set_item (index: INTEGER; value: ANY) is
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

	add (item: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.DomainUpDown+DomainUpDownItemCollection"
		alias
			"Add"
		end

	remove (item: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.DomainUpDown+DomainUpDownItemCollection"
		alias
			"Remove"
		end

	insert (index: INTEGER; item: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.DomainUpDown+DomainUpDownItemCollection"
		alias
			"Insert"
		end

end -- class DOMAINUPDOWNITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_DOMAINUPDOWN
