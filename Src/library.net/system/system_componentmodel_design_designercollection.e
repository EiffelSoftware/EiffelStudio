indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.DesignerCollection"

external class
	SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERCOLLECTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as ienumerable_get_enumerator,
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_count as icollection_get_count
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as ienumerable_get_enumerator
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (designers: ARRAY [SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST]) is
		external
			"IL creator signature (System.ComponentModel.Design.IDesignerHost[]) use System.ComponentModel.Design.DesignerCollection"
		end

	frozen make_1 (designers: SYSTEM_COLLECTIONS_ILIST) is
		external
			"IL creator signature (System.Collections.IList) use System.ComponentModel.Design.DesignerCollection"
		end

feature -- Access

	get_item (index: INTEGER): SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST is
		external
			"IL signature (System.Int32): System.ComponentModel.Design.IDesignerHost use System.ComponentModel.Design.DesignerCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.Design.DesignerCollection"
		alias
			"get_Count"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.Design.DesignerCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.ComponentModel.Design.DesignerCollection"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.DesignerCollection"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.Design.DesignerCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.ComponentModel.Design.DesignerCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.DesignerCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.Design.DesignerCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	finalize is
		external
			"IL signature (): System.Void use System.ComponentModel.Design.DesignerCollection"
		alias
			"Finalize"
		end

	frozen icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.Design.DesignerCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.ComponentModel.Design.DesignerCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERCOLLECTION
