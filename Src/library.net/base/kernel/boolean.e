indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Boolean"

frozen expanded external class
	BOOLEAN

inherit
	SYSTEM_VALUETYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICOMPARABLE

feature -- Access

	frozen false_string: STRING is
		external
			"IL static_field signature :System.String use System.Boolean"
		alias
			"FalseString"
		end

	frozen true_string: STRING is
		external
			"IL static_field signature :System.String use System.Boolean"
		alias
			"TrueString"
		end

feature -- Basic Operations

	frozen parse (value: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Boolean"
		alias
			"Parse"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Boolean"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Boolean"
		alias
			"Equals"
		end

	frozen to_string_with_provider (provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.Boolean"
		alias
			"ToString"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Boolean"
		alias
			"ToString"
		end

	frozen get_type_code: INTEGER is
		external
			"IL signature (): enum System.TypeCode use System.Boolean"
		alias
			"GetTypeCode"
		ensure
			valid_type_code: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 8 or Result = 9 or Result = 10 or Result = 11 or Result = 12 or Result = 13 or Result = 14 or Result = 15 or Result = 16 or Result = 18
		end

	frozen compare_to (obj: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Boolean"
		alias
			"CompareTo"
		end

feature -- Eiffel Basic operations

	infix "and" (other: like Current): BOOLEAN is
			-- Boolean conjunction with `other'
		do
		end

	infix "and then" (other: like Current): BOOLEAN is
			-- Boolean semi-strict conjunction with `other'
		do
		end

	infix "implies" (other: like Current): BOOLEAN is
			-- Boolean implication of `other'
			-- (semi-strict)
		do
		end

	prefix "not" : like Current is
			-- Negation
		do
		end

	infix "or" (other: like Current): BOOLEAN is
			-- Boolean disjunction with `other'
		do
		end

	infix "or else" (other: like Current): BOOLEAN is
			-- Boolean semi-strict disjunction with `other'
		do
		end

	infix "xor" (other: like Current): BOOLEAN is
			-- Boolean exclusive or with `other'
		do
		end

end -- class BOOLEAN
