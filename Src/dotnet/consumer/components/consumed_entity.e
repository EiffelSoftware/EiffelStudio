indexing
	description: ".NET entity (member or constructor) as seen by Eiffel"

class
	CONSUMED_ENTITY

create
	make

feature {NONE} -- Initialization

	make (en: STRING) is
			-- Initialize `Current'.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
		do
			eiffel_name := en
		ensure
			eiffel_name_set: eiffel_name = en
		end

feature -- Access

	eiffel_name: STRING
			-- Eiffel entity name

invariant
	non_void_eiffel_name: eiffel_name /= Void
	valid_eiffel_name: not eiffel_name.is_empty

end -- class CONSUMED_ENTITY
