indexing
	description: "Generic notion of basic type value during the execution of the application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUG_BASIC_VALUE [G]

inherit
	ABSTRACT_DEBUG_VALUE
		redefine
			debug_value_type_id
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end

create {DBG_EVALUATOR, RECV_VALUE, ATTR_REQUEST,CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
	make, make_attribute

feature {NONE} -- Initialization

	make (a_sk_type: INTEGER; v: like value) is
			-- 	Set `value' to `v'.
		require
			v_not_void: v /= Void
		do
			set_default_name
			value := v
			sk_type := a_sk_type
			set_dynamic_class
		ensure
			value_set: value = v
		end

	make_attribute (a_sk_type: INTEGER; attr_name: like name; a_class: like e_class; v: like value) is
			-- Set `attr_name' to `name' and `value' to `v'.
		require
			not_attr_name_void: attr_name /= Void
			v_not_void: v /= Void
		do
			set_name (attr_name)
			if a_class /= Void then
				e_class := a_class
				is_attribute := True
			end
			value := v
			sk_type := a_sk_type
			set_dynamic_class
		ensure
			value_set: value = v
		end

feature -- Access

	sk_type: INTEGER

	value: G
			-- Value of object.

	dynamic_class: CLASS_C
			-- Type represented by `value'.

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		local
			uint8val: NATURAL_8_REF
			uint16val: NATURAL_16_REF
			uint32val: NATURAL_32_REF
			uint64val: NATURAL_64_REF

			int8val: INTEGER_8_REF
			int16val: INTEGER_16_REF
			int32val: INTEGER_REF
			int64val: INTEGER_64_REF

			realval: REAL_REF
			dblval: DOUBLE_REF
			cval: CHARACTER_REF
			ptrval: POINTER_REF
			bval: BOOLEAN_REF
			wcval: WIDE_CHARACTER_REF
			d_fact: DUMP_VALUE_FACTORY
		do
			d_fact := Debugger_manager.Dump_value_factory
			inspect sk_type
			when sk_uint8   then
				uint8val ?= value
				Result := d_fact.new_natural_8_value (uint8val.item, Dynamic_class)
			when sk_uint16  then
				uint16val ?= value
				Result := d_fact.new_natural_16_value (uint16val.item, Dynamic_class)
			when sk_uint32  then
				uint32val ?= value
				Result := d_fact.new_natural_32_value (uint32val.item, Dynamic_class)
			when sk_uint64  then
				uint64val ?= value
				Result := d_fact.new_natural_64_value (uint64val.item, Dynamic_class)

			when sk_int8    then
				int8val ?= value
				Result := d_fact.new_integer_8_value (int8val.item, Dynamic_class)
			when sk_int16   then
				int16val ?= value
				Result := d_fact.new_integer_16_value (int16val.item, Dynamic_class)
			when sk_int32   then
				int32val ?= value
				Result := d_fact.new_integer_32_value (int32val.item, Dynamic_class)
			when sk_int64   then
				int64val ?= value
				Result := d_fact.new_integer_64_value (int64val.item, Dynamic_class)

			when sk_bool    then
				bval ?= value
				Result := d_fact.new_boolean_value (bval.item, Dynamic_class)
			when sk_char    then
				cval ?= value
				Result := d_fact.new_character_value (cval.item, Dynamic_class)
			when sk_wchar   then
				wcval ?= value
				Result := d_fact.new_character_32_value (wcval.item, Dynamic_class)
			when sk_real32  then
				realval ?= value
				Result := d_fact.new_real_32_value (realval.item, Dynamic_class)
			when sk_real64  then
				dblval ?= value
				Result := d_fact.new_real_64_value (dblval.item, Dynamic_class)
			when sk_pointer then
				ptrval ?= value
				Result := d_fact.new_pointer_value (ptrval.item, Dynamic_class)
			else
				check known_type: False	end
			end
		end

feature {DEBUG_VALUE_EXPORTER} -- Output

	output_value: STRING_32 is
			-- Return a string representing `Current'.
		do
			Result := value.out
		end

	type_and_value: STRING_32 is
			-- Return a string representing `Current'.
		do
			create Result.make (40)
			Result.append (dynamic_class.name_in_upper)
			Result.append (Equal_sign_str)
			Result.append (value.out)
		end

feature -- ouput

	expandable: BOOLEAN is False
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)

	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			Result := Void
		end

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			Result := Immediate_value
		end

feature {NONE} -- Setting

	set_dynamic_class is
			-- Set `dynamic_class' to match `sk_type'.
		require
			valid_sk_type:
				sk_type = sk_uint8 or sk_type = sk_uint16 or sk_type = sk_uint32 or sk_type = sk_uint64 or
				sk_type = sk_int8 or sk_type = sk_int16 or sk_type = sk_int32 or sk_type = sk_int64 or
				sk_type = sk_char or sk_type = sk_wchar or sk_type = sk_real32 or sk_type = sk_real64 or
				sk_type = sk_bool or sk_type = sk_pointer
		local
			comp_data: DEBUGGER_DATA_FROM_COMPILER
		do
			comp_data := debugger_manager.compiler_data
			inspect sk_type
			when sk_uint8   then dynamic_class := comp_data.natural_8_class_c
			when sk_uint16  then dynamic_class := comp_data.natural_16_class_c
			when sk_uint32  then dynamic_class := comp_data.natural_32_class_c
			when sk_uint64  then dynamic_class := comp_data.natural_64_class_c
			when sk_int8    then dynamic_class := comp_data.Integer_8_class_c
			when sk_int16   then dynamic_class := comp_data.Integer_16_class_c
			when sk_int32   then dynamic_class := comp_data.Integer_32_class_c
			when sk_int64   then dynamic_class := comp_data.Integer_64_class_c
			when sk_bool    then dynamic_class := comp_data.Boolean_class_c
			when sk_char    then dynamic_class := comp_data.character_8_class_c
			when sk_wchar   then dynamic_class := comp_data.character_32_class_c
			when sk_real32  then dynamic_class := comp_data.real_32_class_c
			when sk_real64  then dynamic_class := comp_data.real_64_class_c
			when sk_pointer then dynamic_class := comp_data.Pointer_class_c
			end
		ensure
			dynamic_class_not_void: dynamic_class /= Void
		end

feature {DEBUGGER_TEXT_FORMATTER_VISITOR} -- Debug value type id

	debug_value_type_id: INTEGER is
		do
			Result := debug_basic_value_id
		end

invariant
	dynamic_class_not_void: dynamic_class /= Void

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

end -- class DEBUG_VALUE
