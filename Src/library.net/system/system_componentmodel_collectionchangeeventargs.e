indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.CollectionChangeEventArgs"

external class
	SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_collectionchangeeventargs

feature {NONE} -- Initialization

	frozen make_collectionchangeeventargs (action: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEACTION; element: ANY) is
		external
			"IL creator signature (System.ComponentModel.CollectionChangeAction, System.Object) use System.ComponentModel.CollectionChangeEventArgs"
		end

feature -- Access

	get_element: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.CollectionChangeEventArgs"
		alias
			"get_Element"
		end

	get_action: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEACTION is
		external
			"IL signature (): System.ComponentModel.CollectionChangeAction use System.ComponentModel.CollectionChangeEventArgs"
		alias
			"get_Action"
		end

end -- class SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS
