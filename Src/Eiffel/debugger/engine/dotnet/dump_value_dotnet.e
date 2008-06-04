indexing
	description: "Objects join all debug values: STRING, INTEGER, BOOLEAN, REFERENCES, ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DUMP_VALUE_DOTNET

inherit
	DUMP_VALUE
		redefine
			set_object_value,
			extra_output_details,
			formatted_output,
			dotnet_value_class_name,
			dotnet_generating_type_evaluated_string,
			dotnet_string_representation
		end

	ICOR_EXPORTER

create {DUMP_VALUE_FACTORY}
	make_empty

feature {DUMP_VALUE_FACTORY} -- Restricted Initialization

	set_object_value (value: STRING_8; dtype: CLASS_C) is
			-- make a object item initialized to `value'
		local
			dobj: DEBUGGED_OBJECT_DOTNET
			l_val: EIFNET_ABSTRACT_DEBUG_VALUE
			l_eifnet_ref: EIFNET_DEBUG_REFERENCE_VALUE
			l_eifnet_str: EIFNET_DEBUG_STRING_VALUE
			l_eifnet_nat: EIFNET_DEBUG_NATIVE_ARRAY_VALUE
		do
			Precursor {DUMP_VALUE} (value, dtype)
			dobj ?= debugger_manager.object_manager.debugged_object (value, 0, 0)
			if dobj /= Void then
				l_val ?= dobj.debug_value
				if l_val /= Void then
					l_eifnet_ref ?= l_val
					if l_eifnet_ref /= Void then
						set_object_for_dotnet_value (l_eifnet_ref)
					else
						l_eifnet_str ?= l_val
						if l_eifnet_str /= Void then
							set_string_for_dotnet_value (l_eifnet_str)
						else
							l_eifnet_nat ?= l_val
							if l_eifnet_nat /= Void then
								set_native_array_object_for_dotnet_value (l_eifnet_nat)
							end
						end
					end
				end
			end
		end

	set_string_for_dotnet_value  (a_eifnet_dsv: EIFNET_DEBUG_STRING_VALUE) is
			-- make a object ICorDebugStringValue item initialized to `value'
		require
			is_dotnet_system
			arg_not_void: a_eifnet_dsv /= Void
		do
			is_dotnet_value := True
			eifnet_debug_value := a_eifnet_dsv
			value_dotnet := eifnet_debug_value.icd_referenced_value

			value_string_dotnet := a_eifnet_dsv.icd_value_info.interface_debug_string_value
			if value_string_dotnet /= Void then
				value_string_dotnet.get_strong_reference_value
			end

			value_string := a_eifnet_dsv.string_value
			if a_eifnet_dsv.is_null then
				value_address := Void
			else
				value_address := a_eifnet_dsv.address
			end
			type := Type_string_dotnet
			dynamic_class := a_eifnet_dsv.dynamic_class
			is_external_type := True
		ensure
			type /= Type_unknown
		end

	set_object_for_dotnet_value  (a_eifnet_drv: EIFNET_DEBUG_REFERENCE_VALUE) is
			-- make a object ICorDebugObjectValue item initialized to `value'
		require
			is_dotnet_system
			arg_not_void: a_eifnet_drv /= Void
		do
			is_dotnet_value := True
			eifnet_debug_value := a_eifnet_drv
			value_dotnet := eifnet_debug_value.icd_referenced_value
			icd_value_info := a_eifnet_drv.icd_value_info
			dotnet_value_class_token := a_eifnet_drv.value_class_token
			if a_eifnet_drv.is_null then
				value_address := Void
			else
				value_address := a_eifnet_drv.address
			end
			type := Type_object

			dynamic_class_type := a_eifnet_drv.dynamic_class_type
			if dynamic_class_type /= Void then
				dynamic_class := dynamic_class_type.associated_class
				debug ("debugger_eifnet_data")
					print ("[>] dyn_class_type = " + dynamic_class_type.full_il_type_name + "%N")
				end
			end
			if dynamic_class = Void then
				dynamic_class := a_eifnet_drv.static_class
			end
			is_external_type := a_eifnet_drv.is_external_type
		ensure
			type /= Type_unknown
		end

	set_native_array_object_for_dotnet_value  (a_eifnet_dnav: EIFNET_DEBUG_NATIVE_ARRAY_VALUE) is
			-- make a object ICorDebugObjectValue item initialized to `value'
		require
			is_dotnet_system
			arg_not_void: a_eifnet_dnav /= Void
		do
			is_dotnet_value := True
			eifnet_debug_value := a_eifnet_dnav
			value_dotnet := eifnet_debug_value.icd_referenced_value
			icd_value_info := a_eifnet_dnav.icd_value_info

			if a_eifnet_dnav.is_null then
				value_address := Void
			else
				value_address := a_eifnet_dnav.address
			end
			type := Type_object

			dynamic_class_type := Void
			dynamic_class := debugger_manager.compiler_data.native_array_class_c
			if dynamic_class = Void then
				dynamic_class := a_eifnet_dnav.static_class
			end
			is_external_type := a_eifnet_dnav.is_external_type
		ensure
			type /= Type_unknown
		end

feature -- Dotnet access

	is_external_type: BOOLEAN
			-- Is the value corresponding to an external type ?
			-- (ex: like SystemObject for dotnet)

	eifnet_debug_value: EIFNET_ABSTRACT_DEBUG_VALUE
			-- Debug value related to `value_dotnet'

	value_string_dotnet: ICOR_DEBUG_STRING_VALUE
			-- ICorDebugStringValue for the dotnet String

	value_frame_dotnet: ICOR_DEBUG_FRAME is
			-- ICorDebugFrame in this DUMP_VALUE context
		do
			Result := Eifnet_debugger.current_stack_icor_debug_frame
		end

feature -- Access

	extra_output_details: STRING_32 is
		do
			if is_dotnet_value and then eifnet_debug_value /= Void then
				Result := eifnet_debug_value.extra_output_details
			else
				Result := Precursor {DUMP_VALUE}
			end
		end

	formatted_output: STRING_32 is
			-- Output of the call to `debug_output' on `Current', if any.
		do
			if type = Type_string_dotnet and then value_string_dotnet = Void then
				Result := Character_routines.eiffel_string_32 (value_string)
			else
				Result := Precursor {DUMP_VALUE}
			end
		end

feature {NONE} -- string_representation Implementation

	dotnet_generating_type_evaluated_string: STRING is
		local
			l_feat: FEATURE_I
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
		do
			l_feat := generating_type_feature_i (dynamic_class)
			if dynamic_class_type /= Void then
				l_icdov := new_value_object_dotnet
				if l_icdov /= Void then
					Result := Eifnet_debugger.generating_type_value_from_object_value (
								value_frame_dotnet,
								value_dotnet,
								l_icdov,
								dynamic_class_type,
								l_feat
							)
					l_icdov.clean_on_dispose
				end
			end
		end

	dotnet_string_representation (min, max: INTEGER): STRING_32 is
			-- String representation for dotnet value
			-- with bounds from `min' and `max'.
		local
			sc, sc8, sc32: CLASS_C
			l_eifnet_debugger: EIFNET_DEBUGGER
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
			l_size: INTEGER
			comp_data: DEBUGGER_DATA_FROM_COMPILER
		do
			l_eifnet_debugger := Eifnet_debugger

			if dynamic_class /= Void then
				comp_data := debugger_manager.compiler_data
				sc8 := comp_data.string_8_class_c
				sc32 := comp_data.string_32_class_c
				if dynamic_class = sc8 or dynamic_class = sc32 then
					sc := dynamic_class
				elseif dynamic_class.simple_conform_to (sc8) then
					sc := sc8
				elseif dynamic_class.simple_conform_to (sc32) then
					sc := sc32
				else
					sc := Void
				end
				if sc /= Void then
					l_icdov := new_value_object_dotnet
					if l_icdov = Void then
						Result := "Void"
					else
						Result := l_eifnet_debugger.string_value_from_string_class_value (sc, value_dotnet, l_icdov, min, max)
						last_string_representation_length := l_eifnet_debugger.last_string_value_length
						l_icdov.clean_on_dispose
					end
				else
					sc := comp_data.system_string_class_c
					if sc /= Void then
						if dynamic_class = sc or dynamic_class.simple_conform_to (sc) then
							if value_string_dotnet /= Void then
								Result := l_eifnet_debugger.string_value_from_system_string_class_value (value_string_dotnet, min, max)
								if Result = Void and then value_string_dotnet.last_error_was_object_neutered then
									value_string_dotnet := l_eifnet_debugger.unneutered_icd_string_value (value_string_dotnet)
									Result := l_eifnet_debugger.string_value_from_system_string_class_value (value_string_dotnet, min, max)
								end
								last_string_representation_length := l_eifnet_debugger.last_string_value_length
							elseif value_string /= Void then
								Result := value_string
								last_string_representation_length := value_string.count
								if max < 0 then
									l_size := last_string_representation_length
								else
									l_size := (max + 1).min (last_string_representation_length)
								end
								Result := Result.substring ((min + 1).max (1), l_size)
							end
						else
							Result := dotnet_debug_output_evaluated_string (l_eifnet_debugger, min, max)
						end
					else
						Result := dotnet_debug_output_evaluated_string (l_eifnet_debugger, min, max)
					end
				end
			else
				Result := dotnet_debug_output_evaluated_string (l_eifnet_debugger, min, max)
			end
		end

	dotnet_debug_output_evaluated_string (a_dbg: EIFNET_DEBUGGER; min, max: INTEGER): STRING_32 is
			-- Evaluation of DEBUG_OUTPUT.debug_output: STRING on object related to Current
		require
			is_dotnet_system
		local
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
		do
			l_icdov := new_value_object_dotnet
			if l_icdov /= Void then
				Result := a_dbg.debug_output_value_from_object_value (value_frame_dotnet, value_dotnet, l_icdov, dynamic_class_type, min, max)
				last_string_representation_length := a_dbg.last_string_value_length
				l_icdov.clean_on_dispose
			end
		end

feature {NONE} -- Implementation dotnet

	icd_value_info: EIFNET_DEBUG_VALUE_INFO

	dotnet_value_class_token: INTEGER;
			-- Class token for the dotnet value

	dotnet_value_class_name: STRING is
			-- Class name for the dotnet value
		local
			l_edvi: EIFNET_DEBUG_VALUE_INFO
		do
			if not is_external_type and then dynamic_class /= Void then
				Result := dynamic_class.name_in_upper
			elseif is_dotnet_value and is_external_type then
				l_edvi := eifnet_debug_value.icd_value_info
				if l_edvi /= Void and then l_edvi.has_object_interface then
					Result := l_edvi.value_class_name
				elseif dynamic_class /= Void then
					Result := dynamic_class.name_in_upper
				else
					Result := "{Token=0x" + dotnet_value_class_token.to_hex_string + "}"
				end
			end
			if Result = Void then
				Result := "Unknown Type"
			end
		end

	new_value_object_dotnet: ICOR_DEBUG_OBJECT_VALUE is
			-- Dotnet value as an ICorDebugObjectValue interface
		do
			if icd_value_info /= Void then
				Result := icd_value_info.new_interface_debug_object_value
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class DUMP_VALUE_DOTNET
