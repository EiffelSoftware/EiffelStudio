note
	description: "Summary description for {PE_DOTNET_META_HEADER}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_DOTNET_META_HEADER

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_from_other

feature {NONE} -- Initialization

	default_create
		do
			META_SIG := 0x424A5342
		end

	make_from_other (a_other: PE_DOTNET_META_HEADER)
		do

		end

feature -- Access

	meta_sig: NATURAL

	singature: NATURAL_32

	major: NATURAL_16

	minor: NATURAL_16

	reserved: NATURAL_32

feature -- Element Change

	set_meta_sig (a_val: NATURAL)
			-- Set `meta_sig` with `a_val`.
		do
			meta_sig := a_val
		ensure
			meta_sig_set: meta_sig = a_val
		end

	set_signature (a_val: NATURAL)
			-- Set `signature` with `a_val`.
		do
			singature := a_val
		ensure
			signature_set: singature = a_Val
		end

	set_major (a_val: NATURAL_16)
			-- Set `major` with `a_val`.
		do
			major := a_val
		ensure
			major_set: major = a_val
		end

	set_minor (a_val: NATURAL_16)
			-- Set 	`minor` with `a_val`
		do
			minor := a_val
		ensure
			minor_set: minor = a_val
		end

	set_reserved (a_val: NATURAL)
			-- Set `reserved` with `a_val`
		do
			reserved := a_val
		ensure
			reserved_set: reserved = a_val
		end

end
