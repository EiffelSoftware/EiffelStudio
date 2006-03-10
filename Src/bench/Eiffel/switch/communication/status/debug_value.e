indexing
	description: "Generic notion of basic type value during the execution of the application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUG_VALUE [G]

inherit
	ABSTRACT_DEBUG_VALUE

	COMPILER_EXPORTER
		undefine
			is_equal
		end

create {RECV_VALUE, ATTR_REQUEST,CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
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
			name := attr_name
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
--			wcval: WIDE_CHARACTER_REF
		do
			inspect sk_type
			when sk_uint8   then
				uint8val ?= value
				create Result.make_natural_32 (uint8val.item.to_natural_32, Dynamic_class)
			when sk_uint16  then
				uint16val ?= value
				create Result.make_natural_32 (uint16val.item.to_natural_32, Dynamic_class)
			when sk_uint32  then
				uint32val ?= value
				create Result.make_natural_32 (uint32val.item, Dynamic_class)
			when sk_uint64  then
				uint64val ?= value
				create Result.make_natural_64 (uint64val.item, Dynamic_class)

			when sk_int8    then
				int8val ?= value
				create Result.make_integer_32 (int8val.item.to_integer, Dynamic_class)
			when sk_int16   then
				int16val ?= value
				create Result.make_integer_32 (int16val.item.to_integer, Dynamic_class)
			when sk_int32   then
				int32val ?= value
				create Result.make_integer_32 (int32val.item, Dynamic_class)
			when sk_int64   then
				int64val ?= value
				create Result.make_integer_64 (int64val.item, Dynamic_class)

			when sk_bool    then
				bval ?= value
				create Result.make_boolean (bval.item, Dynamic_class)
			when sk_char    then
				cval ?= value
				create Result.make_character (cval.item, Dynamic_class)
			when sk_wchar   then
					--| FIXME XR: Why is there no conversion feature in WIDE_CHARACTER?!!!
--				wcval ?= value
				create Result.make_character ('%U', Dynamic_class)
			when sk_real32  then
				realval ?= value
				create Result.make_real (realval.item, Dynamic_class)
			when sk_real64  then
				dblval ?= value
				create Result.make_double (dblval.item, Dynamic_class)
			when sk_pointer then
				ptrval ?= value
				create Result.make_pointer (ptrval.item, Dynamic_class)
			else
				check known_type: False	end
			end
		end

feature {ABSTRACT_DEBUG_VALUE} -- Output

	append_type_and_value (st: TEXT_FORMATTER) is
		do
			dynamic_class.append_name (st)
			st.add_string (Equal_sign_str);
			st.add_string (value.out)
		end;

feature {NONE} -- Output

	append_value (st: TEXT_FORMATTER) is
		do
			st.add_string (value.out)
		end;

	output_value: STRING is
			-- Return a string representing `Current'.
		do
			Result := value.out
		end

	type_and_value: STRING is
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
			system: SYSTEM_I
		do
			system := Eiffel_system.system
			inspect sk_type
			when sk_uint8   then dynamic_class := system.natural_8_class.compiled_class
			when sk_uint16  then dynamic_class := system.natural_16_class.compiled_class
			when sk_uint32  then dynamic_class := system.natural_32_class.compiled_class
			when sk_uint64  then dynamic_class := system.natural_64_class.compiled_class
			when sk_int8    then dynamic_class := system.Integer_8_class.compiled_class
			when sk_int16   then dynamic_class := system.Integer_16_class.compiled_class
			when sk_int32   then dynamic_class := system.Integer_32_class.compiled_class
			when sk_int64   then dynamic_class := system.Integer_64_class.compiled_class
			when sk_bool    then dynamic_class := system.Boolean_class.compiled_class
			when sk_char    then dynamic_class := system.Character_class.compiled_class
			when sk_wchar   then dynamic_class := system.Wide_char_class.compiled_class
			when sk_real32  then dynamic_class := system.real_32_class.compiled_class
			when sk_real64  then dynamic_class := system.real_64_class.compiled_class
			when sk_pointer then dynamic_class := system.Pointer_class.compiled_class
			end
		ensure
			dynamic_class_not_void: dynamic_class /= Void
		end

invariant
	dynamic_class_not_void: dynamic_class /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
