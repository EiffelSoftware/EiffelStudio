indexing
	description: ".NET type member as seen by Eiffel"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONSUMED_MEMBER

inherit
	CONSUMED_ENTITY
		rename
			make as entity_make
		redefine
			is_static, is_deferred, is_public, is_artificially_added,
			is_new_slot, is_property_or_event, is_virtual, is_frozen,
			set_is_public
		end

feature {NONE} -- Initialization

	make (en, dn: STRING; pub: BOOLEAN; a_type: CONSUMED_REFERENCED_TYPE) is
			-- Initialize with `en', `dn' and `pub'.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			a_type_not_void: a_type /= Void
		do
			entity_make (en, pub, a_type)
			n := dn
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			is_public_set: is_public = pub
			declared_type_set: declared_type = a_type
		end

feature -- Status report

	is_public: BOOLEAN is
			-- Is current member public?
		do
			Result := f & {FEATURE_ATTRIBUTE}.Is_public = {FEATURE_ATTRIBUTE}.Is_public
		end

	is_frozen: BOOLEAN is
			-- Is feature frozen?
		do
			Result := f & {FEATURE_ATTRIBUTE}.Is_frozen = {FEATURE_ATTRIBUTE}.Is_frozen
		end

	is_static: BOOLEAN is
			-- Is .NET member static?
		do
			Result := f & {FEATURE_ATTRIBUTE}.Is_static ={FEATURE_ATTRIBUTE}.Is_static
		end

	is_deferred: BOOLEAN is
			-- Is feature deferred?
		do
			Result := f & {FEATURE_ATTRIBUTE}.Is_deferred = {FEATURE_ATTRIBUTE}.Is_deferred
		end

	is_artificially_added: BOOLEAN is
			-- Is feature artificially added?
		do
			Result := f & {FEATURE_ATTRIBUTE}.Is_artificially_added =
				{FEATURE_ATTRIBUTE}.Is_artificially_added
		end
	
	is_property_or_event: BOOLEAN is
			-- Is feature property or event related?
		do
			Result := f & {FEATURE_ATTRIBUTE}.Is_property_or_event =
				{FEATURE_ATTRIBUTE}.Is_property_or_event
		end
		
	is_new_slot: BOOLEAN is
			-- Is current marked with `new_slot' flag?
		do
			Result := f & {FEATURE_ATTRIBUTE}.Is_newslot = {FEATURE_ATTRIBUTE}.Is_newslot
		end

	is_virtual: BOOLEAN is
			-- Is feature virtual?
		do
			Result := f & {FEATURE_ATTRIBUTE}.Is_virtual = {FEATURE_ATTRIBUTE}.Is_virtual
		end

	is_attribute_setter: BOOLEAN is
			-- Is feature an setter of an attribute of current class?
		do
			Result := f & {FEATURE_ATTRIBUTE}.Is_attribute_setter = 
				{FEATURE_ATTRIBUTE}.Is_attribute_setter
		end

feature -- Settings

	set_is_public (pub: like is_public) is
			-- Set `is_public' with `pub'.
		do
			if pub then
				f := f | {FEATURE_ATTRIBUTE}.Is_public
			else
				f := f & {FEATURE_ATTRIBUTE}.Is_public.bit_not
			end
		end

	set_is_artificially_added (val: like is_artificially_added) is
			-- Set `is_artificially_added' with `val'.
		do
			if val then
				f := f | {FEATURE_ATTRIBUTE}.Is_artificially_added
			else
				f := f & {FEATURE_ATTRIBUTE}.Is_artificially_added.bit_not
			end
		ensure
			is_artificially_added_set: is_artificially_added = val
		end
		
feature {CONSUMED_MEMBER} -- Internal

	f: INTEGER
			-- Store status of current feature.

invariant
	non_void_dotnet_name: dotnet_name /= Void
	valid_dotnet_name: not dotnet_name.is_empty

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class CONSUMED_MEMBER
