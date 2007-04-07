indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class MULTI [G -> {H, J, ANY} create used_default_create end, H -> {COMPARABLE rename default_create as used_default_create end} create used_default_create end, J -> NUMERIC]

create
	default_create


end
