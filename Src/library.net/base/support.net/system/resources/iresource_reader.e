indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Resources.IResourceReader"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IRESOURCE_READER

inherit
	IENUMERABLE
	IDISPOSABLE

feature -- Basic Operations

	get_enumerator_idictionary_enumerator: IDICTIONARY_ENUMERATOR is
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

end -- class IRESOURCE_READER
