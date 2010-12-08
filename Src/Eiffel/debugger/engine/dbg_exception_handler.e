note
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

	DEBUGGER_STORABLE_DATA_I

create
	make_handling_by_name

feature -- Init

	make_handling_by_name
			-- Set handling based on exception type name
		do
			create enabled_handled_exceptions_by_name.make (3)
			create disabled_handled_exceptions_by_name.make (3)
			handled_exceptions_by_name.extend ([role_stop, "*"])
		end

feature -- Specific case

	catcall_console_warning_disabled: BOOLEAN assign set_catcall_console_warning_disabled
			-- Is catcall console warning disabled ?

	catcall_debugger_warning_disabled: BOOLEAN assign set_catcall_debugger_warning_disabled
			-- Is catcall debugger warning disabled ?			

feature -- Access

	enabled: BOOLEAN
			-- Handler enabled ?

	exception_catched_by_name (except_name: STRING): BOOLEAN
		require
			except_name_not_void: except_name /= Void
		local
			elt: TUPLE [role: INTEGER; name: STRING]
			en: STRING
			es: INTEGER
			wildcard_matcher: KMP_WILD
		do
			Result := True --| By default we stop on exception
			if enabled then
				if enabled_handled_exceptions_by_name.count > 0 then
					from
						create wildcard_matcher.make_empty
						wildcard_matcher.disable_case_sensitive
						wildcard_matcher.set_text (except_name)
						enabled_handled_exceptions_by_name.start
					until
						enabled_handled_exceptions_by_name.after
					loop
						elt := enabled_handled_exceptions_by_name.item
						en := elt.name
						es := elt.role
						check en.count > 1 end

						wildcard_matcher.set_pattern (en)
						inspect
							es
						when role_continue then
							Result := Result and then (not wildcard_matcher.pattern_matches)
						when role_stop then
							Result := Result or else wildcard_matcher.pattern_matches
						else
							check item_disabled: es = role_disabled end
						end
						enabled_handled_exceptions_by_name.forth
					end
				end
			end
		end

feature -- Change

	enable_exception_handling
			-- Enable handling
		do
			enabled := True
		end

	disable_exception_handling
			-- Disable handling	
		do
			enabled := False
		end

	set_catcall_console_warning_disabled (b: like catcall_console_warning_disabled)
			-- Set `catcall_console_warning_disabled' to `b'
		do
			catcall_console_warning_disabled := b
		end

	set_catcall_debugger_warning_disabled (b: like catcall_debugger_warning_disabled)
			-- Set `catcall_debugger_warning_disabled' to `b'
		do
			catcall_debugger_warning_disabled := b
		end

	wipe_out
			-- Clear filters
		do
			enabled_handled_exceptions_by_name.wipe_out
			disabled_handled_exceptions_by_name.wipe_out
		end

feature -- Change by name

	ignore_exception_by_name (s: STRING)
			-- Set exception type name `s' to be ignored
		local
			ls: TUPLE [INTEGER, STRING]
		do
			disabled_handled_exceptions_by_name.prune_all ([role_disabled, s])
			enabled_handled_exceptions_by_name.prune_all ([role_stop, s])
			ls := [role_continue, s]
			enabled_handled_exceptions_by_name.prune_all (ls)
			enabled_handled_exceptions_by_name.extend (ls)
		end

	catch_exception_by_name (s: STRING)
			-- Set exception type name `s' to be catched	
		local
			ls: TUPLE [INTEGER, STRING]
		do
			disabled_handled_exceptions_by_name.prune_all ([role_disabled, s])
			enabled_handled_exceptions_by_name.prune_all ([role_continue, s])
			ls := [role_stop, s]
			enabled_handled_exceptions_by_name.prune_all (ls)
			enabled_handled_exceptions_by_name.extend (ls)
		end

	disable_exception_by_name (s: STRING)
			-- Set exception type name `s' to be disabled (no operation)	
		local
			ls: TUPLE [INTEGER, STRING]
		do
			enabled_handled_exceptions_by_name.prune_all ([role_continue, s])
			enabled_handled_exceptions_by_name.prune_all ([role_stop, s])
			ls := [role_disabled, s]
			disabled_handled_exceptions_by_name.prune_all (ls)
			disabled_handled_exceptions_by_name.extend (ls)
		end

feature -- Data by exception name

	handled_exceptions_by_name: ARRAYED_LIST [TUPLE [role: INTEGER; name: STRING]]
			-- All handled exceptions cases.
		local
			lst1, lst2: like handled_exceptions_by_name
		do
			lst1 := enabled_handled_exceptions_by_name
			lst2 := disabled_handled_exceptions_by_name
			create Result.make (lst1.count + lst2.count)
			Result.append (lst1)
			Result.append (lst2)
		end

	enabled_handled_exceptions_by_name: like handled_exceptions_by_name
			-- Catched or Ignored exception cases.

	disabled_handled_exceptions_by_name: like handled_exceptions_by_name
			-- Disabled exception cases.

	external_exception_names: LIST [STRING]
		local
			api: DEBUGGER_COMPILER_UTILITIES
			lst: detachable LIST [STRING]
		do
			create api

			create {ARRAYED_LIST [STRING]} Result.make (14)
			Result.compare_objects
			Result.force ("MACHINE_EXCEPTION"); check {MACHINE_EXCEPTION} /= Void end
			lst := api.descendants_type_names_for ("MACHINE_EXCEPTION")
			if lst /= Void then
				Result.append (lst)
			end
			Result.force ("EIFFEL_RUNTIME_EXCEPTION"); check {EIFFEL_RUNTIME_EXCEPTION} /= Void end
			lst := api.descendants_type_names_for ("EIFFEL_RUNTIME_EXCEPTION")
			if lst /= Void then
				Result.append (lst)
			end
		ensure
			Result /= Void implies Result.object_comparison
		end

feature -- Constants

	Role_disabled: INTEGER = 0
	Role_continue: INTEGER = 1
	Role_stop: INTEGER = 2

	has_wildcards (item: STRING): BOOLEAN
		do
			Result := (item.index_of ('*', 1) > 0) or else
					(item.index_of ('?', 1) > 0)
		end;

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
