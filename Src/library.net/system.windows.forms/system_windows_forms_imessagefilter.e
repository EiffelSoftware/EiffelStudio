indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.IMessageFilter"

deferred external class
	SYSTEM_WINDOWS_FORMS_IMESSAGEFILTER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	pre_filter_message (m: SYSTEM_WINDOWS_FORMS_MESSAGE): BOOLEAN is
		external
			"IL deferred signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.IMessageFilter"
		alias
			"PreFilterMessage"
		end

end -- class SYSTEM_WINDOWS_FORMS_IMESSAGEFILTER
