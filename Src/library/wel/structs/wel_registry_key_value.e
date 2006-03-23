indexing
	description: "Structure describing a registry key value"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	WEL_REGISTRY_KEY_VALUE

inherit
	WEL_REGISTRY_KEY_VALUE_TYPE

	PLATFORM
		export
			{NONE} all
		end

create
	make,
	make_with_data,
	make_with_value,
	make_with_dword_value

feature -- Initialization

	make (t: like type; v: STRING_GENERAL) is
			-- Create a new string key value.
		require
			v_not_void: v /= Void
			t_valid: t = reg_sz
		do
			set_string_value (v)
		ensure
			type_set: type = reg_sz
			string_value_set: string_value.is_equal (v)
		end

	make_with_data (t: like type; v: MANAGED_POINTER) is
			-- Create a new key value using data `v'.
		require
			v_not_void: v /= Void
		do
			set_type (t)
			data := v
		ensure
			type_set: type = t
			data_set: data = v
		end

	make_with_value (t: like type; v: like internal_value) is
			-- Create a new key value of type `t' using `v'.
		obsolete
			"Use `make_with_data', `make' or `make_with_dword_value' instead."
		require
			v_not_void: v /= Void
		do
			set_type (t)
			create data.make (v.capacity)
			data.item.memory_copy (v.item, v.capacity)
		ensure
			type_set: type = t
			internal_value_set: internal_value.is_equal (v)
		end

	make_with_dword_value (v: like dword_value) is
			-- Set `dword_value' with `v'.
			-- Set `type' with `reg_dword'.
		do
			set_dword_value (v)
		ensure
			type_set: type = reg_dword
			dword_value_set: dword_value = v
		end

feature -- Access

	type: INTEGER
			-- Type of value
			-- See class WEL_REGISTRY_KEY_VALUE_TYPE for possible
			-- values.

	data: MANAGED_POINTER
			-- Hold data for registry key value

	internal_value: WEL_STRING is
			-- Storage for Current.
		obsolete
			"Use `string_value' or `dword_value' instead."
		do
			create Result.make_empty (data.count - 2)
			Result.item.memory_copy (data.item, data.count)
		end

	value: STRING_32 is
			-- String data.
		obsolete
			"Use `string_value' instead."
		require
			valid_type: type = Reg_sz
		do
			Result := string_value
		ensure
			string_value_not_void: Result /= Void
		end

	string_value: STRING_32 is
			-- String data.
		require
			valid_type: type = Reg_sz
		local
			l_count: INTEGER
			l_str: WEL_STRING
		do
			l_count := data.count
			if l_count > 0 then
				create l_str.share_from_pointer_and_count (data.item, l_count)
				Result := l_str.string
				if Result.item (Result.count) = '%U' then
						-- Case where string was stored with its final null character,
						-- so we don't want it in our actual string.
					Result.remove (l_count)
				end
			end
		ensure
			string_value_not_void: Result /= Void
		end

	dword_value: INTEGER is
			-- Data converted as integer.
		require
			valid_type: type = Reg_dword
		do
			($Result).memory_copy (data.item, Integer_32_bytes)
		end

feature -- Element Change

	set_type (t: INTEGER) is
			-- Set type of value with `t'.
			-- See class WEL_REGISTRY_KEY_VALUE_TYPE for possible
			-- values for `t'.
		do
			type := t
		ensure
			type_set: type = t
		end

	set_value (v: like value) is
			-- Set `value' with `v'.
		obsolete
			"Use `set_string_value' instead'."
		require
			v_not_void: v /= Void
		local
			l_str: WEL_STRING
		do
			create l_str.make (v)
			create data.make (l_str.capacity)
			data.item.memory_copy (l_str.item, l_str.capacity)
		ensure
			value_set: value.is_equal (v)
		end

	set_dword_value (v: like dword_value) is
			-- Set `dword_value' with `v'.
			-- Set `type' with `reg_dword'.
		do
			type := reg_dword
			create data.make (integer_32_bytes)
			data.put_integer_32 (v, 0)
		ensure
			type_set: type = reg_dword
			dword_value_set: dword_value = v
		end

	set_string_value (v: STRING_GENERAL) is
			-- Set `string_value' with `v'.
			-- Set `type' with `reg_sz'.
		require
			v_not_void: v /= Void
		local
			l_str: WEL_STRING
		do
			type := reg_sz
			create l_str.make (v)
			create data.make (l_str.capacity)
			data.item.memory_copy (l_str.item, l_str.capacity)
		ensure
			type_set: type = reg_sz
			dword_value_set: string_value.is_equal (v)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_REGISTRY_KEY_VALUE

