indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ListChangedEventArgs"

external class
	SYSTEM_COMPONENTMODEL_LISTCHANGEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_listchangedeventargs_1,
	make_listchangedeventargs_2,
	make_listchangedeventargs

feature {NONE} -- Initialization

	frozen make_listchangedeventargs_1 (list_changed_type: SYSTEM_COMPONENTMODEL_LISTCHANGEDTYPE; prop_desc: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR) is
		external
			"IL creator signature (System.ComponentModel.ListChangedType, System.ComponentModel.PropertyDescriptor) use System.ComponentModel.ListChangedEventArgs"
		end

	frozen make_listchangedeventargs_2 (list_changed_type: SYSTEM_COMPONENTMODEL_LISTCHANGEDTYPE; new_index: INTEGER; old_index: INTEGER) is
		external
			"IL creator signature (System.ComponentModel.ListChangedType, System.Int32, System.Int32) use System.ComponentModel.ListChangedEventArgs"
		end

	frozen make_listchangedeventargs (list_changed_type: SYSTEM_COMPONENTMODEL_LISTCHANGEDTYPE; new_index: INTEGER) is
		external
			"IL creator signature (System.ComponentModel.ListChangedType, System.Int32) use System.ComponentModel.ListChangedEventArgs"
		end

feature -- Access

	frozen get_new_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ListChangedEventArgs"
		alias
			"get_NewIndex"
		end

	frozen get_list_changed_type: SYSTEM_COMPONENTMODEL_LISTCHANGEDTYPE is
		external
			"IL signature (): System.ComponentModel.ListChangedType use System.ComponentModel.ListChangedEventArgs"
		alias
			"get_ListChangedType"
		end

	frozen get_old_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ListChangedEventArgs"
		alias
			"get_OldIndex"
		end

end -- class SYSTEM_COMPONENTMODEL_LISTCHANGEDEVENTARGS
