indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "GLOBAL_CONVERSATION_ANY"

deferred external class
	GLOBAL_CONVERSATION_ANY

feature -- Basic Operations

	to_eiffel_linked_list (a_list: ARRAY_LIST): LINKED_LIST_ANY is
		external
			"IL deferred signature (System.Collections.ArrayList): LINKED_LIST_ANY use GLOBAL_CONVERSATION_ANY"
		alias
			"to_eiffel_linked_list"
		end

	from_eiffel_linked_list (a_list: LINKED_LIST_ANY): ARRAY_LIST is
		external
			"IL deferred signature (LINKED_LIST_ANY): System.Collections.ArrayList use GLOBAL_CONVERSATION_ANY"
		alias
			"from_eiffel_linked_list"
		end

	to_eiffel_string (string: SYSTEM_STRING): STRING is
		external
			"IL deferred signature (System.String): STRING use GLOBAL_CONVERSATION_ANY"
		alias
			"to_eiffel_string"
		end

	from_eiffel_string (string: STRING): SYSTEM_STRING is
		external
			"IL deferred signature (STRING): System.String use GLOBAL_CONVERSATION_ANY"
		alias
			"from_eiffel_string"
		end

end -- class GLOBAL_CONVERSATION_ANY
