note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEMPLATE_INSPECTOR

feature -- Change

	register (a_inspector_name: READABLE_STRING_8)
		do
			Template_routines.register_template_inspector (Current, a_inspector_name)
		end

	register_type (a_type: TYPE [detachable ANY])
		do
			register (a_type.name)
		end

	unregister
		do
			Template_routines.unregister_template_inspector (Current)
		end

feature {TEMPLATE_ROUTINES}

	internal_data (field_name: STRING; object: detachable ANY): detachable CELL [detachable ANY]
			-- Return object in a cell
			-- If not handled by this inspector, return Void
		deferred
		end

	cell_of (obj: detachable ANY): CELL [detachable ANY]
		do
			create Result.put (obj)
		end

feature -- Routine

	template_routines: TEMPLATE_ROUTINES
		once
			create Result
		end

note
	copyright: "2011-2013, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end -- class TEMPLATE_INSPECTOR
