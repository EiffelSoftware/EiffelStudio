indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Resources.IResourceReader"

deferred external class
	SYSTEM_RESOURCES_IRESOURCEREADER

inherit
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_IDISPOSABLE

feature -- Basic Operations

	get_dictionary_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		external
			"IL deferred signature (): System.Collections.IDictionaryEnumerator use System.Resources.IResourceReader"
		alias
			"GetEnumerator"
		end

	close is
		external
			"IL deferred signature (): System.Void use System.Resources.IResourceReader"
		alias
			"Close"
		end

end -- class SYSTEM_RESOURCES_IRESOURCEREADER
