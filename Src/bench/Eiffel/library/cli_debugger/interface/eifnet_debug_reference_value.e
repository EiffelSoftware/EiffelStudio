indexing
	description: "Dotnet debug value associated with Reference value"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_REFERENCE_VALUE

inherit
	ABSTRACT_REFERENCE_VALUE
		redefine
			kind
		end
	
	COMPILER_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end
		
	ICOR_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end		

	DEBUG_VALUE_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end				

	SHARED_EIFNET_DEBUG_VALUE_FACTORY
		export
			{NONE} all
		undefine
			is_equal
		end				

	SHARED_IL_DEBUG_INFO_RECORDER
		export
			{NONE} all
		undefine
			is_equal
		end				

create {RECV_VALUE, ATTR_REQUEST,CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
	make
--, make_attribute
	
feature {NONE} -- Initialization

	make (a_referenced_value: like referenced_value; a_prepared_value: like value; f: like icd_frame) is
			-- 	Set `value' to `v'.
		require
			a_referenced_value_not_void: a_referenced_value /= Void
			a_prepared_value_not_void: a_prepared_value /= Void
			a_frame_not_void: f /= Void
		do
			set_default_name
			referenced_value := a_referenced_value
			value := a_prepared_value
			icd_frame := f

			create value_info.make (value)
			object_value := value_info.interface_debug_object_value
			if object_value /= Void then
				value_class_token := value_info.value_class_token
				value_module_file_name := value_info.value_module_file_name		
			end

			is_null := value_info.is_null
			if not is_null then
				address := value_info.address_as_hex_string
				if dynamic_class_type = Void then
					is_external_type := True
				end
			end
		ensure
			value_set: value = a_prepared_value
		end

--	make_attribute (attr_name: like name; a_class: like e_class; v: like value) is
--			-- Set `attr_name' to `name' and `value' to `v'.
--		require
--			not_attr_name_void: attr_name /= Void
--			v_not_void: v /= Void
--		do
--			name := attr_name
--			if a_class /= Void then
--				e_class := a_class
--				is_attribute := True
--			end
--			value := v
--		ensure
--			value_set: value = v
--		end		

feature -- Access

	icd_frame: ICOR_DEBUG_FRAME

	referenced_value: ICOR_DEBUG_VALUE
			-- Original ICorDebugValue from Debugger
			-- not dereferenced !
			-- may be useful to ICorDebugEval::CallFunction ...
	value: ICOR_DEBUG_VALUE
			-- Value of object.

	object_value: ICOR_DEBUG_OBJECT_VALUE

	value_info: EIFNET_DEBUG_VALUE_INFO

	value_class_token: INTEGER

	value_module_file_name: STRING

	dynamic_class: CLASS_C is
			-- Find corresponding CLASS_C to type represented by `value'.
		local
			l_class_type: CLASS_TYPE
		do
			Result := internal_dynamic_class
			if Result = Void then
				l_class_type := dynamic_class_type
				if l_class_type /= Void then
					Result := internal_dynamic_class_type.associated_class
					internal_dynamic_class := Result
				end
			end
		end

	dynamic_class_type: CLASS_TYPE is
		do
			Result := internal_dynamic_class_type
			if Result = Void then
				if not is_null then
					check
						value_module_file_name_valid: value_module_file_name /= Void
						value_class_token_valid: value_class_token > 0
					end
					Result := Il_debug_info_recorder.class_type_for_module_class_token (value_module_file_name, value_class_token)
					if Result = Void then
						--| This means we are dealing with an external type (dotnet)
						Result := Eiffel_system.System.system_object_class.compiled_class.types.first
						is_external_type := True
					end
					internal_dynamic_class_type := Result
				end
			end
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
			create Result.make_object_for_dotnet (
					icd_frame, 
					referenced_value, 
					value_info.interface_debug_object_value, 
					value_class_token,
					address, 
					dynamic_class_type, 
					is_null,
					is_external_type
					)
		end

feature {NONE} -- Output

	type_and_value: STRING is
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
					Result.append (Left_square_bracket)
					Result.append (address)
					Result.append (Right_square_bracket)
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
		
	children: LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. 
			-- May be void if there are no children.
			-- Generated on demand.
		local
			l_feature_table: FEATURE_TABLE
			l_feature_i: FEATURE_I
			l_att_token: INTEGER

			l_att_icd_debug_value: ICOR_DEBUG_VALUE
			l_att_debug_value: ABSTRACT_DEBUG_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
		do
			create {LINKED_LIST [ABSTRACT_DEBUG_VALUE]} Result.make
			if dynamic_class /= Void then
				l_icd_class := object_value.get_class
				l_feature_table := dynamic_class.feature_table
				from
					l_feature_table.start
				until
					l_feature_table.after
				loop
					l_feature_i := l_feature_table.item_for_iteration
					debug ("DEBUGGER_TRACE_CHILDREN")
						print (">>> CHILDREN :: "+ l_feature_i.feature_name +"<<<%N")
						print ("%T - from feature_i     => "+l_feature_i.written_class.name_in_upper+"."+l_feature_i.feature_name+ " :: " + l_feature_i.written_class.class_id.out + "%N")
						print ("%T - from dynamic_class => "+dynamic_class.name_in_upper+"."+l_feature_i.feature_name+ " :: " + dynamic_class.class_id.out + "%N")
					end

					if l_feature_i.is_attribute then
						--| FIXME: JFIAT : which class_type to use ?
						l_att_token := Il_debug_info_recorder.feature_token_for_feat_and_class_type (l_feature_i, dynamic_class_type) 
						if l_att_token /= 0 then
							l_att_icd_debug_value := object_value.get_field_value (l_icd_class, l_att_token)
							if l_att_icd_debug_value /= Void then
								l_att_debug_value := Eifnet_debug_value_factory.debug_value_from (l_att_icd_debug_value, icd_frame)
								l_att_debug_value.set_name (l_feature_i.feature_name)
								Result.extend (l_att_debug_value)
							end
						end
					end
					l_feature_table.forth
				end
			end
		ensure then
			Result /= Void
		end
		
	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			if is_null then
				Result := Void_value
			else
				if is_external_type then
					Result := External_reference_value
				else
					Result := Reference_value
				end
			end
		end

feature -- Once request

	once_function_value (a_feat: E_FEATURE): ABSTRACT_DEBUG_VALUE is
			-- If Result = Void, this mean the once has not been already called !
		require
			is_once: a_feat.is_once
			has_result: a_feat.is_function
		local
			l_once_info_tokens: TUPLE [INTEGER, INTEGER]
			l_done_token: INTEGER
			l_result_token: INTEGER

			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_debug_value: ICOR_DEBUG_VALUE

			l_icd_module: ICOR_DEBUG_MODULE

			l_origin_class_c: CLASS_C
			l_origin_class_token: INTEGER
			l_origin_class_module_name: STRING

			l_once_already_called: BOOLEAN

			l_cl_type_a: CL_TYPE_A
			l_adapted_class_type: CLASS_TYPE
			l_class_type_list: LIST [CLASS_TYPE]
		do
			--| In case the once is attached to an ancestor
			--| we need to access the static of the correct ICOR_DEBUG_CLASS
			l_origin_class_c := a_feat.written_class
			if dynamic_class.is_equal (l_origin_class_c) then
				--| The Once is inherited
				l_icd_class := object_value.get_class
				l_adapted_class_type := dynamic_class_type
			else
				if l_origin_class_c.types.count = 1 then
					l_adapted_class_type := l_origin_class_c.types.first
				else
					--| The Once is inherited
	
					--| let's search and find the correct CLASS_TYPE among the parents
					--| this will solve the problem of inherited once and generic class
					--| the level on inheritance is represented by the CLASS_C
					--| then the derivation of the GENERIC by the CLASS_TYPE
					--| among the parent we know the right CLASS_TYPE
					--| so first we localite the CLASS_C then we keep the CLASS_TYPE					
					l_cl_type_a := dynamic_class_type.type.type_a
					l_adapted_class_type := l_cl_type_a.find_class_type (l_origin_class_c).type_i.associated_class_type
				end

				check
					found_item_is_correct: l_adapted_class_type /= Void 
							and then l_adapted_class_type.associated_class = l_origin_class_c
				end

				l_origin_class_module_name := Il_debug_info_recorder.module_file_name_for_class (l_adapted_class_type)
				l_icd_module := Application.imp_dotnet.eifnet_debugger.Eifnet_debugger_info.icor_module (l_origin_class_module_name)
				if l_icd_module /= Void then
						--| It may occurs the ICorDebugModule is not yet loaded
					l_origin_class_token := Il_debug_info_recorder.class_token (l_origin_class_module_name, l_adapted_class_type)
					l_icd_class := l_icd_module.get_class_from_token (l_origin_class_token)
				end
			end

			if l_icd_class /= Void then
					--| now we have the correct ICOR_DEBUG_CLASS as l_icd_class
					--| and we know the good CLASS_TYPE as 
				l_once_info_tokens := Il_debug_info_recorder.once_feature_tokens_for_feat_and_class_type (a_feat.associated_feature_i, l_adapted_class_type)
				l_done_token := l_once_info_tokens.integer_item (1)
				l_result_token := l_once_info_tokens.integer_item (2)	
				
					--| Check if already called (_done)
				if l_done_token /= 0 then
					l_icd_debug_value := l_icd_class.get_static_field_value (l_done_token, icd_frame)
					if l_icd_debug_value /= Void then
						l_icd_debug_value := Debug_value_formatter.prepared_debug_value (l_icd_debug_value)
						l_once_already_called := Debug_value_formatter.prepared_icor_debug_value_as_boolean (l_icd_debug_value)
					end
				end

					--| if already called then get the value (_result)
				if l_once_already_called then
					if l_result_token /= 0 then
						l_icd_debug_value := l_icd_class.get_static_field_value (l_result_token, icd_frame)
						if l_icd_debug_value /= Void then
							Result := Eifnet_debug_value_factory.debug_value_from (l_icd_debug_value, icd_frame)
							Result.set_name (a_feat.name)
						end
					end
				end

				debug ("DEBUGGER_TRACE")
					print ("- " + l_origin_class_c.name_in_upper + " ")
					print (">>" + a_feat.name 
							+ " done[0x"+l_done_token.to_hex_string+"] result[0x"+l_result_token.to_hex_string+"] "
							+ "%N%T -> " + l_once_already_called.out
							+ " Result /= Void =? " + (Result /= Void).out
							+ "%N"
					) 
				end
			end
		end

	Debug_value_formatter: EIFNET_DEBUG_VALUE_FORMATTER is
			-- Formatter of data contained in ICOR_DEBUG_VALUE objects
		once
			create Result
		end

feature {NONE} -- Implementation

	internal_dynamic_class: like dynamic_class

	internal_dynamic_class_type: like dynamic_class_type

end -- class EIFNET_DEBUG_REFERENCE_VALUE
