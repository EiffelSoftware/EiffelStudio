indexing
	description: ".NET entity (member or constructor) as seen by Eiffel"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ENTITY

create
	make

feature {NONE} -- Initialization

	make (en: STRING; pub: BOOLEAN) is
			-- Initialize `Current' with `en' and `pub'.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
		do
			eiffel_name := en
			set_is_public (pub)
		ensure
			eiffel_name_set: eiffel_name = en
			is_public_set: is_public = pub
		end

feature -- Access

	eiffel_name: STRING
			-- Eiffel entity name

	arguments: ARRAY [CONSUMED_ARGUMENT] is
			-- Arguments if any.
		do
		end
		
	return_type: CONSUMED_REFERENCED_TYPE is
			-- Return type if any.
		do
		end

	is_public: BOOLEAN is
			-- Is .NET entity public?
		do
		end

feature -- Status report

	has_arguments: BOOLEAN is
			-- Does current entity have argments?
		do
		end

	has_return_value: BOOLEAN is
			-- Does current entity returns a value?
		do
		end
		
	is_static: BOOLEAN is
			-- Is current entity static?
		do
		end
	
	is_attribute: BOOLEAN is
			-- Is current entity an attribute?
		do
		end

	is_deferred: BOOLEAN is
			-- Is current entity abstract?
		do
		end

feature -- Settings

	set_is_public (pub: like is_public) is
			-- Set `is_public' with `pub'.
		do
		ensure
			is_public_set: is_public = pub
		end
		
invariant
	non_void_eiffel_name: eiffel_name /= Void
	valid_eiffel_name: not eiffel_name.is_empty

end -- class CONSUMED_ENTITY
