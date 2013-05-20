class URI_CONTENTS_TYPES

create

	make


feature

	content_types: HASH_TABLE [STRING, STRING]

	extension (uri: STRING): STRING
			-- extract extendion from a URI
		local
			i: INTEGER
		do
			-- going from the end find the position of the "."
			from
				i := uri.count
			until
				i = 0 or else uri.item (i) = '.'
			loop
				i := i - 1
			end
			Result := uri.substring (i+1, uri.count)
		end

feature {NONE}

	make
		do
			create content_types.make (30)
			content_types.put ("text/html", "html")
			content_types.put ("text/html", "htm")
			content_types.put ("image/gif", "gif")
			content_types.put ("image/jpeg", "jpeg")
			content_types.put ("image/png", "jpg")
			content_types.put ("image/png", "png")
		end



feature -- Access: Encoding

	urlencode (s: STRING): STRING
			-- URL encode `s'
		do
			Result := s.string
			Result.replace_substring_all ("#", "%%23")
			Result.replace_substring_all (" ", "%%20")
			Result.replace_substring_all ("%T", "%%09")
			Result.replace_substring_all ("%N", "%%0A")
			Result.replace_substring_all ("/", "%%2F")
			Result.replace_substring_all ("&", "%%26")
			Result.replace_substring_all ("<", "%%3C")
			Result.replace_substring_all ("=", "%%3D")
			Result.replace_substring_all (">", "%%3E")
			Result.replace_substring_all ("%"", "%%22")
			Result.replace_substring_all ("%'", "%%27")
		end

	urldecode (s: STRING): STRING
			-- URL decode `s'
		do
			Result := s.string
			Result.replace_substring_all ("%%23", "#")
			Result.replace_substring_all ("%%20", " ")
			Result.replace_substring_all ("%%09", "%T")
			Result.replace_substring_all ("%%0A", "%N")
			Result.replace_substring_all ("%%2F", "/")
			Result.replace_substring_all ("%%26", "&")
			Result.replace_substring_all ("%%3C", "<")
			Result.replace_substring_all ("%%3D", "=")
			Result.replace_substring_all ("%%3E", ">")
			Result.replace_substring_all ("%%22", "%"")
			Result.replace_substring_all ("%%27", "%'")
		end

	stripslashes (s: STRING): STRING
		do
			Result := s.string
			Result.replace_substring_all ("\%"", "%"")
			Result.replace_substring_all ("\'", "'")
			Result.replace_substring_all ("\/", "/")
			Result.replace_substring_all ("\\", "\")
		end

note
	copyright: "2011-2011, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
