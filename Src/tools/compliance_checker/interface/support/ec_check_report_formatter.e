note
	description: "[
		A collection of formatting related functions for formatting report output strings.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECK_REPORT_FORMATTER

feature -- Formatting

	format_member (a_member: MEMBER_INFO; a_show_full_name: BOOLEAN): STRING
			-- Formats `a_member'
			-- `a_show_full_name' will cause member fully qualified name to be generated.
		require
			a_member_not_void: a_member /= Void
		local
			l_type: detachable SYSTEM_TYPE
			l_prop: detachable PROPERTY_INFO
			l_method: detachable METHOD_INFO
			l_field: detachable FIELD_INFO
			l_event: detachable EVENT_INFO
			l_ctor: detachable CONSTRUCTOR_INFO
			l_result: detachable STRING
		do
			l_type ?= a_member
			if l_type /= Void then
				l_result := format_type (l_type, a_show_full_name)
			else
				l_method ?= a_member
				if l_method /= Void then
					l_result := format_method (l_method, a_show_full_name)
				else
					l_prop ?= a_member
					if l_prop /= Void then
						l_result := format_property (l_prop, a_show_full_name)
					else
						l_ctor ?= a_member
						if l_ctor /= Void then
							l_result := format_constructor (l_ctor, a_show_full_name)
						else
							l_event ?= a_member
							if l_event /= Void then
								l_result := format_event (l_event, a_show_full_name)
							else
								l_field ?= a_member
								if l_field /= Void then
									l_result := format_field (l_field, a_show_full_name)
								end
							end
						end
					end
				end
			end
			if l_result = Void then
				check attached a_member.name as l_name then
					Result := l_name
				end
			else
				Result := l_result
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	format_type (a_type: SYSTEM_TYPE; a_show_full_name: BOOLEAN): STRING
			-- Format `a_type'
			-- `a_show_full_name' will cause member fully qualified name to be generated
		require
			a_type_not_void: a_type /= Void
		do
			if a_show_full_name then
				check attached a_type.full_name as l_full_name then
					Result := l_full_name
				end
			else
				check attached a_type.name as l_name then
					Result := l_name
				end
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	format_constructor (a_ctor: CONSTRUCTOR_INFO; a_show_full_name: BOOLEAN): STRING
			-- Takes `a_constructor' and creates a readable string.
			-- `a_show_full_name' will cause member fully qualified name to be generated.
		require
			a_ctor_not_void: a_ctor /= Void
		local
			l_name: STRING
			l_type: STRING
			l_params: detachable NATIVE_ARRAY [detachable PARAMETER_INFO]
			l_count: INTEGER
			i: INTEGER
		do
			check attached a_ctor.name as l_ctor_name then
				l_name := l_ctor_name
				create Result.make (40)

				if a_show_full_name then
					check
						attached a_ctor.reflected_type as l_reflected_type and then
						attached l_reflected_type.to_string as l_string
					then
						Result.append (create {STRING}.make_from_cil (l_string))
						Result.append_character ('.')
					end
				end

				Result.append (l_name)

				l_params := a_ctor.get_parameters
				if l_params /= Void then
					l_count := l_params.count
				end
				if l_count > 0 and l_params /= Void then
					from
						Result.append (" (")
					until
						i = l_count
					loop
						check
							attached l_params.item (i) as l_param and then
							attached l_param.parameter_type as l_parameter_type
						then
							l_type := simple_type_name (l_parameter_type)
							Result.append (l_type)
							if i < l_count - 1 then
								Result.append (", ")
							end
						end
						i := i + 1
					end
					Result.append_character (')')
				end
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	format_method (a_method: METHOD_INFO; a_show_full_name: BOOLEAN): STRING
			-- Takes `a_method' and creates a readable string.
			-- `a_show_full_name' will cause member fully qualified name to be generated.
		require
			a_method_not_void: a_method /= Void
		local
			l_name: STRING
			l_type: detachable SYSTEM_TYPE
			l_type_str: STRING
			l_params: detachable NATIVE_ARRAY [detachable PARAMETER_INFO]
			l_count: INTEGER
			i: INTEGER
		do
			check attached a_method.name as l_method_name then
				l_name := l_method_name
				create Result.make (40)

				if a_show_full_name then
					check
						attached a_method.reflected_type as l_reflected_type and then
						attached l_reflected_type.to_string as l_string
					then
						Result.append (create {STRING}.make_from_cil (l_string))
						Result.append_character ('.')
					end
				else
					l_type := a_method.return_type
					if l_type /= Void then
						l_type_str := simple_type_name (l_type)
						Result.append (l_type_str)
						Result.append_character (' ')
					end
				end

				Result.append (l_name)

				l_params := a_method.get_parameters
				if l_params /= Void then
					l_count := l_params.count
				end
				if l_count > 0 and l_params /= Void then
					from
						Result.append (" (")
					until
						i = l_count
					loop
						check
							attached l_params.item (i) as l_param and then
							attached l_param.parameter_type as l_parameter_type
						then
							l_type_str := simple_type_name (l_parameter_type)
							Result.append (l_type_str)
							if i < l_count - 1 then
								Result.append (", ")
							end
						end
						i := i + 1
					end
					Result.append_character (')')
				end
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	format_property (a_prop: PROPERTY_INFO; a_show_full_name: BOOLEAN): STRING
			-- Takes `a_prop' and creates a readable string.
			-- `a_show_full_name' will cause member fully qualified name to be generated.
		require
			a_prop_not_void: a_prop /= Void
		local
			l_name: STRING
			l_type: STRING
		do
			check attached a_prop.name as l_prop_name then
				l_name := l_prop_name
				if a_show_full_name then
					check
						attached a_prop.reflected_type as l_reflected_type and then
						attached l_reflected_type.to_string as l_string
					then
						l_type := l_string
					end
				else
					check attached a_prop.property_type as l_property_type then
						l_type := simple_type_name (l_property_type)
					end
				end

				create Result.make (l_name.count + l_type.count + 12)
				if a_show_full_name then
					Result.append (l_type)
					Result.append_character ('.')
				else
					Result.append ("[property] ")
				Result.append (l_type)
				Result.append_character (' ')
				end

				Result.append (l_name)
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	format_event (a_event: EVENT_INFO; a_show_full_name: BOOLEAN): STRING
			-- Takes `a_event' and creates a readable string.
			-- `a_show_full_name' will cause member fully qualified name to be generated.
		require
			a_event_not_void: a_event /= Void
		local
			l_name: STRING
			l_type: STRING
		do
			check attached a_event.name as l_event_name then
				l_name := l_event_name
				if a_show_full_name then
					check
						attached a_event.reflected_type as l_reflected_type and then
						attached l_reflected_type.to_string as l_string
					then
						l_type := l_string
					end
				else
					check attached a_event.event_handler_type as l_event_type then
						l_type := simple_type_name (l_event_type)
					end
				end

				create Result.make (l_name.count + l_type.count + 10)
				if a_show_full_name then
					Result.append (l_type)
					Result.append_character ('.')
				else
					Result.append ("[event] ")
					Result.append (l_type)
					Result.append_character (' ')
				end
				Result.append_character (' ')
				Result.append (l_name)
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	format_field (a_field: FIELD_INFO; a_show_full_name: BOOLEAN): STRING
			-- Takes `a_field' and creates a readable string.
			-- `a_show_full_name' will cause member fully qualified name to be generated.
		require
			a_field_not_void: a_field /= Void
		local
			l_name: STRING
			l_type: STRING
		do
			check attached a_field.name as l_field_name then
				l_name := l_field_name
				if a_show_full_name then
					check
						attached a_field.reflected_type as l_reflected_type and then
						attached l_reflected_type.to_string as l_string
					then
						l_type := l_string
					end
				else
					check attached a_field.field_type as l_field_type then
						l_type := simple_type_name (l_field_type)
					end
				end

				create Result.make (l_name.count + l_type.count + 1)
				Result.append (l_type)
				if a_show_full_name then
					Result.append_character ('.')
				else
					Result.append_character (' ')
				end
				Result.append (l_name)
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Implementation

	simple_type_name (a_type: SYSTEM_TYPE): SYSTEM_STRING
			-- Retrieves a simple type name for `a_type'
		require
			a_type_not_void: a_type /= Void
		local
			l_type: detachable like a_type
			l_name: detachable SYSTEM_STRING
			l_tail: detachable SYSTEM_STRING
			c: CHARACTER
			i: INTEGER
		do
			if a_type.has_element_type then
				l_type := a_type.get_element_type
			else
				l_type := a_type
			end

			check attached a_type.full_name as l_full_name then
				if a_type.is_array then
					c := '['
					i := l_full_name.index_of ('[')
				elseif a_type.is_by_ref then
					c := '&'
					i := l_full_name.index_of ('&')
				elseif a_type.is_pointer then
					c := '*'
					i := l_full_name.index_of ('*')
				end
				if i > 1 then
					l_name := l_full_name.substring (0, i)
					l_tail := l_full_name.substring (i)
				else
					l_name := l_full_name
				end

				if attached {SYSTEM_STRING} simple_names.item (l_name) as l_simple_name then
					Result := l_simple_name
				else
					Result := "???"
				end
				if l_tail /= Void then
					check attached {SYSTEM_STRING}.concat_string_string (Result, l_tail) as l_result then
						Result := l_result
					end
				end
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: Result.length > 0
		end

	simple_names: HASHTABLE
			-- Simple names table
			-- Key: Full type name
			-- Value: Simple type name
		once
			create Result.make
			Result.add (("System.Object").to_cil, ("object").to_cil)
			Result.add (("System.Byte").to_cil, ("byte").to_cil)
			Result.add (("System.Int16").to_cil, ("short").to_cil)
			Result.add (("System.Int32").to_cil, ("int").to_cil)
			Result.add (("System.Int64").to_cil, ("long").to_cil)
			Result.add (("System.SByte").to_cil, ("sbyte").to_cil)
			Result.add (("System.UInt16").to_cil, ("ushort").to_cil)
			Result.add (("System.UInt32").to_cil, ("uint").to_cil)
			Result.add (("System.UInt64").to_cil, ("ulong").to_cil)
			Result.add (("System.Boolean").to_cil, ("bool").to_cil)
			Result.add (("System.Char").to_cil, ("char").to_cil)
			Result.add (("System.Void").to_cil, ("void").to_cil)
			Result.add (("System.Single").to_cil, ("single").to_cil)
			Result.add (("System.Double").to_cil, ("double").to_cil)
			Result.add (("System.String").to_cil, ("string").to_cil)
			Result.add (("System.TypedReference").to_cil, ("typedref").to_cil)
		ensure
			result_not_void: Result /= Void
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
end -- EC_CHECK_REPORT_FORMATTER
