indexing
	description: "[
		Reads lists of recently accessed programs and URLs from the current user's
		profile in the system registry.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date       : "$Date$"
	revision   : "$Revision$"
	
frozen class
	RECENT

inherit
	SYSTEM_OBJECT

feature -- Query

	frozen typed_urls: NATIVE_ARRAY [SYSTEM_STRING] is
			-- Returns a string array containing the names of the URLs typed into the
			-- Internet Explorer address bar.
		local
			l_list: ARRAY_LIST
			l_key: REGISTRY_KEY
			l_value: SYSTEM_STRING
			l_res: INTEGER
			i: INTEGER
		do
			create l_list.make
			
				-- Registry keys are named url1, url2, etc.
			l_key := {REGISTRY}.current_user.open_sub_key ("Software\Microsoft\Internet Explorer\TypedURLs")
			if l_key /= Void then
				from
					i := 1
					l_value ?= l_key.get_value ("url1")
				until
					l_value = Void		
				loop
					l_res := l_list.add (l_value)
					l_value ?= l_key.get_value ("url" + i.out)
					i := i + 1
				end
			end
			Result ?= l_list.to_array ({SYSTEM_STRING})
		ensure
			result_not_void: Result /= Void
		end
		
	frozen run_mru: NATIVE_ARRAY [SYSTEM_STRING] is
			-- Returns a string array containing the programs that have been run using
			-- the Start Menu Run dialog.
		local
			l_list: ARRAY_LIST
			l_key: REGISTRY_KEY
			l_mru_list: SYSTEM_STRING
			l_len: INTEGER
			l_value: SYSTEM_STRING
			l_res: INTEGER
			c: CHARACTER
			i: INTEGER
		do
			create l_list.make
			
				
			l_key := {REGISTRY}.current_user .open_sub_key ("Software\Microsoft\Internet Explorer\RunMRU")
			if l_key /= Void then
				l_mru_list ?= l_key.get_value ("MRUList")
				if l_mru_list /= Void then
						-- MRUList contains an ordered set of letters, each one representing
						-- a key name in the current key that corresponds to a recent program
					l_len := l_mru_list.length
					from
						i := 0
					until
						i = l_len
					loop
						c := l_mru_list.chars (i)
						l_value ?= l_key.get_value (c.out)
						if l_value /= Void then
							if l_value.ends_with ("\1") and l_value.length > 2 then
								l_value := l_value.substring (1, l_value.length - 2)
							end
							l_res := l_list.add (l_value)
						end
						i := i + 1
					end
				end
			end
			Result ?= l_list.to_array ({SYSTEM_STRING})
		ensure
			result_not_void: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class RECENT
