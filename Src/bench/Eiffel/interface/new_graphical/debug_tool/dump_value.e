indexing
	description: "Objects join all debug values: STRING, INTEGER, BOOLEAN, REFERENCES, ..."
	author: "Arnaud PICHERY"
	date: "$Date$"
	revision: "$Revision$"

class
	DUMP_VALUE

inherit
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
	make_double, make_pointer, make_object,	make_manifest_string
	,make_string_for_dotnet
	,make_object_for_dotnet
	
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
			value_object := value
			type := Type_object
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

	make_manifest_string(value: STRING; dtype: CLASS_C) is
			-- make a string item initialized to `value'
		do
			value_object := value
			type := Type_string
			dynamic_class := dtype
		ensure
			type /= Type_unknown
		end

feature -- dotnet

	is_dotnet_value: BOOLEAN
	
	is_external_type: BOOLEAN
			-- Is the value corresponding to an external type ?
			-- (ex: like SystemObject for dotnet)

	value_dotnet: ICOR_DEBUG_VALUE

feature -- Object ICorDebugStringValue

	value_string_dotnet: ICOR_DEBUG_STRING_VALUE
	
	string_value: STRING

	make_string_for_dotnet (icd_frame: ICOR_DEBUG_FRAME; icd_value: ICOR_DEBUG_VALUE; 
			icd_string: ICOR_DEBUG_STRING_VALUE; value: STRING; a_string_value: STRING; dclass: CLASS_C; 
			a_b_is_null: BOOLEAN) is
			-- make a object item initialized to `value'
		do
--			is_dotnet_value := True
			value_dotnet := icd_value
			value_frame_dotnet := icd_frame
			value_string_dotnet := icd_string
			string_value := a_string_value
			if a_b_is_null then
				value_object := Void
			else
				value_object := value
			end
			type := Type_string_dotnet
			dynamic_class := dclass
			is_external_type := True
		ensure
			type /= Type_unknown
		end

feature -- Object ICorDebugObjectValue

	value_object_dotnet: ICOR_DEBUG_OBJECT_VALUE
	
	value_class_token: INTEGER
	
	value_frame_dotnet: ICOR_DEBUG_FRAME

	make_object_for_dotnet (icd_frame: ICOR_DEBUG_FRAME; icd_value: ICOR_DEBUG_VALUE; 
			icd_object: ICOR_DEBUG_OBJECT_VALUE; a_value_class_token: INTEGER; value: STRING; dtype: CLASS_TYPE; 
			a_b_is_null: BOOLEAN; a_b_is_external_type: BOOLEAN) is
			-- make a object item initialized to `value'
		do
			is_dotnet_value := True
			value_dotnet := icd_value
			value_frame_dotnet := icd_frame
			value_object_dotnet := icd_object
			value_class_token := a_value_class_token
			if a_b_is_null then
				value_object := Void
			else
				value_object := value
			end
			type := Type_object
			
			if dtype /= Void then
				dynamic_class_type := dtype
				dynamic_class := dtype.associated_class
				debug ("DEBUGGER_EIFNET_DATA")
					print ("[>] dyn_class_type = " + dtype.full_il_type_name + "%N")
				end
			end
			is_external_type := a_b_is_external_type
		ensure
			type /= Type_unknown
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
			o: DEBUGGED_OBJECT
			att: ABSTRACT_DEBUG_VALUE
		do
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
--						dynamic_class /= Void 
--						and then 
						dynamic_class.simple_conform_to (Eiffel_system.string_class.compiled_class) 
					then
						Result := True
					else
						dc := debuggable_class
						Result := --dynamic_class /= Void and then
									dc /= Void and then
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

	string_representation_for_dotnet (min, max: INTEGER): STRING is
		require
			object_with_debug_output: address /= Void and has_formatted_output	
			dotnet: is_dotnet_value
		local
			sc: CLASS_C
			l_conform_to_string: BOOLEAN
			l_app_exec_dotnet: APPLICATION_EXECUTION_DOTNET
		do
			sc := Eiffel_system.string_class.compiled_class
			l_conform_to_string := dynamic_class /= sc and then dynamic_class.simple_conform_to (sc)
			l_app_exec_dotnet := Application.imp_dotnet
			if dynamic_class = sc or l_conform_to_string then
				if value_object_dotnet = Void then
					Result := "Void"
				else
					Result := l_app_exec_dotnet.string_value_from_string_class_object_value (value_object_dotnet)
				end					
			else
				Result := l_app_exec_dotnet.debug_output_value_from_object_value (value_dotnet, value_object_dotnet, value_frame_dotnet, dynamic_class_type)
			end
		end

	string_representation (min, max: INTEGER): STRING is
			-- Get the `debug_output' representation with bounds from `min' and `max'.
			-- Special characters are not converted but '%U's are removed.
		require
			object_with_debug_output: address /= Void and has_formatted_output
		local
			f: E_FEATURE
			expr: EB_EXPRESSION
			obj: DEBUGGED_OBJECT
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
					create obj.make (value_object, min, max)
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
						Result.keep_head (l_count.min (Result.count))
						
							-- If what is displayed is less than the count of the STRING object,
							-- we display `...' to show that there is something more.
						if l_count > (max - min + 1) then
							Result.append ("...")
						end
					end
				else
					create expr.make_with_object (
						create {DEBUGGED_OBJECT}.make_with_class (value_object, debuggable_class),
						debuggable_name)
					expr.evaluate
					if expr.error_message = Void and then not expr.final_result_value.is_void then
						Result := expr.final_result_value.string_representation (min, max)
					else
						Result := expr.error_message
					end
				end
			end
			if Result = Void then
				Result := "Could not find string representation"
			end
		ensure
			string_representation_not_void: Result /= Void
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
				Result := "%"" + Character_routines.eiffel_string (value_object) + "%""
			elseif type = Type_string_dotnet then
				Result := "%"" + Character_routines.eiffel_string (string_value) + "%""			
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
			Result := clone (output_value)
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
					value_string_c := value_object.to_c
					send_string_value($value_string_c)
				
				when Type_object then
					if value_object /= Void then
						send_ref_value(hex_to_integer(value_object))
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
		do
			create Result.make (100)

			if is_void then
				Result.append ("NONE = Void")
			elseif dynamic_class /= Void then
				Result.append (dynamic_class.name_in_upper)
				if type = Type_object or type = Type_string_dotnet then
					Result.append_character (' ')
				else
					Result.append_character ('=')
				end
				Result.append (full_output)
				if is_dotnet_value and then is_external_type then
					Result.append (" -> Token=0x" + value_class_token.to_hex_string)
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
				create Result.make (value_object.count + 2)
				Result.append_character ('%"')
				Result.append (value_object)
				Result.append_character ('%"')
			when Type_string_dotnet , Type_object then
				if value_object /= Void then
					create Result.make (value_object.count + 2)
					Result.append_character ('[')
					Result.append (value_object)
					Result.append_character (']')
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
				Result := value_object
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

feature {DUMP_VALUE} -- Implementation

	type: INTEGER 
		-- type discrimant, possible values are Type_XXXX

	value_boolean	: BOOLEAN
	value_character	: CHARACTER
	value_integer	: INTEGER
	value_integer_64: INTEGER_64
	value_real		: REAL
	value_double	: DOUBLE
	value_bits		: BIT_REF -- not yet implemented.
	value_pointer	: POINTER
	value_object	: STRING -- string standing for the address of the object if type=Type_object, or 
							 -- String if type=Type_string

feature {NONE} -- Private Constants
	
	area_name: STRING is "area"
	count_name: STRING is "count"
	
	Type_unknown	: INTEGER is 0
	Type_boolean	: INTEGER is 1
	Type_character	: INTEGER is 2
	Type_integer	: INTEGER is 3
	Type_real		: INTEGER is 4
	Type_double		: INTEGER is 5
	Type_bits		: INTEGER is 6
	Type_pointer	: INTEGER is 7
	Type_object		: INTEGER is 8
	Type_string		: INTEGER is 9
	Type_string_dotnet: INTEGER is 10
	Type_integer_64: INTEGER is 11

	character_routines: CHARACTER_ROUTINES is
			-- To have a printable output of Eiffel strings that have
			-- non-printable characters.
		once
			create Result
		ensure
			character_routines_not_void: Result /= Void
		end

end -- class DUMP_VALUE
