expanded class EXTENDED_STATUS

inherit
	EXPORT_STATUS

create
	default_create,
	make_from_integer

convert
	make_from_integer ({INTEGER}),
	to_integer: {INTEGER}

end
