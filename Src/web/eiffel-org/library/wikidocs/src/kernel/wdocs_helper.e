note
	description: "Summary description for {WDOCS_HELPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_HELPER

feature -- Helper

	normalization_enabled: BOOLEAN = True
			-- For now, normalization is disabled by default.

	normalized_fs_text (a_text: READABLE_STRING_GENERAL): STRING_32
			-- `a_text' converted to a normalized file system text.
			--| for instance a wiki name converted to safe filename.
			--| ex:  "foobar" -> "foobar"
			--| ex:  "foo bar" -> "foo_bar"
			--| ex:  "foo %T   bar" -> "foo_bar"
			--| ex:  "foo_bar" -> "foo_bar"	
		local
			i,n: INTEGER
		do
			if normalization_enabled then
					-- Replace any space with underscore
				create Result.make (a_text.count)
				from
					i := 1
					n := a_text.count
				until
					i > n
				loop
					if a_text[i].is_space then
						if i > 1 and then a_text[i] = '_' then
							-- already has a '_'
						else
							Result.append_character ('_')
						end
					elseif a_text[i] = ':' then
						if i > 1 and then a_text [i] = '-' then
							-- already has a '-'
						else
							Result.append_character ('-')
						end
					else
						Result.append_character (a_text[i])
					end
					i := i + 1
				end
			else
				create Result.make_from_string_general (a_text)
			end
		end

	normalized_fs_path (a_path: PATH): PATH
		require
			not_absolute: a_path.is_absolute
		do
			if normalization_enabled then
				create Result.make_from_string (normalized_fs_text (a_path.name))
			else
				Result := a_path
			end
		end


end
