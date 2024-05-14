note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER_THREAD_INFO

inherit
	DISPOSABLE

	ICOR_EXPORTER

	SHARED_EIFNET_DEBUGGER

create
	make

feature {NONE} -- Initialization

	make (p: POINTER) -- ; icdth_id: INTEGER) is
			-- Initialize Current
		require
			icd_thread_pointer_not_null: p /= Default_pointer
		local
			r: INTEGER
		do
			icd_thread_pointer := p

			r := {ICOR_DEBUG_THREAD}.cpp_get_id (icd_thread_pointer, $thread_id)
			r := {CLI_COM}.add_ref (icd_thread_pointer)
			create pending_steppers.make (7)
		end

feature -- Cleaning

	clean
			-- Clean data
		do
				-- FIXME jfiat: TODO

			clean_pending_steppers
		end

	clean_pending_steppers
			-- Clean pending_steppers
		local
			s: ICOR_DEBUG_STEPPER
		do
			from
				pending_steppers.start
			until
				pending_steppers.after
			loop
				s := pending_steppers.item_for_iteration
				s.deactivate	-- could fail, when process exited
				s.clean_on_dispose
				pending_steppers.forth
			end
			pending_steppers.wipe_out
		end

feature -- Access

	refresh_thread_details (a_factory: ICOR_DEBUG_FACTORY_I)
			-- Get again thread details
		do
			thread_details_fetched := False
			thread_name := Void
			thread_priority := 0
			get_thread_details (a_factory)
		end

	get_thread_details (a_factory: ICOR_DEBUG_FACTORY_I)
			-- Get the thread details
			-- i.e: name, priority and so on ...
		local
			l_icd: ICOR_DEBUG_VALUE
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
			l_name_icd: ICOR_DEBUG_VALUE
			l_priority_icd: ICOR_DEBUG_VALUE
			l_info: EIFNET_DEBUG_VALUE_INFO
			r: INTEGER
			p: POINTER
			extform: EIFNET_DEBUG_EXTERNAL_FORMATTER
		do
			if not thread_details_fetched then
				thread_details_fetched := True

				r := {ICOR_DEBUG_THREAD}.cpp_get_object (icd_thread_pointer, $p)
				if p /= Default_pointer then
					l_icd := a_factory.new_value (p)
				end

				if l_icd /= Void then
					create l_info.make (l_icd)
					l_icdov := l_info.new_interface_debug_object_value
					if l_icdov /= Void then
						extform := Eifnet_debugger.edv_external_formatter
						l_name_icd := l_icdov.get_field_value (
											l_info.value_icd_class,
											extform.token_Thread_m_Name
										)
						l_priority_icd := l_icdov.get_field_value (
											l_info.value_icd_class,
											extform.token_Thread_m_Priority
										)
						l_icdov.clean_on_dispose
						if l_name_icd /= Void then
							if attached extform.system_string_value_to_string (l_name_icd) as s32 then
								thread_name := s32
							end
							l_name_icd.clean_on_dispose
						end
						if l_priority_icd /= Void then
							thread_priority := eifnet_debugger.edv_formatter.icor_debug_value_to_integer (l_priority_icd)
							l_priority_icd.clean_on_dispose
						end
					end
					l_info.icd_prepared_value.clean_on_dispose
					l_info.clean
					l_icd.clean_on_dispose
				end
			end
		ensure
			thread_details_fetched
		end

	get_thread_name (a_factory: ICOR_DEBUG_FACTORY_I)
			-- Get thread's name
		do
			get_thread_details (a_factory)
		end

	get_thread_priority (a_factory: ICOR_DEBUG_FACTORY_I)
			-- Get thread's priority
		do
			get_thread_details (a_factory)
		end

	icd_thread (a_factory: ICOR_DEBUG_FACTORY_I): ICOR_DEBUG_THREAD
		do
			Result := opo_icd_thread
			if Result = Void then
				opo_icd_thread := a_factory.new_thread (icd_thread_pointer)
				opo_icd_thread.add_ref
				Result := opo_icd_thread
			end
		ensure
			result_not_void: Result /= Void
		end

	new_stepper (a_factory: ICOR_DEBUG_FACTORY_I): ICOR_DEBUG_STEPPER
			--
		local
			l_frame: ICOR_DEBUG_FRAME
			l_thread: ICOR_DEBUG_THREAD
			l_stepper: ICOR_DEBUG_STEPPER
			l_error: INTEGER
		do
			clean_pending_steppers
			-- FIXME jfiat: for now we do this way, find the way to reuse steppers
			l_thread := icd_thread (a_factory)
			if l_thread /= Void then
				l_frame := l_thread.get_active_frame
				if l_thread.last_call_succeed and then l_frame /= Void then
					l_stepper := l_frame.create_stepper
					l_error := l_frame.last_call_success
					l_frame.clean_on_dispose
				else
					l_stepper := l_thread.create_stepper
					l_error := l_thread.last_call_success
				end
				if l_error = 0 or l_error = 1 then
--					l_stepper.set_unmapped_stop_mask (l_stepper.enum_cor_debug_unmapped_stop__stop_no_mapping_info)
					l_stepper.set_unmapped_stop_mask (l_stepper.enum_cor_debug_unmapped_stop__stop_none)
					l_stepper.set_unmapped_stop_mask (l_stepper.enum_cor_debug_unmapped_stop__stop_epilog)
--					l_stepper.set_unmapped_stop_mask (l_stepper.enum_cor_debug_unmapped_stop__stop_other_unmapped)
					l_stepper.set_intercept_mask (l_stepper.enum_cor_debug_intercept__intercept_none)
--					l_stepper.set_intercept_mask (l_stepper.enum_cor_debug_intercept__interce)
					Result := l_stepper
					Result.add_ref
					add_icd_stepper (Result.item, Result)
				end
			end
		ensure
			Result /= Void
		end

feature -- Change

	add_icd_stepper (p: POINTER; a_factory: ICOR_DEBUG_FACTORY_I)
			-- Add pointer to Stepper
			--
			-- Nota: call AddRef before adding it
			--		maybe later, we'll do it here
		require
			stepper_not_null: p /= Default_pointer
		do
			pending_steppers.put (a_factory.new_stepper (p), p)
		end

	has_icd_stepper (p: POINTER): BOOLEAN
		require
			p /= Default_pointer
		do
			Result := pending_steppers.has (p)
		end

	remove_icd_stepper (p: POINTER)
		require
			p /= Default_pointer
			has_icd_stepper: has_icd_stepper (p)
		local
			s: ICOR_DEBUG_STEPPER
		do
			s := pending_steppers.item (p)
			if s /= Void then
				s.deactivate
				s.clean_on_dispose
			end
			pending_steppers.remove (p)
		end

feature {NONE} -- Implementation

	thread_details_fetched: BOOLEAN
			-- Is thread details already fetched or computed ?

	opo_icd_thread: ICOR_DEBUG_THREAD
			-- Once per object for `icd_thread'

feature -- Properties

	super_fluous_first_step_complete_message_suppressed: BOOLEAN

	stepping_for_startup: BOOLEAN

	thread_id: INTEGER

	thread_id_as_pointer: POINTER
			-- Thread_id converted to POINTER
		do
			Result := Result + thread_id
		end

	thread_name: STRING_32

	thread_priority: INTEGER

	icd_thread_pointer: POINTER

	last_icd_func_eval: ICOR_DEBUG_EVAL

	pending_steppers: HASH_TABLE [ICOR_DEBUG_STEPPER, POINTER]

feature -- Disposable

	dispose
		local
			n: INTEGER
		do
			opo_icd_thread := Void
			n := {CLI_COM}.release (icd_thread_pointer)
			icd_thread_pointer := Default_pointer
			pending_steppers := Void
			last_icd_func_eval := Void
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
