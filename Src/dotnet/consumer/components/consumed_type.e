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
			is_inter, is_abstract, is_sealed, is_value_type: BOOLEAN;
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
			is_interface := is_inter
			is_deferred := is_abstract
			is_frozen := is_sealed
			is_expanded := is_value_type
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

	is_interface: BOOLEAN
			-- Is .NET type an interface?

	is_deferred: BOOLEAN
			-- Is .NET type abstract?
	
	is_enum: BOOLEAN
			-- Is .NET type an enum?
	
	is_frozen: BOOLEAN
			-- Is .NET type sealed?

	is_expanded: BOOLEAN
			-- Is .NET type a value type?

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
	
invariant
	non_void_eiffel_name: eiffel_name /= Void
	valid_eiffel_name: not eiffel_name.is_empty
	non_void_dotnet_name: dotnet_name /= Void
	valid_dotnet_name: not dotnet_name.is_empty
	valid_interfaces: interfaces /= Void

end -- class CONSUMED_TYPE
