indexing
	description: "represents a JVM CLASS (actually a JVM type, but since the file it will be written to ends with .class ...)%
	% this is the central class in the jvm byte code generation.%
                % a JVM_CLASS object holds all the meta data it gets %
                %from the compiler first in a structured way. once %
                %the data feed ended it is able to traferse this %
                %information and emit java byte code from it"
					 
	date: "$Date$"
	revision: "$Revision$"

class
	JVM_CLASS
				
inherit
	
	SHARED_JVM_CLASS_REPOSITORY
	PLATFORM
	JVM_CONSTANTS
			
create
	make

feature {NONE} -- Initialization
			
	make (fn: STRING; a_type_id: INTEGER) is
			-- create a jvm class gived it's fully qualified name
			-- `fn' is of the form: [package_name\.]+class_name
			-- Basic Types and Arrays are not allowed !
			-- (They don't need to be generated anyway)
		require
			fn_not_void: fn /= Void
			fn_not_empty: not fn.is_empty
			valid_id: a_type_id > 0
		do
			qualified_name := clone (fn)
			type_id := a_type_id
			element_type_id := -1
			create parents.make
			create features.make (1, 10)
			create constant_pool.make
			is_source_code_hack_enabled := True
		end
			
feature {ANY} -- Access
			
	qualified_name: STRING
			-- fully qualified name of class representet by `Current'
			-- including a leading L and a trainling ; if object type
			
	qualified_name_wo_l: STRING is
			-- same as `qualified_name' but without the leading L and
			-- trailing ;
		do
			Result := clone (qualified_name)
			if
				Result.item (1) = 'L'
			then
				Result.tail (Result.count - 1)
				Result.head (Result.count - 1)
			end
		end
			
	type_id: INTEGER
			-- type id of class repr. by `Current'
			
	element_type_id: INTEGER
			-- if `is_array_type' this is set to the `type_id' of the
			-- class whose member the elements of this array are.
			
	is_basic_type: BOOLEAN is
			-- is this type a basic type
		do
			inspect
				qualified_name.item (1)
			when 'I', 'J', 'F', 'D', 'S', 'B', 'Z', 'C' then
				Result := True
			else
			end
		end
			
	jvm_type_id: INTEGER is
			-- JVM type. See JVM_CONSTANTS *_type for details
			-- Please note that JVM type ids are not a bidirectional
			-- match onto types. (There is a unique type id for each
			-- basic type and only one type id for all the rest)
		do
			if
				qualified_name.is_equal ("I")
			then
				Result := int_type
			elseif
				qualified_name.is_equal ("J")
			then
				Result := long_type
			elseif
				qualified_name.is_equal ("F")
			then
				Result := float_type
			elseif
				qualified_name.is_equal ("D")
			then
				Result := double_type
			elseif
				qualified_name.is_equal ("B")
			then
				Result := byte_type
			elseif
				qualified_name.is_equal ("S")
			then
				Result := short_type
			elseif
				qualified_name.is_equal ("Z")
			then
				Result := bool_type
			elseif
				qualified_name.is_equal ("C")
			then
				Result := char_type
			elseif
				qualified_name.is_equal ("V")
			then
				Result := void_type
			else
				Result := object_type
			end
		end
feature {ANY} -- Java debug information
	source_code_file_name: STRING
			-- name of source code file 
	
	has_source_code_file_name: BOOLEAN is
			-- is the source code file name available?
		do
			Result := source_code_file_name /= Void
		end
	
	set_source_code_file_name (a: STRING) is
			-- set the source code file name
		require
			a_not_void: a /= Void
		do
				source_code_file_name := a
			if
				is_source_code_hack_enabled
			then
				-- chop of ".e"
				source_code_file_name.head (source_code_file_name.count - 2)
							-- add ".java"
				source_code_file_name.append (".java")
			end
		ensure
			source_code_file_name_not_void: source_code_file_name /= Void
		end
	
	unset_source_code_file_name is
			-- call if class (resp. type)  has no source code file name
			-- i.e. in case of generic types
		do
			source_code_file_name := Void
		ensure
			has_no_source_code_file_name: not has_source_code_file_name
		end
	
	is_source_code_hack_enabled: BOOLEAN
			-- is the source code hack enabled
			-- in order to work properly jdb (the java debugger from 
			-- suns jdk) source code needs to be stored in files ending 
			-- with ".java". If this variable is set to `True' the meta 
			-- data in the ".class" files will not hold the real source 
			-- code file name, but a modified one, where ".e" is 
			-- replaced with ".java". Make sure to rename the source 
			-- code files as well.
	
feature {ANY} -- Status report
			
	is_array_type: BOOLEAN
			-- is class a native java array
			-- Note: Do we need to store the element type as well?
			
	is_external: BOOLEAN
			-- do we need to generate byte code for this class ?
			-- if `True,' we don't
			
	is_expanded: BOOLEAN
			-- is type expanded ?
			-- if `True' and `is_external' False we are into trouble,
			-- because threre are no expanded object types in Java.
			-- We would need to emulate the creation and copy semantics
			-- of expanded types by hand.
			
	is_deferred: BOOLEAN
			-- is this class deferred ?
			-- If `True' and `is_interface' = `False' this means we are
			-- dealing with an abstract class.
			
	is_interface: BOOLEAN
			-- does this type represent an interface ?
			

feature {ANY} -- Status settings
			
	set_array_type (a_element_type_id: INTEGER) is
			-- if this is an array type (ARRAY[SOMETHING]) put the id of 
			-- "SOMETHING" in here
		require
			repository.has_by_id (a_element_type_id)
		do
			is_array_type := True
			element_type_id := a_element_type_id
		ensure
			is_array_type: is_array_type
			element_type_id_set: element_type_id = a_element_type_id
		end
			
	reset_array_type is
			-- unsets (or resets) the array type status).
			-- after this call this method is marked to be not of an 
			-- array type (which is the default anyway)
		do
			is_array_type := False
		ensure
			not_is_array_type: not is_array_type
		end
			
	set_external is
			-- this is an external class.
			-- external classes are cute, cause they don't need to 
			-- generated. we still need to collect info about them, 
			-- because when we access them, we need to reference them in 
			-- the symbol tablel (read constant pool)
		do
			is_external := True
		ensure
			is_external: is_external
		end
			
	reset_external is
			-- after this call the class is marked to be not an external 
			-- class (which is the default anyway)
		do
			is_external := False
		ensure
			not_is_external: not is_external
		end
			
	set_expanded is
			-- mark this class as expanded, not supported yet !!!!
		do
			is_expanded := True
			check
				--	    False -- Not implemented in JVM (yet?)
			end
			debug ("JVMGEN")
				print ("warning: expanded classes are not (yet) supported%N")
			end
		ensure
			is_expanded: is_expanded
		end
			
	reset_expanded is
			-- mark class as beeing not expanded (default)
		do
			is_expanded := False
		ensure
			not_is_expanded: not is_expanded
		end
			
	set_deferred is
			-- mark class as deferred
		do
			is_deferred := True
		ensure
			is_deferred: is_deferred
		end
			
	reset_deferred is
			-- mark class as not deferred (default)
		do
			is_deferred := False
		ensure
			not_is_deferred: not is_deferred
		end
			
	set_interface is
			-- mark class as interface
		do
			is_interface := True
		ensure
			is_inteface: is_interface
		end
			
	reset_interface is
			-- mark class not to be an interface
		do
			is_interface := False
		ensure
			not_is_inteface: not is_interface
		end
			
feature {ANY} -- Composite access
			
	parents: LINKED_LIST [INTEGER]
			-- list of all parents of this class
			-- of course since we are dealing with Java here
			-- there must at most be one super class all the other
			-- parents must be interfaces.
			-- The items in the list refer to the parents `type_id's
			
	features: ARRAY [JVM_FEATURE]
			-- all features available in this classes namespace (either
			-- declared here, or inherited)
			-- a features index must always be it's `feature_id'
			
			
	has_feature_with_routine_id (rout_id: INTEGER): BOOLEAN is
			-- returns wether the `Current' class has a feature with
			-- routine id `rout_id'.
		local
			i: INTEGER
		do
			from
				i := features.lower
			until
				i > features.upper or Result = True
			loop
				if
					is_valid_feature_id (i) and then features.item (i).routine_id = rout_id
				then
					Result := True
				end
				i := i + 1
			end
		end
			
	feature_by_routine_id (rout_id: INTEGER): JVM_FEATURE is
			-- returns the feature with the given `rout_id' as routine id.
		require
			has_routine_id: has_feature_with_routine_id (rout_id)
		do
			Result := try_feature_by_routine_id (rout_id)
		ensure
			result_not_void: Result /= Void
		end
	
	try_feature_by_routine_id (rout_id: INTEGER): JVM_FEATURE is
			-- returns the feature with the given `rout_id' as routine id
			-- if such a feature exists. otherwise it returns `Void'.
		local
			i: INTEGER
		do
			from
				i := features.lower
			until
				i > features.upper or Result /= Void
			loop
				if
					is_valid_feature_id (i) and then features.item (i).routine_id = rout_id
				then
					Result := features.item (i)
				end
				i := i + 1
			end
		ensure
			precursor_implies_result_not_void: has_precursor_by_routine_id (rout_id) implies Result /= Void
		end
		
	has_precursor_by_routine_id (rout_id: INTEGER): BOOLEAN is
			-- there is at least one features with `rout_id' as
			-- routine_id in `parents'
			-- note: changes the cursor of `parents'
		do
			from
				parents.start
			until
				parents.off or Result
			loop
				if
					repository.item (parents.item).has_feature_with_routine_id (rout_id)
				then
					Result := True
				else
					parents.forth
				end
			end
		end
		
	external_name_of_precursor_by_routine_id (rout_id: INTEGER): STRING is
			-- get the external name of a inherited feature
		require
			has_precursor_by_routine_id (rout_id)
		do
			Result := try_external_name_of_precursor_by_routine_id (rout_id)
		ensure
			Result_valid: Result /= Void and then not Result.is_empty
		end
		
	try_external_name_of_precursor_by_routine_id (rout_id: INTEGER): STRING is
			-- get the external name of a inherited feature if such 
			-- there is a precursor, otherwise return `Void'
		do
			from
				parents.start
			until
				parents.off or Result /= Void
			loop
				if
					repository.item (parents.item).has_feature_with_routine_id (rout_id)
				then
					Result := repository.item (parents.item).feature_by_routine_id (rout_id).written_feature.external_name
				else
					parents.forth
				end
			end
		ensure
			precursor_exists_implies_result_valid: has_precursor_by_routine_id (rout_id) implies Result /= Void and then not Result.is_empty
		end
		
	put_feature (f: JVM_FEATURE) is
			-- put feature into class.
			-- to add a new feature to a class procede as following: 
			-- create the feature and setup the signature, then put it 
			-- in via this feature
		require
			feature_not_set_yet: is_feature_id_free (f.feature_id)
		do
			features.force (f, f.feature_id)
		end
			
	is_feature_id_free (id: INTEGER): BOOLEAN is
			-- is `id' still unset in the feature array ?
		do
			Result := not features.valid_index (id) or else features.item (id) = Void
		end
	
	is_valid_feature_id (id: INTEGER): BOOLEAN is
			-- is a feature with feature id `id' present?
		do
			Result := features.item (id) /= Void
		end
			
	written_methods_count: INTEGER is
			-- how many written methods does this class containt.
			-- (written fields are _not_ included!)
		local
			i: INTEGER
			f: JVM_WRITTEN_FEATURE
		do
			from
				i := features.lower
			until
				i > features.upper
			loop
				f ?= features.item (i)
				if
					f /= Void and then not f.is_field and not f.is_field_setter
				then
					Result := Result + 1
				end
				i := i + 1
			end
		end
			
	written_fields_count: INTEGER is
			-- how many written fields are in this class. written 
			-- methods are _not_ included
		local
			i: INTEGER
			f: JVM_WRITTEN_FEATURE
		do
			from
				i := features.lower
			until
				i > features.upper
			loop
				f ?= features.item (i)
				if
					f /= Void and then f.is_field
				then
					Result := Result + 1
				end
				i := i + 1
			end
		end

	super_class: JVM_CLASS is
			-- super class (heir) of class. since java has only SI, this 
			-- is exactly one class (except for interfaces, which have 
			-- no super class). in case a non interface class has no 
			-- explicit super class specified ANY (resp. 
			-- java.lang.Object) is used.
		require
			not_is_interface: not is_interface
		local
			a_parent: JVM_CLASS
		do
			from
				parents.start
			until
				parents.off or Result /= Void
			loop
				a_parent := repository.item (parents.item)
				if
					not a_parent.is_interface
				then
					Result := a_parent
				end
				parents.forth
			end
		ensure
			result_not_void: Result /= Void
		end
			
	constant_pool: CONSTANT_POOL
			-- constant pool

feature {ANY} -- Special features
	
	invariant_: JVM_WRITTEN_FEATURE
			-- references the invariant of this class (if it has one)
	
	set_invariant (f: JVM_WRITTEN_FEATURE) is
			-- set the invariant feature of this class.
		do
			invariant_ := f
		ensure
			invariant_set: invariant_ = f
		end

feature {ANY} -- Code Generation
			
	jvm_file_name: STRING is
			-- file name of file this class will be stored in
		do
			Result := clone (qualified_name_wo_l) + ".class"
		end
			
	generate_byte_code is
			-- generate JVM byte code for class
			-- this is the magic procedure that produces the ".class" file
		local
			f: RAW_FILE
		do
			if
				not is_external and not is_array_type
			then
				update_file_header
				close_class_header
				close_features
				close_attributes
				close_constant_pool
				create f.make_open_write (jvm_file_name)
				check
					is_open_write: f.is_open_write --TODO: Add error handling instead of assertion
				end
				file_header.emit (f)
				constant_pool.emit (f)
				class_header.emit (f)
				store_fields (f)
				store_methods (f)
				attributes.emit (f)
										
				f.close
			end
		end

feature {NONE} -- Code Generation Implementation
	
	file_header: JVM_BYTE_CODE
			-- byte code for the (physical) file header 
	class_header: JVM_BYTE_CODE
			-- header for the class
	attributes: JVM_BYTE_CODE
			-- meta data at the class level
			-- currently only the source file is allowed (according Java Std.)
			-- Note: Do not confuse with class attributes, the latter
			-- called fields in Java. The former is a way to store meta information
			-- in the java class file.
			
	update_file_header is
			-- fill out `file_header'
			-- only after calling this feature `file_header' can be 
			-- written to disk
		do
			create file_header.make
			file_header.set_constant_pool (constant_pool)
			
						-- write 0xCAFEBABE to `f'. this is the magic number every java
						-- binary file must start with
			file_header.append_uint_16_from_int (0xCAFE)
			file_header.append_uint_16_from_int (0xBABE)
							
						-- write minro and major version number
						-- using 45.02 as documented in "JAVA Virtual Machine (John
						-- Meyer, Troy Downing - O'Reilly - 1997 First Edition)
			file_header.append_uint_16_from_int (0x03)
			file_header.append_uint_16_from_int (0x2D)
		ensure
			file_header_not_void: file_header /= Void
		end
			
	close_constant_pool is
			-- close the constant pool
			-- only after this has happened, you can write the constant 
			-- pool on disk
		do
			constant_pool.close
		end
			
	close_class_header is
			-- fill out `class_header'
			-- only after calling this feature `class_header' can be 
			-- written to disk
		do
			create class_header.make
			class_header.set_constant_pool (constant_pool)
			append_access_flag
			append_this_class
			append_parents
						--	 class_header.close
		ensure
			class_header_not_void: class_header /= Void
						--	 class_header_closed: class_header.is_closed
		end
			
	close_features is
			-- fill out `features'
			-- only after calling this feature `features' can be 
			-- written to disk
		require
			--features_open:
		local
			i: INTEGER
			wf: JVM_WRITTEN_FEATURE
		do
			if
				not is_interface
			then
				add_default_constructor
			end
			from
				i := features.lower
			until
				i > features.upper
			loop
				wf ?= features.item (i)
				if
					wf /= Void
				then
					check
						wf.is_open
					end
					wf.close
				end
				i := i + 1
			end
		ensure
			--features_closed:
		end
			
	close_attributes is
			-- fill out `attributes'
			-- only after calling this feature `attributes' can be 
			-- written to disk
		do
			create attributes.make
			attributes.set_constant_pool (constant_pool)
			if
				has_source_code_file_name
			then
				attributes.append_uint_16_from_int (0x1)
				constant_pool.put_utf8_constant ("SourceFile")
				attributes.append_uint_16_from_int (constant_pool.last_cpe_index)
				attributes.append_uint_32_from_int (0x2)
				constant_pool.put_utf8_constant (source_code_file_name)
				attributes.append_uint_16_from_int (constant_pool.last_cpe_index)
			else
				attributes.append_uint_16_from_int (0x0)
			end
							
		ensure
			attributes_not_void: attributes /= Void
						--	 attributes_closed: attributes.is_closed
		end
			
	store_fields (file: RAW_FILE) is
			-- append byte code for fields in file `file'
		require
			file_valid: file /= Void and then file.is_open_write
		local
			i: INTEGER
			bc: JVM_BYTE_CODE
			f: JVM_WRITTEN_FEATURE
		do
			create bc.make_size (1)
			bc.append_uint_16_from_int (written_fields_count)
			bc.emit (file)
			from
				i := features.lower
			until
				i > features.upper
			loop
				f ?= features.item (i)
				if
					f /= Void and then f.is_field
				then
					check
						f.is_closed
					end
					f.emit (file)
				end
				i := i + 1
			end
		end
			
	store_methods (file: RAW_FILE) is
			-- append byte code for `methods' to file `file'
		require
			file_valid: file /= Void and then file.is_open_write
		local
			i: INTEGER
			bc: JVM_BYTE_CODE
			f: JVM_WRITTEN_FEATURE
		do
			create bc.make_size (1)
			bc.append_uint_16_from_int (written_methods_count)
			bc.emit (file)
			from
				i := features.lower
			until
				i > features.upper
			loop
				f ?= features.item (i)
				if
					f /= Void and then not f.is_field and not f.is_field_setter
				then
					check
						f.is_closed
					end
					f.emit (file)
				end
				i := i + 1
			end
		end
			
			
			
feature {NONE}
	
	append_access_flag is
			-- append access flag to `class_header' byte code
		require
			class_header_not_void: class_header /= Void
		local
			i : INTEGER
		do
			i := Acc_super.bit_or (Acc_public)
			if
				is_interface
			then
				i := i.bit_or (Acc_interface)
			end
			if
				is_deferred and not is_interface
			then
				i := i.bit_or (Acc_abstract)
			end
			class_header.append_uint_16_from_int (i)
		end
						
	append_this_class is
			-- append this class `class_header' byte_code
		require
			class_header_not_void: class_header /= Void
		do
			class_header.append_class_by_type_id (Current.type_id)
		end
			
	append_parents is
			-- append parents byte code to `class_header' byte code
		require
			class_header_not_void: class_header /= Void
		do
			append_super_class
			append_interfaces
		end
			
	append_super_class is
			-- append super class to `class_header' byte code
		require
			class_header_not_void: class_header /= Void
			parents_not_void: parents /= Void
		do
			if
				is_interface
			then
				class_header.append_uint_16_from_int (0)
			else
				class_header.append_class_by_type_id (super_class.type_id)
			end
		end
			
	append_interfaces is
			-- append interfaces to `class_header' byte code
		require
			class_header_not_void: class_header /= Void
			parents_not_void: parents /= Void
		local
			a_parent: JVM_CLASS
			c: INTEGER
		do
			from
				parents.start
			until
				parents.off
			loop
				a_parent := repository.item (parents.item)
				if
					a_parent.is_interface
				then
					c := c + 1
				end
				parents.forth
			end
			class_header.append_uint_16_from_int (c)
			from
				parents.start
			until
				parents.off
			loop
				a_parent := repository.item (parents.item)
				if
					a_parent.is_interface
				then
					class_header.append_class_by_type_id (parents.item)
								-- add count
				end
				parents.forth
			end
		end
			
feature {ANY}
	add_default_constructor is
			-- Since Eiffe creations procedures and Java constructors do
			-- not map one to one a little hack is needed for Eiffel
			-- classes that are to be generated to Java byte code:
			-- For each non-external class a default constructor is
			-- added (this will be the only constructor in this class ever)
			-- The Eiffel creation procedures are just regular features
			-- that can be called after construction.
		require
			not_external: not is_external
			has_super_class: super_class /= Void
		local
			m: JVM_METHOD
			super_class_constructor_index: INTEGER
			f_id: INTEGER
		do
			-- put methodref for superclass default constructor in
			-- constant pool
			constant_pool.put_method_ref ("<init>", "()V", super_class.qualified_name_wo_l)
			super_class_constructor_index := constant_pool.last_cpe_index
							
						-- add new default constructor
			create m.make (constant_pool)
			f_id := features.upper + 1
			check
				free: is_feature_id_free (f_id)
			end
			m.set_feature_id (f_id)
			m.set_routine_id (-1)
			m.set_type_id (type_id)
			m.set_external_name ("<init>")
			m.set_parameters ("")
			m.set_return_type_name ("V")
			m.set_is_constructor (True)
			m.close_signature
							
						-- call superclass default constructor
			m.code.append_push_from_local (0, object_type)
			m.code.append_invoke_default_constructor (super_class.type_id)
						-- return
			m.code.append_return (void_type)
			put_feature (m)
		end
			
invariant
	
	features_not_void: features /= Void
	parents_not_void: parents /= Void
	constant_pool_not_void: constant_pool /= Void
	has_source_code_file_name_implies_source_code_file_name_not_void: has_source_code_file_name implies source_code_file_name /= Void

end -- class JVM_CLASS





