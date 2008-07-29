indexing
	description: "Objects join all debug values: STRING, INTEGER, BOOLEAN, REFERENCES, ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DUMP_VALUE

inherit
	ANY

	DUMP_VALUE_CONSTANTS
		export
			{NONE} all
		end

	DEBUG_EXT
		export
			{NONE} all
		end

	HEXADECIMAL_STRING_CONVERTER
		export
			{NONE} all
		end

	DEBUG_OUTPUT_SYSTEM_I
		export
			{NONE} all
		end

	GENERATING_TYPE_SYSTEM_I
		export
			{NONE} all
		end

	RECV_VALUE
		export
			{NONE} all
			{RECV_VALUE} reset_recv_value
		end

	SHARED_EIFNET_DEBUGGER
		export
			{NONE} all
		end

create {DUMP_VALUE_FACTORY}
	make_empty

feature {DUMP_VALUE_FACTORY} -- Initialization

	make_empty (dbg: like debugger_manager) is
		do
			debugger_manager := dbg
			is_dotnet_system := debugger_manager.is_dotnet_project
			is_dotnet_value := is_dotnet_system
		end

	debugger_manager: DEBUGGER_MANAGER

feature {DUMP_VALUE_FACTORY} -- Preferences related

	debug_output_evaluation_enabled: BOOLEAN
			-- Is debug output enabled ?

	set_debug_output_evaluation_enabled (b: like debug_output_evaluation_enabled) is
		do
			debug_output_evaluation_enabled := b
		end

feature {DUMP_VALUE_FACTORY} -- Restricted Initialization

	set_void_value  (dtype: CLASS_C) is
		do
			value_address := Void
			type := Type_object
			dynamic_class := dtype
		end

	set_object_value  (value: STRING; dtype: CLASS_C) is
			-- make a object item initialized to `value'
		do
			value_address := value
			type := Type_object
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	set_expanded_object_value  (addr: STRING; dtype: CLASS_C) is
			-- Make an expanded object item of type `dtype'.
		require
			dtype_not_void: dtype /= Void
		do
			value_address := addr
			type := Type_expanded_object
			dynamic_class := dtype
		ensure
			value_address_set: value_address = addr
			type_set: type = type_expanded_object
			dynamic_class_set: dynamic_class = dtype
		end

	set_manifest_string_value (value: STRING; dtype: CLASS_C) is
			-- make a string item initialized to `value'
		do
			value_string := value
			type := Type_manifest_string
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	set_exception_value  (value: EXCEPTION_DEBUG_VALUE) is
		do
			value_exception := value
			type := Type_exception
			dynamic_class := value_exception.dynamic_class
		end

	set_procedure_return_value  (value: PROCEDURE_RETURN_DEBUG_VALUE) is
		do
			procedure_return_value := value
			type := Type_procedure_return
			dynamic_class := Void
		end

feature -- change

	set_icd_value_dotnet (v: like value_dotnet) is
			-- Set `value_dotnet' as `v'
		do
			value_dotnet := v
		end

feature -- Dotnet access

	is_dotnet_system: BOOLEAN
			-- Is current related to a dotnet system ?

	is_classic_system: BOOLEAN is
		do
			Result := not is_dotnet_system
		end

	is_dotnet_value: BOOLEAN
			-- Is Current represent a typical dotnet value ?
			-- (String are processing in a special way)

feature {DUMP_VALUE, ES_OBJECTS_GRID_LINE, DBG_EXPRESSION_EVALUATOR, DBG_EVALUATOR, APPLICATION_EXECUTION_DOTNET} -- Internal basic data

	value_dotnet: ICOR_DEBUG_VALUE
			-- Dotnet value as an ICorDebugValue interface

feature {NONE} -- Dotnet specific

	dotnet_value_class_name: STRING is
			-- Class name for the dotnet value
		require
			is_dotnet_system
		do
			check only_dotnet: is_dotnet_value end
			Result := "Dotnet Type"
		ensure
			Result /= Void
		end

	dotnet_string_representation (min, max: INTEGER): STRING_32 is
			-- String representation for dotnet value
			-- with bounds from `min' and `max'.
		require
			is_dotnet_system
		do
			check only_dotnet: is_dotnet_value end
		end

	dotnet_generating_type_evaluated_string: STRING is
		require
			is_stopped: debugger_manager.safe_application_is_stopped
			is_valid_eiffel_type: dynamic_class /= Void and then not dynamic_class.is_true_external
			is_dotnet_value: is_dotnet_value
		do
			check only_dotnet: is_dotnet_value end
		end

feature -- Status report

	same_as (other: DUMP_VALUE): BOOLEAN is
			-- Do `Current' and `other' represent the same object, in the equality sense?
		require
			valid_other: other /= Void
		do
			Result := type = other.type and then output_value (False).is_equal (other.output_value (False))
		end

	to_basic: DUMP_VALUE is
			-- Convert `Current' from a reference value to a basic value, if possible.
			-- If impossible, return `Current'.
		require
			is_reference: address /= Void
		local
			attribs: DS_LIST [ABSTRACT_DEBUG_VALUE]
			l_attribs_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
			att: ABSTRACT_DEBUG_VALUE
		do
			debug ("debug_recv")
				print (generator + ".to_basic%N")
			end
			attribs := debugger_manager.object_manager.attributes_at_address (address, 0, 0)
			if attribs /= Void then
				from
					l_attribs_cursor := attribs.new_cursor
					l_attribs_cursor.start
				until
					l_attribs_cursor.after
				loop
					att := l_attribs_cursor.item
					if att.name.is_equal ("item") then
						Result := att.dump_value
					end
					l_attribs_cursor.forth
				end
			end
			if Result = Void then
				Result := Current
			end
		end

	has_formatted_output: BOOLEAN is
			-- Does `Current' have an associated string representation?
			-- yes if it is a STRING, or conform to STRING
			-- or conform to DEBUG_OUTPUT
		local
			dc: CLASS_C
			string_c, string_32_c, system_string_c: CLASS_C
			comp_data: DEBUGGER_DATA_FROM_COMPILER
		do
			if type = Type_manifest_string then
				Result := True
			elseif type = Type_string_dotnet then
				Result := not is_void
			elseif is_type_object and not is_void then
				if dynamic_class /= Void then
					comp_data := debugger_manager.compiler_data
					string_c := comp_data.string_8_class_c
					string_32_c := comp_data.string_32_class_c
					system_string_c := comp_data.system_string_class_c
					if
						string_c /= Void
						and then dynamic_class.simple_conform_to (string_c)
					then
						Result := True
					elseif
						string_32_c /= Void
						and then dynamic_class.simple_conform_to (string_32_c)
					then
						Result := True
					elseif
						system_string_c /= Void
						and then dynamic_class.simple_conform_to (system_string_c)
					then
						Result := True
					elseif debug_output_evaluation_enabled then
						dc := debuggable_class
						Result := dc /= Void and then
								  dynamic_class.simple_conform_to (dc)
					end
				end
			end
			debug ("debug_recv")
				print ("DUMP_VALUE.has_formatted_output is ")
				print (Result)
				print ("%N")
			end
		end

	formatted_output: STRING_32 is
			-- Output of the call to `debug_output' on `Current', if any.
		require
			has_formatted_output: has_formatted_output
		local
			l_str: STRING_32
			l_max: INTEGER
		do
			debug ("debugger_interface")
				io.put_string ("Finding output value of dump_value%N")
			end
			if type = Type_manifest_string then
				debug ("debugger_interface")
					io.put_string ("Finding output value of constant string")
				end
				Result := Character_routines.eiffel_string_32 (value_string)
--			elseif type = Type_string_dotnet and then value_string_dotnet = Void then
					--| Handled by DUMP_VALUE_DOTNET
			else
				l_max := debugger_manager.displayed_string_size
					--| if l_max = -1, then do no truncate upper string

				l_str := truncated_string_representation (0, l_max)
				if l_str /= Void then
					if (l_max > 0) and then last_string_representation_length > (l_max - 0 + 1) then
						l_str.append ("...")
					end
					create Result.make (l_str.count)
					Result.append (Character_routines.eiffel_string_32 (l_str))
				else
						--| Should not occurs since precondition
						--| is `has_formatted_output'
					check should_not_occurs: False end
					Result := "`debug_output` disabled !"
				end
			end
		ensure
			not_void: Result /= Void
		end

	full_output: STRING is
			-- Complete output, including string representation.
			--| `output_value' = "This is a string"
		do
			Result := output_value (True).twin
			if type /= Type_manifest_string and has_formatted_output then
				Result.append_character (' ')
				Result.append_character ('=')
				Result.append_character (' ')
				Result.append_character ('%"')
				Result.append (formatted_output)
				Result.append_character ('%"')
			end
			debug ("debug_recv")
				print ("Output is ")
				print (Result)
				print ("%N")
			end
		end

	output_for_debugger: STRING_32 is
			-- Displayed output, including string representation.
			--| but remove address value
		do
			if has_formatted_output then
				Result := formatted_output.twin
			else
				Result := output_value (False).twin
			end
			debug ("debug_recv")
				print ("Output is ")
				print (Result)
				print ("%N")
			end
		end

	hexa_output_for_debugger: STRING_32 is
			-- Displayed output, including string representation.
			--| but remove address value
		do
			if has_formatted_output then
				Result := output_for_debugger
			else
				Result := hexa_output_value.twin
			end
			debug ("debug_recv")
				print ("Output is ")
				print (Result)
				print ("%N")
			end
		end

	last_string_representation_length: INTEGER
			-- Length of last string_representation Result

	formatted_truncated_string_representation (min, max: INTEGER): STRING_32 is
		local
			i: INTEGER
		do
			Result := truncated_string_representation (min, max)
			from
				i := 1
			until
				i > Result.count
			loop
				inspect Result.item (i)
				when '%U' then
					Result.put ('U', i)
					Result.insert_character ('%%', i)
					i := i + 2
				when '%R' then
					Result.put ('R', i)
					Result.insert_character ('%%', i)
					i := i + 2
				when '%%' then
					if i + 1 <= Result.count and then Result.item (i + 1) = 'R' then
						Result.insert_character ('%%', i)
						i := i + 1
					end
					i := i + 1
				else
					i := i + 1
				end
			end
		end

	string_representation: STRING_32 is
			-- Complete string value representation.
			-- it can be Void!
		do
			if address /= Void and has_formatted_output then
				Result := raw_string_representation (0, -1)
			end
		end

	truncated_string_representation (min, max: INTEGER): STRING_32 is
			-- truncated string value representation.
			--| if max < 0 then do not truncate the upper part of the string
		do
			Result := raw_string_representation (min, max)
			if Result = Void then
				Result := "Could not find string representation"
			end
		ensure
			truncated_string_representation_not_void: Result /= Void
		end

feature {DUMP_VALUE} -- string_representation Implementation

	raw_string_representation (min, max: INTEGER): STRING_32 is
			-- Get the `debug_output' representation with bounds from `min' and `max'.
			-- Special characters are not converted but '%U's are replaced by '%/1/' .
		require
			object_with_debug_output: address /= Void and has_formatted_output
		do
			debug ("debugger_trace", "debug_recv")
				print (generating_type + ".raw_string_representation (" + min.out + ", " + max.out + ") from " + dynamic_class.name_in_upper +" %N")
			end
			last_string_representation_length := 0
			if is_dotnet_value then
				Result := dotnet_string_representation (min, max)
			else
				Result := classic_string_representation (min, max)
			end
		end

	classic_string_representation (min, max: INTEGER): STRING_32 is
			-- String representation for classic value
			-- with bounds from `min' and `max'.
		require
			is_classic_system
		local
			f: E_FEATURE
			l_attributes: DS_LIST [ABSTRACT_DEBUG_VALUE]
			l_attributes_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
			l_attributes_item: ABSTRACT_DEBUG_VALUE
			cv_spec: SPECIAL_VALUE
			int_value: DEBUG_BASIC_VALUE [INTEGER]
			area_attribute: SPECIAL_VALUE
			count_attribute: DEBUG_BASIC_VALUE [INTEGER]
			l_count: INTEGER
			sc, sc8, sc32: CLASS_C
			done: BOOLEAN
			l_area_name, l_count_name: STRING
			l_slice_max: INTEGER
			comp_data: DEBUGGER_DATA_FROM_COMPILER
		do
			if dynamic_class /= Void then
				comp_data := debugger_manager.compiler_data
				sc8 := comp_data.string_8_class_c
				sc32 := comp_data.string_32_class_c
				if dynamic_class = sc8 or dynamic_class = sc32 then
					sc := dynamic_class
					l_area_name := area_name
					l_count_name := count_name
				else
					if dynamic_class.simple_conform_to (sc8) then
						sc := sc8
					elseif dynamic_class.simple_conform_to (sc32) then
						sc := sc32
					end
					if sc /= Void then
							--| Take name of `area' and `count' from STRING or STRING_32 in descendant version.
							--| since STRING.area and STRING_32.area are not inherited from STRING_GENERAL
							--| we have to test the 2 cases : STRING and STRING_32
						f := sc.feature_with_name (area_name).ancestor_version (dynamic_class)
						l_area_name := f.name
						f := sc.feature_with_name (count_name).ancestor_version (dynamic_class)
						l_count_name := f.name
					end
				end
			end
			if l_area_name /= Void and l_count_name /= Void then
					--| Getting count value and area object
					--| we set slices to 1,1 to avoid receiving all the capacity item of SPECIAL
					--| since here only the printable characters matter

				if value_address /= Void then
					l_attributes := debugger_manager.object_manager.attributes_at_address (value_address, 0, 0)
				end
				if l_attributes /= Void then
					from
						l_attributes_cursor := l_attributes.new_cursor
						l_attributes_cursor.start
					until
						l_attributes_cursor.after or done
					loop
						l_attributes_item := l_attributes_cursor.item
						cv_spec ?= l_attributes_item
						if
							(area_attribute = Void and cv_spec /= Void) and then
							cv_spec.name.is_equal (l_area_name)
						then
							area_attribute := cv_spec
							done := count_attribute /= Void
						elseif count_attribute = Void and cv_spec = Void then
							int_value ?= l_attributes_item
							if int_value /= Void and then int_value.name.is_equal (l_count_name) then
								count_attribute := int_value
								done := area_attribute /= Void
							end
						end
						l_attributes_cursor.forth
					end
						--| At the point `count' from STRING should have been found in
						--| STRING object. `area' maybe Void, thus `area_attribute' may not be found.
					check
						count_attribute_found: count_attribute /= Void
					end
					if count_attribute /= Void then
						l_count := count_attribute.value
						if l_count = 0 then
							Result := ""
						else
							if area_attribute /= Void then
									--| Now we have the real count, we'll get the l_slice_max items
									--| and not all the capacity
								if max < 0 then
									l_slice_max := l_count - 1
								else
									l_slice_max := max.min (l_count - 1)
								end
								area_attribute.reset_items
								area_attribute.get_items (min, l_slice_max)
								Result := area_attribute.truncated_raw_string_value (l_count)
							end
						end
					end
				end
				if Result /= Void and then Result.count > l_count then
						--| We now have retrieved the full `area' of STRING object. Let's check
						--| if we need to display the complete area, or just part of it.
					Result.keep_head (l_count.min (Result.count))
				end
				last_string_representation_length := l_count
			elseif debug_output_evaluation_enabled then
				Result := classic_debug_output_evaluated_string (min, max)
			end
		end

	classic_debug_output_evaluated_string (min, max: INTEGER): STRING_32 is
			-- Evaluation of DEBUG_OUTPUT.debug_output: STRING on object related to Current	
		require
			is_classic_system
		local
			l_final_result_value: DUMP_VALUE
			l_feat: FEATURE_I
		do
			if debugger_manager.safe_application_is_stopped then
				if dynamic_class /= Void then
					l_feat := debug_output_feature_i (dynamic_class)
					l_final_result_value := classic_feature_result_value_on_current (l_feat, dynamic_class)

					if l_final_result_value /= Void and then not l_final_result_value.is_void then
						Result := l_final_result_value.classic_string_representation (min, max)
						last_string_representation_length := l_final_result_value.last_string_representation_length
					end
				end
			end
		end

	generating_type_evaluated_string: STRING is
			-- Full generic type using evaluation of generating_type on the related object
			-- WARNING: This has to be an Eiffel type (descendant of ANY to implement generating_type)
		require
			is_valid_eiffel_type: dynamic_class /= Void and then not dynamic_class.is_true_external
		do
			if debugger_manager.safe_application_is_stopped then
				if is_dotnet_value then
					Result := dotnet_generating_type_evaluated_string
				else
					Result := classic_generating_type_evaluated_string
				end
				if Result /= Void then
					Result.prune_all ('%U')
				end
			end
		end

feature {NONE} -- Classic specific

	classic_generating_type_evaluated_string: STRING is
		require
			is_stopped: debugger_manager.safe_application_is_stopped
			is_valid_eiffel_type: dynamic_class /= Void and then not dynamic_class.is_true_external
			is_classic_system: is_classic_system
		local
			l_feat: FEATURE_I
			l_final_result_value: DUMP_VALUE
		do
			l_feat := generating_type_feature_i (dynamic_class)
			l_final_result_value := classic_feature_result_value_on_current (l_feat, dynamic_class)

			if l_final_result_value /= Void and then not l_final_result_value.is_void then
				Result := l_final_result_value.classic_string_representation (0, -1)
			end
		end

	classic_feature_result_value_on_current (a_feat: FEATURE_I; a_compiled_class: CLASS_C): DUMP_VALUE is
			-- Evaluation of `a_feat': STRING on object related to Current dump_value
			--| FIXME: duplication with DBG_EVALUATOR_CLASSIC.effective_evaluate_routine...
		local
			l_dbg_val: ABSTRACT_DEBUG_VALUE
			l_dbg_obj: DEBUGGED_OBJECT_CLASSIC
			par: INTEGER
			rout_info: ROUT_INFO
			l_dtype: CLASS_C
			l_dyntype: CLASS_TYPE
		do
			check
				running_and_stopped: debugger_manager.safe_application_is_stopped
			end
			if a_feat /= Void and debugger_manager.application.is_valid_object_address (value_address) then
					-- Initialize the communication.
				l_dbg_obj := debugger_manager.object_manager.classic_debugged_object_with_class (value_address, a_compiled_class)
				l_dtype := l_dbg_obj.dynamic_class
				if l_dtype = a_compiled_class or else l_dtype.simple_conform_to (a_compiled_class) then
					l_dyntype := l_dbg_obj.class_type
					if a_feat.is_attribute then
						l_dbg_val := l_dbg_obj.attribute_by_name (a_feat.feature_name)
						if l_dbg_val /= Void then
							Result := l_dbg_val.dump_value
						end
					else
						Init_recv_c
						classic_send_value
						if a_feat.is_external then
							par := par + 1
						end

						if a_feat.written_class.is_precompiled then
							par := par + 2
							rout_info := Eiffel_system.system.rout_info_table.item (a_feat.rout_id_set.first)
							send_rqst_4_integer (Rqst_dynamic_eval, rout_info.offset, rout_info.origin, l_dyntype.type_id - 1, par)
						else
							send_rqst_4_integer (Rqst_dynamic_eval, a_feat.feature_id, l_dyntype.static_type_id - 1, 0, par)
						end
							-- Receive the Result.
						recv_value (Current)
						if is_exception then
							Result := Void --| exception_item
						else
							if item /= Void then
								item.set_hector_addr
								Result := item.dump_value
							end
						end
						reset_recv_value
					end
				end
			end
		end

feature -- Action

	classic_send_value is
			-- send the value the application
		require
			is_classic_system
		local
			value_string_c: ANY
		do
			inspect (type)
			when Type_manifest_string then
				fixme("We should handle STRING_32 on the runtime side of the debuger")
				value_string_c := value_string.as_string_8.to_c
				send_string_value ($value_string_c)
			when Type_object, Type_expanded_object then
				if value_address /= Void then
					send_ref_value (hex_to_pointer (value_address))
				else
					send_ref_value (Default_pointer)
				end
			else
					--| Basic type are handled by DUMP_VALUE_BASIC
				check not is_basic end
				-- unexpected value, do nothing
				debug("DEBUGGER")
					io.put_string ("Error: unexpected value in [DUMP_VALUE]send_value%N")
				end
			end
		end

feature -- Access

	generating_type_representation (generating_type_evaluation_enabled: BOOLEAN): STRING is
			-- {TYPE}.generating_type string representation
		local
			l_generating_type_string: STRING
		do
			create Result.make (100)

			if is_void then
				if dynamic_class /= Void then
					if dynamic_class.is_true_external then
						Result := dynamic_class.external_class_name
					else
						Result := dynamic_class.name_in_upper
					end
				else
					Result := "NONE"
				end
			elseif dynamic_class /= Void then
				if is_dotnet_value and then dynamic_class.is_true_external then
					l_generating_type_string := dotnet_value_class_name
				elseif dynamic_class.is_true_external then
					l_generating_type_string := dynamic_class.external_class_name
				elseif dynamic_class.is_generic or dynamic_class.is_tuple then
					if generating_type_evaluation_enabled then
						l_generating_type_string := generating_type_evaluated_string
					end
				elseif type = type_bits then
					l_generating_type_string := as_dump_value_basic.type_of_bits
				end
				if l_generating_type_string	/= Void then
					Result := l_generating_type_string
				else
					Result := dynamic_class.name_in_upper
				end
			else
				Result := "NONE"
			end
		ensure
			Result_not_void: Result /= Void
		end

	output_value (format_result: BOOLEAN): STRING_32 is
			-- String representation of the value of `Current'.
			-- If `format_result' is True, add the " and other if needed
			--   otherwise return the raw value's output
			--|
			--|   True
			--|   97 'a'
			--|   123
			--|   value_string  or "value_string"
			--|   <0x12345678>
			--|   Void
		local
			s: STRING_32
		do
			inspect type
			when Type_manifest_string then
				if format_result then
					create Result.make (value_string.count + 2)
					Result.append_character ('%"')
					Result.append (value_string.as_string_8)
					Result.append_character ('%"')
				else
					Result := value_string.as_string_8.twin
				end
			when Type_string_dotnet , Type_object, type_expanded_object then
				if value_address /= Void then
					create Result.make (value_address.count + 2)
					Result.append_character ('<')
					Result.append (value_address)
					Result.append_character ('>')
					s := extra_output_details
					if s /= Void then
						Result.append (s)
					end
				else
					if type = type_expanded_object then
						Result := ""
					else
						Result := "Void"
					end
				end
			when Type_procedure_return then
				Result := "Procedure returned"
			when Type_exception then
				Result := "Exception occurred"

--			when
--				Type_boolean,
--				Type_character_8,
--				Type_character_32,
--				Type_natural_8,
--				Type_natural_16,
--				Type_natural_32,
--				Type_natural_64,
--				Type_integer_8,
--				Type_integer_16,
--				Type_integer_32,
--				Type_integer_64,
--				Type_real_32,
--				Type_real_64,
--				Type_bits,
--				Type_pointer
--			then
--				--| Is handled by DUMP_VALUE_BASIC class
			else
				check is_not_basic: not is_basic end
				Result := ""
			end
		ensure
			not_void: Result /= Void
		end

	extra_output_details: STRING_32 is
		do
		end

	to_minimal_hexa_representation (s: STRING): STRING is
			-- Hexa representation of `s' representing the hexa string
			-- from INTEGER.to_hex_string
 		require
			s_not_empty: s /= Void and then s.count > 0
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > s.count or Result /= Void
			loop
				if s.item (i) /= '0' then
					Result := s.substring (i, s.count)
				end
				i := i + 1
			end
			if Result = Void then
				Result := "0"
			end
			Result.prepend (once "0x")
		ensure
			Result_not_void: Result /= Void
		end

	hexa_output_value: STRING_32 is
			-- String representation of the value of `Current'.
			--| True
			--| 0x61 'a'
			--| 123
			--| "value _string"
			--| <0x12345678>
			--| Void
		do
				--| Basic type should be handled by DUMP_VALUE_BASIC
			Result := output_value (True)
		ensure
			not_void: Result /= Void
		end

	address: STRING is
			-- If it makes sense, return the address of current object.
			-- Void if `is_void' or if `Current' does not represent an object.
		do
			if type = Type_object or type = Type_string_dotnet or type = Type_manifest_string then
				Result := value_address
			elseif is_type_exception and value_exception /= Void then
				Result := value_exception.address
			end
		end

	dynamic_class: CLASS_C
			-- Dynamic Class of `Current'. Void iff `is_void'.

	dynamic_class_type: CLASS_TYPE
			-- Dynamic Class Type of `Current'. Void if `is_void'.
			-- Used only in Reference dotnet context (for now)

	is_void: BOOLEAN is
			-- Is `Current' a Void reference?
		do
			Result := ((type = Type_object or type = Type_string_dotnet) and address = Void)
		end

	is_basic: BOOLEAN is
			-- Is `Current' of a basic type?
		do
			Result := not is_type_object
				and not is_exception
				and type /= Type_manifest_string
				and type /= Type_string_dotnet
		end

feature -- Conversion

	as_dump_value_basic: DUMP_VALUE_BASIC is
			--
		require
			is_basic: is_basic
		do
			Result ?= Current
		ensure
			Result_not_void: Result /= Void
		end

	as_dump_value_dotnet: DUMP_VALUE_DOTNET is
			--
		require
			is_dotnet_value: is_dotnet_value
		do
			Result ?= Current
		ensure
			Result_not_void: Result /= Void
		end

feature {DBG_EVALUATOR} -- Convertor

	manifest_string_to_dump_value_object: DUMP_VALUE is
			-- Current manifest string converted to an instance of STRING.
		require
			is_type_manifest_string
		local
			s: STRING_8
		do
			fixme ("This is a temporary safe solution for 6.1, later we'll need to redesign part of debugger's data+evaluator")
			s := value_string
			if s /= Void then
				Result := debugger_manager.expression_evaluation ("(%"" + s + "%").twin")
			end
			if Result = Void then
				Result := debugger_manager.dump_value_factory.new_void_value (debugger_manager.compiler_data.string_8_class_c)
			end
		end

feature {DEBUGGER_EXPORTER, DUMP_VALUE, DBG_EXPRESSION_EVALUATOR, DBG_EVALUATOR} -- Internal data

	value_address	: STRING -- string standing for the address of the object if type=Type_object
	value_string    : STRING_32 -- String value
	value_exception : EXCEPTION_DEBUG_VALUE
	procedure_return_value: PROCEDURE_RETURN_DEBUG_VALUE

	type: INTEGER
		-- type discrimant, possible values are Type_XXXX

--| Useless now, using inspect on 'type' is enought
	is_type_boolean: BOOLEAN is do end -- False
	is_type_integer_32: BOOLEAN is do end -- False

	is_type_object: BOOLEAN is
			-- Is Current value corresponding to an object or an expanded object?
		do
			Result := type = Type_object or type = type_expanded_object
		end

	is_type_manifest_string: BOOLEAN is do Result := type = Type_manifest_string end
--	is_type_expanded: BOOLEAN is do Result := type = Type_expanded_object end
	is_type_exception: BOOLEAN is do Result := type = Type_exception end
	is_type_procedure_return: BOOLEAN is do Result := type = Type_procedure_return end

feature {NONE} -- Private Constants

	area_name: STRING is "area"
	count_name: STRING is "count"

	character_routines: CHARACTER_ROUTINES is
			-- To have a printable output of Eiffel strings that have
			-- non-printable characters.
		once
			create Result
		ensure
			character_routines_not_void: Result /= Void
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

end -- class DUMP_VALUE
