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

create
	make_boolean, make_character, make_integer, make_real,
	make_double, make_pointer, make_object,	make_manifest_string

feature -- Initialization

	make_boolean(value: BOOLEAN; dtype: CLASS_C) is
			-- make a boolean item initialized to `value'
		do
			value_boolean := value
			type := Type_boolean
			dynamic_type := dtype
		ensure
			type /= Type_unknown
		end

	make_character(value: CHARACTER; dtype: CLASS_C) is
			-- make a character item initialized to `value'
		do
			value_character := value
			type := Type_character
			dynamic_type := dtype
		ensure
			type /= Type_unknown
		end

	make_integer(value: INTEGER; dtype: CLASS_C) is
			-- make a integer item initialized to `value'
		do
			value_integer := value
			type := Type_integer
			dynamic_type := dtype
		ensure
			type /= Type_unknown
		end

	make_real(value: REAL; dtype: CLASS_C) is
			-- make a real item initialized to `value'
		do
			value_real := value
			type := Type_real
			dynamic_type := dtype
		ensure
			type /= Type_unknown
		end

	make_double(value: DOUBLE; dtype: CLASS_C) is
			-- make a double item initialized to `value'
		do
			value_double := value
			type := Type_double
			dynamic_type := dtype
		ensure
			type /= Type_unknown
		end

	make_pointer(value: POINTER; dtype: CLASS_C) is
			-- make a pointer item initialized to `value'
		do
			value_pointer := value
			type := Type_pointer
			dynamic_type := dtype
		ensure
			type /= Type_unknown
		end

	make_object(value: STRING; dtype: CLASS_C) is
			-- make a object item initialized to `value'
		do
			value_object := value
			type := Type_object
			dynamic_type := dtype
		ensure
			type /= Type_unknown
		end

	make_manifest_string(value: STRING; dtype: CLASS_C) is
			-- make a string item initialized to `value'
		do
			value_object := value
			type := Type_string
			dynamic_type := dtype
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
		local
			dc: CLASS_C
		do
			if type = Type_string then
				Result := True
			elseif type = Type_object and not is_void then
				if Eiffel_system.string_class.compiled then
					if dynamic_type.simple_conform_to (Eiffel_system.string_class.compiled_class) then
						Result := True
					else
						dc := debuggable_class
						Result := dynamic_type /= Void and then
									dc /= Void and then
									dynamic_type.simple_conform_to (dc)
					end
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
			expr: EB_EXPRESSION
			obj: DEBUGGED_OBJECT
			cv_spec: SPECIAL_VALUE
			sc: CLASS_C
		do
			sc := Eiffel_system.string_class.compiled_class
			if dynamic_type = sc then
				create obj.make (value_object, min, max)
				from
					obj.attributes.start
				until
					obj.attributes.after
				loop
					cv_spec ?= obj.attributes.item
					if cv_spec /= Void and then cv_spec.name.is_equal ("area") then
						Result := cv_spec.raw_string_value
						Result.prune_all ('%U')
					end
					obj.attributes.forth
				end
			elseif dynamic_type.simple_conform_to (sc) then
				f := sc.feature_with_name ("area").ancestor_version (dynamic_type)
				create obj.make (value_object, min, max)
				from
					obj.attributes.start
				until
					obj.attributes.after
				loop
					cv_spec ?= obj.attributes.item
					if cv_spec /= Void and then cv_spec.name.is_equal (f.name) then
						Result := cv_spec.raw_string_value
						Result.prune_all ('%U')
					end
					obj.attributes.forth
				end
			else
				f := debuggable_class.feature_with_name ("debug_output").ancestor_version (dynamic_type)
				create expr.make_with_object (create {DEBUGGED_OBJECT}.make (value_object, 0, 1), f.name)
				expr.evaluate
				if expr.error_message = Void then
					Result := expr.final_result_value.string_representation (min, max)
				else
					Result := expr.error_message
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
				Result := "%"" + (create {CHARACTER_ROUTINES}).eiffel_string (value_object) + "%""
			else
				create Result.make (Application.displayed_string_size + 2)
				Result.append_character ('%"')
				Result.append ((create {CHARACTER_ROUTINES}).eiffel_string (string_representation (0, Application.displayed_string_size)))
				Result.append_character ('%"')
			end
		ensure
			not_void: Result /= Void
		end

	full_output: STRING is
			-- Complete output, including string representation.
		do
			Result := clone (output_value)
			if type /= type_string and has_formatted_output then
				Result.append_character ('=')
				Result.append (formatted_output)
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
		do
			create Result.make (100)
			if dynamic_type /= Void then
				Result.append (dynamic_type.name_in_upper)
				if type = Type_object then
					Result.append_character (' ')
					Result.append (full_output)
				else
					Result.append_character ('=')
					Result.append (full_output)
				end
			elseif is_void then
				Result.append ("NONE = Void")
			else
				Result.append ("ANY ")
				Result.append (full_output)
			end
		end

	output_value: STRING is
			-- String representation of the value of `Current'.
		do
			inspect type
			when Type_boolean then
				Result := value_boolean.out
			when Type_character then
				create Result.make (6)
				Result.append_character ('%'')
				Result.append ((create {CHARACTER_ROUTINES}).char_text (value_character))
				Result.append_character ('%'')
			when Type_integer then
				Result := value_integer.out
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
			when Type_pointer then
				Result := value_pointer.out
			when Type_object then
				if value_object /= Void then
					create Result.make (value_object.count + 2)
					Result.append_character ('[')
					Result.append (value_object)
					Result.append_character (']')
				else
					Result := "Void"
				end
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
			if type = Type_object then
				Result := value_object
			end
		end

	dynamic_type: CLASS_C
			-- Dynamic type of `Current'. Void iff `is_void'.
	
	is_void: BOOLEAN is
			-- Is `Current' a Void reference?
		do
			Result := type = Type_object and address = Void
		end

	is_basic: BOOLEAN is
			-- Is `Current' of a basic type?
		do
			Result := type /= Type_object and type /= Type_string
		end

feature -- Inapplicable

feature {DUMP_VALUE} -- Implementation

	type: INTEGER 
		-- type discrimant, possible values are Type_XXXX

	value_boolean	: BOOLEAN
	value_character	: CHARACTER
	value_integer	: INTEGER
	value_real		: REAL
	value_double	: DOUBLE
	value_bits		: BIT_REF -- not yet implemented.
	value_pointer	: POINTER
	value_object	: STRING -- string standing for the address of the object if type=Type_object, or 
							 -- String if type=Type_string

feature {NONE} -- Implementation

	debuggable_class: CLASS_C is
			-- Class that provides the `debug_output' interface, if any.
		local
			cis: LINKED_LIST [CLASS_I]
			lc: CLASS_C
		do
			lc := internal_debuggable_class.item
			if lc = Void or else not lc.is_valid then
				cis := Eiffel_universe.compiled_classes_with_name (debuggable_class_name)
				if not cis.is_empty then
					Result := cis.first.compiled_class
				end
				internal_debuggable_class.put (Result)
			else
				Result := lc
			end
		end

	internal_debuggable_class: CELL [CLASS_C] is
			-- Last computed `debuggable_class'.
		once
			create Result.put (Void)
		end

feature {NONE} -- Private Constants
	
	debuggable_class_name: STRING is "debug_output"
	
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

end -- class DUMP_VALUE
