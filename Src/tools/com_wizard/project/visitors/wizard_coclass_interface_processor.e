indexing
	description: "Processing interfaces for coclass."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COCLASS_INTERFACE_PROCESSOR

inherit
	WIZARD_SHARED_GENERATION_ENVIRONMENT
		rename
			coclass as dictionary_coclass
		export
			{NONE} all
		end

	ANY

feature -- Access

	coclass: WIZARD_COCLASS_DESCRIPTOR
			-- Coclass descriptor.

	source: BOOLEAN
			-- Is coclass source of events?

feature -- Basic operations

	process_interfaces is
			-- Process interfaces.
		require
			non_void_interface_list: coclass.interface_descriptors /= Void
		do
			from
				coclass.interface_descriptors.start
			until
				coclass.interface_descriptors.off
			loop
				generate_interface_features (coclass.interface_descriptors.item)
				coclass.interface_descriptors.forth
			end

			if coclass.source_interface_descriptors /= Void then
				source := not coclass.source_interface_descriptors.is_empty
				from
					coclass.source_interface_descriptors.start
				until
					coclass.source_interface_descriptors.off
				loop
					remove_from_system_interfaces (coclass.source_interface_descriptors.item.implemented_interface)
					coclass.source_interface_descriptors.item.implemented_interface.set_source (True)
					generate_source_interface_features (coclass.source_interface_descriptors.item)
					coclass.source_interface_descriptors.forth
				end
			end

			finished := True
			clean_up
		end

	generate_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate interface features.
		require
			non_void_interface: an_interface /= Void
		deferred
		end

	generate_source_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate source interface features.
		require
			non_void_interface: an_interface /= Void
		deferred
		end

	remove_from_system_interfaces (an_implemented_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Does `an_implemented_interface' need to be removed from `system_descriptor.interfaces'?
		do
			if system_descriptor.interfaces.has (an_implemented_interface) then
				system_descriptor.interfaces.prune_all (an_implemented_interface)
			end
		ensure
			system_does_not_have: not system_descriptor.interfaces.has (an_implemented_interface)
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
end -- class WIZARD_COCLASS_INTERFACE_PROCESSOR


