indexing
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
			inter: like interfaces) is
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
	
	parent: CONSUMED_REFERENCED_TYPE
			-- Parent type
	
	eiffel_name: STRING
			-- Eiffel class name

	constructors: ARRAYED_LIST [CONSUMED_CONSTRUCTOR]
			-- Class constructors

	fields: ARRAYED_LIST [CONSUMED_FIELD]
			-- Class fields

	interfaces: ARRAYED_LIST [CONSUMED_REFERENCED_TYPE]
			-- Implemented interfaces
	
	properties: ARRAYED_LIST [CONSUMED_PROPERTY]
			-- Properties
	
	events: ARRAYED_LIST [CONSUMED_EVENT]
			-- Events

	procedures: ARRAYED_LIST [CONSUMED_PROCEDURE] is
			-- All procedures in type. 
			-- ie: immediate and inherited procedures, but also procedures associated
			-- to a property or an event.
		local
			l_estimated_count: INTEGER
			l_event: CONSUMED_EVENT
			l_prop: CONSUMED_PROPERTY
		do
			if
				(properties = Void or else properties.is_empty) and
				(events = Void or else events.is_empty)
			then
				Result := internal_procedures
			else
				if properties /= Void then
					l_estimated_count := properties.count
				end
				if events /= Void then
						-- 3 because per event there are 3 routines.
					l_estimated_count := l_estimated_count + 3 * events.count
				end
				if internal_procedures /= Void then
					l_estimated_count := l_estimated_count + internal_procedures.count
				end
				create Result.make (l_estimated_count)

				if internal_procedures /= Void then
					from
						internal_procedures.start
					until
						internal_procedures.after
					loop
						Result.extend (internal_procedures.item)
						internal_procedures.forth
					end
				end		
				
				if properties /= Void and then not properties.is_empty then
					from
						properties.start
					until
						properties.after
					loop
						l_prop := properties.item
						if l_prop.setter /= Void then
							Result.extend (l_prop.setter)
						end
						properties.forth
					end
				end
				
				if events /= Void and then not events.is_empty then
					from
						events.start
					until
						events.after
					loop
						l_event := events.item
						if l_event.raiser /= Void then
							Result.extend (l_event.raiser)
						end
						if l_event.remover /= Void then
							Result.extend (l_event.remover)
						end
						if l_event.adder /= Void then
							Result.extend (l_event.adder)
						end
						events.forth
					end					
				end
			end
		end

	functions: ARRAYED_LIST [CONSUMED_FUNCTION] is
			-- All functions in type. 
			-- ie: immediate and inherited functions, but also functions associated
			-- to a property or an event.
		local
			l_prop: CONSUMED_PROPERTY
		do
			if properties = Void or else properties.is_empty then
				Result := internal_functions
			else
				if internal_functions /= Void then
					create Result.make (internal_functions.count + properties.count)
					from
						internal_functions.start
					until
						internal_functions.after
					loop
						Result.extend (internal_functions.item)
						internal_functions.forth
					end
				else
					create Result.make (properties.count)
				end

				from
					properties.start
				until
					properties.after
				loop
					l_prop := properties.item
					if l_prop.getter /= Void then
						Result.extend (l_prop.getter)
					end
					properties.forth
				end
			end
		end


feature {NONE} -- Internal vales

	internal_procedures: ARRAYED_LIST [CONSUMED_PROCEDURE]
			-- Class procedures

	internal_functions: ARRAYED_LIST [CONSUMED_FUNCTION]
			-- Class functions

feature -- Status Setting

	is_interface: BOOLEAN is
			-- Is .NET type an interface?
		do
			Result := internal_flags & Is_interface_mask = Is_interface_mask
		end

	is_deferred: BOOLEAN is
			-- Is .NET type abstract?
		do
			Result := internal_flags & Is_deferred_mask = Is_deferred_mask
		end
	
	is_enum: BOOLEAN is
			-- Is .NET type an enum?
		do
			Result := internal_flags & Is_enum_mask = Is_enum_mask
		end
	
	is_frozen: BOOLEAN is
			-- Is .NET type sealed?
		do
			Result := internal_flags & Is_frozen_mask = Is_frozen_mask
		end

	is_expanded: BOOLEAN is
			-- Is .NET type a value type?
		do
			Result := internal_flags & Is_expanded_mask = Is_expanded_mask
		end

feature {TYPE_CONSUMER} -- Element settings

	set_fields (fi: like fields) is
			-- set `fields' with `fi'.
		require
			non_void_fields: fi /= Void
		do
			fields := fi
		ensure
			fields_set: fields = fi
		end
	
	set_procedures (meth: like procedures) is
			-- set `procedures' with `meth'.
		require
			non_void_procedures: meth /= Void
		do
			internal_procedures := meth
		ensure
			internal_procedures_set: internal_procedures = meth
		end
	
	set_functions (func: like functions) is
			-- set `functions' with `meth'.
		require
			non_void_functions: func /= Void
		do
			internal_functions := func
		ensure
			internal_functions_set: internal_functions = func
		end

	set_properties (prop: like properties) is
			-- Set `properties' with `prop'.
		require
			non_void_properties: prop /= Void
		do
			properties := prop
		ensure
			properties_set: properties = prop
		end
	
	set_events (ev: like events) is
			-- Set `events' with `ev'.
		require
			non_void_events: ev /= Void
		do
			events := ev
		ensure
			events_set: events = ev
		end
		
feature {TYPE_CONSUMER, ASSEMBLY_CONSUMER} -- Element settings
	
	set_constructors (cons: like constructors) is
			-- set `constructors' with `cons'.
		require
			non_void_constructors: cons /= Void
		do
			constructors := cons
		ensure
			constructors_set: constructors = cons
		end

feature -- Functions used for easy browsing of data from ConsumerWrapper.

	associated_reference_type: CONSUMED_REFERENCED_TYPE is
			-- Reference type of `Current'.
		do
			if internal_associated_reference_type = Void then
				create internal_associated_reference_type.make (dotnet_name, 1)
				-- FIXME IEK The assembly id of 1 has to be checked
			end
			Result := internal_associated_reference_type
		end

	consumed_constructors: ARRAYED_LIST [CONSUMED_ENTITY] is
			-- All constructors implemented by type/
		require
			constructors_not_void: constructors /= Void
		do
			create Result.make (0)
			if constructors /= Void then
				Result.fill (constructors)
			end
		end

	entities: ARRAYED_LIST [CONSUMED_ENTITY] is
			-- All fields, procedures, functions, properties and events immediately
			-- implemented by type.
		do
			Result := consumed_type_entities (True)
			Result.compare_objects
		ensure
			result_not_void: Result /= Void
		end

	inherited_entities: ARRAYED_LIST [CONSUMED_ENTITY] is
			-- All fields, procedures, functions, properties and events inherited by type.
		do
			Result := consumed_type_entities (False)
		end

	flat_entities: ARRAYED_LIST [CONSUMED_ENTITY] is
			-- All fields, procedures, functions, properties and events
			-- implemented/inherited by type.
		do
			Result := consumed_type_entities (True)
			Result.append (consumed_type_entities (False))
		end

	ancestors: ARRAYED_LIST [CONSUMED_REFERENCED_TYPE] is
			-- All interfaces and base classes implemented/inherited by `Current'.
		do
			create Result.make (0)
			if interfaces /= Void then
				Result.fill (interfaces)
			end
			if parent /= Void then
				Result.extend (parent)
			end
		end

feature {NONE} -- Implementation

	internal_associated_reference_type: CONSUMED_REFERENCED_TYPE
		-- Reference type of `Current'.

feature {NONE} -- Internal

	consumed_type_entities (a_immediate: BOOLEAN): ARRAYED_LIST [CONSUMED_ENTITY] is
			-- All fields, procedures, functions, properties and events implemented by type.
			-- If `a_immediate' then return immediate features, else return inherited.
		local
			nb: INTEGER
		do
			if fields /= Void then
				nb := fields.count
			end
			if internal_functions /= Void then
				nb := nb + internal_functions.count
			end
			if internal_procedures /= Void then
				nb := nb + internal_procedures.count
			end
			if events /= Void then
				nb := nb + events.count
			end
			if properties /= Void then
				nb := nb + properties.count
			end
			
			create Result.make (nb)
			if fields /= Void then
				consumed_a_type_entities (fields, a_immediate, Result)
			end
			if internal_functions /= Void then
				consumed_a_type_entities (internal_functions, a_immediate, Result)
			end
			if internal_procedures /= Void then
				consumed_a_type_entities (internal_procedures, a_immediate, Result)
			end
			if events /= Void then
				consumed_a_type_entities (events, a_immediate, Result)
			end
			if properties /= Void then
				consumed_a_type_entities (properties, a_immediate, Result)
			end
		ensure
			result_not_void: Result /= Void
		end

	consumed_a_type_entities (
			a_features: ARRAYED_LIST [CONSUMED_ENTITY]; a_immediate: BOOLEAN; a_result: like consumed_type_entities)
		is
			-- All fields, procedures, functions, properties and events implemented by type.
			-- If `a_immediate' then return immediate features, else return inherited.
		require
			a_features_not_void: a_features /= Void
			a_result_not_void: a_result /= Void
		local
			l_entity: CONSUMED_ENTITY
		do
			from 
				a_features.start
			until
				a_features.after
			loop
				l_entity := a_features.item
				if
					l_entity /= Void and then
					(l_entity.declared_type.is_equal (associated_reference_type) = a_immediate)
				then
					a_result.extend (l_entity)
				end
				a_features.forth
			end
		end
 			
	internal_flags: INTEGER
			-- Store status of current type.

	is_deferred_mask: INTEGER is 1
	is_enum_mask: INTEGER is 2
	is_expanded_mask: INTEGER is 4
	is_frozen_mask: INTEGER is 8
	is_interface_mask: INTEGER is 16
			-- Different mask.

invariant
	non_void_eiffel_name: eiffel_name /= Void
	valid_eiffel_name: not eiffel_name.is_empty
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


end -- class CONSUMED_TYPE
