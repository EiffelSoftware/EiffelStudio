note
	description: ".NET type as needed by the Eiffel compiler"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_TYPE

create
	make

feature {NONE} -- Implementation

	make (dn, en: STRING;
			is_inter, is_abstract, is_sealed, is_value_type, is_enumerator: BOOLEAN;
			par: like parent;
			inter: like interfaces)
			-- Initialize instance.
		require
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_interfaces: inter /= Void
		do
			dotnet_name := dn
			eiffel_name := en
			if is_inter then
				internal_flags := internal_flags | Is_interface_mask
			end
			if is_abstract then
				internal_flags := internal_flags | Is_deferred_mask
			end
			if is_sealed then
				internal_flags := internal_flags | Is_frozen_mask
			end
			if is_value_type then
				internal_flags := internal_flags | Is_expanded_mask
			end
			if is_enumerator then
				internal_flags := internal_flags | Is_enum_mask
			end
			parent := par
			interfaces := inter
		ensure
			dotnet_name_set: dotnet_name = dn
			eiffel_name_set: eiffel_name = en
			is_interface_set: is_interface = is_inter
			is_deferred_set: is_deferred = is_abstract
			is_frozen_set: is_frozen = is_sealed
			is_expanded_set: is_expanded = is_value_type
			parent_set: parent = par
			interfaces_set: interfaces = inter
		end

feature -- Access

	dotnet_name: STRING
			-- Type full name

	parent: detachable CONSUMED_REFERENCED_TYPE
			-- Parent type

	eiffel_name: STRING
			-- Eiffel class name

	constructors: detachable ARRAYED_LIST [CONSUMED_CONSTRUCTOR]
			-- Class constructors

	fields: detachable ARRAYED_LIST [CONSUMED_FIELD]
			-- Class fields

	interfaces: ARRAYED_LIST [CONSUMED_REFERENCED_TYPE]
			-- Implemented interfaces

	properties: detachable ARRAYED_LIST [CONSUMED_PROPERTY]
			-- Properties

	events: detachable ARRAYED_LIST [CONSUMED_EVENT]
			-- Events

	procedures: detachable ARRAYED_LIST [CONSUMED_PROCEDURE]
			-- All procedures in type.
			-- ie: immediate and inherited procedures, but also procedures associated
			-- to a property or an event.
		local
			l_estimated_count: INTEGER
			l_prop: CONSUMED_PROPERTY
		do
			if
				(not attached properties as l_props or else l_props.is_empty) and
				(not attached events as l_events or else l_events.is_empty)
			then
				Result := internal_procedures
			else
				if attached properties as l_props then
					l_estimated_count := l_props.count
				end
				if attached events as l_events then
						-- 3 because per event there are 3 routines.
					l_estimated_count := l_estimated_count + 3 * l_events.count
				end
				if attached internal_procedures as l_procs then
					l_estimated_count := l_estimated_count + l_procs.count
				end
				create Result.make (l_estimated_count)

				if attached internal_procedures as l_procs then
					from
						l_procs.start
					until
						l_procs.after
					loop
						Result.extend (l_procs.item)
						l_procs.forth
					end
				end

				if attached properties as l_props and then not l_props.is_empty then
					from
						l_props.start
					until
						l_props.after
					loop
						l_prop := l_props.item
						if attached l_prop.setter as l_setter then
							Result.extend (l_setter)
						end
						l_props.forth
					end
				end

				if attached events as l_events and then not l_events.is_empty then
					from
						l_events.start
					until
						l_events.after
					loop
						Result.append (l_events.item.eiffelized_consumed_procedures)
						l_events.forth
					end
				end
			end
		end

	functions: detachable ARRAYED_LIST [CONSUMED_FUNCTION]
			-- All functions in type.
			-- ie: immediate and inherited functions, but also functions associated
			-- to a property or an event.
		local
			l_prop: CONSUMED_PROPERTY
		do
			if not attached properties as l_properties or else l_properties.is_empty then
				Result := internal_functions
			else
				if attached internal_functions as l_funcs then
					create Result.make (l_funcs.count + l_properties.count)
					from
						l_funcs.start
					until
						l_funcs.after
					loop
						Result.extend (l_funcs.item)
						l_funcs.forth
					end
				else
					create Result.make (l_properties.count)
				end

				from
					l_properties.start
				until
					l_properties.after
				loop
					l_prop := l_properties.item
					if attached l_prop.getter as l_getter then
						Result.extend (l_getter)
					end
					l_properties.forth
				end
			end
		end


feature {NONE} -- Internal vales

	internal_procedures: detachable ARRAYED_LIST [CONSUMED_PROCEDURE]
			-- Class procedures

	internal_functions: detachable ARRAYED_LIST [CONSUMED_FUNCTION]
			-- Class functions

feature -- Status Setting

	is_interface: BOOLEAN
			-- Is .NET type an interface?
		do
			Result := internal_flags & Is_interface_mask = Is_interface_mask
		end

	is_deferred: BOOLEAN
			-- Is .NET type abstract?
		do
			Result := internal_flags & Is_deferred_mask = Is_deferred_mask
		end

	is_enum: BOOLEAN
			-- Is .NET type an enum?
		do
			Result := internal_flags & Is_enum_mask = Is_enum_mask
		end

	is_frozen: BOOLEAN
			-- Is .NET type sealed?
		do
			Result := internal_flags & Is_frozen_mask = Is_frozen_mask
		end

	is_expanded: BOOLEAN
			-- Is .NET type a value type?
		do
			Result := internal_flags & Is_expanded_mask = Is_expanded_mask
		end

feature -- Element settings

	set_fields (fi: like fields)
			-- set `fields' with `fi'.
		require
			non_void_fields: fi /= Void
		do
			fields := fi
		ensure
			fields_set: fields = fi
		end

	set_procedures (meth: like procedures)
			-- set `procedures' with `meth'.
		require
			non_void_procedures: meth /= Void
		do
			internal_procedures := meth
		ensure
			internal_procedures_set: internal_procedures = meth
		end

	set_functions (func: like functions)
			-- set `functions' with `meth'.
		require
			non_void_functions: func /= Void
		do
			internal_functions := func
		ensure
			internal_functions_set: internal_functions = func
		end

	set_properties (prop: like properties)
			-- Set `properties' with `prop'.
		require
			non_void_properties: prop /= Void
		do
			properties := prop
		ensure
			properties_set: properties = prop
		end

	set_events (ev: like events)
			-- Set `events' with `ev'.
		require
			non_void_events: ev /= Void
		do
			events := ev
		ensure
			events_set: events = ev
		end

	set_constructors (cons: like constructors)
			-- set `constructors' with `cons'.
		require
			non_void_constructors: cons /= Void
		do
			constructors := cons
		ensure
			constructors_set: constructors = cons
		end

feature -- Functions used for easy browsing of data from ConsumerWrapper.

	associated_reference_type: CONSUMED_REFERENCED_TYPE
			-- Reference type of `Current'.
		do
			if attached internal_associated_reference_type as l_ref_type then
				Result := l_ref_type
			else
					-- FIXME IEK The assembly id of 1 has to be checked
				create Result.make (dotnet_name, 1)
				internal_associated_reference_type := Result
			end
		end

	consumed_constructors: ARRAYED_LIST [CONSUMED_ENTITY]
			-- All constructors implemented by type/
		require
			constructors_not_void: constructors /= Void
		do
			create Result.make (0)
			if attached constructors as l_constructors then
				Result.fill (l_constructors)
			end
		end

	entities: ARRAYED_LIST [CONSUMED_ENTITY]
			-- All fields, procedures, functions, properties and events immediately
			-- implemented by type.
		do
			Result := consumed_type_entities (True)
			Result.compare_objects
		ensure
			result_not_void: Result /= Void
		end

	inherited_entities: ARRAYED_LIST [CONSUMED_ENTITY]
			-- All fields, procedures, functions, properties and events inherited by type.
		do
			Result := consumed_type_entities (False)
		end

	flat_entities: ARRAYED_LIST [CONSUMED_ENTITY]
			-- All fields, procedures, functions, properties and events
			-- implemented/inherited by type.
		do
			Result := consumed_type_entities (True)
			Result.append (consumed_type_entities (False))
		end

	ancestors: ARRAYED_LIST [CONSUMED_REFERENCED_TYPE]
			-- All interfaces and base classes implemented/inherited by `Current'.
		do
			create Result.make (0)
			if interfaces /= Void then
				Result.fill (interfaces)
			end
			if attached parent as l_parent then
				Result.extend (l_parent)
			end
		end

feature {NONE} -- Implementation

	internal_associated_reference_type: detachable CONSUMED_REFERENCED_TYPE
		-- Reference type of `Current'.

feature {NONE} -- Internal

	consumed_type_entities (a_immediate: BOOLEAN): ARRAYED_LIST [CONSUMED_ENTITY]
			-- All fields, procedures, functions, properties and events implemented by type.
			-- If `a_immediate' then return immediate features, else return inherited.
		local
			nb: INTEGER
		do
			if attached fields as l_fields then
				nb := l_fields.count
			end
			if attached internal_functions as l_funcs then
				nb := nb + l_funcs.count
			end
			if attached internal_procedures as l_procs then
				nb := nb + l_procs.count
			end
			if attached events as l_events then
				nb := nb + l_events.count
			end
			if attached properties as l_props then
				nb := nb + l_props.count
			end

			create Result.make (nb)
			if attached fields as l_fields then
				consumed_a_type_entities (l_fields, a_immediate, Result)
			end
			if attached internal_functions as l_funcs then
				consumed_a_type_entities (l_funcs, a_immediate, Result)
			end
			if attached internal_procedures as l_procs then
				consumed_a_type_entities (l_procs, a_immediate, Result)
			end
			if attached events as l_events then
				consumed_a_type_entities (l_events, a_immediate, Result)
			end
			if attached properties as l_props then
				consumed_a_type_entities (l_props, a_immediate, Result)
			end
		ensure
			result_not_void: Result /= Void
		end

	consumed_a_type_entities (
			a_features: ARRAYED_LIST [CONSUMED_ENTITY]; a_immediate: BOOLEAN; a_result: like consumed_type_entities)

			-- All fields, procedures, functions, properties and events implemented by type.
			-- If `a_immediate' then return immediate features, else return inherited.
		require
			a_features_not_void: a_features /= Void
			a_result_not_void: a_result /= Void
		local
			l_entity: CONSUMED_ENTITY
			l_ref: like associated_reference_type
		do
			from
				a_features.start
				l_ref := associated_reference_type
			until
				a_features.after
			loop
				l_entity := a_features.item
				if
					l_entity /= Void and then
					(l_entity.declared_type.same_as (l_ref) = a_immediate)
				then
					a_result.extend (l_entity)
				end
				a_features.forth
			end
		end

	internal_flags: INTEGER
			-- Store status of current type.

	is_deferred_mask: INTEGER = 1
	is_enum_mask: INTEGER = 2
	is_expanded_mask: INTEGER = 4
	is_frozen_mask: INTEGER = 8
	is_interface_mask: INTEGER = 16
			-- Different mask.

invariant
	non_void_eiffel_name: eiffel_name /= Void
	valid_eiffel_name: not eiffel_name.is_empty
	non_void_dotnet_name: dotnet_name /= Void
	valid_dotnet_name: not dotnet_name.is_empty

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


end -- class CONSUMED_TYPE
