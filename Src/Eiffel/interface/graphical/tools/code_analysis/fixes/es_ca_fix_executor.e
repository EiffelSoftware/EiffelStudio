note
	description: "Refactoring that fixes a rule violation that has been found by the Code Analysis tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CA_FIX_EXECUTOR

inherit

	ERF_CLASS_TEXT_MODIFICATION
		rename
			make as make_refactoring
		end

	ES_FIX
		rename
			make as make_fix
		redefine
			item
		end

	EB_SHARED_WINDOW_MANAGER
		undefine
			is_equal,
			copy
		end

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	make (f: attached CA_FIX)
			-- Initializes `Current' with fix `a_fix' to apply and with GUI grid
			-- row `a_row' (will be painted green when fix has been applied).
		require
			is_class_writable: not f.source_class.is_read_only
			fix_not_yet_applied: not f.applied
		do
			make_fix (f)
				-- Call initialization of {ERF_CLASS_TEXT_MODIFICATION}.
			make_refactoring (item.class_to_change.original_class)
		end

feature {NONE} -- Implementation

	item: CA_FIX
			-- The fix to apply.

feature -- Fixing

	apply_to (m: ES_CLASS_TEXT_AST_MODIFIER)
			-- <Precursor>
		do
			-- TODO: provide impementation.
		end

    apply
			-- Attempt to apply the fix.
        do
        		-- Only continue fixing when there are no unsaved files.
        	if window_manager.has_modified_windows then
        		prompts.show_info_prompt ("You may not apply a fix when there are unsaved changes.", Void, Void)
        	else
        		window_manager.display_message ("Fixing rule violation...")

        		eiffel_project.quick_melt (True, True, True)
        			-- The compilation must be successful before the fix.
        		if eiffel_project.successful then
					prepare
					check
						text_managed: text_managed
					end
					compute_ast
					if not is_parse_error then
						item.setup (ast, match_list, False, true)
						item.process_ast_node (ast)
						item.process_all_break_as
					end
					rebuild_text
					logger.refactoring_class (class_i)
		        	commit

						-- Mark the fix as applied so that it may not be applied a second time. Then
						-- color the rule violation entry in the GUI.
					item.set_applied (True)

		        		-- Now compile again, which in all cases should succeed.
		        	eiffel_project.quick_melt (True, True, True)

		        	window_manager.display_message (
		        		if eiffel_project.successful then
		        			"Fixing rule violation succeeded."
		        		else
		        			"Fixing rule violation failed."
		        		end)
		        else
		        	prompts.show_info_prompt ("Fix could not be applied due to failed compilation.", Void, Void)
		        end
	        end
        end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
