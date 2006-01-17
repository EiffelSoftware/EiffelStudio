indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EXCEPTION_HANDLER
	
inherit
	ANY
		redefine
			default_create
		end
		
feature -- Init

	default_create is
		do
			create exceptions_handling.make (3)
			exceptions_handling.extend (Prefix_continue.out + "*")
			exceptions_handling.extend (Prefix_stop.out + "EiffelSoftware.Runtime.*")
		end
		
feature -- Access

	exception_handling_enabled: BOOLEAN
		
	enable_exception_handling is
		do
			exception_handling_enabled := True
		end
		
	disable_exception_handling is
		do
			exception_handling_enabled := False or ignoring_external_exception
		end

	wipe_out is
		do
			exceptions_handling.wipe_out
		end
		
	exception_catched (except_name: STRING): BOOLEAN is
		require
			except_name_not_void: except_name /= Void
		local
			es: STRING
			wildcard_matcher: KMP_WILD
		do
			if exception_handling_enabled then
				if ignoring_external_exception then
					es := once "EiffelSoftware.Runtime.*" --EIFFEL_EXCEPTION"
					if has_wildcards (es) then
						create wildcard_matcher.make (es, except_name)
						Result := wildcard_matcher.pattern_matches
					else
						if es.is_equal (except_name.substring (1, es.count)) then
							debug ("dbg_trace")
								print ("Catch exception : " + except_name + "%N")
							end
							Result := True
						else
							debug ("dbg_trace")
								print ("Ignore exception : " + except_name + "%N")
							end
							Result := False
						end
					end
				end
				if exceptions_handling.count > 0 then
					from
						create wildcard_matcher.make_empty
						wildcard_matcher.set_text (except_name)
						exceptions_handling.start
					until
						exceptions_handling.after
					loop
						es := exceptions_handling.item
						check es.count > 1 end
						
						wildcard_matcher.set_pattern (es.substring (2, es.count))
						inspect
							es.item (1)
						when Prefix_continue then
							Result := Result and then (not wildcard_matcher.pattern_matches)
						when Prefix_stop then
							Result := Result or else wildcard_matcher.pattern_matches
						else
							check item_disabled: es.item (1) = Prefix_disabled end
						end
						exceptions_handling.forth
					end
				end
			end
		end
		
	has_wildcards (item: STRING): BOOLEAN is
		do
			Result := (item.index_of ('*', 1) > 0) or else
					(item.index_of ('?', 1) > 0)
		end

	ignoring_external_exception: BOOLEAN
	
	ignore_external_exceptions (v: BOOLEAN) is
			-- 
		do
			ignoring_external_exception := v
			if ignoring_external_exception then
				enable_exception_handling
			end
		end

	exceptions_handling: ARRAYED_LIST [STRING]
	
	ignore_exception (s: STRING) is
		local
			ls: STRING
		do
			exceptions_handling.prune_all (Prefix_disabled.out + s)
			exceptions_handling.prune_all (Prefix_stop.out + s)
			ls := Prefix_continue.out + s
			exceptions_handling.prune_all (ls)
			exceptions_handling.extend (ls)
		end

	catch_exception (s: STRING) is
		local
			ls: STRING
		do
			exceptions_handling.prune_all (Prefix_disabled.out + s)
			exceptions_handling.prune_all (Prefix_continue.out + s)
			ls := Prefix_stop.out + s
			exceptions_handling.prune_all (ls)
			exceptions_handling.extend (ls)
		end

	disable_exception (s: STRING) is
		local
			ls: STRING
		do
			exceptions_handling.prune_all (Prefix_continue.out + s)
			exceptions_handling.prune_all (Prefix_stop.out + s)
			ls := Prefix_disabled.out + s
			exceptions_handling.prune_all (ls)
			exceptions_handling.extend (ls)
		end
		
feature {ES_EXCEPTION_HANDLER_DIALOG} -- Implementation

	Prefix_continue: CHARACTER is '-'
	Prefix_stop: CHARACTER is '+'
	Prefix_disabled: CHARACTER is '_';
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
