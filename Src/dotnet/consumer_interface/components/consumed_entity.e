note
	description: ".NET entity (member or constructor) as seen by Eiffel"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONSUMED_ENTITY

inherit
	COMPARABLE

	DEBUG_OUTPUT
		undefine
			is_equal
		end

feature {NONE} -- Initialization

	make (en, dn: STRING; pub: BOOLEAN; a_type: CONSUMED_REFERENCED_TYPE)
			-- Initialize `Current' with `en', `pub' written in `a_type'.
		require
			eiffel_name_not_void: en /= Void
			valid_eiffel_name: not en.is_empty
			a_type_not_void: a_type /= Void
		do
			e := en
			n := dn
			set_is_public (pub)
			d := a_type
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			is_public_set: is_public = pub
			declared_type_set: declared_type = a_type
		end

feature -- Access

	eiffel_name: STRING
			-- Eiffel entity name
		do
			Result := e
		end

	dotnet_eiffel_name: STRING
			-- Eiffel entity name without overloading resolved.
		do
			Result := q
		ensure
			dotnet_eiffel_name_not_void: Result /= Void
		end

	dotnet_name: STRING
			-- Dotnet name of entity
		do
			Result := n
		ensure
			dotnet_name_not_void: Result /= Void
		end

	declared_type: CONSUMED_REFERENCED_TYPE
			-- Type in which feature is written/declared.
		do
			Result := d
		end

	arguments: detachable ARRAY [CONSUMED_ARGUMENT]
			-- Arguments if any.
		do
		ensure
			arguments_not_void: has_arguments implies Result /= Void
		end

	return_type: detachable CONSUMED_REFERENCED_TYPE
			-- Return type if any.
		do
		end

	is_frozen: BOOLEAN
			-- Is .NET definition frozen?
		do
		end

	is_public: BOOLEAN
			-- Is .NET entity public?
		do
		end

	is_literal: BOOLEAN
			-- Is .NET entity a static literal?
		do
		end

	is_init_only: BOOLEAN
			-- Is .NET field a constant?
		do
		end

	is_artificially_added: BOOLEAN
			-- Is Current artificially added?
		do
		end

	is_property_or_event: BOOLEAN
			-- Is entity an event or property related feature?
		do
		end

	is_new_slot: BOOLEAN
			-- Is entity marked with `newslot' flag in metadata?
		do
		end

	is_virtual: BOOLEAN
			-- Is entity marked with `virtual' flag in metadata?
		do
		end

	is_infix: BOOLEAN
			-- Is function an infix feature?
		do
		end

	is_prefix: BOOLEAN
			-- Is function a prefix feature?
		do
		end

	is_constructor: BOOLEAN
			-- Is constructor feature?
		do
		end

feature -- Status report

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string_general (dotnet_name)
			Result.append (" {")
			Result.append (eiffel_name)
			Result.append ("}")
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := eiffel_name < other.eiffel_name
		end

feature -- ConsumerWrapper functions

	is_method: BOOLEAN
			-- Is entity a .Net method?
		do
			Result := not is_property and then not is_field and then not is_event and then not is_constant
		end

	is_field: BOOLEAN
			-- Is entity a .Net field?
		do
		end

	is_property: BOOLEAN
			-- Is entity a .Net property?
		do
		end

	is_event: BOOLEAN
			-- Is entity a .Net event?
		do
		end

	is_constant: BOOLEAN
			-- Is entity a .Net method?
		do
			Result := is_literal or is_init_only
		end

	eiffelized_consumed_entities: ARRAYED_LIST [CONSUMED_ENTITY]
			-- List of Eiffel mapped Consumed Entities relative to `Current'.
			-- For CONSUMED_PROPERTY this would be `setter' and `getter'
			-- FIXME IEK Temporary solution until better design is implemented.
		do
			create Result.make (0)
			Result.extend (Current)
		end

feature -- Status report

	has_arguments: BOOLEAN
			-- Does current entity have argments?
		do
		end

	has_return_value: BOOLEAN
			-- Does current entity returns a value?
		do
		end

	is_static: BOOLEAN
			-- Is current entity static?
		do
		end

	is_attribute: BOOLEAN
			-- Is current entity an attribute?
		do
		end

	is_deferred: BOOLEAN
			-- Is current entity abstract?
		do
		end

	is_access_type: BOOLEAN
			-- Is current entity an 'Access' type?
		do
			if
				is_field or
				(eiffel_name.substring (1, 4).is_equal ("get_") and not has_arguments)
			then
				Result := True
			end
		end

	is_status_setting_type: BOOLEAN
			-- Is current entity a 'Status Setting' type?
		do
			if
				eiffel_name.substring (1, 4).is_equal ("set_") and then
				(has_arguments and then attached arguments as l_args and then l_args.count = 1)
			then
				Result := True
			end
		end

	is_query_type: BOOLEAN
			-- Is current entity a 'Status Setting' type?
		do
			if has_return_value and then not is_access_type then
				Result := True
			end
		end

	is_command_type: BOOLEAN
			-- Is current entity a 'Status Setting' type?
		do
			Result := not has_return_value and then not is_status_setting_type
		end

	is_event_type: BOOLEAN
			-- Is current entity a 'Status Setting' type?
		do
			Result := is_event
		end

	is_hidden_type: BOOLEAN
			-- Is current entity a 'Status Setting' type?
		do
			Result := not is_public
		end

feature -- Settings

	set_is_public (pub: like is_public)
			-- Set `is_public' with `pub'.
		do
		ensure
			is_public_set: is_public = pub
		end

feature {NONE} -- Access

	n: like dotnet_name
			-- Internal data for `dotnet_name'.

	q: like dotnet_eiffel_name
			-- Internal data for `dotnet_eiffel_name'.
		do
			Result := e
		end

	e: like eiffel_name
			-- Internal data for `eiffel_name'.

	d: like declared_type
			-- Internal data for `declared_type'.

invariant
	non_void_eiffel_name: eiffel_name /= Void
	valid_eiffel_name: not eiffel_name.is_empty
	declared_type_not_void: declared_type /= Void

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


end -- class CONSUMED_ENTITY
