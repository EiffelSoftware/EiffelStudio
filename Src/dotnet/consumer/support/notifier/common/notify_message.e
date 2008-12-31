note
	description: "A notifier icon message for consumption."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	NOTIFY_MESSAGE

inherit
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
			not_a_path_is_empty: a_path.length > 0
			a_reason_attached: a_reason /= Void
			not_a_reason_is_empty: a_reason.length > 0
			a_cache_attached: a_cache /= Void
			not_a_cache_is_empty: a_cache.length > 0
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
			l_value: SYSTEM_STRING
		do
			l_value := {ENVIRONMENT}.get_environment_variable (message_variable)
			if l_value = Void or else l_value.length = 0 then
				message_template := default_message
			else
				message_template := l_value
			end
		ensure
			message_template_attached: message_template /= Void
			not_message_template_is_empty: message_template.length > 0
		end

feature -- Access

	assembly: CONSUMED_ASSEMBLY
			-- Consumed assembly

	assembly_path: SYSTEM_STRING
			-- Path to assembly being consumed

	reason: SYSTEM_STRING
			-- Reason why assembly is being consumed

	cache_path: SYSTEM_STRING
			-- Path to Eiffel Assembly Cache

	message: SYSTEM_STRING
			-- Full notify message
		local
			l_functions: like functions
			l_sb: STRING_BUILDER
			l_pattern: SYSTEM_DLL_REGEX
			l_match: SYSTEM_DLL_MATCH
			l_matches: SYSTEM_DLL_MATCH_COLLECTION
			l_var: SYSTEM_STRING
			l_func: SYSTEM_STRING
			l_value: SYSTEM_STRING
			l_count: INTEGER
			i: INTEGER
		do
			Result := internal_message
			if Result = Void then
				l_functions := functions
				Result := message_template
				create l_sb.make (256)
				l_sb := l_sb.append (Result)
				l_pattern := variable_pattern
				l_matches := l_pattern.matches (Result)
				if l_matches.count > 0 then
					from l_count := l_matches.count until i = l_count loop
						l_match := l_matches.item (i)
						l_var := l_match.groups.item (0).value
						if l_match.groups.count >= 2 then
							l_func := l_match.groups.item (1).value
							if l_functions.has (l_func) then
								l_value := evaluate_function (l_func)
							else
								l_value := l_var
							end
						else
							l_value := l_var
						end
						check l_value_attached: l_value /= Void end
						l_sb := l_sb.replace (l_var, l_value)
						i := i + 1
					end
				end
				l_sb := l_sb.replace ("%%N", "%N")
				l_sb := l_sb.replace ("%%T", "%T")
				Result := l_sb.to_string
				internal_message := Result
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Evaluation

	evaluate_function (a_name: SYSTEM_STRING): SYSTEM_STRING
			-- Evaluates function with the name `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: a_name.length > 0
			functions_has_a_name: functions.has (a_name)
		local
			l_names: NATIVE_ARRAY [SYSTEM_STRING]
			l_ns: SYSTEM_STRING
			l_func: SYSTEM_STRING
		do
			l_names := a_name.to_lower.split (<<namespace_delimiter>>)
			check l_names_count_is_two: l_names.length = 2 end
			if l_names.length = 2 then
				l_ns := l_names.item (0)
				l_func := l_names.item (1)
				if module_namespace.equals (l_ns) then
					if l_func.equals (name_function) then
						Result := current_assembly_name.name
					elseif l_func.equals (version_function) then
						Result := current_assembly_name.version.to_string
					elseif l_func.equals (culture_function) then
						Result := current_assembly_name.culture_info.to_string
					elseif l_func.equals (key_function) then
						Result := current_assembly_name.name
					elseif l_func.equals (full_name_function) then
						Result := current_assembly_name.full_name
					elseif l_func.equals (path_function) then
						Result := current_assembly.location
					elseif l_func.equals (clr_function) then
						Result := {ENVIRONMENT}.version.to_string
					else
						check False end
					end
				elseif assembly_namespace.equals (l_ns) then
					if l_func.equals (name_function) then
						Result := assembly.name
					elseif l_func.equals (version_function) then
						Result := assembly.version
					elseif l_func.equals (culture_function) then
						Result := assembly.culture
					elseif l_func.equals (key_function) then
						Result := assembly.key
					elseif l_func.equals (full_name_function) then
						Result := {SYSTEM_STRING}.format (({SYSTEM_STRING})["{0}, Ver={1}, Cul={2}, PKT={3}"], ({NATIVE_ARRAY [SYSTEM_STRING]})[<<({SYSTEM_STRING})[assembly.name], ({SYSTEM_STRING})[assembly.version], ({SYSTEM_STRING})[assembly.culture], ({SYSTEM_STRING})[assembly.key]>>])
					elseif l_func.equals (path_function) then
						Result := assembly_path
					else
						check False end
					end
				elseif consume_namespace.equals (l_ns) then
					if l_func.equals (reason_function) then
						Result := reason
					elseif l_func.equals (cache_id_function) then
						Result := assembly.folder_name
					elseif l_func.equals (cache_path_function) then
						Result := cache_path
					else
						check False end
					end
				end
			end

			if Result = Void then
				Result := {SYSTEM_STRING}.empty
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Constants

	message_variable: SYSTEM_STRING = "MDC_BALLOON_MSG"
			-- Notify message environment variable

	default_message: SYSTEM_STRING = "Consuming assembly '${assembly:name}, Version=${assembly:version}'.%N%NCLR Version: ${module:clr}%NReason: ${consume:reason}%NAssembly:${assembly:path}%N%NID: ${consume:cache_id}"
			-- Default notify message

feature {NONE} -- Implementation

	message_template: SYSTEM_STRING
			-- Message template

	current_assembly: ASSEMBLY
			-- Executing assembly
		once
			Result := ({like Current}).to_cil.assembly
		ensure
			Result_attached: Result /= Void
		end

	current_assembly_name: ASSEMBLY_NAME
			-- Name of executing assembly
		once
			Result := current_assembly.get_name
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

	internal_message: SYSTEM_STRING
			-- Cached version of `message'
			-- Note: Do not use directly!

invariant
	message_template_attached: message_template /= Void
	not_message_template_is_empty: message_template.length > 0

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

end -- class NOTIFY_MESSAGE
