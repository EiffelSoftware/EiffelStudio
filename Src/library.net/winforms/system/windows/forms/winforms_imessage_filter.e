indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.IMessageFilter"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_IMESSAGE_FILTER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	pre_filter_message (m: WINFORMS_MESSAGE): BOOLEAN is
		external
			"IL deferred signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.IMessageFilter"
		alias
			"PreFilterMessage"
		end

end -- class WINFORMS_IMESSAGE_FILTER
