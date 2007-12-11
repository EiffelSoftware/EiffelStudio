indexing
	description: "Truth values, with the boolean operations"
	external_name: "System.Boolean"
	assembly: "mscorlib"

expanded class BOOLEAN

inherit
	BOOLEAN_REF

create
	default_create,
	make_from_reference

convert
	make_from_reference ({BOOLEAN_REF})

end
