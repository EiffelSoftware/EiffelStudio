indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ISynchronizeInvoke"

deferred external class
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
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

	begin_invoke (method: SYSTEM_DELEGATE; args: ARRAY [ANY]): SYSTEM_IASYNCRESULT is
		external
			"IL deferred signature (System.Delegate, System.Object[]): System.IAsyncResult use System.ComponentModel.ISynchronizeInvoke"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): ANY is
		external
			"IL deferred signature (System.IAsyncResult): System.Object use System.ComponentModel.ISynchronizeInvoke"
		alias
			"EndInvoke"
		end

	invoke (method: SYSTEM_DELEGATE; args: ARRAY [ANY]): ANY is
		external
			"IL deferred signature (System.Delegate, System.Object[]): System.Object use System.ComponentModel.ISynchronizeInvoke"
		alias
			"Invoke"
		end

end -- class SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
