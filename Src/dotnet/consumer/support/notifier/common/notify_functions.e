note
	description: "A collection of notifier functions, that can be used with the MDC_BALLOON_MSG environment variable."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFY_FUNCTIONS

feature {NONE} -- Contants

	namespace_delimiter: CHARACTER = ':'
			-- Message function namespace delimiter

	module_namespace: SYSTEM_STRING = "module"
	assembly_namespace: SYSTEM_STRING = "assembly"
	consume_namespace: SYSTEM_STRING = "consume"
			-- Function namespaces

	name_function: SYSTEM_STRING = "name"
	version_function: SYSTEM_STRING = "version"
	culture_function: SYSTEM_STRING = "culture"
	key_function: SYSTEM_STRING = "key"
	full_name_function: SYSTEM_STRING = "full_name"
	path_function: SYSTEM_STRING = "path"
	clr_function: SYSTEM_STRING = "clr"
	reason_function: SYSTEM_STRING = "reason"
	cache_id_function: SYSTEM_STRING = "cache_id"
	cache_path_function: SYSTEM_STRING = "cache_path"
			-- Function names

feature {NONE} -- Implementation

	message_functions: HASH_TABLE [STRING, STRING]
			-- Message functions

	functions: LIST [SYSTEM_STRING]
			-- List of message functions
		local
			l_result: ARRAYED_LIST [SYSTEM_STRING]
		once
			create l_result.make (12)
			l_result.compare_objects
			l_result.extend (new_function (module_namespace, name_function))
			l_result.extend (new_function (module_namespace, version_function))
			l_result.extend (new_function (module_namespace, culture_function))
			l_result.extend (new_function (module_namespace, key_function))
			l_result.extend (new_function (module_namespace, path_function))
			l_result.extend (new_function (module_namespace, full_name_function))
			l_result.extend (new_function (module_namespace, clr_function))

			l_result.extend (new_function (assembly_namespace, name_function))
			l_result.extend (new_function (assembly_namespace, version_function))
			l_result.extend (new_function (assembly_namespace, culture_function))
			l_result.extend (new_function (assembly_namespace, key_function))
			l_result.extend (new_function (assembly_namespace, full_name_function))
			l_result.extend (new_function (assembly_namespace, path_function))

			l_result.extend (new_function (consume_namespace, reason_function))
			l_result.extend (new_function (consume_namespace, cache_id_function))
			l_result.extend (new_function (consume_namespace, cache_path_function))

			Result := l_result
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_compares_objects: Result.object_comparison
		end

	new_function (a_ns: SYSTEM_STRING; a_name: SYSTEM_STRING): SYSTEM_STRING
			-- Generates a qualified function name from namespace `a_ns' and a
			-- function name `a_name'.
		require
			a_ns_attached: a_ns /= Void
			not_a_ns_is_empty: a_ns.length > 0
			a_name_attached: a_name /= Void
			not_a_name_is_empty: a_name.length > 0
		do
			Result := {SYSTEM_STRING}.concat (a_ns, ({SYSTEM_STRING})[namespace_delimiter.out], a_name)
		ensure
			result_attached: Result /= Void
			not_result_is_empty: Result.length /= 0
			result_split_count_is_two: Result.split (<<namespace_delimiter>>).count = 2
		end

note
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

end -- class NOTIFY_FUNCTIONS
