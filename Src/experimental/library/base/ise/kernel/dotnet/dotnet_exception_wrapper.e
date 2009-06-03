note
	description: "Ancestor of all exception classes to adapt .NET exceptions to Eiffel ones."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DOTNET_EXCEPTION_WRAPPER

feature {NONE} -- Initialization

	make_dotnet_exception (a_dotnet_exception: NATIVE_EXCEPTION)
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

	get_base_exception: detachable NATIVE_EXCEPTION
			-- {SYSTEM_EXCEPTION}.get_base_exception
		do
			if attached dotnet_exception as l_dotnet_exception then
				Result := l_dotnet_exception.get_base_exception
			else
				Result := local_get_base_exception
			end
		end

	local_get_base_exception: detachable NATIVE_EXCEPTION
			-- get_base_exception of local exception
		deferred
		end

	source: detachable SYSTEM_STRING
			-- {SYSTEM_EXCEPTION}.source
		do
			if attached dotnet_exception as l_dotnet_exception then
				Result := l_dotnet_exception.source
			else
				Result := local_source
			end
		end

	local_source: detachable SYSTEM_STRING
			-- source of local exception
		deferred
		end

	stack_trace: detachable SYSTEM_STRING
			-- {SYSTEM_EXCEPTION}.stack_trace
		do
			if attached dotnet_exception as l_dotnet_exception then
				Result := l_dotnet_exception.stack_trace
			else
				Result := local_stack_trace
			end
		end

	local_stack_trace: detachable SYSTEM_STRING
			-- stack_trace of local exception
		deferred
		end

feature -- Status setting

	set_source (value: SYSTEM_STRING)
			-- {SYSTEM_EXCEPTION}.set_source
		do
			if attached dotnet_exception as l_dotnet_exception then
				l_dotnet_exception.set_source (value)
			else
				local_set_source (value)
			end
		end

	local_set_source (value: like local_source)
			-- set_source of local exception
		deferred
		end

feature -- Access

	dotnet_exception: detachable NATIVE_EXCEPTION;
			-- .NET exception

note
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
