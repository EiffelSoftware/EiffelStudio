indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "NewEiffelMethodFactory"

external class
	NEWEIFFELMETHODFACTORY

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

	frozen make_2 (Other: NEWEIFFELMETHODFACTORY) is
		external
			"IL creator signature (NewEiffelMethodFactory) use NewEiffelMethodFactory"
		end

	frozen make (PolymorphID: INTEGER) is
		external
			"IL creator signature (System.Int32) use NewEiffelMethodFactory"
		end

	frozen make_1 (OtherIDs: SYSTEM_COLLECTIONS_ICOLLECTION) is
		external
			"IL creator signature (System.Collections.ICollection) use NewEiffelMethodFactory"
		end

feature -- Access

	frozen IsPolymorphic: BOOLEAN is
		external
			"IL signature (): System.Boolean use NewEiffelMethodFactory"
		alias
			"get_IsPolymorphic"
		end

feature -- Basic Operations

	CompareTo (obj: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use NewEiffelMethodFactory"
		alias
			"CompareTo"
		end

	GetHashCode: INTEGER is
		external
			"IL signature (): System.Int32 use NewEiffelMethodFactory"
		alias
			"GetHashCode"
		end

	ToString: STRING is
		external
			"IL signature (): System.String use NewEiffelMethodFactory"
		alias
			"ToString"
		end

	Equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use NewEiffelMethodFactory"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	Finalize is
		external
			"IL signature (): System.Void use NewEiffelMethodFactory"
		alias
			"Finalize"
		end

end -- class NEWEIFFELMETHODFACTORY
