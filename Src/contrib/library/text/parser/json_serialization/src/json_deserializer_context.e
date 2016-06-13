note
	description: "Context for the deserialization."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_DESERIALIZER_CONTEXT
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
			create deserializers.make (1)
		end

feature -- Access

	default_deserializer: like deserializer assign set_default_deserializer

	deserializer (a_type: TYPE [detachable ANY]): detachable JSON_DESERIALIZER
		local
			o_type, k_type: TYPE [detachable ANY]
		do
			o_type := a_type
			across
				deserializers as ic
			until
				Result /= Void
			loop
				Result := ic.item
				k_type := ic.key
				if o_type ~ k_type then
						-- Found
				elseif
						-- Hack: use conformance of type, and reverse conformance of type of type.
--					attached k_type.attempted (obj) and then
					attached o_type.generating_type.attempted (k_type)
				then
						-- Found
				else
					Result := Void
				end
			end
			if Result = Void and attached default_deserializer as dft then
				Result := dft
			end
		end

feature -- Element change

	register_deserializer (conv: attached like deserializer; a_type: TYPE [detachable ANY])
		do
			deserializers.force (conv, a_type)
		end

	set_default_deserializer (conv: like default_deserializer)
		do
			default_deserializer := conv
		end

feature {NONE} -- Implementation

	deserializers: HASH_TABLE [attached like deserializer, TYPE [detachable ANY]]

;note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
