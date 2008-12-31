note
	description: "A type consumer used to consume only the basic type information."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	TYPE_INFO_ONLY_CONSUMER

inherit
	TYPE_CONSUMER
		redefine
			make
		end

create
	make

feature -- Initialization

	make (t: SYSTEM_TYPE; en: STRING)
			-- Initialize type consumer for type `t' with eiffel name `en'.
		local
			dotnet_name: STRING
		do
			create dotnet_name.make_from_cil (t.full_name)
			if t.is_nested_public or t.is_nested_family or t.is_nested_fam_or_assem then
					-- `t.declaring_type' contains enclosing type of current nested type.
				check
					is_declaring_type_consumed: is_consumed_type (t.declaring_type)
				end
				create {CONSUMED_NESTED_TYPE} consumed_type.make (
					dotnet_name, en, t.is_interface, t.is_abstract,
					False, t.is_value_type, t.is_enum, Void, create {ARRAYED_LIST [CONSUMED_REFERENCED_TYPE]}.make (0),
					referenced_type_from_type (t.declaring_type))
			else
				create consumed_type.make (dotnet_name, en, t.is_interface, t.is_abstract,
					False, t.is_value_type, t.is_enum, Void, create {ARRAYED_LIST [CONSUMED_REFERENCED_TYPE]}.make (0))
			end

			create internal_members.make (0)
			create internal_properties.make (0)
			create internal_events.make (0)
			create internal_constructors.make (0)
			create properties_and_events.make

			internal_referenced_type := referenced_type_from_type (t)
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

end -- class {TYPE_INFO_ONLY_CONSUMER}
