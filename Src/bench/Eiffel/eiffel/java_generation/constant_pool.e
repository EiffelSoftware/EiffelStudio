indexing
	description: "the constant pool is an integral part of a jvm class. it is the symbolic link table, the virtual machine needs to %
	%run and link classes. ie. instead of writing the name and signature of features every time they are accessed directly into %
   %the code attribute, only an index is written. these index %
   %reference an entry in the constant pool, that holds the actual information."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANT_POOL

inherit
	SHARED_JVM_CLASS_REPOSITORY
			
	JVM_BYTE_CODE_EMITTOR
		redefine
			emit,
			close
		end
			
create
	make

feature {NONE} -- Initialisation
			
	make is
		do
			create list.make
						--	 make_size (Int_16_size)
			create class_type_id_to_cpe.make (50)
			create feature_type_id_to_cpe.make (50)
			create count_bc.make_size (Int_16_size)
		end

feature -- Access

	close is
		do
			count_bc.append_uint_16_from_int (list.count + 1)
			from
				list.start
			until
				list.off
			loop
				if
					list.item /= Void
				then
					list.item.close
				end
				list.forth
			end
			Precursor
		end
			
	class_type_id_to_cpe: HASH_TABLE [INTEGER, INTEGER]
			-- provides a mapping from system global `type_id's to
			-- constant pool local entry indizes
			
	feature_type_id_to_cpe: HASH_TABLE [HASH_TABLE [INTEGER, INTEGER], INTEGER]
			-- this maps a (class_type_id, feature_type_id) to constant
			-- pool index
			
	put_class_by_type_id (a_type_id: INTEGER) is
			-- put information for a class into the constant pool (by 
			-- type id)
		require
			valid_id: repository.valid_id (a_type_id)
			open: is_open
		do
			put_class_by_object (repository.item (a_type_id))
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_CLASS")
		end
			
	put_class_by_object (a_class: JVM_CLASS) is
			-- puts a class (CPE_CLASS) and it's name (CPE_UTF8) into
			-- the pool. Updates the `type_id_to_cpe' mapping.
		require
			a_class_not_void: a_class /= Void
			open: is_open
		do
			put_class (a_class.qualified_name_wo_l)
			class_type_id_to_cpe.put (last_cpe_index, a_class.type_id)
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_CLASS")
		end
			
	put_class (class_: STRING) is
			-- puts a class (CPE_CLASS) and it's name (CPE_UTF8) into
			-- the pool. Updates the `type_id_to_cpe' mapping.
		require
			class_valid: class_ /= Void and then not class_.is_empty
			open: is_open
		local
			cpe_class: CPE_CLASS
		do
			put_utf8_constant (class_)
			create cpe_class.make (last_cpe_index)
			put_element (cpe_class)
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_CLASS")
		end
			
	put_feature_by_type_id (a_type_id, a_feature_type_id: INTEGER) is
			-- put information about a feature into the constant pool
		require
			open: is_open
			valid_type_id: repository.valid_id (a_type_id)
			valid_feature: repository.is_valid_feature_id (a_type_id, a_feature_type_id)
			feature_is_written: repository.is_written_feature_by_id (a_type_id, a_feature_type_id)
		local
			h: HASH_TABLE [INTEGER, INTEGER]
			wf: JVM_WRITTEN_FEATURE
		do
			wf ?= repository.item (a_type_id).features.item (a_feature_type_id)
			check
				wf /= Void
			end
			feature_type_id_to_cpe.search (a_type_id)
			if
				not feature_type_id_to_cpe.found
			then
				put_feature_by_object (wf)
				create h.make (50)
				h.put (last_cpe_index, a_feature_type_id)
				feature_type_id_to_cpe.put (h, a_type_id)
			else -- type_id found
				feature_type_id_to_cpe.found_item.search (a_feature_type_id)
				if
					not feature_type_id_to_cpe.found_item.found
				then
					put_feature_by_object (wf)
					feature_type_id_to_cpe.found_item.put (last_cpe_index, a_feature_type_id)
				else
					last_cpe_index := feature_type_id_to_cpe.found_item.found_item
				end	
			end
							
			check
				has_key1: feature_type_id_to_cpe.has (a_type_id)
				has_key2: feature_type_id_to_cpe.item (a_type_id).has (a_feature_type_id)
			end
							
		end

	put_feature_by_object (f: JVM_WRITTEN_FEATURE) is
			-- put information about a feature into the constant pool
		require
			f_not_void: f /= Void
			f_signature_closed: f.is_signature_closed
			open: is_open
		do
			if
				f.class_.is_interface
			then
				put_interface_method_ref_by_object (f)
			elseif
				f.is_field
			then
				put_field_ref_by_object (f)
			elseif
				not f.is_field_setter
			then
				put_method_ref_by_object (f)
			else
				check
					TODO: False
				end
			end
		end
			
	put_method_ref_by_object (f: JVM_WRITTEN_FEATURE) is
			-- put information about a method into the constant pool
		require
			f_not_void: f /= Void
			f_is_field: not f.is_field and not f.is_field_setter
			f_signature_closed: f.is_signature_closed
			open: is_open
		local
			cpe: CPE_METHOD_REF
			name_and_type_index, class_index: INTEGER
		do
			put_name_and_type_from_object (f)
			name_and_type_index := last_cpe_index
			put_class_by_object (f.class_)
			class_index := last_cpe_index
			create cpe.make (class_index, name_and_type_index)
			put_element (cpe)
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_METHOD_REF")
		end
			
	put_interface_method_ref_by_object (f: JVM_WRITTEN_FEATURE) is
			-- put information about a interface method into the constant pool
		require
			f_not_void: f /= Void
			f_class_is_interface: f.class_.is_interface
			f_is_field: not f.is_field and not f.is_field_setter
			f_signature_closed: f.is_signature_closed
			open: is_open
		local
			cpe: CPE_INTERFACE_METHOD_REF
			name_and_type_index, class_index: INTEGER
		do
			put_name_and_type_from_object (f)
			name_and_type_index := last_cpe_index
			put_class_by_object (f.class_)
			class_index := last_cpe_index
			create cpe.make (class_index, name_and_type_index)
			put_element (cpe)
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_INTERFACE_METHOD_REF")
		end
			
	put_method_ref (method_name, method_signature, written_class: STRING) is
			-- puts a MethodRef entry into the Constant Pool.
			-- `method_name' is the name of the method the constant
			-- refers to
			-- `method_signature' is the signature of the method (it
			-- needs to be in JVM format example: "(I)V"
			-- `written_class' is the class the feature is "written" in
			-- (declared and defined).
		require
			method_name_not_void: method_name /= Void
			method_signature_not_void: method_signature /= Void
			written_class_not_void: written_class /= Void
			written_class_name_valid: written_class.occurrences ('.') = 0
			open: is_open
		local
			class_index, name_type_index: INTEGER
			cpe: CPE_METHOD_REF
		do
			put_name_and_type (method_name, method_signature)
			name_type_index := last_cpe_index
			put_class (written_class)
			class_index := last_cpe_index
			create cpe.make (class_index, name_type_index)
			put_element (cpe)
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_METHOD_REF")
		end
			
	put_field_ref (name, type, class_: STRING) is
			-- put information about a field into the constant pool
		require
			name_not_void: name /= Void
			type_not_void: type /= Void
			class_not_void: class_ /= Void
			open: is_open
			class_name_valid: class_.occurrences ('.') = 0
		local
			class_index, name_type_index: INTEGER
			cpe: CPE_FIELD_REF
		do
			put_name_and_type (name, type)
			name_type_index := last_cpe_index
			put_class (class_)
			class_index := last_cpe_index
			create cpe.make (class_index, name_type_index)
			put_element (cpe)
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_FIELD_REF")
		end
			
	put_field_ref_by_object (f: JVM_WRITTEN_FEATURE) is
			-- put information about a field into the constant pool
		require
			f_not_void: f /= Void
			f_is_field: f.is_field
			f_signature_closed: f.is_signature_closed
			open: is_open
		do
			put_field_ref (f.external_name, f.signature, f.class_.qualified_name_wo_l)
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_FIELD_REF")
		end
						
	put_name_and_type_from_object (f: JVM_WRITTEN_FEATURE) is
			-- put name and type entry of a feature into the constant pool
		require
			f_not_void: f /= Void
			f_signature_closed: f.is_signature_closed
			open: is_open
		do
			put_name_and_type (f.external_name, f.signature)
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_NAME_AND_TYPE")
		end
			
	put_name_and_type (name, type: STRING) is
			-- put name and type entry of a feature into the constant pool
		require
			name_not_void: name /= Void
			type_not_void: type /= Void
			open: is_open
		local
			name_index, type_index: INTEGER
			cpe: CPE_NAME_AND_TYPE
		do
			put_utf8_constant (name)
			name_index := last_cpe_index
			put_utf8_constant (type)
			type_index := last_cpe_index
			create cpe.make (name_index, type_index)
			put_element (cpe)
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_NAME_AND_TYPE")
		end
			
	emit (file: RAW_FILE) is
			-- append constant pool to file
		do
			count_bc.emit (file)
			from
				list.start
			until
				list.off
			loop
				-- since long and double values take up two places in the 
				-- constant pool  (one of 
				-- which is left Void) an item may indeed be void.
				if
					list.item /= Void
				then
					list.item.emit (file)
				end
				list.forth
			end
		end
			
	put_double_constant (d: DOUBLE) is
			-- put a double constant into pool
		local
			cpe: CPE_DOUBLE
		do
			create cpe.make (d)
			put_element (cpe)
			if
				not last_put_cached
			then
				list.force (Void)
							-- for obscure reasons (citing book "Java Virtual Machine - 
							-- Jon Meyer, pg. 179) when an entry tagged 
							-- CONSTANT_Long or CONSTANT_Double appears in the constant 
							-- pool, the JVM considers this as taking up two entries. 
							-- For example, if a constant CONSTANT_Long appears at index 
							-- 3 in the constant pool, then the next constant in the 
							-- class file will be fiven an index number 5. Index 4 is 
							-- treated as an invalid index, and must not be referred to 
							-- by the class file.
			end
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_DOUBLE")
		end
			
	put_float_constant (f: REAL) is
			--	put fload constant into pool
		local
			cpe: CPE_FLOAT
		do
			create cpe.make (f)
			put_element (cpe)
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_FLOAT")
		end
			
	put_int_32_constant (i: INTEGER) is
			--	put int 32 (java type int) constant into pool
		local
			cpe: CPE_INTEGER
		do
			create cpe.make (i)
			put_element (cpe)
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_INTEGER")
		end
			
	put_int_64_constant_from_int (i: INTEGER) is
			--	put int 64 (java type long) constant into pool
		local
			cpe: CPE_LONG
		do
			create cpe.make_from_int (i)
			put_element (cpe)
			if
				not last_put_cached
			then
				list.force (Void)
							-- for obscure reasons (citing book "Java Virtual Machine - 
							-- Jon Meyer, pg. 179) when an entry tagged 
							-- CONSTANT_Long or CONSTANT_Double appears in the constant 
							-- pool, the JVM considers this as taking up two entries. 
							-- For example, if a constant CONSTANT_Long appears at index 
							-- 3 in the constant pool, then the next constant in the 
							-- class file will be fiven an index number 5. Index 4 is 
							-- treated as an invalid index, and must not be referred to 
							-- by the class file.
			end
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_LONG")
		end
			
	put_utf8_constant (s: STRING) is
			--	put utf8 constant into pool
			-- note that this cannot directly be used for 
			-- java.lang.String manifests. they require a 
			-- `put_string_constant' call.
		local
			cpe: CPE_UTF8
		do
			create cpe.make (s)
			put_element (cpe)
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_UTF8")
		end
			
	put_string_constant (s: STRING) is
			-- put string (java type java.lang.String) constant into pool
		local
			cpe: CPE_STRING
		do
			put_utf8_constant (s)
			create cpe.make (last_cpe_index)
			put_element (cpe)
		ensure
			last_cpe: list.i_th (last_cpe_index).generating_type.is_equal ("CPE_STRING")
		end
			
feature {ANY} 
	last_cpe_index: INTEGER
			-- index of item inserted last
			-- we use a caching mechanism to avoid duplicate entries.
			-- if an entry has not been inserted, because a entry with 
			-- the same data was already present, `last_cpe_index' is 
			-- still set to the index of the already present entry.
	
	put_element (el: CONSTANT_POOL_ELEMENT) is
			-- puts an element into the list.
			-- the index of the element can be retrieved from `last_cpe_index'.
			-- elements will only be put into the list if they are not
			-- there yet, otherwise the index of the existing element
			-- will be stored in `last_cpe_index'.
		require
			open: is_open
		local
			found: BOOLEAN
		do
			from
				list.start
			until
				list.off or found
			loop
				if
					list.item /= Void and then list.item.is_equal (el)
				then
					found := True
					last_cpe_index := list.index
					last_put_cached := True
				else
					list.forth
				end
			end
			if
				not found
			then
				list.force (el)
				last_cpe_index := list.count
				last_put_cached := False
			end
		ensure
			last_put_cached implies list.count = old list.count
			not last_put_cached implies list.count - 1 = old list.count
		end
	
	last_put_cached: BOOLEAN
			-- this variable tells you wether the last call to 
			-- `put_element' actually inserted a new element (False) or 
			-- just set `last_cpe_index' to point to a equal entry 
			-- already present

feature {NONE} -- Implementation
			
	list: LINKED_LIST [CONSTANT_POOL_ELEMENT]
			-- the actual entries are stored in this list
			
	count_bc: JVM_BYTE_CODE
			-- information about the length of the constant pool

invariant
	
	class_type_id_to_cpe_not_void: class_type_id_to_cpe /= Void
	feature_type_id_to_cpe_not_void: feature_type_id_to_cpe /= Void
	count_bc_not_void: count_bc /= Void
			
end

			


