indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeObject"

external class
	SYSTEM_CODEDOM_CODEOBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.CodeDom.CodeObject"
		end

feature -- Access

	frozen get_user_data: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.CodeDom.CodeObject"
		alias
			"get_UserData"
		end

end -- class SYSTEM_CODEDOM_CODEOBJECT
