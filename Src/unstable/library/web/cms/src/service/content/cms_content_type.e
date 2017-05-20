note
	description: "[
			Interface defining a CMS content type.
		]"
	status: "draft"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_CONTENT_TYPE

inherit
	CMS_API_ACCESS

feature -- Access

	name: READABLE_STRING_8
			-- Internal name.
		deferred
		end

	title: READABLE_STRING_32
			-- Human readable name.
		deferred
		end

	description: detachable READABLE_STRING_32
			-- Optional description
		deferred
		end

feature -- Access

	has_format (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is Current content type supporting format `a_name`?
		do
			Result := format (a_name) /= Void
		end

	available_formats: LIST [CONTENT_FORMAT]
			-- Available formats for Current type.
		deferred
		end

	format (a_name: READABLE_STRING_GENERAL): detachable CONTENT_FORMAT
			-- Format named `a_name', if available.
		do
			across
				available_formats as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not a_name.is_case_insensitive_equal (Result.name) then
					Result := Void
				end
			end
		end

feature -- Element change		

	extend_format (f: CONTENT_FORMAT)
			-- Add `f' to the list of `available_formats'
		require
			not_has_format: format (f.name) = Void
		do
			available_formats.extend (f)
		ensure
			format_added: format (f.name) /= Void
		end

	remove_format (f: CONTENT_FORMAT)
			-- Add `f' to the list of `available_formats'
		local
			lst: like available_formats
			l_name: READABLE_STRING_GENERAL
		do
			from
				l_name := f.name
				lst := available_formats
				lst.start
			until
				lst.after
			loop
				if l_name.is_case_insensitive_equal (lst.item.name) then
					lst.remove
				else
					lst.forth
				end
			end
		ensure
			format_removed: format (f.name) = Void
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
