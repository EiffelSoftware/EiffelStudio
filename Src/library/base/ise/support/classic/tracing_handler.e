note
	description: "[
		Abstract class to dispatch tracing events to user. Tracing events are dispatched
		by calling `activate' on the TRACING_HANDLER's instance.
	 	For each thread being created a copy of the current tracer object will be
	 	used for the newly created thread to avoid race condition. It is up to the implementer
	 	of the class to ensure proper thread-safety and to properly implement `duplicated' which
	 	is by default implemented using `twin'.
 	]"
	legal: "See notice at end of class."
    status: "See notice at end of class."
    date: "$Date$"
    revision: "$Revision$"

deferred class
	TRACING_HANDLER

feature -- Tracing

	trace (a_type_id: INTEGER; a_c_class_name, a_c_feature_name: POINTER; a_depth: INTEGER; a_is_entering: BOOLEAN)
			-- Trigger a trace operation from a feature represented by `a_c_feature_name' defined in
			-- class `a_c_class_name' and applied to an object of type `a_type_id' at a call depth `a_depth'.
			-- If `a_is_entering' we are entering the routine, otherwise we are exiting it.			
		require
			a_type_id_non_negative: a_type_id >= 0
			a_depth_non_negative: a_depth >= 0
		deferred
		end

	frozen activate
			-- Register `Current' to the runtime and for all running threads to handle
			-- all the tracing calls.
		require
			valid_platform: not {PLATFORM}.is_dotnet
		do
			c_set_tracer ($Current, $per_thread_trace)
		end

	frozen deactivate
			-- Remove runtime tracing for all running threads.
		require
			valid_platform: not {PLATFORM}.is_dotnet
		local
			l_default: TYPED_POINTER [TRACING_HANDLER]
		do
			c_set_tracer (l_default, default_pointer)
		end

feature -- Duplication

	duplicated: like Current
			-- New duplication of `Current' not necessarly equal to `Current'. This duplicate
			-- version is used for each new threads to perform tracing.
			--| Default version uses `twin'.
		do
			Result := twin
		ensure
			duplicated_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	frozen per_thread_trace (a_type_id: INTEGER; a_c_class_name, a_c_feature_name: POINTER; a_depth: INTEGER; a_is_entering: BOOLEAN)
			-- Thread safe tracing. Each time the runtime triggers a trace event,
			-- the per thread TRACE_HANDLER will be called avoiding any race condition.
		require
			a_type_id_non_negative: a_type_id >= 0
			a_depth_non_negative: a_depth >= 0
		do
			per_thread_tracer.trace (a_type_id, a_c_class_name, a_c_feature_name, a_depth, a_is_entering)
		end

	frozen c_set_tracer (a_tracer: POINTER; a_fnptr: POINTER)
			-- Register `Current' to the runtime to handle all the tracing calls.
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"eif_set_tracer ($a_tracer, $a_fnptr);"
		end

	frozen per_thread_tracer: TRACING_HANDLER
			-- Per thread instance of Current used
		once ("THREAD")
			Result := duplicated
		ensure
			per_thread_tracer_not_void: Result /= Void
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
