indexing
	description: "Description of pointer data type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_POINTED_DATA_TYPE_DESCRIPTOR

inherit
	WIZARD_DATA_TYPE_DESCRIPTOR
		redefine
			visitor
		end

	ECOM_TYPE_KIND
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_creator: WIZARD_POINTED_DATA_TYPE_CREATOR) is
			-- Initialize
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
		ensure
			non_void_pointed_descriptor: pointed_data_type_descriptor /= Void
		end

feature -- Access
	
	pointed_data_type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Description of array element type

	visitor: WIZARD_DATA_TYPE_VISITOR is
			-- Data type visitor.
		local
			type_descriptor: WIZARD_TYPE_DESCRIPTOR
			user_defined: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR
			pointed: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			if instance_visitor /= Void then
				Result := instance_visitor
			elseif pointed_data_type_descriptor.pointing_visitor /= Void then
				Result := pointed_data_type_descriptor.pointing_visitor
				instance_visitor := Result
			else
				user_defined ?= pointed_data_type_descriptor
				pointed ?= pointed_data_type_descriptor
				if user_defined /= Void then
					type_descriptor := user_defined.library_descriptor.descriptors.item 
							(user_defined.type_descriptor_index)
					if type_descriptor.pointed_data_type_visitor /= Void then
						Result := type_descriptor.pointed_data_type_visitor
						instance_visitor := Result
						pointed_data_type_descriptor.set_pointing_visitor (Result)
					else
						create Result
						Result.visit (Current)
						instance_visitor := Result
						pointed_data_type_descriptor.set_pointing_visitor (Result)
						type_descriptor.set_pointed_data_type_visitor (Result)
					end
				elseif pointed /= Void then
					user_defined ?= pointed.pointed_data_type_descriptor
					if user_defined /= Void then
						type_descriptor := user_defined.library_descriptor.descriptors.item 
							(user_defined.type_descriptor_index)
						if type_descriptor.pointed_pointed_data_type_visitor /= Void then
							Result := type_descriptor.pointed_pointed_data_type_visitor
							instance_visitor := Result
							pointed_data_type_descriptor.set_pointing_visitor (Result)
						else
							create Result
							Result.visit (Current)
							instance_visitor := Result
							pointed_data_type_descriptor.set_pointing_visitor (Result)
							type_descriptor.set_pointed_pointed_data_type_visitor (Result)
						end
					end
				end
				if Result = Void then
					create Result
					Result.visit (Current)
					instance_visitor := Result
					pointed_data_type_descriptor.set_pointing_visitor (Result)
				end
			end
		end

	interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR is
			-- Interface descriptor.
		require
--			interface_type: visitor.is_interface_pointer or visitor.is_interface_pointer_pointer or
--						visitor.is_coclass_pointer or visitor.is_coclass_pointer_pointer
--			non_unknown: visitor.c_type.substring_index (iunknown_type, 1) = 0
--			non_dispatch: visitor.c_type.substring_index (idispatch_type, 1) = 0
		local
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			user_defined: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR
			alias_descriptor: WIZARD_ALIAS_DESCRIPTOR
			tmp_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR
			tmp_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
			a_type_descriptor: WIZARD_TYPE_DESCRIPTOR
			a_index: INTEGER
		do
			user_defined ?= pointed_data_type_descriptor
			if user_defined = Void then
				pointed_descriptor ?= pointed_data_type_descriptor
				check
					non_void_pointed_descriptor: pointed_descriptor /= Void
				end
				user_defined ?= pointed_descriptor.pointed_data_type_descriptor
			end
			check
				non_void_user_defined: user_defined /= Void
			end
			a_index := user_defined.type_descriptor_index
			a_type_descriptor := user_defined.library_descriptor.descriptors.item (a_index)
			from
				alias_descriptor ?= a_type_descriptor
			until
				alias_descriptor = Void
			loop
				user_defined ?= alias_descriptor.type_descriptor
				if (user_defined /= Void) then
					a_index := user_defined.type_descriptor_index
					a_type_descriptor := user_defined.library_descriptor.descriptors.item (a_index)
					alias_descriptor ?= a_type_descriptor
				else
					alias_descriptor := Void
				end
			end
			tmp_interface_descriptor ?= a_type_descriptor
			if tmp_interface_descriptor = Void then
				tmp_coclass_descriptor ?= a_type_descriptor
				if tmp_coclass_descriptor /= Void then
					tmp_interface_descriptor := tmp_coclass_descriptor.default_interface_descriptor
				end
			end
			Result := tmp_interface_descriptor
		ensure
			non_void_interface_descriptor: Result /= Void
		end

feature -- Status report

	is_equal_data_type (other: WIZARD_DATA_TYPE_DESCRIPTOR): BOOLEAN is
			-- Is `other' describes same data type?
		local
			other_pointed: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			other_pointed ?= other
			if other_pointed /= Void then
				Result := pointed_data_type_descriptor.is_equal_data_type (other_pointed.pointed_data_type_descriptor)
			end
		end

feature -- Basic operations

	set_pointed_descriptor (a_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR) is
			-- Set `pointed_data_type_descriptor'
		require
			valid_descriptor: a_descriptor /= Void
		do
			pointed_data_type_descriptor := a_descriptor
		ensure
			pointed_set: pointed_data_type_descriptor = a_descriptor
		end

feature -- Visitor

	visit (a_visitor: WIZARD_DATA_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_pointed_data_type (Current)
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
end -- class WIZARD_POINTED_DATA_TYPE_DESCRIPTOR

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

