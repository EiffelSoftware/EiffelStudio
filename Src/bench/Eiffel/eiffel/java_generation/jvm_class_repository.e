indexing
	description: "stores and manages jvm classes. each class is uniquly identified by a type id.%
                % additionaly each class has a `qualified_name'. This class %
                %also contains some convenience functions for working %
                %with `type_id's, `feature_id's and `routine_id's"
	note: "do not use directly. use SHARED_JVM_CLASS_REPOSITORY instead"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JVM_CLASS_REPOSITORY

create {SHARED_JVM_CLASS_REPOSITORY} -- This class must be used by SHARED_JVM_CLASS_REPOSITORY only.
	make
			
feature {NONE} -- Initialization
			
	make is
		do
		end
			
feature {ANY} -- Status
			
	has_by_id (id: INTEGER): BOOLEAN is
			-- is a class with `id' present in repository?
		require
			valid_id: valid_id (id)
		do
			if
				repository /= Void
			then
				if
					repository.valid_index (id)
				then
					Result := repository.item (id) /= Void
				end
			end
		end
			
	has_by_qualified_name (n: STRING): BOOLEAN is
			-- is a class with name `n' present in repository?
		require
			n_not_void: n /= Void
			n_not_empty: not n.is_empty
		local
			i: INTEGER
		do
			if
				repository /= Void
			then
				from
					i := repository.lower
				until
					i > repository.upper or Result = True
				loop
					if
						repository.item (i) /= Void and then
						repository.item (i).qualified_name.is_equal (n)
					then
						Result := True
					end
					i := i + 1
				end
			end
		end
			
	is_valid_feature_id (type_id, feature_id: INTEGER): BOOLEAN is
			-- is `feature_id' a valid feature id for the class with the 
			-- type id `type_id' ?
		require
			valid_type_id: valid_id (type_id)
		do
			Result := item (type_id).features.valid_index (feature_id) and then
			item (type_id).features.item (feature_id) /= Void
		end
			
	is_written_feature_by_id (type_id, feature_id: INTEGER): BOOLEAN is
			-- is the feature with of class `type_id' with feature id 
			-- `feature_id' a written feature?
		require
			valid_type_id: valid_id (type_id)
			valid_feature: is_valid_feature_id (type_id, feature_id)
		local
			wf: JVM_WRITTEN_FEATURE
		do
			wf ?= repository.item (type_id).features.item (feature_id)
			Result := wf /= Void
		end
							
			
	valid_id (id: INTEGER): BOOLEAN is
			-- is `id' a valid id?
		do
			Result := id > 0
		end
			
	item (id: INTEGER): JVM_CLASS is
			-- access class with type id `id'
		require
			valid_id: valid_id (id)
		do
			Result := repository.item (id)
		end
			
	item_by_qualified_name (n: STRING): JVM_CLASS is
			-- access class with qualified name `n'
		require
			n_not_void: n /= Void
			n_not_empty: not n.is_empty
			name_present: has_by_qualified_name (n)
		local
			i: INTEGER
		do
			if
				repository /= Void
			then
				from
					i := repository.lower
				until
					i > repository.upper or Result /= Void
				loop
					if
						repository.item (i) /= Void and then
						repository.item (i).qualified_name.is_equal (n)
					then
						Result := repository.item (i)
					end
					i := i + 1
				end
			end
		end
			
			
feature {ANY} -- Element Change
			
	put (n: STRING; id: INTEGER) is
			-- adds a new java class to the repository
			-- `n' is the fully qualified java class name
			-- `id' is it's feature id.
		require
			n_not_void: n /= Void
			n_not_empty: not n.is_empty
			valid_id: valid_id (id)
			id_not_taken: not has_by_id (id)
		local
			new_class: JVM_CLASS
		do
			if
				repository = Void
			then
				set_capacity (initial_repository_size)
			end
			create new_class.make (n, id)
			repository.force (new_class, id)
		ensure
			class_put: has_by_id (id)
			name_set: item (id).qualified_name.is_equal (n)
		end
			
	set_capacity (a: INTEGER) is
		do
			if
				repository = Void
			then
				create repository.make (0, a)
			end
		end
			
feature {ANY} -- Code Generation
			
	generate_byte_code is
			-- generate jvm byte code for each class in the repository
			-- that needs to be generated (excluding external and basic types)
		local
			i: INTEGER
			c: JVM_CLASS
		do
			from
				i := repository.lower
			until
				i > repository.upper
			loop
				c := repository.item (i)
				if
					c /= Void
				then
					c.generate_byte_code
				end
				i := i + 1
			end
		end
			
feature {NONE} -- Implementation
			
	repository: ARRAY [JVM_CLASS]
			-- actual class container
			-- the index of a class must always be it's `type_id'
			
	initial_repository_size: INTEGER is 100
			-- constant that defined the intial size of repository
			-- for performance tweaks only
			
end -- class JVM_CLASS_REPOSITORY





			
			
