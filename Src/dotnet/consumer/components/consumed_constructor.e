indexing
	description: ".NET type constructor as seen in Eiffel"

class
	CONSUMED_CONSTRUCTOR

inherit
	CONSUMED_ENTITY
		rename
			make as entity_make
		end

create
	make

feature {NONE} -- Initialization

	make (en: STRING; args: like arguments) is
			-- Initialize consumed constructor.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_arguments: arguments /= Void
		do
			entity_make (en)
			arguments := args
		ensure
			eiffel_name_set: eiffel_name = en
			arguments_set: arguments = args
		end

feature -- Access

	arguments: ARRAY [CONSUMED_ARGUMENT]
			-- Constructor arguments

invariant
	non_void_arguments: arguments /= Void

end -- class CONSUMED_CONSTRUCTOR
