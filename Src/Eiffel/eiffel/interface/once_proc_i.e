note
	description: "Representation of a once procedure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ONCE_PROC_I

inherit
	DYN_PROC_I
		rename
			is_object_relative_once as is_object_relative
		redefine
			is_object_relative,
			is_once,
			is_once_creation,
			is_process_relative,
			prepare_object_relative_once,
			replicated,
			selected,
			transfer_from,
			transfer_to,
			unselected,
			update_api
		end

feature -- Status report

	is_once: BOOLEAN = True
			-- Is the current feature a once one?

	is_process_relative: BOOLEAN
			-- Is once routine process-wide (rather than thread-specific)?

	is_thread_relative: BOOLEAN
			-- Is once routine thread-specific?
		do
			Result := not (is_process_relative or is_object_relative)
		end

	is_object_relative: BOOLEAN
			-- Is once routine per object?

	is_once_creation (c: CLASS_C): BOOLEAN
			-- Is it a creation procedure in a once class `c`?
		do
			Result := c.is_once and then attached c.creators as cs and then cs.has (feature_name_id)
		end

feature -- Status setting

	set_is_process_relative
			-- Set `is_process_relative'.
		do
			is_object_relative := False
			is_process_relative := True
		ensure
			is_process_relative_set: is_process_relative
		end

	set_is_thread_relative
			-- Set `is_thread_relative'.
		do
			is_object_relative := False
			is_process_relative := False
		ensure
			is_thread_relative_set: is_thread_relative
		end

	set_is_object_relative
			-- Set `is_object_relative'.
		do
			is_process_relative := False
			is_object_relative := True
		ensure
			is_object_relative_set: is_object_relative
		end

feature -- Adaptation

	transfer_to (other: ONCE_PROC_I)
			-- Transfer data from Current into `other'.
		do
			Precursor (other)
			if is_process_relative then
				other.set_is_process_relative
			elseif is_object_relative then
				other.set_is_object_relative
			else
				other.set_is_thread_relative
			end
		end

	transfer_from (other: ONCE_PROC_I)
			-- Transfer data from Current into `other'.
		do
			Precursor (other)
			if other.is_process_relative then
				set_is_process_relative
			elseif other.is_object_relative then
				set_is_object_relative
			else
				set_is_thread_relative
			end
		end

	replicated (in: INTEGER): FEATURE_I
			-- Replication
		local
			rep: R_ONCE_PROC_I
		do
			create rep
			transfer_to (rep)
			rep.set_code_id (new_code_id)
			rep.set_access_in (in)
			Result := rep
		end

	selected: ONCE_PROC_I
			-- <Precursor>
		do
			create Result
			Result.transfer_from (Current)
		end

	unselected (in: INTEGER): FEATURE_I
			-- Unselected feature
		local
			unselect: D_ONCE_PROC_I
		do
			create unselect
			transfer_to (unselect)
			unselect.set_access_in (in)
			Result := unselect
		end

feature -- Object relative once

	prepare_object_relative_once (a_byte_code: BYTE_CODE)
			-- <Precursor>
			--| Warning: the code relies on the presence of
			--|      ISE_EXCEPTION_MANAGER.default_create
			--| and  ISE_EXCEPTION_MANAGER.once_raise (an_exception: EXCEPTION)
		local
			l_rescue: DO_RESCUE_B
			l_hidden_if_called_b: HIDDEN_IF_B
			l_if_b: IF_B
			l_bin_ne_b: BIN_NE_B
			l_excep_attr_b: ATTRIBUTE_B
			l_ISE_EXCEPTION_MANAGER_default_create_feature_b: ANY_FEATURE_B
			l_ISE_EXCEPTION_MANAGER_once_raise_feature_b: FEATURE_B
			l_ISE_EXCEPTION_MANAGER_last_exception_feature_b: FEATURE_B

			l_nested_b: NESTED_B
			l_access_expr_b: ACCESS_EXPR_B
			l_creation_expr_b: CREATION_EXPR_B
			l_result_attr_b: ATTRIBUTE_B
			l_called_attr_b: ATTRIBUTE_B
			l_compound: BYTE_LIST [BYTE_NODE]
			l_body_compound: BYTE_LIST [BYTE_NODE]
			l_then_compound, l_wrapper_compound: HIDDEN_B
			l_parameters: BYTE_LIST [PARAMETER_B]
			l_param: PARAMETER_B
			l_try_b: TRY_B
			l_ISE_EXCEPTION_MANAGER_type: CL_TYPE_A
			l_ISE_EXCEPTION_MANAGER_class_c: CLASS_C
			l_default_create_fi: FEATURE_I
			n: INTEGER
		do
			if
				is_object_relative and then
				attached written_class.object_relative_once_info_of_rout_id_set (rout_id_set) as l_obj_once_info and then
				attached {STD_BYTE_CODE} a_byte_code as bc
			then
				l_compound := a_byte_code.compound

					--| Build new body compound
					--|
					--|		attr_called := True
					--|		... body ...
					--|		attr_result := Result
					--|
				if l_compound /= Void and then not l_compound.is_empty then
					n := 2 --| called + compound
				else
					n := 1 --| called
				end
				if has_return_value then
						--| To generate `attr_result := Result'
					n := n + 1 --| attr_result := Result
				end

				create l_body_compound.make (n)
					--| attr_called := True
				create l_called_attr_b.make (l_obj_once_info.called_attribute_i)
				l_called_attr_b.set_type (l_obj_once_info.called_type_a)
				l_called_attr_b.set_is_attachment
				l_body_compound.extend (create {HIDDEN_B}.make_wrapper
					(create {ASSIGN_B}.make (l_called_attr_b, create {BOOL_CONST_B}.make (True))))
					--| reuse existing compound	/ body				
				if l_compound /= Void and then not l_compound.is_empty then
					if l_compound.count = 1 then
						l_body_compound.extend (l_compound.first)
					else
						check l_compound.count > 0 end
						l_body_compound.extend (l_compound)
					end
				end
				if has_return_value then
					create l_result_attr_b.make (l_obj_once_info.result_attribute_i)
					l_result_attr_b.set_type (a_byte_code.real_type (l_obj_once_info.result_type_a))
					l_result_attr_b.set_is_attachment
					l_body_compound.extend (create {HIDDEN_B}.make_wrapper
						(create {ASSIGN_B}.make (l_result_attr_b, create {RESULT_B})))	--| attr_result := Result
				end

				--|
				--| if called then
				--| 	if attached attr_exception as l_attr_exception then
				--|			(create {ISE_EXCEPTION_MANAGER}).raise (l_attr_exception)
				--|		end
				--|		Result := attr_result
				--|	else --/ Not called yet
				--|		attr_called := True
				--|		... body ...
				--|		attr_result := Result
				--| end
				--|

					--| if called then
				create l_hidden_if_called_b
				create l_called_attr_b.make (l_obj_once_info.called_attribute_i)
				l_called_attr_b.set_type (l_obj_once_info.called_type_a)
				l_hidden_if_called_b.set_condition (l_called_attr_b)
				create l_if_b
				create l_excep_attr_b.make (l_obj_once_info.exception_attribute_i)
				l_excep_attr_b.set_type (a_byte_code.real_type (l_obj_once_info.exception_type_a))
				create l_bin_ne_b
				l_bin_ne_b.set_left (l_excep_attr_b)
				l_bin_ne_b.set_right (create {VOID_B})
				l_if_b.set_condition (l_bin_ne_b)
				l_ISE_EXCEPTION_MANAGER_class_c := system.ise_exception_manager_class.compiled_class
				check
					ise_exception_manager_class_compiled: l_ISE_EXCEPTION_MANAGER_class_c /= Void
				end
				l_default_create_fi := l_ISE_EXCEPTION_MANAGER_class_c.feature_of_name_id (Names_heap.default_create_name_id)
				check
					default_create_exists: l_default_create_fi /= Void
				end

				if
					l_ISE_EXCEPTION_MANAGER_class_c /= Void and then
					attached l_ISE_EXCEPTION_MANAGER_class_c.feature_of_name_id (Names_heap.once_raise_name_id) as l_once_raise_fi
				then
					--| (create {ISE_EXCEPTION_MANAGER})
					create l_creation_expr_b
					l_ISE_EXCEPTION_MANAGER_type := l_ISE_EXCEPTION_MANAGER_class_c.types.first.type
					l_creation_expr_b.set_type (l_ISE_EXCEPTION_MANAGER_type)
					l_creation_expr_b.set_info (create {CREATE_TYPE}.make (l_ISE_EXCEPTION_MANAGER_type))
					l_creation_expr_b.set_creation_instruction (False)

						--| default_create
					create l_ISE_EXCEPTION_MANAGER_default_create_feature_b.make (l_default_create_fi, l_default_create_fi.type, Void, False)
					l_creation_expr_b.set_call (l_ISE_EXCEPTION_MANAGER_default_create_feature_b)


						--| {ISE_EXCEPTION_MANAGER}.once_raise (EXCEPTION)
					create l_ISE_EXCEPTION_MANAGER_once_raise_feature_b.make (l_once_raise_fi, a_byte_code.real_type (l_once_raise_fi.type), Void, False)
					create l_excep_attr_b.make (l_obj_once_info.exception_attribute_i)
					l_excep_attr_b.set_type (a_byte_code.real_type (l_obj_once_info.exception_type_a))

					create l_parameters.make (1)
					create l_param
					l_param.set_expression (l_excep_attr_b)
					l_param.set_attachment_type (l_excep_attr_b.type)
					l_parameters.extend (l_param)
					l_ISE_EXCEPTION_MANAGER_once_raise_feature_b.set_parameters (l_parameters)
					l_param.set_parent (l_ISE_EXCEPTION_MANAGER_once_raise_feature_b)

						--| Build ... (create {ISE_EXCEPTION_MANAGER}).once_raise (EXCEPTION)
					create l_nested_b
					create l_access_expr_b
					l_access_expr_b.set_expr (l_creation_expr_b)
					l_nested_b.set_target (l_access_expr_b)
					l_nested_b.set_message (l_ISE_EXCEPTION_MANAGER_once_raise_feature_b)
					l_ISE_EXCEPTION_MANAGER_once_raise_feature_b.set_parent (l_nested_b)

					create l_wrapper_compound.make (1)
					l_wrapper_compound.extend (l_nested_b)
					l_if_b.set_compound (l_wrapper_compound)
				end

				if has_return_value then
					create l_then_compound.make (2)
					l_then_compound.extend (l_if_b)

					create l_result_attr_b.make (l_obj_once_info.result_attribute_i)
					l_result_attr_b.set_type (a_byte_code.real_type (l_obj_once_info.result_type_a))
					l_then_compound.extend (create {ASSIGN_B}.make (create {RESULT_B}, l_result_attr_b))
				else
					create l_then_compound.make_wrapper (l_if_b)
				end

				l_hidden_if_called_b.set_compound (l_then_compound)
					--|	else --/ Not called yet
					--| use l_body_compound inside a TRY_B
				if
					l_ISE_EXCEPTION_MANAGER_class_c /= Void and then
					attached l_ISE_EXCEPTION_MANAGER_class_c.feature_of_name_id (Names_heap.last_exception_name_id) as l_last_exception_fi
				then
					create {HIDDEN_B} l_compound.make (1)
					--| Get last exception
					--| attr_except := (create {ISE_EXCEPTION_MANAGER}).last_exception
					--| *(EIF_REFERENCE *)(Current + _REFACS_2_) = RTLA;
					create l_excep_attr_b.make (l_obj_once_info.exception_attribute_i)
					l_excep_attr_b.set_type (l_obj_once_info.exception_type_a)
					l_excep_attr_b.set_is_attachment

					create l_creation_expr_b
					l_ISE_EXCEPTION_MANAGER_type := l_ISE_EXCEPTION_MANAGER_class_c.types.first.type
					l_creation_expr_b.set_type (l_ISE_EXCEPTION_MANAGER_type)
					l_creation_expr_b.set_info (create {CREATE_TYPE}.make (l_ISE_EXCEPTION_MANAGER_type))
					l_creation_expr_b.set_creation_instruction (False)

						--| default_create
					create l_ISE_EXCEPTION_MANAGER_default_create_feature_b.make (l_default_create_fi, l_default_create_fi.type, Void, False)
					l_creation_expr_b.set_call (l_ISE_EXCEPTION_MANAGER_default_create_feature_b)

						--| {ISE_EXCEPTION_MANAGER}.last_exception: EXCEPTION
					create l_ISE_EXCEPTION_MANAGER_last_exception_feature_b.make (l_last_exception_fi, a_byte_code.real_type (l_last_exception_fi.type), Void, False)

						--| Build ... (create {ISE_EXCEPTION_MANAGER}).last_exception returning an EXCEPTION object
					create l_nested_b
					create l_access_expr_b
					l_access_expr_b.set_expr (l_creation_expr_b)
					l_nested_b.set_target (l_access_expr_b)
					l_nested_b.set_message (l_ISE_EXCEPTION_MANAGER_last_exception_feature_b)
					l_ISE_EXCEPTION_MANAGER_last_exception_feature_b.set_parent (l_nested_b)

					l_compound.extend (create {ASSIGN_B}.make (l_excep_attr_b, l_nested_b))
				else
					l_compound := Void
					check False end
				end

				create l_try_b
				if attached a_byte_code.rescue_clause as rc then
					create l_rescue.make (l_body_compound, rc)
					l_try_b.set_compound (l_rescue.wrapped_into_byte_list)
				else
					l_try_b.set_compound (l_body_compound)
				end

				if l_compound /= Void then
					l_try_b.set_except_part (l_compound)
				end
				l_try_b.propagate_exception

				l_hidden_if_called_b.set_else_part (l_try_b.wrapped_into_byte_list)

				create l_compound.make (1)
				l_compound.extend (l_hidden_if_called_b)
				bc.set_compound (l_compound)
			end
		end

feature {NONE} -- Implementation

	update_api (f: E_ROUTINE)
			-- Update api feature `f' attribute features.
		do
			Precursor {DYN_PROC_I} (f)
			f.set_once (True)
			f.set_object_relative_once (is_object_relative)
		end

invariant
	one_of_process_thread_object:
				(    is_process_relative and not is_thread_relative and not is_object_relative) or
				(not is_process_relative and     is_thread_relative and not is_object_relative) or
				(not is_process_relative and not is_thread_relative and     is_object_relative)

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
