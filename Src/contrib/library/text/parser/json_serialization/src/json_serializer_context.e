note
	description: "Context for JSON serialization."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_SERIALIZER_CONTEXT

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
			create serializers.make (1)
		end

feature -- Settings

	is_pretty_printing: BOOLEAN
			-- Generate pretty JSON string (indented...)?

	is_compact_printing: BOOLEAN
		do
			Result := not is_pretty_printing
		end

feature -- Settings change

	set_pretty_printing
		do
			is_pretty_printing := True
		end

	set_compact_printing
		do
			is_pretty_printing := False
		end

feature -- Access

	default_serializer: like serializer assign set_default_serializer

	serializer (obj: detachable ANY): detachable JSON_SERIALIZER
		local
			o_type, k_type: TYPE [detachable ANY]
		do
			if obj /= Void then
				o_type := obj.generating_type
				across
					serializers as ic
				until
					Result /= Void
				loop
					Result := ic.item
					k_type := ic.key
					if o_type ~ k_type then
							-- Found
					elseif
							-- Hack: use conformance of type, and reverse conformance of type of type.
						attached k_type.attempted (obj) and then
						attached o_type.generating_type.attempted (k_type)
					then
							-- Found
					else
						Result := Void
					end
				end
			end
			if Result = Void and attached default_serializer as dft then
				Result := dft
			end
		end

feature -- Element change

	register_serializer (a_conf: attached like serializer; a_type: TYPE [detachable ANY])
		do
			serializers.force (a_conf, a_type)
		end

	set_default_serializer (conv: like default_serializer)
		do
			default_serializer := conv
		end

feature {NONE} -- Implementation

	serializers: HASH_TABLE [like serializer, TYPE [detachable ANY]]

;note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
