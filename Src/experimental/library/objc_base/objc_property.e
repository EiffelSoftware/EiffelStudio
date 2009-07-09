note
	description: "Summary description for {OBJC_PROPERTY}."
	status: "Not completed"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_PROPERTY

create
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_ptr: POINTER)
			-- Initialize Current from an objective C objc_property_t `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			item := a_ptr
		ensure
			item_set: item = a_ptr
		end

feature -- Access

	name: STRING
			-- Name of current property
		require
			exists: exists
		local
			l_ptr: POINTER
		do
			l_ptr := {NS_OBJC_RUNTIME}.property_name (item)
			if l_ptr /= default_pointer then
				Result := (create {C_STRING}.make_shared_from_pointer (l_ptr)).string
			else
				Result := ""
			end
		end

	type: STRING
			-- Type of current property as an objective C encoding.
			-- Use `OBJC_TYPE_ENCODING' to decode type
		require
			exists: exists
		local
			l_attributes: like attributes
			l_attr: STRING
			l_result: detachable STRING
		do
			from
				l_attributes := attributes
				l_attributes.start
			until
				l_attributes.after
			loop
				l_attr := l_attributes.item
				if l_attr.count > 1 and then l_attr [1] = 'T' then
					l_result := l_attr.substring (2, l_attr.count)
				end
				l_attributes.forth
			end
			if l_result /= Void then
				Result := l_result
			else
				Result := "?"
			end
		end

	attributes: LIST [STRING]
			-- List of attributes for current property
		require
			exists: exists
		local
			l_ptr: POINTER
		do
			if attached internal_attributes as l_result then
				Result := l_result
			else
				l_ptr := {NS_OBJC_RUNTIME}.property_attributes (item)
				if l_ptr /= default_pointer then
					Result := (create {C_STRING}.make_shared_from_pointer (l_ptr)).string.split (',')
					Result.compare_objects
				else
					create {ARRAYED_LIST [STRING]} Result.make (0)
				end
			end
		end

feature -- Status Report

	exists: BOOLEAN
			-- Can current be used?
		do
			Result := item /= default_pointer
		end

	is_read_only: BOOLEAN
			-- Is Current a read only property?
		require
			exists: exists
		do
			Result := attributes.has ("R")
		end

feature {NONE} -- Implementation: Access

	item: POINTER
			-- Underlying Method pointer.

	internal_attributes: detachable LIST [STRING];
			-- Storage for `attributes'.

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
