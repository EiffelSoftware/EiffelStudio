indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.ApartmentState"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	APARTMENT_STATE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen sta: APARTMENT_STATE is
		external
			"IL enum signature :System.Threading.ApartmentState use System.Threading.ApartmentState"
		alias
			"0"
		end

	frozen unknown: APARTMENT_STATE is
		external
			"IL enum signature :System.Threading.ApartmentState use System.Threading.ApartmentState"
		alias
			"2"
		end

	frozen mta: APARTMENT_STATE is
		external
			"IL enum signature :System.Threading.ApartmentState use System.Threading.ApartmentState"
		alias
			"1"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

	from_integer (a_value: INTEGER): like Current is
		do
			--Built-in
		end

	to_integer: INTEGER is
		do
			--Built-in
		end

end -- class APARTMENT_STATE
