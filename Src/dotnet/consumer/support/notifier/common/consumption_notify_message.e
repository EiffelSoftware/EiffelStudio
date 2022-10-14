note
	description: "A notifier icon message for consumption."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	CONSUMPTION_NOTIFY_MESSAGE

inherit
	NOTIFY_MESSAGE

	SYSTEM_OBJECT

	NOTIFY_FUNCTIONS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_ca: like assembly; a_path: like assembly_path; a_reason: like reason; a_cache: like cache_path)
			--
		require
			a_ca_attached: a_ca /= Void
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
			a_reason_attached: a_reason /= Void
			not_a_reason_is_empty: not a_reason.is_empty
			a_cache_attached: a_cache /= Void
			not_a_cache_is_empty: not a_cache.is_empty
		do
			assembly := a_ca
			assembly_path := a_path
			reason := a_reason
			cache_path := a_cache
			initialize_message_template
		ensure
			set_assembly: assembly = a_ca
			set_assembly_path: assembly_path = a_path
			set_reason: reason = a_reason
			set_cache_path: cache_path = a_cache
		end

	initialize_message_template
			-- Initializes `message_template'.
		local
			l_value: detachable STRING_32
		do
			l_value := (create {EXECUTION_ENVIRONMENT}).item (message_variable)
			if l_value = Void or else l_value.is_empty then
				message_template := default_message
			else
				message_template := l_value
			end
		ensure
			message_template_attached: message_template /= Void
			not_message_template_is_empty: not message_template.is_empty
		end

feature -- Access

	assembly: CONSUMED_ASSEMBLY
			-- Consumed assembly

	assembly_path: READABLE_STRING_32
			-- Path to assembly being consumed

	reason: READABLE_STRING_32
			-- Reason why assembly is being consumed

	cache_path: PATH
			-- Path to Eiffel Assembly Cache

	message: STRING_32
			-- Full notify message
		local
			l_functions: like functions
			l_pattern: SYSTEM_DLL_REGEX
			l_var: SYSTEM_STRING
			l_func: SYSTEM_STRING
			l_value: STRING_32
			l_count: INTEGER
			i: INTEGER
		do
			if attached internal_message as l_result then
				Result := l_result
			else
				l_functions := functions
				create Result.make_from_string (default_message)
				l_pattern := variable_pattern
				if
					attached l_pattern.matches (default_message) as l_matches and then
					l_matches.count > 0
				then
					from l_count := l_matches.count until i = l_count loop
						if
							attached l_matches.item (i) as l_match and then
							attached l_match.groups as l_groups and then
							attached l_groups.item (0) as l_group
						then
							l_var := l_group.value
							if l_var /= Void then
								if
									l_groups.count >= 2 and then
									attached l_groups.item (1) as l_second_group
								then
									l_func := l_second_group.value
									if l_func /= Void and then l_functions.has (create {STRING_32}.make_from_cil (l_func)) then
										l_value := evaluate_function (create {STRING_32}.make_from_cil (l_func))
										Result.replace_substring_all (create {STRING_32}.make_from_cil (l_var), l_value)
									end
								end
							end
						end
						i := i + 1
					end
				end
				Result.replace_substring_all ({STRING_32} "%%N", {STRING_32} "%N")
				Result.replace_substring_all ({STRING_32} "%%T", {STRING_32} "%T")
				internal_message := Result
			end
		end

feature {NONE} -- Evaluation

	evaluate_function (a_name: READABLE_STRING_32): STRING_32
			-- Evaluates function with the name `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			functions_has_a_name: functions.has (a_name)
		local
			l_names: LIST [READABLE_STRING_32]
			l_ns: READABLE_STRING_32
			l_func: READABLE_STRING_32
			l_result: detachable SYSTEM_STRING
		do
			l_names := a_name.as_lower.split (namespace_delimiter)
			if l_names.count = 2 then
				l_ns := l_names.i_th (1)
				l_func := l_names.i_th (2)
				if module_namespace.same_string_general (l_ns) then
					if l_func.same_string_general (name_function) then
						l_result := current_assembly_name.name
					elseif l_func.same_string_general (version_function) and then attached current_assembly_name.version as l_version then
						l_result := l_version.to_string
					elseif l_func.same_string_general (culture_function) and then attached current_assembly_name.culture_info as l_culture then
						l_result := l_culture.to_string
					elseif l_func.same_string_general (key_function) then
						l_result := current_assembly_name.name
					elseif l_func.same_string_general (full_name_function) then
						l_result := current_assembly_name.full_name
					elseif l_func.same_string_general (path_function) then
						l_result := current_assembly.location
					elseif l_func.same_string_general (clr_function) and then attached {ENVIRONMENT}.version as l_version then
						l_result := l_version.to_string
					end
				elseif assembly_namespace.same_string_general (l_ns) then
					if l_func.same_string_general (name_function) then
						l_result := assembly.name
					elseif l_func.same_string_general (version_function) then
						l_result := assembly.version
					elseif l_func.same_string_general (culture_function) then
						l_result := assembly.culture
					elseif l_func.same_string_general (key_function) then
						l_result := assembly.key
					elseif l_func.same_string_general (full_name_function) then
						l_result := {SYSTEM_STRING}.format (({SYSTEM_STRING})["{0}, Ver={1}, Cul={2}, PKT={3}"], ({NATIVE_ARRAY [detachable SYSTEM_STRING]})[<<({SYSTEM_STRING})[assembly.name], ({SYSTEM_STRING})[assembly.version], ({SYSTEM_STRING})[assembly.culture], ({SYSTEM_STRING})[assembly.key]>>])
					elseif l_func.same_string_general (path_function) then
						l_result := assembly_path
					end
				elseif consume_namespace.same_string_general (l_ns) then
					if l_func.same_string_general (reason_function) then
						l_result := reason
					elseif l_func.same_string_general (cache_id_function) then
						l_result := assembly.folder_name
					elseif l_func.same_string_general (cache_path_function) then
						l_result := cache_path.name
					end
				end
			end
			if l_result /= Void then
				Result := l_result
			else
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Constants

	message_variable: STRING = "MDC_BALLOON_MSG"
			-- Notify message environment variable

	default_message: STRING_32 = "Consuming assembly '${assembly:name}, Version=${assembly:version}'.%N%NCLR Version: ${module:clr}%NReason: ${consume:reason}%NAssembly:${assembly:path}%N%NID: ${consume:cache_id}"
			-- Default notify message

feature {NONE} -- Implementation

	message_template: STRING_32
			-- Message template

	current_assembly: ASSEMBLY
			-- Executing assembly
		once
			Result := ({like Current}).to_cil.assembly
			check
				from_documentation: attached Result
			then
			end
		ensure
			Result_attached: Result /= Void
		end

	current_assembly_name: ASSEMBLY_NAME
			-- Name of executing assembly
		once
			Result := current_assembly.get_name
			check
				from_documentation: attached Result
			then
			end
		ensure
			result_attached: Result /= Void
		end

	variable_pattern: SYSTEM_DLL_REGEX
			-- Inline variable pattern regualr expression
		once
			create Result.make ("\$\{([a-zA-z]+\:[a-zA-z]+)\}")
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Internal Implementation Cache

	internal_message: detachable STRING_32
			-- Cached version of `message'
			-- Note: Do not use directly!

invariant
	message_template_attached: message_template /= Void
	not_message_template_is_empty: not message_template.is_empty

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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

end
