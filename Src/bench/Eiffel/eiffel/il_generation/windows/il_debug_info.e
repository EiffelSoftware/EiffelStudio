indexing
	description: "Common information about System used by IL_DEBUG_INFO_XYZ objects"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_DEBUG_INFO

inherit
	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
		end

feature {SHARED_IL_DEBUG_INFO} -- Reset

	reset is
		do
			internal_class_types := Void
		end

feature -- Class info

	class_of_id (a_cls_id: INTEGER): CLASS_C is
			-- -- Class of id `a_cls_id'
		require
			a_cls_id_void: a_cls_id /= 0			
		do
			Result := System.class_of_id (a_cls_id)
		end
		
feature -- Class Types info

	class_types: ARRAY [CLASS_TYPE] is
			-- List all class types in system indexed using both `implementation_id' and
			-- `static_type_id'.
		local
			i, nb: INTEGER
			l_class_type: CLASS_TYPE
			l_class_types: ARRAY [CLASS_TYPE]
		do
			Result := internal_class_types
			if Result = Void then
					-- Collect all class types in system and initialize `internal_class_types'.
				from
					l_class_types := System.class_types
					i := l_class_types.lower
					nb := l_class_types.upper
					create Result.make (0, System.Static_type_id_counter.count)
				until
					i > nb
				loop
					l_class_type := l_class_types.item (i)
					if l_class_type /= Void then
						Result.put (l_class_type, l_class_type.static_type_id)
						Result.put (l_class_type, l_class_type.implementation_id)
					end
					i := i + 1
				end
				internal_class_types := Result
			end
		ensure
			class_types_not_void: Result /= Void
			class_types_not_empty: Result.count > 0
		end

feature {NONE} -- Class Types info Implementation

	internal_class_types: ARRAY [CLASS_TYPE]
			-- Array of CLASS_TYPE in system indexed by `implementation_id' and
			-- `static_type_id' of CLASS_TYPE.

end
