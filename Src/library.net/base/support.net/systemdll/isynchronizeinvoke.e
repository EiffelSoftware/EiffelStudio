indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.ComponentModel.ISynchronizeInvoke"
	assembly: "System", "1.0.3200.0", "neutral", "b77a5c561934e089"

deferred external class
	ISYNCHRONIZEINVOKE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_invoke_required: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.ISynchronizeInvoke"
		alias
			"get_InvokeRequired"
		end

feature -- Basic Operations

	begin_invoke (method: DELEGATE; args: NATIVE_ARRAY [ANY]): IASYNC_RESULT is
		external
			"IL deferred signature (System.Delegate, System.Object[]): System.IAsyncResult use System.ComponentModel.ISynchronizeInvoke"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): ANY is
		external
			"IL deferred signature (System.IAsyncResult): System.Object use System.ComponentModel.ISynchronizeInvoke"
		alias
			"EndInvoke"
		end

	invoke (method: DELEGATE; args: NATIVE_ARRAY [ANY]): ANY is
		external
			"IL deferred signature (System.Delegate, System.Object[]): System.Object use System.ComponentModel.ISynchronizeInvoke"
		alias
			"Invoke"
		end

end -- class ISYNCHRONIZEINVOKE
