indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.PropertyChangedEventArgs"

external class
	SYSTEM_COMPONENTMODEL_PROPERTYCHANGEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_propertychangedeventargs

feature {NONE} -- Initialization

	frozen make_propertychangedeventargs (property_name: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.PropertyChangedEventArgs"
		end

feature -- Access

	get_property_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.PropertyChangedEventArgs"
		alias
			"get_PropertyName"
		end

end -- class SYSTEM_COMPONENTMODEL_PROPERTYCHANGEDEVENTARGS
