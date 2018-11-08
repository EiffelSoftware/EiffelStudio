note
	description: "JSON Web Algorithms (JWA)"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name= JSON Web Algorithms", "src=https://tools.ietf.org/html/rfc7518", "protocol=uri"


class
	JWT_ALGORITHMS

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			create items.make_caseless (2)
			register_algorithm (hs256)
			register_algorithm (none)
				-- TODO: check if this is acceptable default.
			set_default_algorithm ({JWT_ALG_HS256}.name)
		end

feature -- Access

	hs256: JWT_ALG_HS256
		do
			create Result
		end

	none: JWT_ALG_NONE
		do
			create Result
		end

feature -- Access

	default_algorithm: JWT_ALG
		do
			if attached internal_default_alg_name as l_alg_name then
				Result := algorithm (l_alg_name)
			end
			if Result = Void then
				Result := none
			end
		end

	algorithm alias "[]" (a_name: READABLE_STRING_GENERAL): detachable JWT_ALG
		do
			Result := items [a_name]
		end

feature -- Element change

	register_algorithm (alg: attached like algorithm)
		do
			items [alg.name] := alg
		end

	unregister_algorithm (a_alg_name: READABLE_STRING_GENERAL)
		do
			items.remove (a_alg_name)
		end

	set_default_algorithm (a_alg_name: detachable READABLE_STRING_GENERAL)
		do
			if
				a_alg_name = Void or else
				not is_supported_algorithm (a_alg_name)
			then
				internal_default_alg_name := Void
			else
				internal_default_alg_name := a_alg_name
			end
		end

feature -- Status report	

	is_supported_algorithm (a_name: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := items.has (a_name)
		end

feature {NONE} -- Implementation

	items: STRING_TABLE [attached like algorithm]

	internal_default_alg_name: detachable READABLE_STRING_GENERAL

invariant

end
