indexing
	description: ".NET type as needed by the Eiffel compiler"
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

	constructors: ARRAY [CONSUMED_CONSTRUCTOR]
			-- Class constructors

	fields: ARRAY [CONSUMED_FIELD]
			-- Class fields

	interfaces: ARRAY [CONSUMED_REFERENCED_TYPE]
			-- Implemented interfaces
	
	properties: ARRAY [CONSUMED_PROPERTY]
			-- Properties
	
	events: ARRAY [CONSUMED_EVENT]
			-- Events

	procedures: ARRAY [CONSUMED_PROCEDURE] is
			-- All procedures in type. 
			-- ie: immediate and inherited procedures, but also procedures associated
			-- to a property or an event.
		local
			i, j, nb, nb_prop_event_proc: INTEGER
			event_or_set_procedures: ARRAY [CONSUMED_PROCEDURE]
			l_event: CONSUMED_EVENT
			l_prop: CONSUMED_PROPERTY
		do
			if
				(properties = Void or else properties.is_empty) and
				(events = Void or else events.is_empty)
			then
				Result := internal_procedures
			else
				create event_or_set_procedures.make (1, properties.count + events.count * 3)
				if properties /= Void and then not properties.is_empty then
					from
						i := properties.lower
						nb := properties.upper
					until
						i > nb
					loop
						l_prop := properties.item (i)
						if l_prop.setter /= Void then
							nb_prop_event_proc := nb_prop_event_proc + 1
							event_or_set_procedures.put (l_prop.setter, nb_prop_event_proc)
						end
						i := i + 1
					end
					
				end
				
				if events /= Void and then not events.is_empty then
					from
						i := events.lower
						nb := events.upper
					until
						i > nb
					loop
						l_event := events.item (i)
						if l_event.raiser /= Void then
							nb_prop_event_proc := nb_prop_event_proc + 1
							event_or_set_procedures.put (l_event.raiser, nb_prop_event_proc)
						end
						if l_event.remover /= Void then
							nb_prop_event_proc := nb_prop_event_proc + 1
							event_or_set_procedures.put (l_event.remover, nb_prop_event_proc)
						end
						if l_event.adder /= Void then
							nb_prop_event_proc := nb_prop_event_proc + 1
							event_or_set_procedures.put (l_event.adder, nb_prop_event_proc)
						end
						i := i + 1
					end					
				end
				
				create Result.make (1, internal_procedures.count + nb_prop_event_proc)
				from
					i := internal_procedures.lower
					nb := internal_procedures.upper
				until
					i > nb
				loop
					Result.put (internal_procedures.item (i), i)
					i := i + 1
				end
				from
					j := i
					i := event_or_set_procedures.lower
					nb := Result.upper
				until
					j > nb
				loop
					Result.put (event_or_set_procedures.item (i), j)
					i := i + 1
					j := j + 1
				end
			end
		ensure
			non_void_result: Result /= Void
		end

	functions: ARRAY [CONSUMED_FUNCTION] is
			-- All functions in type. 
			-- ie: immediate and inherited functions, but also functions associated
			-- to a property or an event.
		local
			i, j, nb, nb_getter: INTEGER
			get_functions: ARRAY [CONSUMED_FUNCTION]
			l_prop: CONSUMED_PROPERTY
		do
			if properties = Void or else properties.is_empty then
				Result := internal_functions
			else
				create get_functions.make (1, properties.count)
				from
					i := properties.lower
					nb := properties.upper
				until
					i > nb
				loop
					l_prop := properties.item (i)
					if l_prop.getter /= Void then
						nb_getter := nb_getter + 1
						get_functions.put (l_prop.getter, nb_getter)
					end
					i := i + 1
				end
				
				create Result.make (1, internal_functions.count + nb_getter)
				from
					i := internal_functions.lower
					nb := internal_functions.upper
				until
					i > nb
				loop
					Result.put (internal_functions.item (i), i)
					i := i + 1
				end
				from
					j := i
					i := get_functions.lower
					nb := Result.upper
				until
					j > nb 
				loop
					Result.put (get_functions.item (i), j)
					i := i + 1
					j := j + 1
				end
			end
		ensure
			non_void_result: Result /= Void
		end


feature {NONE} -- Internal vales

	internal_procedures: ARRAY [CONSUMED_PROCEDURE]
			-- Class procedures

	internal_functions: ARRAY [CONSUMED_FUNCTION]
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
	
	set_constructors (cons: like constructors) is
			-- set `constructors' with `cons'.
		require
			non_void_constructors: cons /= Void
		do
			constructors := cons
		ensure
			constructors_set: constructors = cons
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
		require
			fields_not_void: fields /= Void
		do
			Result := consumed_type_entities (True)
			Result.compare_objects
		ensure
			result_not_void: Result /= Void
		end
		
	inherited_entities: ARRAYED_LIST [CONSUMED_ENTITY] is
			-- All fields, procedures, functions, properties and events inherited by type.
		require
			fields_not_void: fields /= Void
		do
			Result := consumed_type_entities (False)
		end
		
	flat_entities: ARRAYED_LIST [CONSUMED_ENTITY] is
			-- All fields, procedures, functions, properties and events
			-- implemented/inherited by type.
		require
			fields_not_void: fields /= Void
		do
			Result := consumed_type_entities (True)
			Result.fill (consumed_type_entities (False))
			-- This is quite inefficient but only sparingly.
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
		require
			fields_not_void: fields /= Void
			internal_functions_not_void: internal_functions /= Void
			internal_procedures_not_void: internal_procedures /= Void
			properties_not_void: properties /= Void
			events_not_void: events /= Void
		do
			create Result.make (fields.count + internal_functions.count +
				internal_procedures.count + events.count + properties.count)
			consumed_a_type_entities (fields, a_immediate, Result)
			consumed_a_type_entities (internal_functions, a_immediate, Result)
			consumed_a_type_entities (internal_procedures, a_immediate, Result)
			consumed_a_type_entities (events, a_immediate, Result)
			consumed_a_type_entities (properties, a_immediate, Result)
		ensure
			result_not_void: Result /= Void
		end

	consumed_a_type_entities (
			a_features: ARRAY [CONSUMED_ENTITY]; a_immediate: BOOLEAN; a_result: like consumed_type_entities)
		is
			-- All fields, procedures, functions, properties and events implemented by type.
			-- If `a_immediate' then return immediate features, else return inherited.
		require
			a_features_not_void: a_features /= Void
			a_result_not_void: a_result /= Void
		local
			i, nb: INTEGER
			l_entity: CONSUMED_ENTITY
		do
			from 
				i := a_features.lower
				nb := a_features.upper
			until
				i > nb
			loop
				l_entity := a_features.item (i)
				if
					l_entity /= Void and then
					(l_entity.declared_type.is_equal (associated_reference_type) = a_immediate)
				then
					a_result.extend (l_entity)
				end
				i := i + 1
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
	valid_interfaces: interfaces /= Void

end -- class CONSUMED_TYPE
