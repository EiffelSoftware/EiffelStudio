indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PrinterSettings+PrinterResolutionCollection"

external class
	PRINTERRESOLUTIONCOLLECTION_IN_SYSTEM_DRAWING_PRINTING_PRINTERSETTINGS

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
			get_enumerator as system_collections_ienumerable_get_enumerator,
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_count as system_collections_icollection_get_count
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create
	make

feature {NONE} -- Initialization

	frozen make (array: ARRAY [SYSTEM_DRAWING_PRINTING_PRINTERRESOLUTION]) is
		external
			"IL creator signature (System.Drawing.Printing.PrinterResolution[]) use System.Drawing.Printing.PrinterSettings+PrinterResolutionCollection"
		end

feature -- Access

	get_item (index: INTEGER): SYSTEM_DRAWING_PRINTING_PRINTERRESOLUTION is
		external
			"IL signature (System.Int32): System.Drawing.Printing.PrinterResolution use System.Drawing.Printing.PrinterSettings+PrinterResolutionCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PrinterSettings+PrinterResolutionCollection"
		alias
			"get_Count"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PrinterSettings+PrinterResolutionCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Drawing.Printing.PrinterSettings+PrinterResolutionCollection"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PrinterSettings+PrinterResolutionCollection"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Printing.PrinterSettings+PrinterResolutionCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Drawing.Printing.PrinterSettings+PrinterResolutionCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Drawing.Printing.PrinterSettings+PrinterResolutionCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Printing.PrinterSettings+PrinterResolutionCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Printing.PrinterSettings+PrinterResolutionCollection"
		alias
			"Finalize"
		end

	frozen system_collections_icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PrinterSettings+PrinterResolutionCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen system_collections_ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Drawing.Printing.PrinterSettings+PrinterResolutionCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class PRINTERRESOLUTIONCOLLECTION_IN_SYSTEM_DRAWING_PRINTING_PRINTERSETTINGS
