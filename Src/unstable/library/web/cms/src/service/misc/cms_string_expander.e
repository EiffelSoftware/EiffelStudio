note
	description: "[
			String expander facility for the CMS.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STRING_EXPANDER [G -> READABLE_STRING_GENERAL]

create
	make

feature {NONE} -- Initialization

	make
		do
			create values.make (3)
		end

feature -- Access

	values: STRING_TABLE [G]

	has_error: BOOLEAN
		do
			Result := attached error_handler as h and then h.has_error
		end

feature -- Element change

	force, put (new: G; key: READABLE_STRING_GENERAL)
		do
			values.force (new, key)
		end

feature -- Conversion

	expand_string (a_text: STRING_GENERAL)
		do
			if attached {STRING_32} a_text as t32 then
				expand_string_32 (t32)
			elseif attached {STRING_8} a_text as t8 then
				expand_string_8 (t8)
			else
				check known_string: False end
			end
		end

	expand_string_8 (a_text: STRING)
		local
			k, s: READABLE_STRING_8
			utf: UTF_CONVERTER
		do
				--| FIXME: implement better string expander.
			across
				values as ic
			loop
				if attached {READABLE_STRING_8} ic.item as v then
					s := v.to_string_8
				elseif attached ic.item as v then
					s := utf.utf_32_string_to_utf_8_string_8 (v)
				else
					s := ""
				end
				if attached {READABLE_STRING_8} ic.key as v then
					k := v
				else
					k := utf.utf_32_string_to_utf_8_string_8 (ic.key)
				end
				a_text.replace_substring_all ({STRING_8} "$" + k, s)
			end
		end

	expand_string_32 (a_text: STRING_32)
		local
			k, s: READABLE_STRING_32
		do
				--| FIXME: implement better string expander.
			across
				values as ic
			loop
				if attached ic.item as v then
					s := v.to_string_32
				else
					s := {STRING_32} ""
				end
				k := ic.key.to_string_32
				a_text.replace_substring_all ({STRING_32} "$" + k, s)
			end
		end

feature {NONE} -- Implementation

	reset_error
		do
			if attached error_handler as h then
				h.reset
			end
		end

	error_handler: detachable ERROR_HANDLER

	report_error (m: detachable READABLE_STRING_GENERAL)
		local
			h: like error_handler
		do
			h := error_handler
			if h = Void then
				create h.make
				error_handler := h
			end
			h.add_custom_error (-1, "string expander error", m)
		end

;note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
