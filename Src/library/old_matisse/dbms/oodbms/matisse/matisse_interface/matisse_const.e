class MATISSE_CONST 

inherit

	MT_CONST_EXTERNAL

feature  -- Implementation Modes

	NO_MODE : INTEGER is 0
	VERSION_ACCESS : INTEGER is 3
	OPENED_TRANSACTION : INTEGER is 4
	NO_SELECTED_DATABASE: INTEGER is 2
	SELECTED_DATABASE: INTEGER is 1

feature -- Implementation - see Matisse.h 

	Mtmin_tran_priority : INTEGER is once Result := c_mtmin_tran_priority end
	Mtmax_tran_priority: INTEGER is once Result := c_mtmax_tran_priority end

	Mtread : INTEGER is once Result := c_mtread end
	Mtwrite : INTEGER is once Result := c_mtwrite end

	Mtdirect : INTEGER is once Result := c_mtdirect end
	Mtreverse : INTEGER is once Result := c_mtreverse end

	Mtascend : INTEGER is once Result := c_mtascend end
	Mtdescend : INTEGER is once Result := c_mtdescend end

	Mtnil : INTEGER is once Result := c_mtnil end
	Mts32 : INTEGER is once Result := c_mts32 end
	Mtdouble : INTEGER is once Result := c_mtdouble end
	Mtfloat : INTEGER is once Result := c_mtfloat end
	Mtchar : INTEGER is once Result := c_mtchar end
	Mtstring : INTEGER is once Result := c_mtstring end
	Mtasciichar : INTEGER is once Result := c_mtasciichar end
	Mtasciistring : INTEGER is once Result := c_mtasciistring end
	Mts32_list : INTEGER is once Result := c_mts32_list end
	Mtdouble_list : INTEGER is once Result := c_mtdouble_list end
	Mtfloat_list : INTEGER is once Result := c_mtfloat_list end
	Mtstring_list : INTEGER is once Result := c_mtstring_list end
	Mtasciistring_list : INTEGER is once Result := c_mtasciistring_list end
	Mts32_array : INTEGER is once Result := c_mts32_array end
Mtu8_array : INTEGER is once Result := c_mtu8_array end
	Mtdouble_array : INTEGER is once Result := c_mtdouble_array end
	Mtfloat_array : INTEGER is once Result := c_mtfloat_array end
	Mtstring_array : INTEGER is once Result := c_mtstring_array end
	Mtasciistring_array : INTEGER is once Result := c_mtasciistring_array end

-- FIXME: remove following when GENERAL.same_type fixed
Mtrelationship_type:INTEGER is -100

	-- Types not supported : MTU8_ARRAY, MTU16_ARRAY, MTS16_ARRAY 

	Matisse_success : INTEGER is once Result := c_matisse_success end

feature -- Implementation Queries

	Ocs : STRING is "a"  -- Class
	Oeps : STRING is "b" -- Entrypointname, attribute, class
	Ois : STRING is "c"  -- Index, Class, Direct|Reverse, array
	Oirs : STRING is "d" -- Object, Relationship
	Ooas : STRING is "e" -- Object
	Oors : STRING is "f" -- Object
	Ooirs : STRING is "g"-- Object
	Ors : STRING is "h"  -- Object, Attribute

	Class_map : STRING is "1"
	Object_map : STRING is "2"
	Attribute_map : STRING is "3"
	Index_map : STRING is "4"
	Array_map : STRING is "5"
	Name_map : STRING is "6"
	Direction_map : STRING is "7"
	Relationship_map : STRING is "8"
Index_crit_start_map:STRING is "9"
Index_crit_end_map:STRING is "10"

	root_class : MT_CLASS is once !!Result.make("Mt Class") end

feature -- Schema
	Relative_schema_name_seperator: STRING is "::"
			-- separator between class and attribute or relation name in 
			-- relative form of schema

end -- class MATISSE_CONST
