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
			dotnet_eiffel_name,
			has_arguments, arguments, is_public,
			is_frozen,
			is_constructor,
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
			non_void_arguments: args /= Void
			a_type_not_void: a_type /= Void
		do
			entity_make (en, pub, a_type)
			a := args
		ensure
			eiffel_name_set: eiffel_name = en
			arguments_set: arguments = args
			is_public_set: is_public = pub
			declared_type_set: declared_type = a_type
		end

feature -- Access

	arguments: ARRAY [CONSUMED_ARGUMENT] is
			-- Constructor arguments
		do
			Result := a
		end

	is_public: BOOLEAN is
			-- Is constructor public?
		do
			Result := p
		end

	is_frozen: BOOLEAN is True
			-- A constructor cannot be redefined.
			
	is_constructor: BOOLEAN is True
			-- A constructor is a constructor.

	dotnet_name: STRING is ".ctor"
			-- Name of a .NET constructor.
			
	dotnet_eiffel_name: STRING is "make"
			-- Eiffelized name of .NET constructor.

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
			p := pub
		ensure then
			is_public_set: is_public = pub
		end

feature {NONE} -- Access

	a: like arguments
			-- Internal data for `arguments'.
	
	p: like is_public
			-- Internal data for `is_public'.

end -- class CONSUMED_CONSTRUCTOR then
