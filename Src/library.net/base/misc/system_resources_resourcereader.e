indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Resources.ResourceReader"

frozen external class
	SYSTEM_RESOURCES_RESOURCEREADER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RESOURCES_IRESOURCEREADER
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			dispose as system_idisposable_dispose
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (file_name: STRING) is
		external
			"IL creator signature (System.String) use System.Resources.ResourceReader"
		end

	frozen make_1 (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Resources.ResourceReader"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Resources.ResourceReader"
		alias
			"GetHashCode"
		end

	frozen get_enumerator_idictionary_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Resources.ResourceReader"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Resources.ResourceReader"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Resources.ResourceReader"
		alias
			"Equals"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Resources.ResourceReader"
		alias
			"Close"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Resources.ResourceReader"
		alias
			"Finalize"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.Resources.ResourceReader"
		alias
			"System.IDisposable.Dispose"
		end

	frozen system_collections_ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Resources.ResourceReader"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_RESOURCES_RESOURCEREADER
