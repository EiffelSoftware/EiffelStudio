indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	EXTERNAL_CALL_STACK_ELEMENT

inherit
	CALL_STACK_ELEMENT

create
	make

feature {NONE} -- Initialization

	make (level: INTEGER) is
		do
			level_in_stack := level
		end

feature -- Change

	set_info (a_oa: STRING; a_cn, a_fn: STRING; a_bi: INTEGER; a_extra: STRING) is
		require
			object_address_not_void: a_oa /= Void
			class_name_not_void: a_cn /= Void
			routine_name_not_void: a_fn /= Void
			break_index_positive: a_bi > 0
		do
			class_name := a_cn
			routine_name := a_fn
			break_index := a_bi
			object_address := a_oa
		end

feature -- Properties

	object_address: STRING

feature -- Output

	display_arguments (st: STRUCTURED_TEXT) is
			-- Display the arguments passed to the routine
			-- associated with Current call.
		do
		end

	display_locals (st: STRUCTURED_TEXT) is
			-- Display the local entities and result (if it exists) of 
			-- the routine associated with Current call.
		do
		end
		
	display_feature (st: STRUCTURED_TEXT) is
			-- Display information about associated routine.
		do
				-- Print object address (14 characters)
			st.add_string ("[")
			st.add_string (display_object_address)
			st.add_string ("] ")
			st.add_column_number (14)
				-- Print class name
			st.add_string (class_name)
			st.add_string (" ")
			st.add_column_number (26)

			st.add_string (routine_name)

			-- print line number
			st.add_string(" ( @ ")
			st.add_int(break_index)
			st.add_string(" )")
		end

	display_object_address: like object_address is
		do
			Result := object_address
		end

end -- class EIFFEL_CALL_STACK_ELEMENT
