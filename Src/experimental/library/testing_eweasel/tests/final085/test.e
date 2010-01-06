class
	TEST

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make,
	make_with_default_format

feature {NONE} -- Initialization

	default_create
		do
			make (Void)
		end

	make(a_parser: like parser)
		require
			a_parser_not_void: a_parser /= Void
		do
			make_with_default_format (a_parser, "html")
		end

	make_with_default_format(a_parser: like parser; a_default_format: STRING)
		require
			a_parser_not_void: a_parser /= Void
			a_default_format_not_void: a_default_format /= Void
		do
			default_format := a_default_format
			default_lags := <<
					[0, "YTD"], [1, "M"], [3, "M"], [1, "Y"]
				>>
			parser := a_parser
		end

feature -- Access

	default_format: STRING
	default_lags: ARRAY[TEST1]
	parser: ANY

end
