indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "EiffelMethodFactory"

external class
	EIFFELMETHODFACTORY

inherit
	ANY
		redefine
			Finalize,
			GetHashCode,
			Equals,
			ToString
		end
	SYSTEM_ICOMPARABLE

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (Other: EIFFELMETHODFACTORY) is
		external
			"IL creator signature (EiffelMethodFactory) use EiffelMethodFactory"
		end

	frozen make (PolymorphID: INTEGER) is
		external
			"IL creator signature (System.Int32) use EiffelMethodFactory"
		end

	frozen make_1 (OtherIDs: SYSTEM_COLLECTIONS_ICOLLECTION) is
		external
			"IL creator signature (System.Collections.ICollection) use EiffelMethodFactory"
		end

feature -- Access

	frozen IsPolymorphic: BOOLEAN is
		external
			"IL signature (): System.Boolean use EiffelMethodFactory"
		alias
			"get_IsPolymorphic"
		end

feature -- Basic Operations

	CompareTo (obj: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use EiffelMethodFactory"
		alias
			"CompareTo"
		end

	GetHashCode: INTEGER is
		external
			"IL signature (): System.Int32 use EiffelMethodFactory"
		alias
			"GetHashCode"
		end

	ToString: STRING is
		external
			"IL signature (): System.String use EiffelMethodFactory"
		alias
			"ToString"
		end

	Equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use EiffelMethodFactory"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	Finalize is
		external
			"IL signature (): System.Void use EiffelMethodFactory"
		alias
			"Finalize"
		end

end -- class EIFFELMETHODFACTORY
