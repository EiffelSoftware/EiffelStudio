indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_INTERFACE_CREATOR

inherit
	EI_MIDL_COMPONENT_CREATOR

create
	make

feature -- Access

	midl_interface: EI_MIDL_INTERFACE
			-- MIDL interface

feature -- Basic operations

	create_from_eiffel_class (eiffel_class: EI_CLASS) is
			-- Generate MIDL interface from 'eiffel_class'.
		local
			str_buffer: STRING
		do
			create midl_interface.make (eiffel_class.name)
			str_buffer := "Interface for "
			str_buffer.append (eiffel_class.description)

			midl_interface.set_description (str_buffer)

			if not eiffel_class.features.is_empty then
				produce_interface_feature (eiffel_class.features)
			end

			succeed := True
		end

feature {NONE} -- Implementation

	produce_interface_feature (l_features: HASH_TABLE[EI_FEATURE, STRING]) is
			-- Produce features for interface from 'l_features'.
		require
			non_void_input: l_features /= Void
			valid_input: not l_features.is_empty
			non_void_midl_interface: midl_interface /= Void
		local
			feature_creator: EI_MIDL_FEATURE_CREATOR
		do
			from
				l_features.start
			until
				l_features.after
			loop
				create feature_creator.make
				feature_creator.create_from_eiffel_feature (l_features.item_for_iteration)

				if feature_creator.succeed then
					midl_interface.add_feature (feature_creator.midl_feature)
					succeed := True
				end

				l_features.forth
			end
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
end -- class EI_MIDL_INTERFACE_CREATOR

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

