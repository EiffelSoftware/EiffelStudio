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
			is_static, is_deferred, is_public,
			set_is_public
		end

feature {NONE} -- Initialization

	make (en, dn: STRING; pub: BOOLEAN) is
			-- Initialize with `en', `dn' and `pub'.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
		do
			entity_make (en, pub)
			dotnet_name := dn
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			is_public_set: is_public = pub
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
		
feature {NONE} -- Internal

	internal_flags: INTEGER
			-- Store status of current feature.

invariant
	non_void_dotnet_name: dotnet_name /= Void
	valid_dotnet_name: not dotnet_name.is_empty

end -- class CONSUMED_MEMBER
