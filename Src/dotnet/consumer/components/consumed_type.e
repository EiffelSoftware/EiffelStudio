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

	procedures: ARRAY [CONSUMED_PROCEDURE]
			-- Class procedures

	functions: ARRAY [CONSUMED_FUNCTION]
			-- Class functions

	interfaces: ARRAY [CONSUMED_REFERENCED_TYPE]
			-- Implemented interfaces
			
	entities: ARRAYED_LIST [CONSUMED_ENTITY] is
			-- All constructors, fields, procedures and functions implemented by type.
		require
			constructors_not_void: constructors /= Void
			fields_not_void: fields /= Void
			functions_not_void: functions /= Void
			procedures_not_void: procedures /= Void
		do
			create Result.make (0)
			Result.fill (constructors)
			Result.fill (fields)
			Result.fill (functions)
			Result.fill (procedures)
		ensure
			entities_not_void: Result /= Void
		end		

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
			procedures := meth
		ensure
			procedures_set: procedures = meth
		end
	
	set_functions (func: like functions) is
			-- set `functions' with `meth'.
		require
			non_void_functions: func /= Void
		do
			functions := func
		ensure
			functions_set: functions = func
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

feature {NONE} -- Internal

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
