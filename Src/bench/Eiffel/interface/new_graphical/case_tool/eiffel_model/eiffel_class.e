indexing
	description: "Objects that is a model for an Eiffel class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EM_CLASS

inherit
	EG_NODE
		redefine
			default_create
		end
		
create
	make_with_name,
	make_expanded_with_name
		
feature {NONE} -- Implementation

	default_create is
			-- Create an EIFFEL_CLASS.
		do
			Precursor {EG_NODE}
			create properties_changed_actions
			create generics_changed_actions
			create root_class_changed_actions
		end

	make_with_name (a_name: like name) is
			-- Create an EIFFEL_CLASS using `a_name' as `name'.
		require
			a_name_not_void: a_name /= Void
		do
			default_create
			name := a_name
		ensure
			set: name = a_name
		end
		
	make_expanded_with_name (a_name: like name) is
			-- Create an expanded EIFFEL_CLASS using `a_name' as `name'.
		require
			a_name_not_void: a_name /= Void
		do
			make_with_name (a_name)
			is_expanded := True
		ensure
			set: name = a_name
			is_expanded: is_expanded
		end

feature -- Status report.
	
	is_expanded: BOOLEAN
			-- Is `Current' expanded?
			
	is_deferred: BOOLEAN
			-- Is `Current' deferred?
			
	is_effective: BOOLEAN
			-- Is `Current' effective?
			
	is_persistent: BOOLEAN
			-- Is `Current' persistend?
			
	is_interfaced: BOOLEAN
			-- Is `Current' interfaced?
			
	is_root_class: BOOLEAN
			-- Is `Current' a root class?
			
	is_reused: BOOLEAN
			-- Is `Current' a reusable component?
			
	is_compiled: BOOLEAN
			-- Is `Current' a compiled class?

feature -- Access

	properties_changed_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Called when `is_expanded', `is_deferred', `is_effective', `is_persistent', `is_reused', `is_compiled' or `is_interfaced' change.

	generics: STRING
			-- Generic parameters of `Current'.
			
	generics_changed_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Called when `generics' is changed.
			
	root_class_changed_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Called when `is_root_class' changed.

feature -- Status settings.

	set_is_root_class (b: BOOLEAN) is
			-- Set `is_root_class' to `b'.
		do
			if b /= is_root_class then
				is_root_class := b
				root_class_changed_actions.call (Void)
			end
		ensure
			set: is_root_class = b
		end

	set_is_expanded (b: BOOLEAN) is
			-- Set `is_expanded' to `b'.
		local
			e_cs_link: EM_CLIENT_SUPPLIER_LINK
		do
			if b /= is_expanded then
				is_expanded := b
				from
					links.start
				until
					links.after
				loop
					e_cs_link ?= links.item
					if e_cs_link /= Void then
						if e_cs_link.supplier = Current then
							e_cs_link.set_is_aggregated (b)
						end
					end
					links.forth
				end
				properties_changed_actions.call (Void)
			end
		ensure
			set: is_expanded = b
		end
		
	set_is_deferred (b: BOOLEAN) is
			-- Set `is_deferred' to `b'.
		do
			if is_deferred /= b then
				is_deferred := b
				properties_changed_actions.call (Void)
			end
		ensure
			set: is_deferred = b
		end
		
	set_is_effective (b: BOOLEAN) is
			-- Set `is_effective' to `b'.
		do
			if is_deferred /= b then
				is_effective := b
				properties_changed_actions.call (Void)
			end
		ensure
			set: is_effective = b
		end
		
	set_is_persistent (b: BOOLEAN) is
			-- Set `is_persistent' to `b'.
		do
			if is_persistent /= b then
				is_persistent := b
				properties_changed_actions.call (Void)
			end
		ensure
			set: is_persistent = b
		end
		
	set_is_interfaced (b: BOOLEAN) is
			-- Set `is_effective' to `b'.
		do
			if is_interfaced /= b then
				is_interfaced := b
				properties_changed_actions.call (Void)
			end
		ensure
			set: is_interfaced = b
		end
		
	set_is_reused (b: BOOLEAN) is
			-- Set `is_reused' to `b'.
		do
			if is_reused /= b then
				is_reused := b
				properties_changed_actions.call (Void)
			end
		ensure
			set: is_reused = b
		end
	
feature -- Element change

	set_generics (a_generic: STRING) is
			-- Set `generics' to `a_generic'.
		do
			if (generics /= Void and a_generic = Void) or else
			   (generics = Void and a_generic /= Void) or else
			   (generics /= Void and then a_generic /= Void and then not generics.is_equal (a_generic)) then
				generics := a_generic
				generics_changed_actions.call (Void)
			end
		ensure
			set: (generics = Void implies a_generic = Void) and (generics /= Void implies (a_generic /= Void and then generics.is_equal (a_generic)))
		end	
		
invariant
	generics_changed_actions_not_void: generics_changed_actions /= Void
	properties_changed_actions_not_void: properties_changed_actions /= Void
	root_class_changed_actions_not_void: root_class_changed_actions /= Void

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

end -- class EM_CLASS
