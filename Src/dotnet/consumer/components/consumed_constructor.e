indexing
	description: ".NET type constructor as seen in Eiffel"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_CONSTRUCTOR

inherit
	CONSUMED_ENTITY
		rename
			make as entity_make
		redefine
			has_arguments, arguments, is_public, set_is_public
		end

create
	make

feature {NONE} -- Initialization

	make (en: STRING; args: like arguments; pub: BOOLEAN) is
			-- Initialize consumed constructor.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_arguments: arguments /= Void
		do
			entity_make (en, pub)
			arguments := args
		ensure
			eiffel_name_set: eiffel_name = en
			arguments_set: arguments = args
			is_public_set: is_public = pub
		end

feature -- Access

	arguments: ARRAY [CONSUMED_ARGUMENT]
			-- Constructor arguments

	is_public: BOOLEAN
			-- Is constructor public?

feature -- Status report

	has_arguments: BOOLEAN is
			-- Does current have arguments?
		do
			Result := arguments /= Void and then arguments.count /= 0
		end

feature -- Settings

	set_is_public (pub: like is_public) is
			-- Set `is_public' with `pub'.
		do
			is_public := pub
		ensure
			is_public_set: is_public = pub
		end

invariant
	non_void_arguments: arguments /= Void

end -- class CONSUMED_CONSTRUCTOR
