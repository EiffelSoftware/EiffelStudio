note
	description: "[
		Set of tests which have been created using test generation.
		
		To reproduce failure each instruction will be called in a safe environment, allowing the
		execution to continue even if a exception has been raised.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_GENERATED_TEST_SET

inherit
	EQA_TEST_SET
		rename
			on_prepare as on_prepare_frozen
		redefine
			on_prepare_frozen
		end

feature {NONE} -- Access

	last_object: detachable ANY
	last_boolean: BOOLEAN
	last_character_8: CHARACTER_8
	last_character_32: CHARACTER_32
	last_integer_8: INTEGER_8
	last_integer_16: INTEGER_16
	last_integer_32: INTEGER_32
	last_integer_64: INTEGER_64
	last_natural_8: NATURAL_8
	last_natural_16: NATURAL_16
	last_natural_32: NATURAL_32
	last_natural_64: NATURAL_64
	last_real_32: REAL_32
	last_real_64: REAL_64
	last_pointer: POINTER
			-- Values returned from last routine call in `execute_safe'

feature {NONE} -- Status report

	is_recovery_enabled: BOOLEAN
			-- Should `execute_safe' try to recover from an exceptional routine call?

feature {NONE} -- Status setting

	set_is_recovery_enabled (a_is_recovery_enabled: like is_recovery_enabled)
			-- Set `is_recovering_enabled' to True.
		do
			is_recovery_enabled := a_is_recovery_enabled
		ensure
			is_recovery_enabled_set: is_recovery_enabled = a_is_recovery_enabled
		end

	reset_results
			-- Set all `last_*' attributes to their default value.
		do
			last_object := Void
			last_boolean := last_boolean.default
			last_character_8 := last_character_8.default
			last_character_32 := last_character_32.default
			last_integer_8 := last_integer_8.default
			last_integer_16 := last_integer_16.default
			last_integer_32 := last_integer_32.default
			last_integer_64 := last_integer_64.default
			last_natural_8 := last_natural_8.default
			last_natural_16 := last_natural_16.default
			last_natural_32 := last_natural_32.default
			last_natural_64 := last_natural_64.default
			last_real_32 := last_real_32.default
			last_real_64 := last_real_64.default
			last_pointer := last_pointer.default
		end

feature {NONE} -- Basic operations

	execute_safe (a_routine: ROUTINE [detachable TUPLE])
			-- Call `a_agent'
		require
			a_routine_attached: a_routine /= Void
			no_open_args: a_routine.open_count = 0
		local
			l_rescued: BOOLEAN
		do
			if not l_rescued then
				reset_results

					-- We use `detachable' here for TUPLE and return type of function object
					-- because this could be created at runtime.
					-- We use `detachable' for target of function object, because if agent is
					-- created by non-void safe code, the type will be detached.
				if attached {FUNCTION [detachable TUPLE, detachable ANY]} a_routine as l_func then
					if attached {FUNCTION [detachable TUPLE, BOOLEAN]} l_func as l_bool_func then
						last_boolean := l_bool_func.item (Void)
					elseif attached {FUNCTION [detachable TUPLE, CHARACTER_8]} l_func as l_char8_func then
						last_character_8 := l_char8_func.item (Void)
					elseif attached {FUNCTION [detachable TUPLE, CHARACTER_32]} l_func as l_char32_func then
						last_character_32 := l_char32_func.item (Void)
					elseif attached {FUNCTION [detachable TUPLE, INTEGER_8]} l_func as l_int8_func then
						last_integer_8 := l_int8_func.item (Void)
					elseif attached {FUNCTION [detachable TUPLE, INTEGER_16]} l_func as l_int16_func then
						last_integer_16 := l_int16_func.item (Void)
					elseif attached {FUNCTION [detachable TUPLE, INTEGER_32]} l_func as l_int32_func then
						last_integer_32 := l_int32_func.item (Void)
					elseif attached {FUNCTION [detachable TUPLE, INTEGER_64]} l_func as l_int64_func then
						last_integer_64 := l_int64_func.item (Void)
					elseif attached {FUNCTION [detachable TUPLE, NATURAL_8]} l_func as l_nat8_func then
						last_natural_8 := l_nat8_func.item (Void)
					elseif attached {FUNCTION [detachable TUPLE, NATURAL_16]} l_func as l_nat16_func then
						last_natural_16 := l_nat16_func.item (Void)
					elseif attached {FUNCTION [detachable TUPLE, NATURAL_32]} l_func as l_nat32_func then
						last_natural_32 := l_nat32_func.item (Void)
					elseif attached {FUNCTION [detachable TUPLE, NATURAL_64]} l_func as l_nat64_func then
						last_natural_64 := l_nat64_func.item (Void)
					elseif attached {FUNCTION [detachable TUPLE, REAL_32]} l_func as l_real32_func then
						last_real_32 := l_real32_func.item (Void)
					elseif attached {FUNCTION [detachable TUPLE, REAL_64]} l_func as l_real64_func then
						last_real_64 := l_real64_func.item (Void)
					elseif attached {FUNCTION [detachable TUPLE, POINTER]} l_func as l_pointer_func then
						last_pointer := l_pointer_func.item (Void)
					else
						last_object := l_func.item (Void)
					end
				else
					a_routine.call (Void)
				end
			end
		rescue
			if is_recovery_enabled then
				l_rescued := True
				retry
			else
				if attached (create {EXCEPTIONS}).exception_manager.last_exception as l_excpt then
					l_excpt.raise
				end
			end
		end

feature {NONE} -- Events

	frozen on_prepare_frozen
			-- <Precursor>
		do
			on_prepare
			set_is_recovery_enabled (True)
		ensure then
			recovery_enabled: is_recovery_enabled
		end

	on_prepare
			-- Called after `prepare' has performed all initialization.
		do
		ensure
			prepared: is_prepared
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
