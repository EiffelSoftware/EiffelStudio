indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DOTNET_EXCEPTION_WAPPER

feature {NONE} -- Initialization

	make_dotnet_exception (a_dotnet_exception: NATIVE_EXCEPTION) is
			-- Set `dotnet_exception' with `a_dotnet_exception'
		require
			a_dotnet_exception_not_void: a_dotnet_exception /= Void
		do
			default_create
			dotnet_exception := a_dotnet_exception
		ensure
			dotnet_exception_set: dotnet_exception = a_dotnet_exception
		end

feature -- Access

	get_base_exception: NATIVE_EXCEPTION is
			-- {SYSTEM_EXCEPTION}.get_base_exception
		do
			if dotnet_exception /= Void then
				Result := dotnet_exception.get_base_exception
			else
				Result := local_get_base_exception
			end
		end

	local_get_base_exception: NATIVE_EXCEPTION is
			-- get_base_exception of local exception
		deferred
		end

	source: SYSTEM_STRING is
			-- {SYSTEM_EXCEPTION}.source
		do
			if dotnet_exception /= Void then
				Result := dotnet_exception.source
			else
				Result := local_source
			end
		end

	local_source: SYSTEM_STRING is
			-- source of local exception
		deferred
		end

	stack_trace: SYSTEM_STRING is
			-- {SYSTEM_EXCEPTION}.stack_trace
		do
			if dotnet_exception /= Void then
				Result := dotnet_exception.stack_trace
			else
				Result := local_stack_trace
			end
		end

	local_stack_trace: SYSTEM_STRING is
			-- stack_trace of local exception
		deferred
		end

feature -- Status setting

	set_source (value: SYSTEM_STRING) is
			-- {SYSTEM_EXCEPTION}.set_source
		do
			if dotnet_exception /= Void then
				dotnet_exception.set_source (value)
			else
				local_set_source (value)
			end
		end

	local_set_source (value: SYSTEM_STRING) is
			-- set_source of local exception
		deferred
		end

feature -- Access

	dotnet_exception: NATIVE_EXCEPTION
			-- .NET exception

invariant
	dotnet_exception_not_void: dotnet_exception /= Void

end
