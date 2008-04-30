indexing
	description: "Processing interface for component."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_INTERFACE_GENERATOR

inherit
	WIZARD_TYPES
		export
			{NONE} all
		end

	ECOM_FUNC_KIND
		export
			{NONE} all
		end

	ANY

feature -- Access

	interface: WIZARD_INTERFACE_DESCRIPTOR
			-- Interface descriptor.

	component: WIZARD_COMPONENT_DESCRIPTOR
			-- Component descriptor.

feature -- Basic operations

	generate_functions_and_properties (a_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate functions and properties.
		require
			non_void_interface: a_interface /= Void
		local
			l_properties: LIST [WIZARD_PROPERTY_DESCRIPTOR]
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
			l_already_generated: BOOLEAN
			l_coclass: WIZARD_COCLASS_DESCRIPTOR
		do
			l_interface := a_interface.inherited_interface
			if l_interface /= Void then
				l_coclass ?= component
				if l_coclass /= Void then
					l_already_generated := l_interface.is_implementing_coclass (l_coclass) or
											is_interface_generated_for_coclass (l_interface, l_coclass)
				end

				if not l_already_generated and not l_interface.is_iunknown and not l_interface.is_idispatch then
					if l_coclass /= Void then
						-- Now register the fact that this interface was already generated for that coclass
						-- This is necessary because two interfaces may inherit from a common interface that
						-- is not implemented by the coclass (the feature names will be identical because we
						-- want to merge).
						add_generated_interface_for_coclass (l_interface, l_coclass)
					end
					generate_functions_and_properties (l_interface)
				end
			end

			l_properties := a_interface.properties
			if not l_properties.is_empty then
				from
					l_properties.start
				until
					l_properties.after
				loop
					process_property (l_properties.item)
					l_properties.forth
				end
			end

			if not a_interface.functions_empty then
				from
					a_interface.functions_start
				until
					a_interface.functions_after
				loop
					process_function (a_interface.functions_item)
					a_interface.functions_forth
				end
			end
		end

	process_property (a_property: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Process property.
		require
			non_void_property: a_property/= Void
		deferred
		end


	process_function (a_function: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Process function.
		require
			non_void_descriptor: a_function/= Void
		deferred
		end

feature {NONE} -- Implementation

	finished: BOOLEAN
			-- Is processing finished?

	clean_up is
			-- Clean up.
		require
			finished: finished
		deferred
		end

	is_interface_generated_for_coclass (a_interface: WIZARD_INTERFACE_DESCRIPTOR; a_coclass: WIZARD_COCLASS_DESCRIPTOR): BOOLEAN is
			-- Was interface `a_interface' already generated in context of coclass `a_coclass'?
		require
			non_void_interface: a_interface /= Void
			non_void_coclass: a_coclass /= Void
		do
			generated_coclasses.search (a_coclass.guid.out)
			if generated_coclasses.found then
				Result := generated_coclasses.found_item.has (a_interface.guid.out)
			end
		end

	add_generated_interface_for_coclass (a_interface: WIZARD_INTERFACE_DESCRIPTOR; a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Add interface `a_interface' in list of generated interfaces for coclass `a_coclass'.
		require
			non_void_interface: a_interface /= Void
			non_void_coclass: a_coclass /= Void
		local
			l_interfaces: HASH_TABLE [STRING, STRING]
			l_interface_guid, l_coclass_guid: STRING
		do
			l_interface_guid := a_interface.guid.out
			l_coclass_guid := a_coclass.guid.out
			generated_coclasses.search (l_coclass_guid)
			if generated_coclasses.found then
				l_interfaces := generated_coclasses.found_item
				l_interfaces.put (l_interface_guid, l_interface_guid)
			else
				create l_interfaces.make (10)
				l_interfaces.put (l_interface_guid, l_interface_guid)
				generated_coclasses.put (l_interfaces, l_coclass_guid)
			end
		ensure
			added: generated_coclasses.has (a_coclass.guid.out) and then
						generated_coclasses.item (a_coclass.guid.out).has (a_interface.guid.out)
		end

	generated_coclasses: HASH_TABLE [HASH_TABLE [STRING, STRING], STRING]
			-- Table of table of generated interfaces guids indexed by coclass guids

invariant
	non_void_interface: not finished implies interface /= Void
	non_void_component: not finished implies component /= Void
	non_void_generated_coclasses: generated_coclasses /= Void

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
end -- class WIZARD_COMPONENT_INTERFACE_GENERATOR


