indexing
	description: "Object to represent an uncompled completion feature for completion"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPLETION_FEATURE
	
inherit
	FEATURE_DESCRIPTOR
		redefine
			all_callers,
			all_callers_count,
			ancestor_versions_count,
			ancestor_versions,
			descendant_callers,
			descendant_callers_count,
			descendant_versions_count,
			descendant_versions,
			description,
			evaluated_class,
			exported_to_all,
			external_name,
			feature_location,
			has_postcondition,
			has_precondition,
			implementers_count,
			implementers,
			is_attribute,
			is_constant,
			is_deferred,
			is_external,
			is_frozen,
			is_function,
			is_infix,
			is_obsolete,
			is_once,
			is_prefix,
			is_procedure,
			is_unique,
			local_callers,
			local_callers_count,
			name,
			parameters,
			return_type,
			signature,
			written_class
		end
		
create
	make,
	make_with_return_type
	
feature {NONE} -- Initialization

	make (a_name: like name; a_arguments: like arguments_internal; a_feature_type: INTEGER; a_file_name: like file_name) is
			-- create an instance
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
		do
			name := clone (a_name)
			name.to_lower
			file_name := clone (a_file_name)
			file_name.to_lower
			if a_arguments /= Void then
				arguments_internal := a_arguments
			else
				create arguments_internal.make (0)
			end
			create parameters.make (arguments_internal)
			return_type := void_keyword
			set_feature_type (a_feature_type)
			create {ARRAYED_LIST [PARAMETER_ENUMERATOR]} overloads_parameters.make (0)
			create {ARRAYED_LIST [STRING]} overloads_return_types.make (0)
		end
		
	make_with_return_type (a_name: like name; a_arguments: like arguments_internal; a_return_type: like return_type; a_feature_type: INTEGER; a_file_name: like file_name) is
			-- create an instance with a return type
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			non_void_return_type: a_return_type /= Void
			valid_return_type: not a_return_type.is_empty
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
		do
			make (a_name, a_arguments, a_feature_type, a_file_name) 
			return_type := clone (a_return_type)
			return_type.to_upper
		end

feature -- Access

	name: STRING
			-- name of feature

	overloads_count: INTEGER
			-- Number of overloads (0 means the feature is not overloaded)

	parameters: PARAMETER_ENUMERATOR
			-- Feature parameters
	
	overloads_parameters: LIST [PARAMETER_ENUMERATOR]
			-- Feature overloaded parameters

	return_type: STRING
			-- return type of feature
	
	overloads_return_types: LIST [STRING]
			-- Feature overloaded return types

	description: STRING is
			-- Feature description.
		do
			Result := internal_description (signature)
		end
		
	overloads_descriptions: LIST [STRING] is
			-- Overloaded features descriptions
		local
			l_signatures: LIST [STRING]
		do
			create {ARRAYED_LIST [STRING]} Result.make (overloads_count)
			from
				l_signatures := overloads_signatures
				l_signatures.start
			until
				l_signatures.after
			loop
				Result.extend (internal_description (l_signatures.item))
				l_signatures.forth
			end
		ensure
			non_void_descriptions: Result /= void
		end

	signature: STRING is
			-- Main feature signature
		do
			Result := clone (name)
			if arguments_internal.count > 0 then
				Result.append (" (")
			end
			from
				arguments_internal.start
			until
				arguments_internal.after
			loop
				Result.append (arguments_internal.item.display)
				if not arguments_internal.islast then
					Result.append ("; ")
				end
				arguments_internal.forth
			end
			if arguments_internal.count > 0 then
				Result.append_character (')')
			end
			if not return_type.is_equal (void_keyword) then
				Result.append (": " + return_type)
			end
		ensure then
			result_exists: Result /= void
		end

	overloads_signatures: LIST [STRING] is
			-- Overloaded features signatures
		do
			create {ARRAYED_LIST [STRING]} Result.make (overloads_count)
			from
				overloads_parameters.start
			until
				overloads_parameters.after				
			loop
				Result.extend (internal_signature (overloads_parameters.item))
				overloads_parameters.forth
			end
		ensure
			non_void_signature: Result /= Void
		end
	
	feature_location (file_path: CELL [STRING]; line_number: INTEGER_REF) is
			-- Feature location
		do
			if file_path /= Void then
				file_path.put (file_name)
			end
			line_number.set_item (0);
		end
		
	file_name: STRING
			-- file name feature is contained within

feature -- Basic Operations
	
	add_overload (a_parameters: PARAMETER_ENUMERATOR; a_return_type: STRING) is
			-- 	Add a new overload to this feature
		require
			non_void_parameters: a_parameters /= Void
			non_void_return_type: a_return_type /= Void
		do
			overloads_parameters.extend (a_parameters)
			overloads_return_types.extend (a_return_type)
			overloads_count := overloads_count + 1
		ensure
			overloads_count_increased: overloads_count = old overloads_count + 1
			parameters_added: overloads_parameters.has (a_parameters)
			return_type_added: overloads_return_types.has (a_return_type)
		end
		
feature {NONE} -- Dummy implementations

	all_callers: FEATURE_ENUMERATOR is
			-- all callers to feature
		once
			create Result.make (create {ARRAYED_LIST [FEATURE_DESCRIPTOR]}.make (0))
		end
		
	all_callers_count: INTEGER is 0
	
	ancestor_versions: FEATURE_ENUMERATOR is
			-- all ancestor versions of feature
		once
			create Result.make (create {ARRAYED_LIST [FEATURE_DESCRIPTOR]}.make (0))
		end
		
	ancestor_versions_count: INTEGER is 0
	
	descendant_versions: FEATURE_ENUMERATOR is
			-- all decendant versions of feature
		once
			create Result.make (create {ARRAYED_LIST [FEATURE_DESCRIPTOR]}.make (0))
		end
		
	descendant_versions_count: INTEGER is 0
	
	descendant_callers: FEATURE_ENUMERATOR is
			-- all decendant callers to feature
		once
			create Result.make (create {ARRAYED_LIST [FEATURE_DESCRIPTOR]}.make (0))
		end

	descendant_callers_count: INTEGER is 0

	written_class: STRING is ""
			-- class to which feature belongs

	local_callers: FEATURE_ENUMERATOR is
			-- all local callers to feature
		once
			create Result.make (create {ARRAYED_LIST [FEATURE_DESCRIPTOR]}.make (0))
		end
		
	local_callers_count: INTEGER is 0

	has_postcondition: BOOLEAN is False

	has_precondition: BOOLEAN is False
		
	implementers: FEATURE_ENUMERATOR is
			-- all implements to feature
		once
			create Result.make (create {ARRAYED_LIST [FEATURE_DESCRIPTOR]}.make (0))
		end
		
	implementers_count: INTEGER is 0
	
	is_attribute: BOOLEAN
	is_constant: BOOLEAN 
	is_deferred: BOOLEAN 
	is_external: BOOLEAN 
	is_frozen: BOOLEAN 
	is_function: BOOLEAN
	is_infix: BOOLEAN 
	is_obsolete: BOOLEAN 
	is_once: BOOLEAN 
	is_prefix: BOOLEAN 
	is_procedure: BOOLEAN
	is_unique: BOOLEAN

	evaluated_class: STRING is ""
	
	exported_to_all: BOOLEAN is True
	
	external_name: STRING is 
		do
			Result := name
		end

feature {NONE} -- Implementation

	internal_description (a_signature: STRING): STRING is
			-- Feature description with signature `a_signature'
		do
			create Result.make (20)
			if is_once then
				Result.append ("Once ")
			end
			if is_constant then
				Result.append ("Constant ")
			end
			if is_frozen then
				Result.append ("Frozen ")
			end
			if is_external then
				Result.append ("External ")
			end
			if is_deferred then
				Result.append ("Deferred ")
			end
			if is_infix then
				Result.append ("Infix operator ")
			elseif is_prefix then
				Result.append ("Prefix operator ")
			elseif is_attribute then
				Result.append ("Attribute: ")
			elseif is_function then
				Result.append ("Function: ")
			elseif is_procedure then
				Result.append ("Procedure: ")
			end
			Result.append (name)
			Result.append ("%NSignature: ")
			Result.append (a_signature)
			Result.prune_all ('%R')
			Result.prune_all ('%T')
		ensure then
			result_exists: Result /= void
		end

	internal_signature (a_parameters: PARAMETER_ENUMERATOR): STRING is
			-- Signature of function with parameters `parameters'
		require
			non_void_parameters: a_parameters /= Void
		local
			i, parameters_count: INTEGER
			rgelt: CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE]
		do
			Result := clone (name)
			parameters_count := a_parameters.count
			if parameters_count > 0 then
				Result.append (" (")
			end
			from
				i := 1
			until
				i > parameters_count
			loop
				create rgelt.put (Void)
				a_parameters.ith_item (i, rgelt)
				Result.append (rgelt.item.display)
				if i < parameters_count then
					Result.append ("; ")
				end
				i := i + 1
			end
			if parameters_count > 0 then
				Result.append_character (')')
			end
			if not return_type.is_equal (void_keyword) then
				Result.append (": " + return_type)
			end
		ensure then
			result_exists: Result /= void
		end
		
	set_feature_type (a_feature_type: INTEGER) is
			-- set feature type attributes
		do
 			is_attribute := a_feature_type.bit_and (feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_attribute) > 0
			is_constant := a_feature_type.bit_and (feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_constant) > 0
			is_deferred := a_feature_type.bit_and (feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_deferred) > 0
			is_external := a_feature_type.bit_and (feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_external) > 0
			is_frozen := a_feature_type.bit_and (feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_frozen) > 0
			is_function := a_feature_type.bit_and (feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_function) > 0
			is_infix := a_feature_type.bit_and (feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_infix) > 0
			is_obsolete := a_feature_type.bit_and (feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_obsolete) > 0
			is_once := a_feature_type.bit_and (feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_once) > 0
			is_prefix := a_feature_type.bit_and (feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_prefix) > 0
			is_procedure := a_feature_type.bit_and (feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_procedure) > 0
		end
		
	arguments_internal: ARRAYED_LIST [PARAMETER_DESCRIPTOR]
			-- arguments for feature

	void_keyword: STRING is "Void"
			-- Void keyword for void return types

invariant
	non_void_arguments: arguments_internal /= Void
	non_void_name: name /= Void
	non_void_return_type: return_type /= Void
	valid_overloads_parameters_count: overloads_parameters.count = overloads_count
	valid_overloads_return_types_count: overloads_return_types.count = overloads_count

end -- class COMPLETION_FEATURE
