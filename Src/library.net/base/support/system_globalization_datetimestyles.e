indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Globalization.DateTimeStyles"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_GLOBALIZATION_DATETIMESTYLES

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen allow_white_spaces: SYSTEM_GLOBALIZATION_DATETIMESTYLES is
		external
			"IL enum signature :System.Globalization.DateTimeStyles use System.Globalization.DateTimeStyles"
		alias
			"7"
		end

	frozen no_current_date_default: SYSTEM_GLOBALIZATION_DATETIMESTYLES is
		external
			"IL enum signature :System.Globalization.DateTimeStyles use System.Globalization.DateTimeStyles"
		alias
			"8"
		end

	frozen allow_trailing_white: SYSTEM_GLOBALIZATION_DATETIMESTYLES is
		external
			"IL enum signature :System.Globalization.DateTimeStyles use System.Globalization.DateTimeStyles"
		alias
			"2"
		end

	frozen none: SYSTEM_GLOBALIZATION_DATETIMESTYLES is
		external
			"IL enum signature :System.Globalization.DateTimeStyles use System.Globalization.DateTimeStyles"
		alias
			"0"
		end

	frozen allow_inner_white: SYSTEM_GLOBALIZATION_DATETIMESTYLES is
		external
			"IL enum signature :System.Globalization.DateTimeStyles use System.Globalization.DateTimeStyles"
		alias
			"4"
		end

	frozen allow_leading_white: SYSTEM_GLOBALIZATION_DATETIMESTYLES is
		external
			"IL enum signature :System.Globalization.DateTimeStyles use System.Globalization.DateTimeStyles"
		alias
			"1"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_GLOBALIZATION_DATETIMESTYLES
