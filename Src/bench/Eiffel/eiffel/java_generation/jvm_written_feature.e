indexing
	description: "represents written features. that is either a new feature, or a redefined/renamed/somehow changed feature."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
class
	JVM_WRITTEN_FEATURE

inherit
	JVM_FEATURE
			
	JVM_BYTE_CODE_EMITTOR
		redefine
			emit,
			close
		end
			
	JVM_CONSTANTS
			
	JVM_NAME_CONVERTER
			
create
	make

feature {ANY} -- Initialsiation
			
	make (cp: CONSTANT_POOL) is
			-- create feature
			-- `cp' is the constant pool of it's class
		require
			cp_not_void: cp /= Void
		do
			create parameter_type_names.make (1, 0)
			create parameter_jvm_type_ids.make (1, 0)
			return_type_name := clone ("V")
			return_jvm_type_id := void_type
			set_constant_pool (cp)
		end

feature {ANY} -- Access
			
	external_name: STRING
			-- JVM name of this feature.
			-- This is the ready to go string for the name entry in a
			-- CONSTANT_NameAndType entry in the constant pool.
			
	signature: STRING is
			-- Signature of this feature (return type and parameter types)
			-- This is the ready to go string for the type entry in a
			-- CONSTANT_NameAndType entry in the constant pool.
		require
			signature_closed: is_signature_closed
		local
			i: INTEGER
		do
			if
				signature_cache = Void
			then
				if
					is_field
				then
					signature_cache := return_type_name
				else
					from
						i := parameter_type_names.lower
						signature_cache := clone ("(")
					until
						i > parameter_type_names.upper
					loop
						signature_cache.append (parameter_type_names.item (i))
						i := i + 1
					end
					signature_cache.append (")")
					signature_cache.append (return_type_name)
				end
			end
			Result := signature_cache
		end
			
feature {ANY} --
			
	is_field: BOOLEAN
			-- `True' if this is a field
			-- `False' if this is a method
			
	is_static: BOOLEAN
			-- `True' if this is a static feature
			
	is_constructor: BOOLEAN
			-- `True' if this is a constructor
			-- Note: In Java constructors must not be called as regular features
			
	is_field_setter: BOOLEAN
			-- Is this feature a setter ?
			-- Note: Setters will not be real Java functions. This is
			-- only a placeholder, when we should make a call to such a
			-- feature we generate the bytecode to set the attribute instead.
			
	is_method: BOOLEAN is
			-- is this a real method?
			-- Note: Attribute setters are not considerd to be methods
			-- since they will not be generated to real byte code.
		do
			Result := not is_field and not is_field_setter
		end
			
	written_feature: JVM_WRITTEN_FEATURE is
		-- returns Current, since we are a written feature
		do
			Result := Current
		end
	
	field: JVM_WRITTEN_FEATURE is
			-- in case this is a field setter, return the corresponding field
			-- works for static and non static field setters
		require
			is_field_setter: is_field_setter
		do
			check
				TODO: False
			end
		ensure
			result_not_void: Result /= Void
			result_is_field: Result.is_field
		end
	
feature {ANY} --
			
	set_is_field (b: BOOLEAN) is
			-- set `is_field' flag
		do
			is_field := b
		ensure
			is_field_set: is_field = b
		end
			
	set_is_static (b: BOOLEAN) is
		-- set `is_static' flag
		do
			is_static := b
		ensure
			is_static_set: is_static = b
		end
			
	set_is_constructor (b: BOOLEAN) is
			-- set `is_constructor' flag
		do
			is_constructor := b
		ensure
			is_constructor_set: is_constructor = b
		end
			
	set_is_field_setter (b: BOOLEAN) is
			-- set `is_field_setter' flag
		do
			is_field_setter := b
		ensure
			is_field_setter_set: is_field_setter = b
		end

			
	set_external_name (n: STRING) is
			-- set `external_name' of this feature
		require
			n_not_void: n /= Void
			n_not_empty: not n.is_empty
		do
			external_name := n
		ensure
			external_name_not_void: external_name /= Void
			external_name_set: external_name.is_equal (n)
		end
			
	set_parameters (s: STRING) is
			-- Set parameters from a string. JVM Format
			-- Example: "I[Ljava/lang/String;"
			-- Note: do not wrapp string in "(" and ")"
		require
			s_not_void: s/= Void
			no_brackets1: s.occurrences (')') = 0
			no_brackets2: s.occurrences ('(') = 0
			no_dots: s.occurrences ('.') = 0
		do
			parameter_type_names := jvm_type_descriptor_to_jvm_type_names (s)
			parameter_jvm_type_ids := jvm_type_descriptors_to_jvm_type_ids (s)
		end
			
	set_return_type_name (s: STRING) is
			-- Set return type from string. JVM Format
			-- Example: "Ljava/lang/String;"
		require
			s_not_void: s /= Void
			no_brackets1: s.occurrences (')') = 0
			no_brackets2: s.occurrences ('(') = 0
			no_dots: s.occurrences ('.') = 0
		do
			return_type_name := s
			return_jvm_type_id := jvm_type_descriptors_to_jvm_type_ids (s).item (1)
		end
			
	set_parameters_from_string_array (params: ARRAY [STRING]) is
			-- Set parameters from array of strings in format of the
			-- Java external clause in Eiffel source code.
		require
			params_not_void: params /= Void
		do
			set_parameters (eiffel_external_parameter_names_to_jvm_parameters (params))
		end
			
	set_return_type_from_string (s: STRING) is
			-- Set return type from string. Format of Java external
			-- clause in Eiffel source code.
		require
			s_not_void: s /= Void
		do
			set_return_type_name (java_to_jvm_name (s))
		end
			
	set_parameters_from_type_id_list (l: LINKED_LIST [PAIR [INTEGER, STRING]]) is
			-- Set parameters from a list of pairs containing type ids 
			-- plus names
		require
			l_not_void: l /= Void
		local
			s: STRING
			i: INTEGER
		do
			check
				not (type_id = 13 and feature_id = 8)
			end
			create s.make (20)
			from
				l.start
				create parameter_names.make (1, l.count)
			until
				l.off
			loop
				i := i + 1
				parameter_names.put (l.item.second, i)
				s.append_string (repository.item (l.item.first).qualified_name)
				l.forth
			end
			set_parameters (s)
		end
			
	set_return_type_by_id (a_type_id: INTEGER) is
			-- Set return type from a type id
		require
			valid_id: repository.has_by_id (a_type_id)
		do
			set_return_type_name (repository.item (a_type_id).qualified_name)
		end
			
	emit (file: RAW_FILE) is
			-- emmit the features byte code to a file
			-- in this class, this is only for attributes (fields)
			-- decendants will redefine it to fit their purposes.
		do
			header_bc.emit (file)
			attributes_count_bc.emit (file)
		end
			
	close is
		do
			close_header
			close_attributes_count
			Precursor
		end
			
	is_signature_closed: BOOLEAN
			-- a written feature introduces another closed state
			-- that is first the signature is declared, the feature is 
			-- completly open
			-- then the signature is closed. from that point on, the 
			-- signature must not be changed anymore. the gain is, that 
			-- now other components can access the signature. for 
			-- example a method can refere to this feature in it's byte code.
			-- then after the signature is closed, before it can be 
			-- emitted is has to be closed "using `close'" just like any 
			-- other jvm byte code emitter too.
	
	close_signature is
			-- close signature. see `is_signature_closed' for details.
		do
			is_signature_closed := True
		ensure
			signature_closed: is_signature_closed
		end

feature {NONE} -- Implementation			
	
	close_header is
		local
			name_index: INTEGER
			type_index: INTEGER
		do
			constant_pool.put_utf8_constant (external_name)
			name_index := constant_pool.last_cpe_index
			constant_pool.put_utf8_constant (signature)
			type_index := constant_pool.last_cpe_index
							
			create header_bc.make_size (Int_16_size * 3)
			append_access_flag
			header_bc.append_uint_16_from_int (name_index) -- name index
			header_bc.append_uint_16_from_int (type_index) -- type index
		end
	
	append_access_flag is
		local
			f: INTEGER
		do
			f := Acc_public
			if
				is_static
			then
				f := f.bit_or (Acc_static)
			end
			header_bc.append_uint_16_from_int (f) -- acess flags (TODO)
		end
	header_bc: JVM_BYTE_CODE
	attributes_count_bc: JVM_BYTE_CODE
			
	close_attributes_count is
		do
			create attributes_count_bc.make_size (Int_16_size)
			attributes_count_bc.append_uint_16_from_int (0) -- Attributes count
		end

feature {ANY} -- Basic Access
	
	return_class: JVM_CLASS is
			-- gets you the eiffel type of the return type if present
		require
			signature_closed: is_signature_closed
			has_non_void_return_type: has_non_void_return_type
		local
			s: STRING
		do
			s := clone (signature)
			if
				not is_field
			then
				check
					only_one_bracket: s.occurrences (')') = 1
					index_of_not_0: s.index_of ('(', 1) /= 0
				end
				-- remove parameters
				s.tail (s.count - s.index_of (')', 1))
			end
			-- now s contains only the return type
			check
				type_in_universe: repository.has_by_qualified_name (s)
			end
			Result := repository.item_by_qualified_name (s)
		end
			
	has_non_void_return_type: BOOLEAN is
			-- tells wether the given feature has a non void return type
		require
			signature_closed: is_signature_closed
		do
			if
				is_field
			then
				Result := True
			else
				if
					signature.item (signature.count) /= 'V'
				then
					Result := True
				end
			end
		end

feature
	return_type_name: STRING
			-- jvm type name of return type ("V" in case of procedures)
	
	return_jvm_type_id: INTEGER
			-- jvm type id of return type 
			-- see JVM_CONSTANTS.*_type
			
	parameter_type_names: ARRAY [STRING]
			-- jvm type names of the method parameters
	
	parameter_jvm_type_ids: ARRAY [INTEGER]
			-- jvm type ids of the method parameters
			-- see JVM_CONSTANTS.*_type
	
	parameter_names: ARRAY [STRING]
			-- names of parameters. usefull for debugger meta data.
			-- may be void, some parameter names might be unkown.
	
	
feature {NONE}	
	
	signature_cache: STRING
			-- cache of signature
invariant
	closed_implies_header_not_void: is_closed implies header_bc /= Void
	closed_implies_attributes_count_not_void: is_closed implies attributes_count_bc /= Void
	sig_closed_is_field_has_return_type: is_signature_closed and is_field implies has_non_void_return_type
	return_type_name_not_void: return_type_name /= Void
	return_jvm_type_id_valid: valid_jvm_type (return_jvm_type_id)
	parameter_type_names_not_void: parameter_type_names /= Void
	-- for all items `e' in `parameter_type_names' | valid_jvm_type (e)
end



