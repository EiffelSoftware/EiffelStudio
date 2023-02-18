note
	description: "Recorder of type information for classes to be checked."

class
	CA_AST_TYPE_RECORDER

inherit
	SHARED_AST_CONTEXT

	SHARED_STATELESS_VISITOR

create
	make

feature {NONE} -- Initialization

	make
		do
			create node_types.make (100)
		end

feature -- AST Type Analysis

	clear
			-- Clears the recorded type information.
		do
			node_types.wipe_out
		end

	analyze_class (c: CLASS_C)
			-- Analyzes class `c` and records the type information of its AST nodes.
		do
				-- Setup context.
			prepare_for_class (c)
				-- Process all immediate features.
			across c.written_in_features as f loop
				internal_analyze_feature (f.associated_feature_i, c)
			end
				-- Process class invariant.
			if attached c.invariant_feature as f and then f.written_in = c.class_id then
				internal_analyze_feature (f, c)
			end
				-- Clean up context.
			tear_down_for_class (c)
		end

	type_of_node (a_node: AST_EIFFEL; a_written_class: CLASS_C; a_feature: FEATURE_I; a_class: CLASS_C): TYPE_A
			-- Retrieves the type of the AST node `a_node' written in class
			-- `a_written_class' when evaluated in a feature `a_feature' of class
			-- `a_class'.
		do
			Result := node_types [[a_node.index, a_written_class.class_id, a_feature.rout_id_set.first, a_class.class_id]]
		end

	node_types: HASH_TABLE [TYPE_A, TUPLE [node: INTEGER; written_class: INTEGER; feat: INTEGER; cl: INTEGER]]
		-- Type of the AST node `node' written in class
		-- `written_class' when evaluated in a feature `feature' of class
		-- `class'.

feature {NONE} -- Implementation

	prepare_for_class (c: CLASS_C)
			-- Initializes type check for class `c`.
		do
			context.initialize (c, c.actual_type)
			feature_checker.init (context)
			feature_checker.set_type_recorder (agent record_node_type)
		end

	tear_down_for_class (c: CLASS_C)
			-- Stop type checks for class `c'.
		do
			feature_checker.set_type_recorder (Void)
		end

	internal_analyze_feature (f: FEATURE_I; c: CLASS_C)
			-- Analyzes feature `f` from class `c`.
		do
			context.clear_feature_context
			context.initialize (c, c.actual_type)
			context.set_current_feature (f)
			context.set_written_class (f.written_class)
			if f.is_invariant then
				feature_checker.invariant_type_check (f, c.invariant_ast, False)
			else
				feature_checker.type_check_only (f, True, f.written_in /= c.class_id, f.is_replicated_directly)
			end
		end

feature {NONE} -- Implementation: Data Structures

	record_node_type (a_type: TYPE_A; a_node: detachable AST_EIFFEL; a_written_class: CLASS_C; a_feature: FEATURE_I; a_class: CLASS_C)
			-- Record type `a_type' of AST node `a_node' written in class `a_written_class'
			-- when evaluated in a feature `a_feature' of class `a_class'.
		do
			if a_node /= Void then
				node_types [[a_node.index, a_written_class.class_id, a_feature.rout_id_set.first, a_class.class_id]] := a_type
			end
		end

note
	ca_ignore: "CA011", "CA011: too many arguments"
	date: "$Date$"
	revision: "$Revision$"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	copyright:	"Copyright (c) 2018-2023, Eiffel Software"
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
