indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "EiffelMethodFactory"

external class
	EIFFEL_METHOD_FACTORY

inherit
	ICOMPARABLE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (other: EIFFEL_METHOD_FACTORY) is
		external
			"IL creator signature (EiffelMethodFactory) use EiffelMethodFactory"
		end

	frozen make (polymorph_id: INTEGER) is
		external
			"IL creator signature (System.Int32) use EiffelMethodFactory"
		end

	frozen make_1 (other_ids: ICOLLECTION) is
		external
			"IL creator signature (System.Collections.ICollection) use EiffelMethodFactory"
		end

feature -- Access

	frozen get_is_polymorphic: BOOLEAN is
		external
			"IL signature (): System.Boolean use EiffelMethodFactory"
		alias
			"get_IsPolymorphic"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use EiffelMethodFactory"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use EiffelMethodFactory"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use EiffelMethodFactory"
		alias
			"Equals"
		end

	compare_to (obj: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use EiffelMethodFactory"
		alias
			"CompareTo"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use EiffelMethodFactory"
		alias
			"Finalize"
		end

end -- class EIFFEL_METHOD_FACTORY
