indexing
	description: "Objects join all debug values: STRING, INTEGER, BOOLEAN, REFERENCES, ..."
	author: "Arnaud PICHERY"
	date: "$Date$"
	revision: "$Revision$"

class
	DUMP_VALUE

inherit
	
	DUMP_VALUE_CONSTANTS	
		export
			{NONE} all
		end
		
	DEBUG_EXT
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

create
	make_boolean, make_character, make_integer, make_integer_64, make_real,
	make_double, make_pointer, make_object,	make_manifest_string,
	make_string_for_dotnet, make_object_for_dotnet
	
feature -- Initialization

	make_boolean(value: BOOLEAN; dtype: CLASS_C) is
			-- make a boolean item initialized to `value'
		do
			value_boolean := value
			type := Type_boolean
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_character(value: CHARACTER; dtype: CLASS_C) is
			-- make a character item initialized to `value'
		do
			value_character := value
			type := Type_character
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_integer(value: INTEGER; dtype: CLASS_C) is
			-- make a integer item initialized to `value'
		do
			value_integer := value
			type := Type_integer
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_integer_64 (value: INTEGER_64; dtype: CLASS_C) is
			-- make a integer_64 item initialized to `value'
		do
			value_integer_64 := value
			type := Type_integer_64
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_real(value: REAL; dtype: CLASS_C) is
			-- make a real item initialized to `value'
		do
			value_real := value
			type := Type_real
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_double(value: DOUBLE; dtype: CLASS_C) is
			-- make a double item initialized to `value'
		do
			value_double := value
			type := Type_double
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_pointer(value: POINTER; dtype: CLASS_C) is
			-- make a pointer item initialized to `value'
		do
			value_pointer := value
			type := Type_pointer
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_object(value: STRING; dtype: CLASS_C) is
			-- make a object item initialized to `value'
		do
			value_address := value
			type := Type_object
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_manifest_string(value: STRING; dtype: CLASS_C) is
			-- make a string item initialized to `value'
		do
			value_string := value
			type := Type_string
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

feature -- Dotnet creation

	make_string_for_dotnet (a_eifnet_dsv: EIFNET_DEBUG_STRING_VALUE) is
			-- make a object ICorDebugStringValue item initialized to `value'
		require
			arg_not_void: a_eifnet_dsv /= Void			
		do
--			is_dotnet_value := True
			eifnet_debug_value := a_eifnet_dsv
			value_frame_dotnet := eifnet_debug_value.icd_frame
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
			is_dotnet_value := True
			eifnet_debug_value := a_eifnet_drv
			value_frame_dotnet := eifnet_debug_value.icd_frame
			value_dotnet := eifnet_debug_value.icd_referenced_value

			value_object_dotnet := a_eifnet_drv.icd_value_info.interface_debug_object_value
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
				debug ("DEBUGGER_EIFNET_DATA")
					print ("[>] dyn_class_type = " + dynamic_class_type.full_il_type_name + "%N")
				end
			end
			is_external_type := a_eifnet_drv.is_external_type
		ensure
			type /= Type_unknown
		end

feature -- Access 

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
	
	value_frame_dotnet: ICOR_DEBUG_FRAME
			-- ICorDebugFrame in this DUMP_VALUE context
	
feature -- change

	set_value_dotnet (v: like value_dotnet) is
			-- Set `value_dotnet' as `v'
		do
			value_dotnet := v	
		end	

	set_value_frame_dotnet (v: like value_frame_dotnet) is
			-- Set `value_frame_dotnet' as `v'
		do
			value_frame_dotnet := v	
		end			
	
feature {NONE} -- Implementation dotnet

	value_object_dotnet: ICOR_DEBUG_OBJECT_VALUE
			-- Dotnet value as an ICorDebugObjectValue interface
	
	value_class_token: INTEGER
			-- Class token for the dotnet value
	
	value_class_name: STRING is
			-- Class name for the dotnet value
		do
			if not is_external_type and then dynamic_class/= Void then
				Result := dynamic_class.name_in_upper
			elseif is_dotnet_value and is_external_type then
				if eifnet_debug_value.icd_value_info /= Void then
					Result := eifnet_debug_value.icd_value_info.value_class_name
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
			o: DEBUGGED_OBJECT_CLASSIC
			att: ABSTRACT_DEBUG_VALUE
		do
			if application.is_classic then			
				debug ("debug_recv")
					print ("DUMP_VALUE.to_basic%N")
				end
				create o.make (address, 0, 1)
				from
					o.attributes.start
				until
					o.attributes.after
				loop
					att := o.attributes.item
					if att.name.is_equal ("item") then
						Result := att.dump_value
					end
					o.attributes.forth
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
		do
			if type = Type_string then
				Result := True
			elseif type = Type_string_dotnet then
				Result := not is_void
			elseif type = Type_object and not is_void then
				if Eiffel_system.string_class.is_compiled then
					if 
						dynamic_class.simple_conform_to (Eiffel_system.string_class.compiled_class) 
					then
						Result := True
					else
						dc := debuggable_class
						Result :=   dc /= Void and then
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

	last_string_representation_length: INTEGER
			-- Length of last string_representation Result
			
	string_representation_for_dotnet (min, max: INTEGER): STRING is
			-- String representation for dotnet value
		require
			object_with_debug_output: address /= Void and has_formatted_output	
			dotnet: is_dotnet_value
		local
			sc: CLASS_C
			l_conform_to_string: BOOLEAN
			l_eifnet_debugger: EIFNET_DEBUGGER
		do
			sc := Eiffel_system.string_class.compiled_class
			l_conform_to_string := dynamic_class /= sc and then dynamic_class.simple_conform_to (sc)
			l_eifnet_debugger := Application.imp_dotnet.eifnet_debugger
			if dynamic_class = sc or l_conform_to_string then
				if value_object_dotnet = Void then
					Result := "Void"
				else
					Result := l_eifnet_debugger.string_value_from_string_class_object_value (value_object_dotnet, min, max)
					last_string_representation_length := l_eifnet_debugger.last_string_value_length
				end					
			else
				Result := l_eifnet_debugger.debug_output_value_from_object_value (value_frame_dotnet, value_dotnet, value_object_dotnet, dynamic_class_type, min, max)
				last_string_representation_length := l_eifnet_debugger.last_string_value_length				
			end
			
			if Result /= Void then
					-- If what is displayed is less than the count of the STRING object,
					-- we display `...' to show that there is something more.
				if (max > 0) and then last_string_representation_length > (max - min + 1) then
					Result.append ("...")
				end
			end			
		end

	string_representation (min, max: INTEGER): STRING is
			-- Get the `debug_output' representation with bounds from `min' and `max'.
			-- Special characters are not converted but '%U's are removed.
		require
			object_with_debug_output: address /= Void and has_formatted_output
		local
			f: E_FEATURE
			obj: DEBUGGED_OBJECT_CLASSIC
			l_attributes: LIST [ABSTRACT_DEBUG_VALUE]
			cv_spec: SPECIAL_VALUE
			int_value: DEBUG_VALUE [INTEGER]
			l_count: INTEGER
			sc: CLASS_C
			l_conform_to_string: BOOLEAN
			l_area_name, l_count_name: STRING
		do
			debug ("debug_recv")
				print ("DUMP_VALUE.string_representation of " + dynamic_class.name_in_upper + "%N")
			end
			last_string_representation_length := 0
			if is_dotnet_value then
				Result := string_representation_for_dotnet (min, max)
			else
				sc := Eiffel_system.string_class.compiled_class
				l_conform_to_string := dynamic_class /= sc and then dynamic_class.simple_conform_to (sc)
				if dynamic_class = sc or l_conform_to_string then
					if l_conform_to_string then
							-- Take name of `area' and `count' from STRING in descendant version.
						f := sc.feature_with_name (area_name).ancestor_version (dynamic_class)
						l_area_name := f.name
						f := sc.feature_with_name (count_name).ancestor_version (dynamic_class)
						l_count_name := f.name
					else
						l_area_name := area_name
						l_count_name := count_name
					end
					create obj.make (value_address, min, max)
					l_attributes := obj.attributes
					from
						l_attributes.start
					until
						l_attributes.after
					loop
						cv_spec ?= l_attributes.item
						if cv_spec /= Void and then cv_spec.name.is_equal (l_area_name) then
							Result := cv_spec.raw_string_value
							Result.prune_all ('%U')
						else
							int_value ?= l_attributes.item					
							if int_value /= Void and then int_value.name.is_equal (l_count_name) then
								l_count := int_value.value
							end
						end
						l_attributes.forth
					end
						-- At the point `area' and `count' from STRING should have been found in
						-- STRING object.
					check
						count_attribute_found: True
						area_attribute_found: True
					end
					if Result /= Void then
							-- We now have retrieved the full `area' of STRING object. Let's check
							-- if we need to display the complete area, or just part of it.
						last_string_representation_length := Result.count
						if max < 0 then
						else
							Result.keep_head (l_count.min (last_string_representation_length))						
						end
						
							-- If what is displayed is less than the count of the STRING object,
							-- we display `...' to show that there is something more.
						if (max > 0) and then l_count > (max - min + 1) then
							Result.append ("...")
						end
					end
				else
					Result := debug_output_evaluated_string (min, max)
				end
			end
			if Result = Void then
				Result := "Could not find string representation"
			end
		ensure
			string_representation_not_void: Result /= Void
		end

	debug_output_evaluated_string (min, max: INTEGER): STRING is
		local
			expr: EB_EXPRESSION
		do
			create expr.make_with_object (
					create {DEBUGGED_OBJECT_CLASSIC}.make_with_class (value_address, debuggable_class),
					debuggable_name
				)
			expr.evaluate
			if expr.error_message = Void and then not expr.final_result_value.is_void then
				Result := expr.final_result_value.string_representation (min, max)
				last_string_representation_length := expr.final_result_value.last_string_representation_length
			else
				Result := expr.error_message
			end
		end

	generic_type_evaluated_string: STRING is
		local
			expr: EB_EXPRESSION
		do
			if application.is_dotnet then
				if dynamic_class_type /= Void then
					Result := Application.imp_dotnet.eifnet_debugger.generating_type_value_from_object_value (
								value_frame_dotnet, 
								value_dotnet, 
								value_object_dotnet, 
								dynamic_class_type
							)
				end
			else
				create expr.make_with_object (
						create {DEBUGGED_OBJECT_CLASSIC}.make_with_class (value_address, eiffel_system.system.any_class.compiled_class),
						"generating_type"
					)
				expr.evaluate
				if expr.error_message = Void and then not expr.final_result_value.is_void then
					Result := expr.final_result_value.string_representation (0, -1)
--				else
--					Result := expr.error_message
				end				
			end			
		end

	formatted_output: STRING is
			-- Output of the call to `debug_output' on `Current', if any.
		require
			has_formatted_output
		do
			debug ("debugger_interface")
				io.put_string ("Finding output value of dump_value%N")
			end
			if type = Type_string then
				debug ("debugger_interface")
					io.put_string ("Finding output value of constant string")
				end
				Result := "%"" + Character_routines.eiffel_string (value_string) + "%""
			elseif type = Type_string_dotnet then
				Result := "%"" + Character_routines.eiffel_string (value_string) + "%""			
			else
				create Result.make (Application.displayed_string_size + 2)
				Result.append_character ('%"')
				Result.append (Character_routines.eiffel_string (string_representation (0, Application.displayed_string_size)))
				Result.append_character ('%"')
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
				Result.append_character ('=')
				Result.append (formatted_output)
			end
			debug ("debug_recv")
				print ("Output is ")
				print (Result)
				print ("%N")
			end
		end

feature -- Action
	
	send_value is
			-- send the value the application
		local
			value_string_c: ANY
		do
			inspect (type)
				when Type_boolean then
					send_bool_value(value_boolean)
				when Type_character then
					send_char_value(value_character)
				when Type_integer then
					send_integer_value(value_integer)
				when Type_integer_64 then
					send_integer_64_value (value_integer_64)
				when Type_real then
					send_real_value(value_real)
				when Type_double then
					send_double_value(value_double)
				when Type_pointer then
					send_ptr_value(value_pointer)
				when Type_string then
					value_string_c := value_string.to_c
					send_string_value($value_string_c)
				when Type_object then
					if value_address /= Void then
						send_ref_value(hex_to_integer(value_address))
					else
						send_ref_value(0)
					end
				else
					-- unexpected value, do nothing
					debug("DEBUGGER")
						io.putstring ("Error: unexpected value in [DUMP_VALUE]send_value%N")
					end
			end
		end
	
feature -- Access

	type_and_value: STRING is
			-- String representation of the type and value of `Current'.
			--| CLASS_NAME = `full_output'
		local
			l_generating_type_string: STRING
		do
			create Result.make (100)

			if is_void then
				Result.append ("NONE = Void")
			elseif dynamic_class /= Void then
				if dynamic_class.is_generic then
					l_generating_type_string := generic_type_evaluated_string
				end
				if l_generating_type_string	/= Void then
					Result.append (l_generating_type_string)
				else
					Result.append (dynamic_class.name_in_upper)				
				end
				
				if type = Type_object or type = Type_string_dotnet then
					Result.append_character (' ')
				else
					Result.append_character ('=')
				end
				Result.append (full_output)
				if is_dotnet_value and then is_external_type then
					Result.append (" -> " + value_class_name)
				end
			else		
				Result.append ("ANY ")			
				Result.append (full_output)
			end
		end

	output_value: STRING is
			-- String representation of the value of `Current'.
			--| True
			--| '/123/ :'C'
			--| 123
			--| [0x12345678]
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
			when Type_integer then
				Result := value_integer.out
			when Type_integer_64 then
				Result := value_integer_64.out
			when Type_real then
				Result := value_real.out
			when Type_double then
				Result := value_double.out
			when Type_bits then
				Result := value_bits.out
			when Type_string then
				create Result.make (value_string.count + 2)
				Result.append_character ('%"')
				Result.append (value_string)
				Result.append_character ('%"')
			when Type_string_dotnet , Type_object then
				if value_address /= Void then
					create Result.make (value_address.count + 2)
					Result.append_character ('<')
					Result.append (value_address)
					Result.append_character ('>')
				else
					Result := "Void"
				end
			when Type_pointer then
				Result := value_pointer.out
			else
				Result := ""
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
			-- Dynamic Class Type of `Current'. Void iff `is_void'.
			-- Used only in Reference dotnet context (for now)
	
	is_void: BOOLEAN is
			-- Is `Current' a Void reference?
		do
			Result := (type = Type_object or type = Type_string_dotnet) and address = Void
		end

	is_basic: BOOLEAN is
			-- Is `Current' of a basic type?
		do
			Result := type /= Type_object and type /= Type_string and type /= Type_string_dotnet
		end

feature {DUMP_VALUE, EIFNET_EXPORTER} -- Internal data

	value_boolean	: BOOLEAN
	value_character	: CHARACTER
	value_integer	: INTEGER
	value_integer_64: INTEGER_64
	value_real		: REAL
	value_double	: DOUBLE
	value_bits		: BIT_REF -- not yet implemented.
	value_pointer	: POINTER
	value_address	: STRING -- string standing for the address of the object if type=Type_object
	value_string    : STRING -- String value


	type: INTEGER 
		-- type discrimant, possible values are Type_XXXX
			
--| Useless now, using inspect on 'type' is enought
--	is_type_unknown       : BOOLEAN is do Result := type = Type_unknown end
--	is_type_boolean       : BOOLEAN is do Result := type = Type_boolean end
--	is_type_character     : BOOLEAN is do Result := type = Type_character end
--	is_type_integer       : BOOLEAN is do Result := type = Type_integer end
--	is_type_real          : BOOLEAN is do Result := type = Type_real end
--	is_type_double        : BOOLEAN is do Result := type = Type_double end
--	is_type_bits          : BOOLEAN is do Result := type = Type_bits end
--	is_type_pointer       : BOOLEAN is do Result := type = Type_pointer end
--	is_type_object        : BOOLEAN is do Result := type = Type_object end
--	is_type_string        : BOOLEAN is do Result := type = Type_string end
--	is_type_string_dotnet : BOOLEAN is do Result := type = Type_string_dotnet end
--	is_type_integer_64    : BOOLEAN is do Result := type = Type_integer_64 end

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

end -- class DUMP_VALUE
