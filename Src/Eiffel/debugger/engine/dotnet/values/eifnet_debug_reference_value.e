note
	description: "Dotnet debug value associated with Reference value"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_REFERENCE_VALUE

inherit
	ABSTRACT_REFERENCE_VALUE
		redefine
			reset_children,
			kind
		end

	EIFNET_ABSTRACT_DEBUG_VALUE
		undefine
			address
		redefine
			reset_children,
			kind
		end

	SHARED_EIFNET_DEBUGGER
		export
			{NONE} all
		undefine
			is_equal
		end

	INTERNAL_COMPILER_STRING_EXPORTER
		undefine
			is_equal
		end

create {RECV_VALUE, ATTR_REQUEST,CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
	make

feature {NONE} -- Initialization

	make (a_referenced_value: like icd_referenced_value; a_prepared_value: like icd_value)
			-- 	Set `value' to `v'.
		require
			a_referenced_value_not_void: a_referenced_value /= Void
			a_prepared_value_not_void: a_prepared_value /= Void
		do
			set_default_name

			init_dotnet_data (a_referenced_value, a_prepared_value)

			get_object_value
			if object_value /= Void then
				value_class_token := icd_value_info.value_class_token
				release_object_value
			end

			is_null := icd_value_info.is_null
			if is_null then
				create address.make_void
			else
				create address.make_from_natural_64 (icd_value_info.object_address)
				if dynamic_class_type = Void then
					is_external_type := True
				else
					is_expanded := dynamic_class_type.is_expanded
				end
			end
			register_dotnet_data
		ensure
			value_set: icd_value = a_prepared_value
		end

feature -- Get

	has_object_value: BOOLEAN
		do
			Result := object_value /= Void
		end

	get_object_value
			-- Get `object_value' value
		require
			object_value_void: not has_object_value
		do
			object_value := icd_value_info.new_interface_debug_object_value
		end

	release_object_value
			-- Release `object_value'
		require
			has_object_value: has_object_value
		do
			object_value.clean_on_dispose
			object_value := Void
		end

feature -- Access

	object_value: ICOR_DEBUG_OBJECT_VALUE
			-- Interface to ICorDebugObjectValue

	value_class_token: NATURAL_32
			-- class token related to `object_value'

	value_module_file_name: STRING
			-- ICorDebugModule filename related to `object_value'

	dynamic_class: CLASS_C
			-- Find corresponding CLASS_C to type represented by `value'.
		local
			l_class_type: CLASS_TYPE
		do
			Result := internal_dynamic_class
			if Result = Void then
				l_class_type := dynamic_class_type
				if l_class_type /= Void then
					Result := l_class_type.associated_class
					internal_dynamic_class := Result
				end
			end
		end

	dynamic_class_type: CLASS_TYPE
			-- Corresponding CLASS_TYPE represented by `value'.
		do
			Result := internal_dynamic_class_type
			if Result = Void then
				if not is_null then
					if icd_value_info.has_object_interface and then value_class_token > 0 then
						Result := icd_value_info.value_class_type
						if Result = Void then
								--| This means we are dealing with an external type (dotnet)
							internal_dynamic_class := icd_value_info.value_class_c
							check internal_dynamic_class /= Void end
							Result := internal_dynamic_class.types.first
							is_external_type := True
						end
					else
						internal_dynamic_class := debugger_manager.compiler_data.system_object_class_c
						Result := internal_dynamic_class.types.first
					end
					internal_dynamic_class_type := Result
				end
			end
		end

	dump_value: DUMP_VALUE
			-- Dump_value corresponding to `Current'.
		do
			Result := Debugger_manager.Dump_value_factory.new_object_for_dotnet_value (Current)
		end

feature -- Change

	reset_children
		do
			attributes := Void
		end

feature {NONE} -- Output

	type_and_value: STRING_32
			-- Return a string representing `Current'.
		local
			ec: CLASS_C;
		do
			if is_null then
				Result := NONE_representation
			else
				ec := dynamic_class;
				if ec /= Void then
					create Result.make (60)
					Result.append (ec.name_in_upper)
					Result.append (Left_address_delim)
					Result.append (address.output)
					Result.append (Right_address_delim)
					if is_external_type then
						Result.append (" token=0x"+ value_class_token.to_hex_string)
					end
				else
					create Result.make (20)
					Result.append (Any_class.name_in_upper)
					Result.append (Is_unknown)
				end
			end
		end

feature -- Output

	children: DEBUG_VALUE_LIST
			-- List of all sub-items of `Current'.
			-- May be void if there are no children.
			-- Generated on demand.
			-- (sorted by name)
		do
			Result := attributes
			if Result = Void then
				if is_external_type then
					Result := children_from_external_type
				else
					Result := children_from_eiffel_type
				end
				attributes := Result
			end
		end

	attributes: DEBUG_VALUE_LIST

feature {APPLICATION_EXECUTION} -- Query

	attribute_value_for (att_name: STRING): ABSTRACT_DEBUG_VALUE
			-- Attribute value named `att_name'.
		local
			l_icd_class: ICOR_DEBUG_CLASS
			cl: CLASS_C
			o: like object_value
		do
			o := object_value
			object_value := Void
			get_object_value
			if object_value /= Void then
				l_icd_class := object_value.get_class
				if l_icd_class /= Void then
					cl := dynamic_class
					if cl /= Void then
						if (attached cl.feature_named_32 (att_name) as f) and then f.is_attribute then
							Result := attribute_value (object_value, l_icd_class, f)
						end
					end
				end
				object_value.clean_on_dispose
				object_value := Void
			end
			if o /= Void then
				object_value := o
			end
		end

feature {NONE} -- Children implementation

	children_from_eiffel_type: DEBUG_VALUE_LIST
			-- List of all sub-items of `Current'.
			-- May be void if there are no children.
			-- Generated on demand.
			-- (sorted by name)
		local
			l_feature_table: FEATURE_TABLE
			l_feature_i: FEATURE_I

			l_att_debug_value: ABSTRACT_DEBUG_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
		do
			get_object_value
			if object_value /= Void then
				l_icd_class := object_value.get_class
				if l_icd_class /= Void then
					if dynamic_class /= Void then
						l_feature_table := dynamic_class.feature_table
						create Result.make (l_feature_table.count)
						from
							l_feature_table.start
						until
							l_feature_table.after
						loop
							l_feature_i := l_feature_table.item_for_iteration
							debug ("DEBUGGER_TRACE_CHILDREN")
								print (">>> CHILDREN :: " + l_feature_i.feature_name + "<<<%N")
								print ("%T - from feature_i     => "
										+ l_feature_i.written_class.name_in_upper + "." + l_feature_i.feature_name
										+ " :: " + l_feature_i.written_class.class_id.out + "%N")
								print ("%T - from dynamic_class => " + dynamic_class.name_in_upper
										+ "." + l_feature_i.feature_name + " :: " + dynamic_class.class_id.out + "%N")
							end
							if l_feature_i.is_attribute then
								l_att_debug_value := attribute_value (object_value, l_icd_class, l_feature_i)
								if l_att_debug_value /= Void then
									Result.put_last (l_att_debug_value)
								end
							end
							l_feature_table.forth
						end
					end
				end
				release_object_value
			end
		end

	attribute_value (a_obj_value: ICOR_DEBUG_OBJECT_VALUE; a_icd_class: ICOR_DEBUG_CLASS; f: FEATURE_I): ABSTRACT_DEBUG_VALUE
			-- Attribute's value in the context of Current related to `f'
		require
			object_value_not_void: a_obj_value /= Void
		local
			l_att_token: NATURAL_32
			l_att_icd_debug_value: ICOR_DEBUG_VALUE
			l_statcl: CLASS_C
			icdm: ICOR_DEBUG_MODULE
		do
			debug ("refactor_fixme")
				fixme ("Debugger/dotnet: Find general working solution to get dotnet field without trying many attempts.")
			end
				--| Let's try using the record IL data
			l_att_token := Il_debug_info_recorder.feature_token_for_feat_and_class_type (f, dynamic_class_type)
			l_att_icd_debug_value := a_obj_value.get_field_value (a_icd_class, l_att_token)

			if not a_obj_value.last_call_succeed and then l_att_icd_debug_value = Void then
					--| Let's try using meta data and field name/
				icdm := a_icd_class.get_module
				if icdm /= Void then
					l_att_token := icdm.md_field_token (a_icd_class.token, f.feature_name)
					if l_att_token /= 0 then
						l_att_icd_debug_value := a_obj_value.get_field_value (a_icd_class, l_att_token)
					end
				end
			end
			if l_att_icd_debug_value /= Void then
				if f.type.has_associated_class then
					l_statcl := f.type.associated_class
				end
				Result := debug_value_from_icdv (l_att_icd_debug_value, l_statcl)
				if Result /= Void then
					Result.set_name (f.feature_name)
				else
					create {DEBUG_BASIC_VALUE[INTEGER]} Result.make (Sk_int32, 0)
					Result.set_name ("ERROR on " + f.feature_name)
						--| FIXME JFIAT : 2003/10/24 maybe add DUMMY_VALUE to say
						--| we had problem to get its value ...
					debug ("DEBUGGER_TRACE_CHILDREN")
						print ("Unable to build debug value for : "
								+ dynamic_class.name_in_upper + "." + f.feature_name
								+ "%N"
							)
					end
				end
			end
		end

feature -- Status

	kind: INTEGER
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			if is_null then
				Result := Void_value
			else
				if is_external_type then
					if is_static then
						Result := Static_external_reference_value
					else
						Result := External_reference_value
					end
				else
					if is_static then
						Result := Static_reference_value
					else
						Result := Reference_value
					end
				end
			end
		end

feature -- Once request

	once_function_value (a_feat: E_FEATURE): ABSTRACT_DEBUG_VALUE
			-- If Result = Void, this mean the once has not been already called !
		require
			object_value_not_void: object_value /= Void
			is_once: a_feat.is_once
			has_result: a_feat.is_function
		local
			l_class_c: CLASS_C
			l_origin_clc: CLASS_C

			l_icd_frame: ICOR_DEBUG_FRAME
			l_eifnet_debugger: EIFNET_DEBUGGER
			l_once_data: TUPLE [called: BOOLEAN; exc: ICOR_DEBUG_VALUE; res: ICOR_DEBUG_VALUE]
		do
				--| In case the once is attached to an ancestor
			l_origin_clc := a_feat.written_class
			l_eifnet_debugger := Eifnet_debugger

			l_class_c := l_origin_clc
			if l_class_c = Void then
				l_class_c := dynamic_class
			end

			if l_class_c /= Void then
				l_icd_frame := eifnet_debugger.current_stack_icor_debug_frame
				if a_feat.is_object_relative_once then
					l_once_data := l_eifnet_debugger.object_relative_once_function_data (l_icd_frame, address, l_class_c, a_feat.associated_feature_i)
				else
					l_once_data := l_eifnet_debugger.once_function_data (l_icd_frame, l_class_c, a_feat.associated_feature_i)
				end
					--|FIXME: Handle Unicode
				if l_once_data /= Void then
					if not l_once_data.called then
						Result := error_value (a_feat.name_32.as_string_8 , "Not yet called")
					elseif l_once_data.exc /= Void then
						Result := exception_value (a_feat.name_32.as_string_8, "Exception occurred", debug_value_from_icdv (l_once_data.exc, Void))
					else
						if l_once_data.res /= Void then
							Result := debug_value_from_icdv (l_once_data.res, a_feat.type.associated_class)
							Result.set_name (a_feat.name_32.as_string_8)
						end
					end
				else
					Result := error_value (a_feat.name_32.as_string_8 , "Could not retrieve information")
				end
			end

			debug ("DEBUGGER_TRACE")
				print ("- " + a_feat.written_class.name_in_upper + " ")
				print (">>" + a_feat.name_32.as_string_8 + " Result /= Void =? " + (Result /= Void).out + "%N")
			end
		end

feature {NONE} -- Implementation

	internal_dynamic_class: like dynamic_class

	internal_dynamic_class_type: like dynamic_class_type;

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class EIFNET_DEBUG_REFERENCE_VALUE
