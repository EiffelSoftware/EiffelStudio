indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	DYNAMIC_LIB_EXPORT_FEATURE

creation
	make
	
feature -- Initialization

	make (ec:CLASS_C; ecr:E_FEATURE; ef:E_FEATURE)  is
		do
			dl_class ?= ec
			dl_creation := ecr
			dl_routine := ef
			dl_index := 0

		end

feature -- Attributes

	dl_class : CLASS_C
	dl_creation: E_FEATURE
	dl_routine: E_FEATURE
	dl_index: INTEGER

feature -- Access.

	dl_routine_id: INTEGER is
		do
			Result := dl_routine.id
		end

feature -- Changes.

	set_dl_class (c:CLASS_C) is
		do
			dl_class ?= c
		end

	set_dl_creation (c:E_FEATURE) is
		do
			dl_creation := c
		end

	set_dl_routine (c:E_FEATURE) is
		do
			dl_routine := c
		end

	set_dl_index (c:INTEGER) is
		do
			dl_index := c
		end

end -- class DLL_EXPORT_FEATURE
