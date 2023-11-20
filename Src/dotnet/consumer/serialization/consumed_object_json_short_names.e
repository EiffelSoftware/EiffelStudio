note
	description: "Summary description for {CONSUMED_OBJECT_JSON_SHORT_NAMES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_OBJECT_JSON_SHORT_NAMES

inherit
	CONSUMED_OBJECT_JSON_NAMES
		redefine
			unique_id,
			folder_name,
			name,
			culture,
			version,
			key,
			location,
			gac_path,
			eiffel_name,
			dotnet_name,
			dotnet_eiffel_name,
			parent,
			properties,
			interfaces,
			constructors,
			functions,
			procedures,
			arguments,
			fields,
			events,
			getter,
			setter,
			value,
			adder,
			remover,
			raiser,
			assembly_id,
			type,
			element_type,
			formal_type_name,
			formal_position,
			declared_type,
			return_type,
			associated_reference_type,
			enclosing_type,
			flag,
			position
		end

feature	-- Names

--	is_dirty: JSON_STRING once Result := "is_dirty" end
--	assemblies: JSON_STRING once Result := "assemblies" end
	unique_id: JSON_STRING once Result := "uid" end
	folder_name: JSON_STRING once Result := "d" end
	name: JSON_STRING once Result := "n" end
	version: JSON_STRING once Result := "v" end
	culture: JSON_STRING once Result := "c" end
	key: JSON_STRING once Result := "k" end
	location: JSON_STRING once Result := "loc" end
	gac_path: JSON_STRING once Result := "gac" end
--	is_consumed: JSON_STRING once Result := "is_consumed" end
--	is_in_gac: JSON_STRING once Result := "is_in_gac" end
--	has_info_only: JSON_STRING once Result := "has_info_only" end
--
--	eiffel_names: JSON_STRING once Result := "eiffel_names" end
--	dotnet_names: JSON_STRING once Result := "dotnet_names" end
--	flags: JSON_STRING once Result := "flags" end
--	positions: JSON_STRING once Result := "positions" end
--	count: JSON_STRING once Result := "count" end
--	namespaces: JSON_STRING once Result := "namespaces" end

	eiffel_name: JSON_STRING once Result := "en" end
	dotnet_name: JSON_STRING once Result := "dn" end
	dotnet_eiffel_name: JSON_STRING once Result := "den" end
	parent: JSON_STRING once Result := "par" end
	properties: JSON_STRING once Result := "props" end
	interfaces: JSON_STRING once Result := "int" end
	constructors: JSON_STRING once Result := "cr" end
	functions: JSON_STRING once Result := "fcts" end
	procedures: JSON_STRING once Result := "procs" end
	arguments: JSON_STRING once Result := "args" end
	fields: JSON_STRING once Result := "flds" end
	events: JSON_STRING once Result := "evts" end
	associated_reference_type: JSON_STRING once Result := "art" end
	enclosing_type: JSON_STRING once Result := "enct" end
	getter: JSON_STRING once Result := "get" end
	setter: JSON_STRING once Result := "set" end
	value: JSON_STRING once Result := "val" end
	adder: JSON_STRING once Result := "add" end
	remover: JSON_STRING once Result := "rem" end
	raiser: JSON_STRING once Result := "rai" end
	assembly_id: JSON_STRING once Result := "aid" end
	type: JSON_STRING once Result := "t" end
	element_type: JSON_STRING once Result := "et" end
	formal_type_name: JSON_STRING once Result := "ftn" end
	formal_position: JSON_STRING once Result := "fpos" end
	declared_type: JSON_STRING once Result := "dt" end
	return_type: JSON_STRING once Result := "rt" end
--	is_frozen: JSON_STRING once Result := "is_frozen" end
--	is_public: JSON_STRING once Result := "is_public" end
--	is_literal: JSON_STRING once Result := "is_literal" end
--	is_init_only: JSON_STRING once Result := "is_init_only" end
--	is_artificially_added: JSON_STRING once Result := "is_artificially_added" end
--	is_property_or_event: JSON_STRING once Result := "is_property_or_event" end
--	is_new_slot: JSON_STRING once Result := "is_new_slot" end
--	is_virtual: JSON_STRING once Result := "is_virtual" end
--	is_infix: JSON_STRING once Result := "is_infix" end
--	is_prefix: JSON_STRING once Result := "is_prefix" end
--	is_constructor: JSON_STRING once Result := "is_constructor" end
--	is_generic: JSON_STRING once Result := "is_generic" end
--	generic_parameters: JSON_STRING once Result := "generic_parameters" end

	flag: JSON_STRING once Result := "f" end
	position: JSON_STRING once Result := "p" end


end
