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

	EXCEP_CONST
		redefine
			default_create
		end

feature -- Init

	default_create is
		do
			set_handling_by_name_mode
		end

feature -- Access

	exception_handling_enabled: BOOLEAN

	ignoring_external_exception: BOOLEAN

	handling_mode_is_by_name: BOOLEAN is
		do
			Result := handling_mode = name_handling_mode
		end

	handling_mode_is_by_code: BOOLEAN is
		do
			Result := handling_mode = code_handling_mode
		end

	exception_catched_by_name (except_name: STRING): BOOLEAN is
		require
			handling_mode_is_by_name: handling_mode_is_by_name
			except_name_not_void: except_name /= Void
		local
			elt: TUPLE [INTEGER, STRING]
			en: STRING
			es: INTEGER
			wildcard_matcher: KMP_WILD
		do
			Result := True --| By default we stop on exception
			if exception_handling_enabled then
				if ignoring_external_exception then
					en := once "EiffelSoftware.Runtime.*" --EIFFEL_EXCEPTION"
					if has_wildcards (en) then
						create wildcard_matcher.make (en, except_name)
						Result := wildcard_matcher.pattern_matches
					else
						if en.is_equal (except_name.substring (1, en.count)) then
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
				if handled_exceptions_by_name.count > 0 then
					from
						create wildcard_matcher.make_empty
						wildcard_matcher.set_text (except_name)
						handled_exceptions_by_name.start
					until
						handled_exceptions_by_name.after
					loop
						elt := handled_exceptions_by_name.item
						en := exception_name_value_from (elt)
						es := exception_name_role_from (elt)
						check en.count > 1 end

						wildcard_matcher.set_pattern (en.substring (2, en.count))
						inspect
							es
						when role_continue then
							Result := Result and then (not wildcard_matcher.pattern_matches)
						when role_stop then
							Result := Result or else wildcard_matcher.pattern_matches
						else
							check item_disabled: es = role_disabled end
						end
						handled_exceptions_by_name.forth
					end
				end
			end
		end

	exception_catched_by_code (except_code: INTEGER): BOOLEAN is
		require
			handling_mode_is_by_code: handling_mode_is_by_code
			except_code_valid: True
		local
			es: INTEGER
		do
			Result := True --| By default we stop on exception			
			if exception_handling_enabled then
				if ignoring_external_exception then
					inspect
						except_code
					when
						external_exception,
						com_exception,
						Floating_point_exception,
						io_exception,
						no_more_memory,
						operating_system_exception,
						signal_exception
					then
						Result := True
					else
						Result := False
					end
				end
				if handled_exceptions_by_code.count > 0 then
					es := exception_role_for_code (except_code)
					inspect
						es
					when role_continue then
						Result := False
					when role_stop then
						Result := True
					else
						Result := True
					end
				end
			end
		end

	exception_role_for_code (c: INTEGER): INTEGER is
		require
			handling_mode_is_by_code: handling_mode_is_by_code
			except_code_valid: True
		do
			Result := role_stop
			if handled_exceptions_by_code.has (c) then
				Result := handled_exceptions_by_code.item (c)
			end
		end

feature -- Change

	set_handling_by_name_mode is
		require
			handled_exceptions_by_name_is_void: handled_exceptions_by_name = Void
		do
			create handled_exceptions_by_name.make (3)
			handling_mode := Name_handling_mode
			handled_exceptions_by_name.extend ([role_continue, "*"])
			handled_exceptions_by_name.extend ([role_stop, "EiffelSoftware.Runtime.*"])
		end

	set_handling_by_code_mode is
		require
			handled_exceptions_by_code_is_void: handled_exceptions_by_code = Void
		do
			create handled_exceptions_by_code.make (3)
			handling_mode := Code_handling_mode
--			handled_exceptions_by_code.extend ([role_continue, -1])
		end

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
			handled_exceptions_by_name.wipe_out
		end

	ignore_external_exceptions (v: BOOLEAN) is
		do
			ignoring_external_exception := v
			if ignoring_external_exception then
				enable_exception_handling
			end
		end

feature -- Change by name

	ignore_exception_by_name (s: STRING) is
		local
			ls: TUPLE [INTEGER, STRING]
		do
			handled_exceptions_by_name.prune_all ([role_disabled, s])
			handled_exceptions_by_name.prune_all ([role_stop, s])
			ls := [role_continue, s]
			handled_exceptions_by_name.prune_all (ls)
			handled_exceptions_by_name.extend (ls)
		end

	catch_exception_by_name (s: STRING) is
		local
			ls: TUPLE [INTEGER, STRING]
		do
			handled_exceptions_by_name.prune_all ([role_disabled, s])
			handled_exceptions_by_name.prune_all ([role_continue, s])
			ls := [role_stop, s]
			handled_exceptions_by_name.prune_all (ls)
			handled_exceptions_by_name.extend (ls)
		end

	disable_exception_by_name (s: STRING) is
		local
			ls: TUPLE [INTEGER, STRING]
		do
			handled_exceptions_by_name.prune_all ([role_continue, s])
			handled_exceptions_by_name.prune_all ([role_stop, s])
			ls := [role_disabled, s]
			handled_exceptions_by_name.prune_all (ls)
			handled_exceptions_by_name.extend (ls)
		end

feature -- Change by code

	ignore_exception_by_code (c: INTEGER) is
		require
			valid_code: valid_code (c) or c = 0
		do
			handled_exceptions_by_code.force (role_continue,c)
		end

	catch_exception_by_code (c: INTEGER) is
		require
			valid_code: valid_code (c) or c = 0
		do
			handled_exceptions_by_code.force (role_stop, c)
		end

--	disable_exception_by_code (c: INTEGER) is
--		require
--			valid_code: valid_code (c) or c = 0
--		do
--			handled_exceptions_by_code.force (role_disabled, c)
--		end

feature -- Data by exception name

	handled_exceptions_by_name: ARRAYED_LIST [TUPLE [INTEGER,STRING] ]

	exception_name_value_from (elt: TUPLE [INTEGER, STRING]): STRING is
		do
			Result ?= elt.item (2)
		end

	exception_name_role_from (elt: TUPLE [INTEGER, STRING]): INTEGER is
		do
			Result := elt.integer_item (1)
		end

feature -- Data by exception code

	handled_exceptions_by_code: DS_HASH_TABLE [INTEGER, INTEGER]

feature {ES_EXCEPTION_HANDLER_DIALOG} -- Implementation

	handling_mode: INTEGER

	Name_handling_mode: INTEGER is 1
	Code_handling_mode: INTEGER is 2

	Role_disabled: INTEGER is 0
	Role_continue: INTEGER is 1
	Role_stop: INTEGER is 2

	has_wildcards (item: STRING): BOOLEAN is
		do
			Result := (item.index_of ('*', 1) > 0) or else
					(item.index_of ('?', 1) > 0)
		end;

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
