indexing
	description: "[
		Objects that represent an EiffelBuild constant. Note that `value' is only defined
		in descendents, as for an INTEGER constant, it is an expanded type, and we cannot
		define it as deferred here.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_CONSTANT
	
inherit
	GB_CONSTANTS
		export
			{NONE} all
		end
		
	GB_XML_UTILITIES
		export
			{NONE} all
		end
		
	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end

feature -- Access

	type: STRING is
			-- Type of `Current'.
		deferred
		end

	name: STRING
			-- Name of `Current'.
			
	value_as_string: STRING is
			-- Value represented by `Current' as a STRING.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	as_multi_column_list_row: EV_MULTI_COLUMN_LIST_ROW is
			-- Representation of `Current' as a multi column list row.
		deferred
		ensure
			Result_not_void: Result /= Void
			data_points_to_current: Result.data = Current
		end
		
	referers: ARRAYED_LIST [GB_CONSTANT_CONTEXT]
			-- All contexts in which `Current' is specified.

feature -- Element change

	set_name (a_name: STRING) is
			-- Assign  `name' to `a_name'.
		require
			a_name_ok: a_name /= Void and not a_name.is_empty
		do
			name := a_name
		ensure
			name_assigned: name = a_name
		end
		
	add_referer (referer: GB_CONSTANT_CONTEXT) is
			-- Add `referer' to `referers'.
		require
			referer_not_void: referer /= Void
		do
			referers.extend (referer)
		ensure
			has_referer: not referers.has (referer)
		end
	
	remove_referer (referer: GB_CONSTANT_CONTEXT) is
			-- Remove `referer' from `referers'.
		require
			referer_not_void: referer /= Void
		do
			referers.prune_all (referer)
		ensure
			not_has_referer: not referers.has (referer)
		end

feature -- Miscellaneous

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XM representation of `Current' in `element'.
		require
			element_not_void: element /= Void
		do
			add_element_containing_string (element, type_string, type)
			add_element_containing_string (element, constant_name_string, name)
			add_element_containing_string (element, Constant_value_string, value_as_string)
		end
		
invariant
	name_not_void: name /= Void
	type_not_void: type /= Void
	referers_not_void: referers /= Void

end -- class GB_CONSTANT
