indexing

    Product: EiffelStore
    Database: Matisse

class DB_STORE_MAT

inherit

	DB_STORE_I

	EXT_INTERNAL
		export {NONE} all
	end

creation -- Creation procedure

	make

feature -- Initialization

	make (size: INTEGER) is
		-- Do nothing
		do
		end -- make

feature -- Access

	repository: DB_REPOSITORY_MAT -- Associated repository

feature -- Status setting

	set_repository (one_repository: DB_REPOSITORY_MAT) is
		-- Set `repository' with `one_repository'.
		require else
			rep_not_void: one_repository /= Void
		do
			repository := one_repository
		ensure then
			repository_not_void: repository /= Void
		end -- set_repository

feature -- Status report

	owns_repository: BOOLEAN is
		-- Is current associated with `repository'?
		do
			 Result := repository /= Void
		ensure then
			Result = (repository /= Void)
		end -- owns_repository

feature -- Element change

	put (one_object: ANY) is
		-- Store `one_object'
		require else
			object_exists: one_object /= Void
			owns_repository: owns_repository
			repository_exists: repository.exists
			conforms_to_repository : repository.conforms(one_object)
		local
			one_attribute : MT_ATTRIBUTE
			one_mat_object : MT_OBJECT
			i,j : INTEGER
			found : BOOLEAN
			one_value : ANY
			c_attributes : ARRAY[MT_ATTRIBUTE]
			tmp_strg: STRING
		do
			one_mat_object := repository.implementation.new_instance
			c_attributes:= repository.implementation.attributes
			from
				i:=c_attributes.lower
			until
				i>=c_attributes.upper + 1
			loop
				one_attribute := c_attributes.item(i)
				from 
					j:=1
					found := false
				until
					j>field_count (one_object) or found
				loop
					tmp_strg := one_attribute.name
					tmp_strg.to_lower
					found := field_name(j,one_object).is_equal(tmp_strg) 						
					j:=j+1
				end
				check found end
				one_attribute.set_value(one_mat_object,one_attribute.type, field(j-1,one_object))
				i:=i+1
			end 
		end -- put

	force (object: ANY) is
		-- Do what `put' does.
		require else
			object_exists: object /= Void
			owns_repository: owns_repository
			repository_exists: repository.exists
		do
			put (object)
		end -- force

end -- class DB_STORE_MAT

