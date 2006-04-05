indexing
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

	format_member (a_member: MEMBER_INFO; a_show_full_name: BOOLEAN): STRING is
			-- Formats `a_member'
			-- `a_show_full_name' will cause member fully qualified name to be generated.
		require
			a_member_not_void: a_member /= Void
		local
			l_type: SYSTEM_TYPE
			l_prop: PROPERTY_INFO
			l_method: METHOD_INFO
			l_field: FIELD_INFO
			l_event: EVENT_INFO
			l_ctor: CONSTRUCTOR_INFO
		do
			l_type ?= a_member
			if l_type /= Void then
				Result := format_type (l_type, a_show_full_name)
			else
				l_method ?= a_member
				if l_method /= Void then
					Result := format_method (l_method, a_show_full_name)
				else
					l_prop ?= a_member
					if l_prop /= Void then
						Result := format_property (l_prop, a_show_full_name)
					else
						l_ctor ?= a_member
						if l_ctor /= Void then
							Result := format_constructor (l_ctor, a_show_full_name)
						else
							l_event ?= a_member
							if l_event /= Void then
								Result := format_event (l_event, a_show_full_name)
							else
								l_field ?= a_member
								if l_field /= Void then
									Result := format_field (l_field, a_show_full_name)	
								end
							end
						end
					end
				end
			end
			if Result = Void then
				Result := a_member.name
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end
		
	format_type (a_type: SYSTEM_TYPE; a_show_full_name: BOOLEAN): STRING is
			-- Format `a_type'
			-- `a_show_full_name' will cause member fully qualified name to be generated
		require
			a_type_not_void: a_type /= Void
		do
			if a_show_full_name then
				Result := a_type.full_name
			else
				Result := a_type.name
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	format_constructor (a_ctor: CONSTRUCTOR_INFO; a_show_full_name: BOOLEAN): STRING is
			-- Takes `a_constructor' and creates a readable string.
			-- `a_show_full_name' will cause member fully qualified name to be generated.
		require
			a_ctor_not_void: a_ctor /= Void
		local
			l_name: SYSTEM_STRING
			l_type: SYSTEM_STRING
			l_params: NATIVE_ARRAY [PARAMETER_INFO]
			l_count: INTEGER
			i: INTEGER
		do
			l_name := a_ctor.name
			create Result.make (40)

			if a_show_full_name then
				Result.append (a_ctor.reflected_type.to_string)
				Result.append_character ('.')
			end

			Result.append (l_name)
			
			l_params := a_ctor.get_parameters
			l_count := l_params.count
			if l_count > 0 then
				Result.append (" (")
				from
					l_count := l_params.count
				until
					i = l_count
				loop
					l_type := simple_type_name (l_params.item (i).parameter_type)
					Result.append (l_type)
					if i < l_count - 1 then
						Result.append (", ")	
					end
					i := i + 1
				end
				Result.append_character (')')
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	format_method (a_method: METHOD_INFO; a_show_full_name: BOOLEAN): STRING is
			-- Takes `a_method' and creates a readable string.
			-- `a_show_full_name' will cause member fully qualified name to be generated.
		require
			a_method_not_void: a_method /= Void
		local
			l_name: SYSTEM_STRING
			l_type: SYSTEM_TYPE
			l_type_str: SYSTEM_STRING
			l_params: NATIVE_ARRAY [PARAMETER_INFO]
			l_count: INTEGER
			i: INTEGER
		do
			l_name := a_method.name
			create Result.make (40)
		
			if a_show_full_name then
				Result.append (a_method.reflected_type.to_string)
				Result.append_character ('.')
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
			l_count := l_params.count
			if l_count > 0 then
				Result.append (" (")
				from
					l_count := l_params.count
				until
					i = l_count
				loop
					l_type_str := simple_type_name (l_params.item (i).parameter_type)
					Result.append (l_type_str)
					if i < l_count - 1 then
						Result.append (", ")	
					end
					i := i + 1
				end
				Result.append_character (')')
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	format_property (a_prop: PROPERTY_INFO; a_show_full_name: BOOLEAN): STRING is
			-- Takes `a_prop' and creates a readable string.
			-- `a_show_full_name' will cause member fully qualified name to be generated.
		require
			a_prop_not_void: a_prop /= Void
		local
			l_name: SYSTEM_STRING
			l_type: SYSTEM_STRING
		do
			l_name := a_prop.name
			if a_show_full_name then
				l_type := a_prop.reflected_type.to_string
			else
				l_type := simple_type_name (a_prop.property_type)
			end
			
			create Result.make (l_name.length + l_type.length + 12)
			if a_show_full_name then
				Result.append (l_type)
				Result.append_character ('.')
			else
				Result.append ("[property] ")
			Result.append (l_type)
			Result.append_character (' ')
			end

			Result.append (l_name)			
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	format_event (a_event: EVENT_INFO; a_show_full_name: BOOLEAN): STRING is
			-- Takes `a_event' and creates a readable string.
			-- `a_show_full_name' will cause member fully qualified name to be generated.
		require
			a_event_not_void: a_event /= Void
		local
			l_name: SYSTEM_STRING
			l_type: SYSTEM_STRING
		do
			l_name := a_event.name
			if a_show_full_name then
				l_type := a_event.reflected_type.to_string
			else
				l_type := simple_type_name (a_event.event_handler_type)
			end
			
			create Result.make (l_name.length + l_type.length + 10)
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
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end
		
	format_field (a_field: FIELD_INFO; a_show_full_name: BOOLEAN): STRING is
			-- Takes `a_field' and creates a readable string.
			-- `a_show_full_name' will cause member fully qualified name to be generated.
		require
			a_field_not_void: a_field /= Void
		local
			l_name: SYSTEM_STRING
			l_type: SYSTEM_STRING
		do
			l_name := a_field.name
			if a_show_full_name then
				l_type := a_field.reflected_type.to_string
			else
				l_type := simple_type_name (a_field.field_type)
			end
			
			create Result.make (l_name.length + l_type.length + 1)
			Result.append (l_type)
			if a_show_full_name then
				Result.append_character ('.')
			else
				Result.append_character (' ')
			end
			Result.append (l_name)
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Implementation
		
	simple_type_name (a_type: SYSTEM_TYPE): SYSTEM_STRING is
			-- Retrieves a simple type name for `a_type'
		require
			a_type_not_void: a_type /= Void
		local
			l_type: like a_type
			l_full_name: SYSTEM_STRING			
			l_name: SYSTEM_STRING
			l_tail: SYSTEM_STRING
			c: CHARACTER
			i: INTEGER
		do
			if a_type.has_element_type then
				l_type := a_type.get_element_type
			else
				l_type := a_type
			end
			
			l_full_name := a_type.full_name
			if l_full_name /= Void then
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
	
				Result ?= simple_names.item (l_name)
			else					
				Result := "???"
			end

			
			if Result = Void then
				Result := l_full_name
			elseif l_tail /= Void then
				Result := {SYSTEM_STRING}.concat_string_string (Result, l_tail)
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: Result.length > 0
		end
		
	simple_names: HASHTABLE is
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
end -- EC_CHECK_REPORT_FORMATTER
