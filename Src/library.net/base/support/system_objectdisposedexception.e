indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ObjectDisposedException"

external class
	SYSTEM_OBJECTDISPOSEDEXCEPTION

inherit
	SYSTEM_INVALIDOPERATIONEXCEPTION
		redefine
			get_message
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_objectdisposedexception,
	make_objectdisposedexception_1

feature {NONE} -- Initialization

	frozen make_objectdisposedexception (object_name: STRING) is
		external
			"IL creator signature (System.String) use System.ObjectDisposedException"
		end

	frozen make_objectdisposedexception_1 (object_name: STRING; message: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ObjectDisposedException"
		end

feature -- Access

	frozen get_object_name: STRING is
		external
			"IL signature (): System.String use System.ObjectDisposedException"
		alias
			"get_ObjectName"
		end

	get_message: STRING is
		external
			"IL signature (): System.String use System.ObjectDisposedException"
		alias
			"get_Message"
		end

end -- class SYSTEM_OBJECTDISPOSEDEXCEPTION
