note
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

	SHARED_LOCALE
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

	SHARED_ENCODING_CONVERTER
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER

create {DUMP_VALUE_FACTORY}
	make_empty

feature {DUMP_VALUE_FACTORY} -- Initialization

	make_empty (dbg: like debugger_manager)
		do
			debugger_manager := dbg
			is_dotnet_system := debugger_manager.is_dotnet_project
			is_dotnet_value := is_dotnet_system
		end

	debugger_manager: DEBUGGER_MANAGER

feature {DUMP_VALUE_FACTORY} -- Preferences related

	debug_output_evaluation_enabled: BOOLEAN
			-- Is debug output enabled ?

	set_debug_output_evaluation_enabled (b: like debug_output_evaluation_enabled)
		do
			debug_output_evaluation_enabled := b
		end

feature {DUMP_VALUE_FACTORY} -- Restricted Initialization

	set_void_value  (dtype: CLASS_C)
		do
			value_address := Void
			type := Type_object
			dynamic_class := dtype
		end

	set_object_value  (value: DBG_ADDRESS; dtype: CLASS_C; scp_pid: like scoop_processor_id)
			-- make a object item initialized to `value'
		do
			value_address := value
			type := Type_object
			dynamic_class := dtype
			scoop_processor_id := scp_pid
		ensure
			type /= Type_unknown
		end

	set_expanded_object_value  (addr: DBG_ADDRESS; dtype: CLASS_C; scp_pid: like scoop_processor_id)
			-- Make an expanded object item of type `dtype'.
		require
			dtype_not_void: dtype /= Void
		do
			value_address := addr
			type := Type_expanded_object
			dynamic_class := dtype
			scoop_processor_id := scp_pid
		ensure
			value_address_set: value_address = addr
			type_set: type = type_expanded_object
			dynamic_class_set: dynamic_class = dtype
		end

	set_manifest_string_value (value: STRING; dtype: CLASS_C)
			-- make a string item initialized to `value'
		require
			value_attached: value /= Void
		do
			value_string := value
			type := Type_manifest_string
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	set_manifest_string_32_value (value: STRING_32; dtype: CLASS_C)
			-- make a string item initialized to `value'
		require
			value_attached: value /= Void
		local
			utf: UTF_CONVERTER
		do
			value_string := utf.string_32_to_utf_8_string_8 (value)
			type := type_manifest_string_32
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	set_exception_value  (value: EXCEPTION_DEBUG_VALUE)
		do
			value_exception := value
			type := Type_exception
			dynamic_class := value_exception.dynamic_class
			scoop_processor_id := value.scoop_processor_id
		end

	set_procedure_return_value  (value: PROCEDURE_RETURN_DEBUG_VALUE)
		do
			procedure_return_value := value
			type := Type_procedure_return
			dynamic_class := Void
		end

feature -- Status

	is_invalid_value: BOOLEAN
			-- Is Current an invalid value?

	is_valid_value: BOOLEAN
			-- Is Current a valid value?
		do
			Result := not is_invalid_value
		end

feature -- change

	invalidate_value
			-- Mark Current as invalid value
		do
			is_invalid_value := True
		end

	set_icd_value_dotnet (v: like value_dotnet)
			-- Set `value_dotnet' as `v'
		do
			value_dotnet := v
		end

feature -- Dotnet access

	is_dotnet_system: BOOLEAN
			-- Is current related to a dotnet system ?

	is_classic_system: BOOLEAN
		do
			Result := not is_dotnet_system
		end

	is_dotnet_value: BOOLEAN
			-- Is Current represent a typical dotnet value ?
			-- (String are processing in a special way)

feature {DUMP_VALUE, DBG_EXPRESSION_EVALUATOR, DBG_EVALUATOR, APPLICATION_EXECUTION_DOTNET} -- Internal basic data

	value_dotnet: ICOR_DEBUG_VALUE
			-- Dotnet value as an ICorDebugValue interface

feature {NONE} -- Dotnet specific

	dotnet_value_class_name: STRING_32
			-- Class name for the dotnet value
		require
			is_dotnet_system
		do
			check only_dotnet: is_dotnet_value end
			Result := "Dotnet Type"
		ensure
			Result /= Void
		end

	dotnet_string_representation (min, max: INTEGER): STRING_32
			-- String representation for dotnet value
			-- with bounds from `min' and `max'.
		require
			is_dotnet_system
		do
			check only_dotnet: is_dotnet_value end
		end

	dotnet_generating_type_evaluated_string: STRING
		require
			is_stopped: debugger_manager.safe_application_is_stopped
			is_valid_eiffel_type: dynamic_class /= Void and then not dynamic_class.is_true_external
			is_dotnet_value: is_dotnet_value
		do
			check only_dotnet: is_dotnet_value end
		end

feature {DBG_EXPRESSION_EVALUATOR, DBG_EXPRESSION_EVALUATION} -- Status report

	identical_to (other: DUMP_VALUE): BOOLEAN
			-- Do `Current' and `other' represent the same object, in the ref equality sense?
		require
			other_attached: other /= Void
		do
			if type = other.type then
				inspect type
				when type_procedure_return then
					Result := True
				when type_object, type_exception, type_string_dotnet then
					Result := address.is_equal (other.address)
				when type_expanded_object then
					Result := output_value (False).is_equal (other.output_value (False))
					-- FIXME: this is really poor implementation ...
				else
					Result := output_value (False).is_equal (other.output_value (False))
				end
			else
				Result := False
			end
		end

feature -- Conversion

	to_basic: DUMP_VALUE
			-- Convert `Current' from a reference value to a basic value, if possible.
			-- If impossible, return `Current'.
		local
			attribs: DEBUG_VALUE_LIST
		do
			debug ("debug_recv")
				print (generator + ".to_basic%N")
			end
			if address /= Void and then not address.is_void then
				attribs := debugger_manager.object_manager.attributes_at_address (address, 0, 0)
				if attribs /= Void then
					Result := attribs.named_value ("item").dump_value
				end
				if Result = Void then
					Result := Current
				end
			end
		end

feature -- Status report

	has_formatted_output: BOOLEAN
			-- Does `Current' have an associated string representation?
			-- yes if it is a STRING, or conform to STRING
			-- or conform to DEBUG_OUTPUT
		local
			rs8_c, rs32_c, ss_c: detachable CLASS_C
			comp_data: DEBUGGER_DATA_FROM_COMPILER
		do
			if type = Type_manifest_string then
				Result := True
			elseif type = Type_manifest_string_32 then
				Result := True
			elseif type = Type_string_dotnet then
				Result := not is_void
			elseif is_type_object and not is_void then
				if attached dynamic_class as l_dynclass then
					comp_data := debugger_manager.compiler_data
					rs8_c := comp_data.readable_string_8_class_c
					rs32_c := comp_data.readable_string_32_class_c
					ss_c := comp_data.system_string_class_c
					if
						rs8_c /= Void
						and then l_dynclass.simple_conform_to (rs8_c)
					then
						Result := True
					elseif
						rs32_c /= Void
						and then l_dynclass.simple_conform_to (rs32_c)
					then
						Result := True
					elseif
						ss_c /= Void
						and then l_dynclass.simple_conform_to (ss_c)
					then
						Result := True
					elseif debug_output_evaluation_enabled then
						Result := attached debuggable_class as l_dbgclass and then
								  l_dynclass.simple_conform_to (l_dbgclass)
					end
				end
			end
			debug ("debug_recv")
				print ("DUMP_VALUE.has_formatted_output is ")
				print (Result)
				print ("%N")
			end
		end

	formatted_output: detachable STRING_32
			-- Output of the call to `debug_output' on `Current', if any.
		require
			has_formatted_output: has_formatted_output
		local
			l_max: INTEGER
			utf: UTF_CONVERTER
		do
			debug ("debugger_interface")
				io.put_string ("Finding output value of dump_value%N")
			end
			if type = Type_manifest_string or type = Type_manifest_string_32 then
				debug ("debugger_interface")
					io.put_string ("Finding output value of constant string")
				end
				Result := Character_routines.eiffel_string_32 (utf.utf_8_string_8_to_string_32 (value_string))
--			elseif type = Type_string_dotnet and then value_string_dotnet = Void then
					--| Handled by DUMP_VALUE_DOTNET
			else
				l_max := debugger_manager.displayed_string_size
					--| if l_max = -1, then do no truncate upper string

				if attached address as add then
					if
						attached truncated_string_representation (0, l_max) as l_str
					then
						if (l_max > 0) and then last_string_representation_length > (l_max - 0 + 1) then
							l_str.append_string_general ("...")
						end
						create Result.make (l_str.count)
						Result.append (Character_routines.eiffel_string_32 (l_str))
					else
							--| Should not occurs since precondition
							--| is `has_formatted_output'
						if add.has_offset then
								--| This should not occurs anymore, but let this for now
								--| TODO: 2009-09-22: remove after a few weeks of testing
							Result := "`debug_output' disabled on this expanded item!"
						else
							check error_reported: debugger_manager.application.error_reported end
						end
					end
				else
						--| Should not occurs since precondition
						--| is `has_formatted_output'
					check should_not_occurs: False end
				end
			end
		end

	full_output: STRING_32
			-- Complete output, including string representation.
			--| `output_value' = "This is a string"
		do
			Result := output_value (True).twin
			if
				(type /= Type_manifest_string or type /= Type_manifest_string_32) and
				has_formatted_output and then
				attached formatted_output as fo
			then
				Result.append_character (' ')
				Result.append_character ('=')
				Result.append_character (' ')
				Result.append_character ('%"')
				Result.append (fo)
				Result.append_character ('%"')
			end
			debug ("debug_recv")
				print ("Output is ")
				print (Result)
				print ("%N")
			end
		ensure
			full_output_not_void: Result /= Void
		end

	output_for_debugger: STRING_32
			-- Displayed output, including string representation.
			--| but remove address value
		local
			s: detachable STRING_32
		do
			if has_formatted_output then
				s := formatted_output
			end
			if s /= Void then
				create Result.make_from_string (s)
			else
				create Result.make_from_string (output_value (False))
			end
			debug ("debug_recv")
				print ("Output is ")
				print (Result)
				print ("%N")
			end
		ensure
			result_attached: Result /= Void
		end

	hexa_output_for_debugger: STRING_32
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


	string_representation: detachable STRING_32
			-- Complete string value representation.
			-- it can be Void!
		do
			if address /= Void and has_formatted_output then
				Result := truncated_string_representation (0, -1)
			end
		end

	attached_string_representation: STRING_32
			-- Complete string value representation.
			-- it can be Void!
		do
			if attached string_representation as s then
				Result := s
			else
				Result := no_string_representation_text
			end
		end

	formatted_truncated_string_representation (min, max: INTEGER): STRING_32
		local
			i: INTEGER
		do
			Result := attached_truncated_string_representation (min, max)
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

	truncated_string_representation (min, max: INTEGER): detachable STRING_32
			-- Get the `debug_output' representation with bounds from `min' and `max'.
			-- Special characters are not converted but '%U's are replaced by '%/1/' .
		require
			object_with_debug_output: has_formatted_output and address /= Void
		do
			debug ("debugger_trace", "debug_recv")
				localized_print
					(generating_type.name_32 + {STRING_32} ".truncated_string_representation (" +
					min.out + {STRING_32} ", " +
					max.out + {STRING_32} ") from " +
					dynamic_class.name_in_upper +{STRING_32} " %N")
			end
			last_string_representation_length := 0
			if is_dotnet_value then
				Result := dotnet_string_representation (min, max)
			else
				Result := classic_string_representation (min, max)
			end
		end

	attached_truncated_string_representation (min, max: INTEGER): STRING_32
			-- truncated string value representation.
			--| if max < 0 then do not truncate the upper part of the string
		do
			Result := truncated_string_representation (min, max)
			if Result = Void then
				Result := no_string_representation_text
			end
		ensure
			truncated_string_representation_not_void: Result /= Void
		end

feature {DUMP_VALUE} -- string_representation Implementation

	no_string_representation_text: STRING = "Could not find string representation"

	classic_string_representation (min, max: INTEGER): detachable STRING_32
			-- String representation for classic value
			-- with bounds from `min' and `max'.
		require
			is_classic_system
		local
			f: detachable E_FEATURE
			l_attributes: DEBUG_VALUE_LIST
			l_attributes_cursor: like {DEBUG_VALUE_LIST}.new_cursor
			l_attributes_item: ABSTRACT_DEBUG_VALUE
			done: BOOLEAN
			area_attribute: detachable SPECIAL_VALUE
			count_attribute, area_lower_attribute: detachable DEBUG_BASIC_VALUE [INTEGER]

			l_count: INTEGER
			s8_c, s32_c, sc: detachable CLASS_C
			l_area_name, l_count_name, l_area_lower_name: detachable READABLE_STRING_32
			l_area_lower_value: INTEGER
			l_slice_max: INTEGER
			comp_data: DEBUGGER_DATA_FROM_COMPILER
			rescued: BOOLEAN
		do
			if not rescued then
				if attached dynamic_class as l_dynamic_class then
					comp_data := debugger_manager.compiler_data

					s8_c := comp_data.string_8_class_c
					s32_c := comp_data.string_32_class_c

					if
						l_dynamic_class = s8_c
						or l_dynamic_class = s32_c
					then
						sc := l_dynamic_class
						l_area_name := area_name
						l_count_name := count_name
					else
						s8_c := comp_data.readable_string_8_class_c
						s32_c := comp_data.readable_string_32_class_c

						if s8_c /= Void and then l_dynamic_class.simple_conform_to (s8_c) then
							sc := s8_c
						elseif s32_c /= Void and then l_dynamic_class.simple_conform_to (s32_c) then
							sc := s32_c
						end
						if sc /= Void then
								--| Take name of `area' and `count' from (READABLE_)STRING_8 or (READABLE_)STRING_32 in descendant version.
								--| since (READABLE_)STRING.area and (READABLE_)STRING_32.area are not inherited from (READABLE_)STRING_GENERAL
								--| we have to test the 2 cases : STRING and STRING_32

							f := sc.feature_with_name (area_name).ancestor_version (l_dynamic_class)
							l_area_name := f.name_32
							f := sc.feature_with_name (count_name).ancestor_version (l_dynamic_class)
							l_count_name := f.name_32

								--| And also manage the IMMUTABLE_STRING_8 and _32 !
							s8_c := comp_data.immutable_string_8_class_c
							s32_c := comp_data.immutable_string_32_class_c
							if s8_c /= Void and then (s8_c = l_dynamic_class or else l_dynamic_class.simple_conform_to (s8_c)) then
								sc := s8_c
							elseif s32_c /= Void and then (s32_c = l_dynamic_class or else l_dynamic_class.simple_conform_to (s32_c)) then
								sc := s32_c
							else
								sc := Void
							end
							if sc /= Void then
								f := sc.feature_with_name (area_lower_name).ancestor_version (l_dynamic_class)
								if f /= Void then
									l_area_lower_name := f.name_32
								end
							end

								--| FIXME: Handle Unicode
								--| ....
						end
					end
				end
				if l_area_name /= Void and l_count_name /= Void then
						--| Getting count value and area object
						--| we set slices to 1,1 to avoid receiving all the capacity item of SPECIAL
						--| since here only the printable characters matter
					if value_address /= Void and then not value_address.is_void then
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
							if attached {SPECIAL_VALUE} l_attributes_item as cv_spec then
								if area_attribute = Void and then cv_spec.name.is_equal (l_area_name) then
									area_attribute := cv_spec
									done := count_attribute /= Void and (l_area_lower_name = Void or else area_lower_attribute /= Void)
								end
							elseif
								(count_attribute = Void or area_lower_attribute = Void) and then
								attached {DEBUG_BASIC_VALUE [INTEGER]} l_attributes_item as int_value
							then
								if count_attribute = Void and then int_value.name.is_equal (l_count_name) then
									count_attribute := int_value
									done := area_attribute /= Void and (l_area_lower_name = Void or else area_lower_attribute /= Void)
								elseif
									l_area_lower_name /= Void and then area_lower_attribute = Void and then
									int_value.name.is_equal (l_area_lower_name)
								then
									area_lower_attribute := int_value
									done := area_attribute /= Void and count_attribute /= Void
								end
							end
							l_attributes_cursor.forth
						end
		--| Useless:		from until l_attributes_cursor.after loop l_attributes_cursor.forth end					

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
									if area_lower_attribute /= Void then
										l_area_lower_value := area_lower_attribute.value
									else
										l_area_lower_value := 0
									end
									if max < 0 then
										l_slice_max := l_count - 1
									else
										l_slice_max := max.min (l_count - 1)
									end
									area_attribute.reset_items
									area_attribute.get_items (min + l_area_lower_value, l_area_lower_value + l_slice_max)
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
			else -- rescued
				Result := Void
			end
		rescue
			rescued := True
			retry
		end

	classic_debug_output_evaluated_string (min, max: INTEGER): detachable STRING_32
			-- Evaluation of DEBUG_OUTPUT.debug_output: STRING on object related to Current	
		require
			is_classic_system
		local
			l_feat: FEATURE_I
		do
			if
				debugger_manager.safe_application_is_stopped and then
				attached dynamic_class
			then
				l_feat := debug_output_feature_i (dynamic_class)
				if
					l_feat /= Void and then
					attached classic_feature_result_value_on_current (l_feat, dynamic_class) as l_final_result_value and then
					not l_final_result_value.is_void
				then
					Result := l_final_result_value.classic_string_representation (min, max)
					last_string_representation_length := l_final_result_value.last_string_representation_length
				end
			end
		end

	generating_type_evaluated_string: detachable STRING_32
			-- Full generic type using evaluation of generating_type on the related object
			-- WARNING: This has to be an Eiffel type (descendant of ANY to implement generating_type)
		require
			is_valid_eiffel_type: dynamic_class /= Void and then not dynamic_class.is_true_external
		do
			if debugger_manager.safe_application_is_stopped then
				Result := debugger_manager.application.debugger_type_string_evaluation (Current, Void)
				if Result.is_empty then
						--| In case the RT_ .. classes are not up to date.
						--| TODO: 2009-09-16: remove this after next release.
					if is_dotnet_value then
						Result := dotnet_generating_type_evaluated_string
					else
						Result := classic_generating_type_evaluated_string
					end
				end
				if Result /= Void then
					Result.prune_all ('%U')
				end
			end
		end

feature {NONE} -- Classic specific

	classic_generating_type_evaluated_string: detachable STRING_32
		require
			is_stopped: debugger_manager.safe_application_is_stopped
			is_valid_eiffel_type: dynamic_class /= Void and then not dynamic_class.is_true_external
			is_classic_system: is_classic_system
		local
			l_feat: FEATURE_I
		do
			l_feat := generating_type_feature_i (dynamic_class)
			if
				l_feat /= Void and then
				attached classic_feature_result_value_on_current (l_feat, dynamic_class) as l_final_result_value and then
				not l_final_result_value.is_void
			then
				Result := l_final_result_value.classic_string_representation (0, -1)
			end
		end

	classic_feature_result_value_on_current (a_feat: FEATURE_I; a_compiled_class: CLASS_C): detachable DUMP_VALUE
			-- Evaluation of `a_feat': STRING on object related to Current dump_value
			--| FIXME: duplication with DBG_EVALUATOR_CLASSIC.effective_evaluate_routine...
		local
			l_dbg_val: ABSTRACT_DEBUG_VALUE
			l_dbg_obj: DEBUGGED_OBJECT_CLASSIC
			l_dtype: CLASS_C
			l_dyntype: CLASS_TYPE
		do
			check
				running_and_stopped: debugger_manager.safe_application_is_stopped
			end
			if
				a_feat /= Void and then
				not debugger_manager.application.error_reported and then
				debugger_manager.application.is_valid_and_known_object_address (value_address)
			then
					-- Initialize the communication.
				l_dbg_obj := debugger_manager.object_manager.classic_debugged_object_with_class (value_address, a_compiled_class)
				if not l_dbg_obj.is_erroneous then
					l_dtype := l_dbg_obj.dynamic_class
					if l_dtype = a_compiled_class or else l_dtype.simple_conform_to (a_compiled_class) then
						if a_feat.is_attribute then
							l_dbg_val := l_dbg_obj.attribute_by_name (a_feat.feature_name)
							if l_dbg_val /= Void then
								Result := l_dbg_val.dump_value
							end
						else
							Init_recv_c
							classic_send_value
							if last_classic_send_value_succeed then
								l_dyntype := l_dbg_obj.class_type
								send_rqst_3_integer (Rqst_dynamic_eval, a_feat.rout_id_set.first, l_dyntype.type_id - 1, 0)

									-- Receive the Result.
								recv_value (Current)
								if error then
									debugger_manager.application.report_error
									Result := Void -- Error ...
								else
									if is_exception then
										Result := Void --| exception_item
									else
										if item /= Void then
											item.set_hector_addr
											Result := item.dump_value
										end
									end
								end
								reset_recv_value
							else
								Result := Void --| Unable to send the value
							end
						end
					end
				end
			end
		end

feature -- Action

	last_classic_send_value_succeed: BOOLEAN

	classic_send_value
			-- send the value the application
			-- Return False if unable to send the value
		require
			is_classic_system
		local
			value_string_c: ANY
			s8: STRING_8
			s32: STRING_32
			utf: UTF_CONVERTER
		do
			last_classic_send_value_succeed := True
			inspect type
			when Type_manifest_string then
				s8 := value_string.to_string_8
				value_string_c := s8.to_c
				send_string_value ($value_string_c, s8.count)
			when type_manifest_string_32 then
				s32 := utf.utf_8_string_8_to_string_32 (value_string)
				value_string_c := s32.to_c
					-- Send UTF-32 directly.
				send_string_32_value ($value_string_c, s32.count * {PLATFORM}.character_32_bytes)
			when Type_object, Type_expanded_object then
				if attached value_address as add then
					if add.has_offset then
						send_ref_offset_value (add.as_pointer, add.offset)
					else
						send_ref_value (add.as_pointer)
					end
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
				last_classic_send_value_succeed := False
			end
		end

feature -- Access

	generating_type_representation (generating_type_evaluation_enabled: BOOLEAN): STRING_32
			-- {TYPE}.generating_type string representation
		local
			l_generating_type_string: STRING_32
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

	output_value (format_result: BOOLEAN): STRING_32
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
			utf: UTF_CONVERTER
		do
			inspect type
			when Type_manifest_string then
				if format_result then
					create Result.make (value_string.count + 2)
					Result.append_character ('%"')
					Result.append (value_string)
					Result.append_character ('%"')
				else
					Result := value_string.twin
				end
			when Type_manifest_string_32 then
				s := utf.utf_8_string_8_to_string_32 (value_string)
				if format_result then
					create Result.make (s.count + 2)
					Result.append_character ('%"')
					Result.append (s)
					Result.append_character ('%"')
				else
					Result := s.twin
				end
			when Type_string_dotnet , Type_object, type_expanded_object then
				if value_address /= Void and then not value_address.is_void then
					s := value_address.output
					create Result.make (s.count + 2)
					Result.append_character ('<')
					Result.append (s)
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

	extra_output_details: STRING_32
		do
		end

	to_minimal_hexa_representation (s: STRING): STRING
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

	hexa_output_value: STRING_32
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

	address: DBG_ADDRESS
			-- If it makes sense, return the address of current object.
			-- Void if `is_void' or if `Current' does not represent an object.
		do
			inspect type
			when type_object, type_string_dotnet, type_manifest_string, type_manifest_string_32 then
				Result := value_address
			when type_expanded_object then
				Result := value_address
			when
				type_exception
			then
				if attached value_exception as e then
					Result := e.address
				end
			else
				check is_not_type_exception: not is_type_exception end
			end
		end

	dynamic_class: CLASS_C
			-- Dynamic Class of `Current'. Void iff `is_void'.

	dynamic_class_type: CLASS_TYPE
			-- Dynamic Class Type of `Current'. Void if `is_void'.
			-- Used only in Reference dotnet context (for now)

	scoop_processor_id: NATURAL_16
			-- Associated SCOOP pid if relevant.

	is_void: BOOLEAN
			-- Is `Current' a Void reference?
		do
			Result := (type = Type_object or type = Type_string_dotnet) and (address = Void or else address.is_void)
		end

	is_basic: BOOLEAN
			-- Is `Current' of a basic type?
		do
			Result := not is_type_object
				and not is_exception
				and type /= Type_manifest_string
				and type /= Type_manifest_string_32
				and type /= Type_string_dotnet
		end

feature -- Conversion

	as_dump_value_basic: DUMP_VALUE_BASIC
			--
		require
			is_basic: is_basic
		do
			check
				from_precondition_is_basic: attached {DUMP_VALUE_BASIC} Current as r
			then
				Result := r
			end
		ensure
			Result_not_void: Result /= Void
		end

	as_dump_value_dotnet: DUMP_VALUE_DOTNET
			--
		require
			is_dotnet_value: is_dotnet_value
		do
			check
				from_precondition_is_basic: attached {DUMP_VALUE_DOTNET} Current as r
			then
				Result := r
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {DBG_EVALUATOR} -- Convertor

	manifest_string_to_dump_value_object: DUMP_VALUE
			-- Current manifest string converted to an instance of STRING.
		require
			is_type_manifest_string_8
		local
			s: STRING_8
		do
			debug ("refactor_fixme")
				fixme ("This is a temporary safe solution for 6.1, later we'll need to redesign part of debugger's data+evaluator")
			end
			s := value_string
			if s /= Void then
				Result := debugger_manager.expression_evaluation ("(%"" + s + "%").twin")
			end
			if Result = Void then
				Result := debugger_manager.dump_value_factory.new_void_value (debugger_manager.compiler_data.string_8_class_c)
			end
		end

	manifest_string_32_to_dump_value_object: DUMP_VALUE
			-- Current manifest string converted to an instance of STRING_32.
		require
			is_type_manifest_string_32
		local
			s: STRING_8
		do
			debug ("refactor_fixme")
				fixme ("This is a temporary safe solution for 6.1, later we'll need to redesign part of debugger's data+evaluator")
			end
			s := value_string
			if s /= Void then
				Result := debugger_manager.expression_evaluation ("(%"" + s + "%").twin")
			end
			if Result = Void then
				Result := debugger_manager.dump_value_factory.new_void_value (debugger_manager.compiler_data.string_32_class_c)
			end
		end

feature -- Access: internal data

	value_address	: like address -- string standing for the address of the object if type=Type_object
	value_string    : STRING_8 -- String value, in UTF-8
	value_exception : EXCEPTION_DEBUG_VALUE
	procedure_return_value: PROCEDURE_RETURN_DEBUG_VALUE

	type: INTEGER
		-- type discrimant, possible values are Type_XXXX

--| Useless now, using inspect on 'type' is enought
	is_type_boolean: BOOLEAN do end -- False
	is_type_integer_32: BOOLEAN do end -- False

	is_type_object: BOOLEAN
			-- Is Current value corresponding to an object or an expanded object?
		do
			Result := type = Type_object or type = type_expanded_object
		end

	is_type_expanded_object: BOOLEAN
		do
			Result := type = type_expanded_object
		end

	is_type_manifest_string: BOOLEAN do Result := type = Type_manifest_string or type = Type_manifest_string_32 end
	is_type_manifest_string_8: BOOLEAN do Result := type = Type_manifest_string end
	is_type_manifest_string_32: BOOLEAN do Result := type = Type_manifest_string_32 end
--	is_type_expanded: BOOLEAN is do Result := type = Type_expanded_object end
	is_type_exception: BOOLEAN do Result := type = Type_exception end
	is_type_procedure_return: BOOLEAN do Result := type = Type_procedure_return end

feature {NONE} -- Private Constants

	area_name: STRING = "area"
	count_name: STRING = "count"
	area_lower_name: STRING = "area_lower"

feature {NONE} -- Implementation

	Character_routines: DBG_CHARACTER_ROUTINES
			-- To have a printable output of Eiffel strings that have
			-- non-printable characters.
			--| In addition for the debugger, escape the `escaped_character' character used for PATH			
		once
			create Result
		ensure
			character_routines_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
