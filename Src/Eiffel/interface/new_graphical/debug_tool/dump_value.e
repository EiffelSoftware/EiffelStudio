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

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	BEURK_HEXER
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_APPLICATION_EXECUTION
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
		end

	IPC_SHARED
		export
			{NONE} all
		end

	SHARED_DEBUGGED_OBJECT_MANAGER
		export
			{NONE} all
		end

	SHARED_EIFNET_DEBUGGER

create
	make_void,
	make_boolean, make_character, make_wide_character,
	make_integer_32, make_integer_64,
	make_natural_32, make_natural_64,
	make_real,
	make_double, make_pointer, make_object,	make_manifest_string,
	make_string_for_dotnet, make_object_for_dotnet, make_bits,
	make_expanded_object,
	make_exception

feature -- Initialization

	init is
			-- Common initialization
		do
			is_dotnet_system := Application.is_dotnet
			is_dotnet_value := is_dotnet_system
		end

	make_void (dtype: CLASS_C) is
		do
			init
			value_address := Void
			type := Type_object
			dynamic_class := dtype
		end

	make_boolean(value: BOOLEAN; dtype: CLASS_C) is
			-- make a boolean item initialized to `value'
		do
			init
			value_boolean := value
			type := Type_boolean
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_character(value: CHARACTER; dtype: CLASS_C) is
			-- make a character item initialized to `value'
		do
			init
			value_character := value
			type := Type_character
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_wide_character(value: WIDE_CHARACTER; dtype: CLASS_C) is
			-- make a wide_character item initialized to `value'
		do
			init
			value_wide_character := value
			print (generator + ".make_wide_character (" + value.out + " /" + value.natural_32_code.out + "/ %N")
			type := Type_wide_character
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_integer_32 (value: INTEGER; dtype: CLASS_C) is
			-- make a integer item initialized to `value'
		do
			init
			value_integer_32 := value
			type := Type_integer_32
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_integer_64 (value: INTEGER_64; dtype: CLASS_C) is
			-- make a integer_64 item initialized to `value'
		do
			init
			value_integer_64 := value
			type := Type_integer_64
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_natural_32 (value: NATURAL_32; dtype: CLASS_C) is
			-- make a integer item initialized to `value'
		do
			init
			value_natural_32 := value
			type := Type_natural_32
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_natural_64 (value: NATURAL_64; dtype: CLASS_C) is
			-- make a integer_64 item initialized to `value'
		do
			init
			value_natural_64 := value
			type := Type_natural_64
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_real(value: REAL; dtype: CLASS_C) is
			-- make a real item initialized to `value'
		do
			init
			value_real := value
			type := type_real_32
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_double(value: DOUBLE; dtype: CLASS_C) is
			-- make a double item initialized to `value'
		do
			init
			value_double := value
			type := type_real_64
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_pointer(value: POINTER; dtype: CLASS_C) is
			-- make a pointer item initialized to `value'
		do
			init
			value_pointer := value
			type := Type_pointer
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_object (value: STRING; dtype: CLASS_C) is
			-- make a object item initialized to `value'
		do
			init
			value_address := value
			type := Type_object
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_expanded_object (dtype: CLASS_C) is
			-- Make an expanded object item of type `dtype'.
		require
			dtype_not_void: dtype /= Void
		do
			init
			value_address := Void
			type := Type_expanded_object
			dynamic_class := dtype
		ensure
			value_address_set: value_address = Void
			type_set: type = type_expanded_object
			dynamic_class_set: dynamic_class = dtype
		end

	make_bits (a_value, a_type: STRING; dtype: CLASS_C) is
			-- Make bit item of type `a_type' and class `dtype'
			-- initialized with `value'.
		require
			a_value_not_void: a_value /= Void
			a_type_not_void: a_type /= Void
			dtype_not_void: dtype /= Void
		do
			init
			value_bits := a_value
			type_of_bits := a_type
			type := Type_bits
			dynamic_class := dtype
		ensure
			type_set: type /= Type_unknown
			dynamic_class_set: dynamic_class = dtype
			value_bits_set: value_bits = a_value
			type_of_bits_set: type_of_bits = a_type
		end

	make_manifest_string (value: STRING; dtype: CLASS_C) is
			-- make a string item initialized to `value'
		do
			init
			value_string := value
			type := Type_string
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_exception (value: EXCEPTION_DEBUG_VALUE) is
		do
			init
			value_exception := value
			type := Type_exception
			dynamic_class := value_exception.dynamic_class
		end

feature -- Dotnet creation

	make_string_for_dotnet (a_eifnet_dsv: EIFNET_DEBUG_STRING_VALUE) is
			-- make a object ICorDebugStringValue item initialized to `value'
		require
			arg_not_void: a_eifnet_dsv /= Void
		do
			init
			is_dotnet_value := True
			eifnet_debug_value := a_eifnet_dsv
			value_dotnet := eifnet_debug_value.icd_referenced_value

			value_string_dotnet := a_eifnet_dsv.icd_value_info.interface_debug_string_value
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

	make_object_for_dotnet (a_eifnet_drv: EIFNET_DEBUG_REFERENCE_VALUE) is
			-- make a object ICorDebugObjectValue item initialized to `value'
		require
			arg_not_void: a_eifnet_drv /= Void
		do
			init
			is_dotnet_value := True
			eifnet_debug_value := a_eifnet_drv
			value_dotnet := eifnet_debug_value.icd_referenced_value
			icd_value_info := a_eifnet_drv.icd_value_info
			value_class_token := a_eifnet_drv.value_class_token
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

feature -- Dotnet access

	is_dotnet_system: BOOLEAN
			-- Is current related to a dotnet system ?

	is_classic_system: BOOLEAN is
		do
			Result := not is_dotnet_value
		end

	is_dotnet_value: BOOLEAN
			-- Is Current represent a typical dotnet value ?
			-- (String are processing in a special way)

	is_external_type: BOOLEAN
			-- Is the value corresponding to an external type ?
			-- (ex: like SystemObject for dotnet)

	eifnet_debug_value: EIFNET_ABSTRACT_DEBUG_VALUE
			-- Debug value related to `value_dotnet'

	value_dotnet: ICOR_DEBUG_VALUE
			-- Dotnet value as an ICorDebugValue interface

	value_string_dotnet: ICOR_DEBUG_STRING_VALUE
			-- ICorDebugStringValue for the dotnet String

	value_frame_dotnet: ICOR_DEBUG_FRAME is
			-- ICorDebugFrame in this DUMP_VALUE context
		do
			Result := Eifnet_debugger.current_stack_icor_debug_frame
		end

feature -- change

	set_value_dotnet (v: like value_dotnet) is
			-- Set `value_dotnet' as `v'
		do
			value_dotnet := v
		end

feature {NONE} -- Implementation dotnet

	new_value_object_dotnet: ICOR_DEBUG_OBJECT_VALUE is
			-- Dotnet value as an ICorDebugObjectValue interface
		do
			if icd_value_info /= Void then
				Result := icd_value_info.new_interface_debug_object_value
			end
		end

	icd_value_info: EIFNET_DEBUG_VALUE_INFO

	value_class_token: INTEGER
			-- Class token for the dotnet value

	value_class_name: STRING is
			-- Class name for the dotnet value
		local
			l_edvi: EIFNET_DEBUG_VALUE_INFO
		do
			if not is_external_type and then dynamic_class/= Void then
				Result := dynamic_class.name_in_upper
			elseif is_dotnet_value and is_external_type then
				l_edvi := eifnet_debug_value.icd_value_info
				if l_edvi /= Void and then l_edvi.has_object_interface then
					Result := l_edvi.value_class_name
				else
					Result := "{Token=0x" + value_class_token.to_hex_string + "}"
				end
			end
			if Result = Void then
				Result := "Unknown Type"
			end
		ensure
			Result /= Void
		end

feature -- Status report

	same_as (other: DUMP_VALUE): BOOLEAN is
			-- Do `Current' and `other' represent the same object, in the equality sense?
		require
			valid_other: other /= Void
		do
			Result := type = other.type and then output_value.is_equal (other.output_value)
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
			attribs := Debugged_object_manager.attributes_at_address (address, 0, 0)
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
			string_c, system_string_c: CLASS_I
		do
			if type = Type_string then
				Result := True
			elseif type = Type_string_dotnet then
				Result := not is_void
			elseif is_type_object and not is_void then
				if dynamic_class /= Void then
					string_c := Eiffel_system.system.string_class
					system_string_c := eiffel_system.system.system_string_class
					if
						string_c /= Void
						and then string_c.is_compiled
						and then dynamic_class.simple_conform_to (string_c.compiled_class)
					then
						Result := True
					elseif
						system_string_c /= Void
						and then system_string_c.is_compiled
						and then dynamic_class.simple_conform_to (system_string_c.compiled_class)
					then
						Result := True
					elseif preferences.debug_tool_data.debug_output_evaluation_enabled then
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

	formatted_output: STRING is
			-- Output of the call to `debug_output' on `Current', if any.
		require
			has_formatted_output
		local
			l_str: STRING
			l_max: INTEGER
		do
			debug ("debugger_interface")
				io.put_string ("Finding output value of dump_value%N")
			end
			if type = Type_string then
				debug ("debugger_interface")
					io.put_string ("Finding output value of constant string")
				end
				Result := "%"" + Character_routines.eiffel_string (value_string) + "%""
			elseif type = Type_string_dotnet and value_string_dotnet = Void then
				Result := "%"" + Character_routines.eiffel_string (value_string) + "%""
			else
				l_max := Application.displayed_string_size
				l_str := truncated_string_representation (0, l_max)
				if l_str /= Void then
					if (l_max > 0) and then last_string_representation_length > (l_max - 0 + 1) then
						l_str.append ("...")
					end
					create Result.make (Application.displayed_string_size + 2)
					Result.append_character ('%"')
					Result.append (Character_routines.eiffel_string (l_str))
					Result.append_character ('%"')
				else
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
			Result := output_value.twin
			if type /= type_string and has_formatted_output then
				Result.append_character (' ')
				Result.append_character ('=')
				Result.append_character (' ')
				Result.append (formatted_output)
			end
			debug ("debug_recv")
				print ("Output is ")
				print (Result)
				print ("%N")
			end
		end

	output_for_debugger: STRING is
			-- Displayed output, including string representation.
			--| but remove address value
		do
			if has_formatted_output then
				Result := formatted_output.twin
			else
				Result := output_value.twin
			end
			debug ("debug_recv")
				print ("Output is ")
				print (Result)
				print ("%N")
			end
		end

	hexa_output_for_debugger: STRING is
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

	formatted_truncated_string_representation (min, max: INTEGER): STRING is
		do
			Result := truncated_string_representation (min, max)
			Result.replace_substring_all ("%U", "%%U")
		end

	truncated_string_representation (min, max: INTEGER): STRING is
		do
			Result := raw_string_representation (min, max)
			if Result = Void then
				Result := "Could not find string representation"
			end
		ensure
			truncated_string_representation_not_void: Result /= Void
		end

feature {DUMP_VALUE} -- string_representation Implementation

	raw_string_representation (min, max: INTEGER): STRING is
			-- Get the `debug_output' representation with bounds from `min' and `max'.
			-- Special characters are not converted but '%U's are replaced by '%/1/' .
		require
			object_with_debug_output: address /= Void and has_formatted_output
		do
			debug ("debugger_trace")
				print (generating_type + ".raw_string_representation (" + min.out + ", " + max.out + ")%N")
			end

			debug ("debug_recv")
				print ("DUMP_VALUE.raw_string_representation of " + dynamic_class.name_in_upper + "%N")
			end
			last_string_representation_length := 0
			if is_dotnet_value then
				Result := dotnet_string_representation (min, max)
			else
				Result := classic_string_representation (min, max)
			end
		end

	classic_string_representation (min, max: INTEGER): STRING is
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
			int_value: DEBUG_VALUE [INTEGER]
			area_attribute: SPECIAL_VALUE
			count_attribute: DEBUG_VALUE [INTEGER]
			l_count: INTEGER
			sc: CLASS_C
			l_conform_to_string, done: BOOLEAN
			l_area_name, l_count_name: STRING
			l_slice_max: INTEGER
		do
			sc := Eiffel_system.string_class.compiled_class
			l_conform_to_string := dynamic_class /= Void
										and then dynamic_class /= sc
										and then dynamic_class.simple_conform_to (sc)
			if dynamic_class = sc or l_conform_to_string then
				if l_conform_to_string then
						--| Take name of `area' and `count' from STRING in descendant version.
					f := sc.feature_with_name (area_name).ancestor_version (dynamic_class)
					l_area_name := f.name
					f := sc.feature_with_name (count_name).ancestor_version (dynamic_class)
					l_count_name := f.name
				else
					l_area_name := area_name
					l_count_name := count_name
				end
					--| Getting count value and area object
					--| we set slices to 1,1 to avoid receiving all the capacity item of SPECIAL
					--| since here only the printable characters matter

				if value_address /= Void then
					l_attributes := Debugged_object_manager.attributes_at_address (value_address, 0, 0)
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
				if Result /= Void then
						--| We now have retrieved the full `area' of STRING object. Let's check
						--| if we need to display the complete area, or just part of it.
					Result.keep_head (l_count.min (Result.count))
				end
				last_string_representation_length := l_count
			else
				Result := classic_debug_output_evaluated_string (min, max)
			end
		end

	dotnet_string_representation (min, max: INTEGER): STRING is
			-- String representation for dotnet value
			-- with bounds from `min' and `max'.
		require
			is_dotnet_system
		local
			sc: CLASS_C
			si: CLASS_I
			l_conformed_to_sc: BOOLEAN
			l_eifnet_debugger: EIFNET_DEBUGGER
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
			l_size: INTEGER
		do
			l_eifnet_debugger := Application.imp_dotnet.eifnet_debugger

			sc := Eiffel_system.system.string_class.compiled_class
			l_conformed_to_sc := dynamic_class /= Void and then dynamic_class /= sc and then dynamic_class.simple_conform_to (sc)
			if dynamic_class = sc or l_conformed_to_sc then
				l_icdov := new_value_object_dotnet
				if l_icdov = Void then
					Result := "Void"
				else
					Result := l_eifnet_debugger.string_value_from_string_class_value (value_dotnet, l_icdov, min, max)
					last_string_representation_length := l_eifnet_debugger.last_string_value_length
					l_icdov.clean_on_dispose
				end
			else
				si := Eiffel_system.system.system_string_class
				if si /= Void and then si.is_compiled then
					sc := si.compiled_class
					l_conformed_to_sc := dynamic_class /= Void and then dynamic_class /= sc and then dynamic_class.simple_conform_to (sc)
					if dynamic_class = sc or l_conformed_to_sc then
						if value_string_dotnet /= Void then
							Result := l_eifnet_debugger.string_value_from_system_string_class_value (value_string_dotnet, min, max)
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
		end

	dotnet_debug_output_evaluated_string (a_dbg: EIFNET_DEBUGGER; min, max: INTEGER): STRING is
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

	classic_debug_output_evaluated_string (min, max: INTEGER): STRING is
			-- Evaluation of DEBUG_OUTPUT.debug_output: STRING on object related to Current	
		require
			is_classic_system
		local
			l_final_result_value: DUMP_VALUE
			l_feat: FEATURE_I
		do
			if application.is_running and application.is_stopped then
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
		local
			l_feat: FEATURE_I
			l_final_result_value: DUMP_VALUE
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
		do
			if application.is_running and application.is_stopped then
				if preferences.debug_tool_data.generating_type_evaluation_enabled then
					l_feat := generating_type_feature_i (dynamic_class)
					if application.is_dotnet then
						if dynamic_class_type /= Void then
							l_icdov := new_value_object_dotnet
							if l_icdov /= Void then
								Result := Application.imp_dotnet.eifnet_debugger.generating_type_value_from_object_value (
											value_frame_dotnet,
											value_dotnet,
											l_icdov,
											dynamic_class_type,
											l_feat
										)
								l_icdov.clean_on_dispose
							end
						end
					else
						l_final_result_value := classic_feature_result_value_on_current (l_feat, dynamic_class)

						if l_final_result_value /= Void and then not l_final_result_value.is_void then
							Result := l_final_result_value.classic_string_representation (0, -1)
						end
					end
				end
				if Result /= Void then
					Result.prune_all ('%U')
				end
			end
		end

	classic_feature_result_value_on_current (a_feat: FEATURE_I; a_compiled_class: CLASS_C): DUMP_VALUE is
			-- Evaluation of `a_feat': STRING on object related to Current dump_value
		local
			l_dbg_val: ABSTRACT_DEBUG_VALUE
			l_dbg_obj: DEBUGGED_OBJECT_CLASSIC
			par: INTEGER
			rout_info: ROUT_INFO
			l_dtype: CLASS_C
			l_dyntype: CLASS_TYPE
		do
			check
				running_and_stopped: Application.is_running and Application.is_stopped
			end
			if a_feat /= Void and Application.is_valid_object_address (value_address) then
					-- Initialize the communication.
				l_dbg_obj := Debugged_object_manager.classic_debugged_object_with_class (value_address, a_compiled_class)
				l_dtype := l_dbg_obj.dtype
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
							send_rqst_3_integer (Rqst_dynamic_eval, rout_info.offset, rout_info.origin, par)
						else
							send_rqst_3_integer (Rqst_dynamic_eval, a_feat.feature_id, l_dyntype.static_type_id - 1, par)
						end
							-- Receive the Result.
						recv_value (Current)
						if is_exception_trace then

							reset_recv_value
						else
							if item /= Void then
								item.set_hector_addr
								Result := item.dump_value
								clear_item
							end
						end
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
				when Type_boolean then
					send_bool_value(value_boolean)
				when Type_character then
					send_char_value(value_character)
				when Type_wide_character then
					send_wchar_value(value_wide_character)
				when Type_integer_32 then
					send_integer_value (value_integer_32)
				when Type_integer_64 then
					send_integer_64_value (value_integer_64)
				when type_real_32 then
					send_real_value(value_real)
				when type_real_64 then
					send_double_value(value_double)
				when Type_pointer then
					send_ptr_value(value_pointer)
				when Type_string then
					value_string_c := value_string.to_c
					send_string_value($value_string_c)
				when Type_object, Type_expanded_object then
					if value_address /= Void then
						send_ref_value (hex_to_pointer (value_address))
					else
						send_ref_value (Default_pointer)
					end
				else
					-- unexpected value, do nothing
					debug("DEBUGGER")
						io.put_string ("Error: unexpected value in [DUMP_VALUE]send_value%N")
					end
			end
		end

feature -- Access

	type_and_value: STRING is
			-- String representation of the type and value of `Current'.
			--| dynamic CLASS_NAME = `full_output'
		do
			create Result.make (100)

			Result.append (generating_type_representation)
			if is_void then
				Result.append (" = Void")
			elseif dynamic_class /= Void then
				if is_type_object or type = Type_string_dotnet then
					Result.append_character (' ')
				else
					Result.append_character (' ')
					Result.append_character ('=')
					Result.append_character (' ')
				end
				Result.append (full_output)
			else
				Result.append (full_output)
			end
		end

	generating_type_representation: STRING is
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
					l_generating_type_string := value_class_name
				elseif dynamic_class.is_true_external then
					l_generating_type_string := dynamic_class.external_class_name
				elseif dynamic_class.is_generic or dynamic_class.is_tuple then
					l_generating_type_string := generating_type_evaluated_string
				elseif type = type_bits then
					l_generating_type_string := type_of_bits
				end
				if l_generating_type_string	/= Void then
					Result := l_generating_type_string
				else
					Result := dynamic_class.name_in_upper
				end
			else
				Result := "ANY"
			end
		end

	output_value: STRING is
			-- String representation of the value of `Current'.
			--| True
			--| '/123/ :'C'
			--| 123
			--| "value _string"
			--| <0x12345678>
			--| Void
		do
			inspect type
			when Type_boolean then
				Result := value_boolean.out
			when Type_character then
				create Result.make (10)
				Result.append_character ('/')
				Result.append_integer (value_character.code)
				Result.append ("/ : %'")
				Result.append (Character_routines.char_text (value_character))
				Result.append_character ('%'')
			when Type_wide_character then
				create Result.make (10)
				Result.append_character ('/')
				Result.append_integer (value_wide_character.code)
				Result.append ("/ : %'")
				Result.append (Character_routines.wchar_text (value_wide_character))
				Result.append_character ('%'')
			when Type_natural_32 then
				Result := value_natural_32.out
			when Type_natural_64 then
				Result := value_natural_64.out
			when Type_integer_32 then
				Result := value_integer_32.out
			when Type_integer_64 then
				Result := value_integer_64.out
			when type_real_32 then
				Result := value_real.out
			when type_real_64 then
				Result := value_double.out
			when Type_bits then
				Result := value_bits
			when Type_string then
				create Result.make (value_string.count + 2)
				Result.append_character ('%"')
				Result.append (value_string)
				Result.append_character ('%"')
			when Type_string_dotnet , Type_object, type_expanded_object then
				if value_address /= Void then
					create Result.make (value_address.count + 2)
					Result.append_character ('<')
					Result.append (value_address)
					Result.append_character ('>')
				else
					if type = type_expanded_object then
						Result := ""
					else
						Result := "Void"
					end
				end
			when Type_pointer then
				Result := value_pointer.out
			else
				Result := ""
			end
		ensure
			not_void: Result /= Void
		end

	hexa_output_value: STRING is
			-- String representation of the value of `Current'.
			--| True
			--| '/123/ :'C'
			--| 123
			--| "value _string"
			--| <0x12345678>
			--| Void
		local
			l_0x: STRING
		do
			l_0x := once "0x"
			inspect type
			when Type_character then
				create Result.make (10)
				Result.append_character ('/')
				Result.append_string (l_0x)
				Result.append_string (value_character.code.to_hex_string)
				Result.append ("/ : %'")
				Result.append (Character_routines.char_text (value_character))
				Result.append_character ('%'')
			when Type_wide_character then
				create Result.make (10)
				Result.append_character ('/')
				Result.append_string (l_0x)
				Result.append_string (value_wide_character.code.to_hex_string)
				Result.append ("/ : %'")
				Result.append (Character_routines.wchar_text (value_wide_character))
				Result.append_character ('%'')
			when Type_natural_32 then
				Result := l_0x + value_natural_32.to_hex_string
			when Type_natural_64 then
				Result := l_0x + value_natural_64.to_hex_string
			when Type_integer_32 then
				Result := l_0x + value_integer_32.to_hex_string
			when Type_integer_64 then
				Result := l_0x + value_integer_64.to_hex_string
			else
				Result := output_value
			end
		ensure
			not_void: Result /= Void
		end

	address: STRING is
			-- If it makes sense, return the address of current object.
			-- Void if `is_void' or if `Current' does not represent an object.
		do
			if type = Type_object or type = Type_string_dotnet then
				Result := value_address
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
			Result := not is_type_object and type /= Type_string and type /= Type_string_dotnet
		end

feature {DUMP_VALUE, EB_OBJECT_TREE_ITEM, ES_OBJECTS_GRID_LINE, EIFNET_EXPORTER, DBG_EXPRESSION_EVALUATOR} -- Internal data

	value_boolean	: BOOLEAN
	value_character	: CHARACTER
	value_wide_character : WIDE_CHARACTER
	value_integer_32: INTEGER
	value_integer_64: INTEGER_64
	value_natural_32: NATURAL_32
	value_natural_64: NATURAL_64
	value_real		: REAL
	value_double	: DOUBLE
	value_bits		: STRING
	type_of_bits	: STRING
	value_pointer	: POINTER
	value_address	: STRING -- string standing for the address of the object if type=Type_object
	value_string    : STRING -- String value

	value_exception : EXCEPTION_DEBUG_VALUE


	type: INTEGER
		-- type discrimant, possible values are Type_XXXX

--| Useless now, using inspect on 'type' is enought
--	is_type_unknown       : BOOLEAN is do Result := type = Type_unknown end
	is_type_boolean       : BOOLEAN is do Result := type = Type_boolean end
--	is_type_character     : BOOLEAN is do Result := type = Type_character end
--	is_type_integer_32       : BOOLEAN is do Result := type = Type_integer_32 end
--	is_type_real          : BOOLEAN is do Result := type = type_real_32 end
--	is_type_double        : BOOLEAN is do Result := type = type_real_64 end
--	is_type_bits          : BOOLEAN is do Result := type = Type_bits end
--	is_type_pointer       : BOOLEAN is do Result := type = Type_pointer end

	is_type_object: BOOLEAN is
			-- Is Current value corresponding to an object or an expanded object?
		do
			Result := type = Type_object or type = type_expanded_object
		end

	is_type_string        : BOOLEAN is do Result := type = Type_string end
--	is_type_string_dotnet : BOOLEAN is do Result := type = Type_string_dotnet end
--	is_type_integer_64    : BOOLEAN is do Result := type = Type_integer_64 end
	is_type_expanded      : BOOLEAN is do Result := type = Type_expanded_object end

	is_type_exception     : BOOLEAN is do Result := type = Type_exception end

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
