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
			dotnet_name,
			has_arguments, arguments, is_public,
			is_frozen,
			set_is_public
		end

create
	make

feature {NONE} -- Initialization

	make (en: STRING; args: like arguments; pub: BOOLEAN; a_type: CONSUMED_REFERENCED_TYPE) is
			-- Initialize consumed constructor.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_arguments: arguments /= Void
			a_type_not_void: a_type /= Void
		do
			entity_make (en, pub, a_type)
			arguments := args
		ensure
			eiffel_name_set: eiffel_name = en
			arguments_set: arguments = args
			is_public_set: is_public = pub
			declared_type_set: declared_type = a_type
		end

feature -- Access

	arguments: ARRAY [CONSUMED_ARGUMENT]
			-- Constructor arguments

	is_public: BOOLEAN
			-- Is constructor public?

	is_frozen: BOOLEAN is True
			-- A constructor cannot be redefined.

	dotnet_name: STRING is ".ctor"
			-- Name of a .NET constructor.

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
