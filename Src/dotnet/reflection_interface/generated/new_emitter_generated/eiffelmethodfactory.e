indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "EiffelMethodFactory"

external class
	EIFFELMETHODFACTORY

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICOMPARABLE

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (other: EIFFELMETHODFACTORY) is
		external
			"IL creator signature (EiffelMethodFactory) use EiffelMethodFactory"
		end

	frozen make (polymorph_id: INTEGER) is
		external
			"IL creator signature (System.Int32) use EiffelMethodFactory"
		end

	frozen make_1 (other_ids: SYSTEM_COLLECTIONS_ICOLLECTION) is
		external
			"IL creator signature (System.Collections.ICollection) use EiffelMethodFactory"
		end

feature -- Access

	frozen is_polymorphic: BOOLEAN is
		external
			"IL signature (): System.Boolean use EiffelMethodFactory"
		alias
			"get_IsPolymorphic"
		end

feature -- Basic Operations

	compare_to (obj: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use EiffelMethodFactory"
		alias
			"CompareTo"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use EiffelMethodFactory"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use EiffelMethodFactory"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use EiffelMethodFactory"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use EiffelMethodFactory"
		alias
			"Finalize"
		end

end -- class EIFFELMETHODFACTORY
