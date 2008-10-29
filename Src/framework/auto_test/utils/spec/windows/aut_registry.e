indexing
	description: "Windows registry implementation"
	author: "Ilinca Ciupa and Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

class AUT_REGISTRY

inherit

	AUT_ABSTRACT_REGISTRY

	WEL_REGISTRY_ACCESS_MODE
		export
			{NONE} all
		end

feature -- Access

	subkeys (key_name: STRING): DS_LINEAR [STRING] is
		local
			result_list: DS_LINKED_LIST [STRING]
			registry: WEL_REGISTRY
			key: POINTER
			subkey_count: INTEGER
			subkey: WEL_REGISTRY_KEY
			i: INTEGER
		do
			create registry
			key := registry.open_key_with_access (key_name, Key_enumerate_sub_keys | Key_query_value)
			if key /= Default_pointer then
				subkey_count := registry.number_of_subkeys (key)
				check
					count_positive: subkey_count >= 0
				end

				from
					i := 0
					create result_list.make
				until
					i >= subkey_count or
					result_list = Void
				loop
					subkey := registry.enumerate_key (key, i)
					if subkey /= Void then
						result_list.force_last (subkey.name.as_string_8)
					else
						result_list := Void
					end
					i := i + 1
				end
				registry.close_key (key)
				Result := result_list
			end
		end

	string_value (key_name: STRING): STRING is
		local
			registry: WEL_REGISTRY
			key_value: WEL_REGISTRY_KEY_VALUE
			last_index_of_slash: INTEGER
			key_path, key_value_name: STRING
		do
			create registry
			last_index_of_slash := key_name.last_index_of ('\', key_name.count)
			if
				last_index_of_slash > 1 and
				key_name.count > last_index_of_slash
			then
				key_path := key_name.substring (1, last_index_of_slash - 1)
				key_value_name := key_name.substring (last_index_of_slash + 1, key_name.count)
				key_value := registry.open_key_value (key_path, key_value_name)
				if key_value /= Void then
					Result := key_value.string_value
					registry.close_key (key_value.data.item)
				end
			end
		end

feature -- Status report

	is_available: BOOLEAN is True

end
