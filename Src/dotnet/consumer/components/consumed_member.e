indexing
	description: ".NET type member as seen by Eiffel"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONSUMED_MEMBER

inherit
	CONSUMED_ENTITY
		rename
			make as entity_make
		redefine
			dotnet_name,
			is_static, is_deferred, is_public, is_artificially_added,
			set_is_public
		end

feature {NONE} -- Initialization

	make (en, dn: STRING; pub: BOOLEAN; a_type: CONSUMED_REFERENCED_TYPE) is
			-- Initialize with `en', `dn' and `pub'.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			a_type_not_void: a_type /= Void
		do
			entity_make (en, pub, a_type)
			dotnet_name := dn
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			is_public_set: is_public = pub
			declared_type_set: declared_type = a_type
		end
		
feature -- Access

	dotnet_name: STRING
			-- .NET member name

feature -- Status report

	is_public: BOOLEAN is
			-- Is current member public?
		do
			Result := internal_flags & feature {FEATURE_ATTRIBUTE}.Is_public =
				feature {FEATURE_ATTRIBUTE}.Is_public
		end

	is_frozen: BOOLEAN is
			-- Is feature frozen?
		do
			Result := internal_flags & feature {FEATURE_ATTRIBUTE}.Is_frozen =
				feature {FEATURE_ATTRIBUTE}.Is_frozen
		end

	is_static: BOOLEAN is
			-- Is .NET member static?
		do
			Result := internal_flags & feature {FEATURE_ATTRIBUTE}.Is_static =
				feature {FEATURE_ATTRIBUTE}.Is_static
		end

	is_deferred: BOOLEAN is
			-- Is feature deferred?
		do
			Result := internal_flags & feature {FEATURE_ATTRIBUTE}.Is_deferred =
				feature {FEATURE_ATTRIBUTE}.Is_deferred
		end

	is_artificially_added: BOOLEAN is
			-- Is feature deferred?
		do
			Result := internal_flags & feature {FEATURE_ATTRIBUTE}.Is_artificially_added =
				feature {FEATURE_ATTRIBUTE}.Is_artificially_added
		end
				
feature -- Settings

	set_is_public (pub: like is_public) is
			-- Set `is_public' with `pub'.
		do
			if pub then
				internal_flags := internal_flags | feature {FEATURE_ATTRIBUTE}.Is_public
			else
				internal_flags := internal_flags & feature {FEATURE_ATTRIBUTE}.Is_public.bit_not
			end
		end

	set_is_artificially_added (val: like is_artificially_added) is
			-- Set `is_artificially_added' with `val'.
		do
			if val then
				internal_flags := internal_flags | feature {FEATURE_ATTRIBUTE}.Is_artificially_added
			else
				internal_flags := internal_flags & feature {FEATURE_ATTRIBUTE}.Is_artificially_added.bit_not
			end
		ensure
			is_artificially_added_set: is_artificially_added = val
		end
		
feature {NONE} -- Internal

	internal_flags: INTEGER
			-- Store status of current feature.

invariant
	non_void_dotnet_name: dotnet_name /= Void
	valid_dotnet_name: not dotnet_name.is_empty

end -- class CONSUMED_MEMBER
