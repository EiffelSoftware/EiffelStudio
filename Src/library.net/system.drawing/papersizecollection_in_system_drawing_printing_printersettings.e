indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PrinterSettings+PaperSizeCollection"

external class
	PAPERSIZECOLLECTION_IN_SYSTEM_DRAWING_PRINTING_PRINTERSETTINGS

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
	make

feature {NONE} -- Initialization

	frozen make (array: ARRAY [SYSTEM_DRAWING_PRINTING_PAPERSIZE]) is
		external
			"IL creator signature (System.Drawing.Printing.PaperSize[]) use System.Drawing.Printing.PrinterSettings+PaperSizeCollection"
		end

feature -- Access

	get_item (index: INTEGER): SYSTEM_DRAWING_PRINTING_PAPERSIZE is
		external
			"IL signature (System.Int32): System.Drawing.Printing.PaperSize use System.Drawing.Printing.PrinterSettings+PaperSizeCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PrinterSettings+PaperSizeCollection"
		alias
			"get_Count"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PrinterSettings+PaperSizeCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Drawing.Printing.PrinterSettings+PaperSizeCollection"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.PrinterSettings+PaperSizeCollection"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Printing.PrinterSettings+PaperSizeCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Drawing.Printing.PrinterSettings+PaperSizeCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Drawing.Printing.PrinterSettings+PaperSizeCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Printing.PrinterSettings+PaperSizeCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Printing.PrinterSettings+PaperSizeCollection"
		alias
			"Finalize"
		end

	frozen icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.PrinterSettings+PaperSizeCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Drawing.Printing.PrinterSettings+PaperSizeCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class PAPERSIZECOLLECTION_IN_SYSTEM_DRAWING_PRINTING_PRINTERSETTINGS
