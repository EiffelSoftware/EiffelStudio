indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.IListSource"

deferred external class
	SYSTEM_COMPONENTMODEL_ILISTSOURCE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_contains_list_collection: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.IListSource"
		alias
			"get_ContainsListCollection"
		end

feature -- Basic Operations

	get_list: SYSTEM_COLLECTIONS_ILIST is
		external
			"IL deferred signature (): System.Collections.IList use System.ComponentModel.IListSource"
		alias
			"GetList"
		end

end -- class SYSTEM_COMPONENTMODEL_ILISTSOURCE
