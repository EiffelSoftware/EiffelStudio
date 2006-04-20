indexing
	description: "[
		Objects that hold data about profile data as an intermediary step
		for subsequent building into an EV_GRID.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROFILE_QUERY_GRID_ROW
	
create {EB_PROFILE_QUERY_WINDOW, EB_PROFILE_QUERY_GRID_ROW} 
	make_parent,
	make_node
	
feature {NONE} -- Creation

	make_parent (lower_index, upper_index: INTEGER; a_text: STRING; a_profile_data: PROFILE_DATA; a_type: INTEGER) is
			-- Make as a parent node with attributes.
		require
			a_text_not_void: a_text /= Void
			profile_data_not_void: profile_data /= Void
			valid_type: a_type >= 1 and a_type <= 5
		do
			child_node_lower_index := lower_index
			child_node_upper_index := upper_index
			text := a_text
			profile_data := a_profile_data
			type := a_type
		end
		
	make_node (a_text: STRING; a_profile_data: PROFILE_DATA; a_type: INTEGER) is
			-- Make as a node with no subrows.
		require
			a_text_not_void: a_text /= Void
			profile_data_not_void: profile_data /= Void
			valid_type: a_type >= 1 and a_type <= 5
		do
			text := a_text
			profile_data := a_profile_data
			type := a_type
		end
		
feature {EB_PROFILE_QUERY_WINDOW, EB_PROFILE_QUERY_GRID_ROW}-- Access

	profile_data: PROFILE_DATA
		-- The profile data which `Current' is a representation of.

	child_node_lower_index: INTEGER
		-- For all parent nodes, this is an index of where the subrow index start in an external structure.
		-- Used externally to `Current' and may be set to any value as desired by the client.
	
	child_node_upper_index: INTEGER
		-- For all parent nodes, this is an index of where the subrow index ends in an external structure.
		-- Used externally to `Current' and may be set to any value as desired by the client.

	text: STRING
		-- Text displayed in first column of grid for `Current'.
		-- This may be Void if `type' is 4 as we have access to
		-- the cluster, class and feature texts individually.
	
	calls: INTEGER
		-- Total amount of calls to function.
		-- If `type' is 2 or 3 this is a cumulative value of all subrows.
	
	self: REAL
		-- Total amount of seconds spent in the function itself.
		-- If `type' is 2 or 3 this is a cumulative value of all subrows.
	
	descendents: REAL
		-- Total amount of seconds spent in the descendants of the function.
		-- If `type' is 2 or 3 this is a cumulative value of all subrows.
	
	total: REAL
		-- Total amount of seconds spent in the function.
		-- If `type' is 2 or 3 this is a cumulative value of all subrows.
	
	percentage: REAL
		-- Percentage of time spent in the function and the descendants.
		-- If `type' is 2 or 3 this is a cumulative value of all subrows.
	
	display_agent: PROCEDURE [ANY, TUPLE[]]
		-- An agent to display `Current' in a grid.
	
	feature_grid_item: EV_GRID_DRAWABLE_ITEM
		-- A grid representation of feature name for display in first column.
	
	calls_grid_item: EV_GRID_LABEL_ITEM
		-- A grid representation of `calls'.
	
	self_grid_item: EV_GRID_LABEL_ITEM
		-- A grid representation of `self'.
	
	descendents_grid_item: EV_GRID_LABEL_ITEM
		-- A grid representation of `descendents'.
	
	total_grid_item: EV_GRID_LABEL_ITEM
		-- A grid representation of `total'.
	
	percentage_grid_item: EV_GRID_LABEL_ITEM
		-- A grid representation of `percentage'.
	
	is_expanded: BOOLEAN
		-- Is grid representation of `Current' expanded?
		-- Required so that after changing modes we can restore the
		-- expanded state
	
	row: EV_GRID_ROW
		-- Grid row associated to `Current' while `Current' is displayed in a grid.
	
	type: INTEGER
		-- Type of row represented by `Current'. May be one
		-- of the following 5 types:
		-- 1. Feature
		-- 2. Class
		-- 3. Cluster
		-- 4. Cluster.Class.Feature
		-- 5. Other
		
	cluster_text, class_text, feature_text: STRING
		-- Three texts comprising the cluster, class and feature text to
		-- be displayed in the first column of a grid.
		-- Only used if `type' is 4.
	
	
	internal_cluster_text_width, internal_class_text_width, internal_feature_text_width, internal_text_width: INTEGER
		-- Internal values of string widths to enable buffered access.
	
	text_width: INTEGER is
			-- Width of `text' in pixels.
		do
			if internal_text_width = 0 then
				internal_text_width := drawing_font.string_width (text) + 2
			end
			Result := internal_text_width
		ensure
			result_non_negative: result >= 0
		end
	
	cluster_text_width: INTEGER is
			-- Width of `cluster_text' in pixels.
		do
			if internal_cluster_text_width = 0 then
				internal_cluster_text_width := drawing_font.string_width (cluster_text) + 2
			end
			Result := internal_cluster_text_width
		ensure
			result_non_negative: result >= 0
		end
		
	class_text_width: INTEGER is
			-- Width of `class_text' in pixels.
		do
			if internal_class_text_width = 0 then
				internal_class_text_width := drawing_font.string_width (class_text) + 2
			end
			Result := internal_class_text_width
		ensure
			result_non_negative: result >= 0
		end
		
	feature_text_width: INTEGER is
			-- Width of `feature_text' in pixels.
		do
			if internal_feature_text_width = 0 then
				internal_feature_text_width := drawing_font.string_width (feature_text) + 2
			end
			Result := internal_feature_text_width
		ensure
			result_non_negative: result >= 0
		end
		
	drawing_font: EV_FONT is
			-- Once access to Font used for drawing.
		once
			Result := (create {EV_LABEL}).font
		end
		
	is_feature_renamed: BOOLEAN is
			-- Is feature represented by `Current' renamed?
		local
			eiffel_profile_data: EIFFEL_PROFILE_DATA
			e_feature: E_FEATURE
		do
			eiffel_profile_data ?= profile_data
			if eiffel_profile_data /= Void then
				e_feature := eiffel_profile_data.function.e_feature
				Result := e_feature = Void
			end
		end
		
feature {EB_PROFILE_QUERY_WINDOW, EB_PROFILE_QUERY_GRID_ROW} -- Status setting

	set_row (a_row: EV_GRID_ROW) is
			-- Associated `a_row' with `Current'.
		require
			a_row_not_void: a_row /= Void
		do
			row := a_row
		ensure
			row_set: row = a_row
		end
		
	set_is_expanded (expanded_state: BOOLEAN) is
			-- Assign `expanded_state' to `is_expanded'.
		do
			is_expanded := expanded_state
		ensure
			expanded_state_set: is_expanded = expanded_state
		end

	set_cluster_class_feature_text (a_cluster, a_class, a_feature: STRING) is
			-- Assign `a_cluster', `a_class' and `a_feature' to `cluster_text',
			-- `class_text' and `feature_text'.
		require
			valid_type: type = 4
			a_cluster_not_void: a_cluster /= Void
			a_class_not_void: a_class /= Void
			a_feature_not_void: a_feature /= Void
		do
			cluster_text := a_cluster
			class_text := a_class
			feature_text := a_feature	
		ensure
			cluster_set: cluster_text = a_cluster
			class_set: class_text = a_class
			feature_set: feature_text = a_feature
		end

	set_grid_items (a_features_grid_item: EV_GRID_DRAWABLE_ITEM; a_calls_grid_item, a_self_grid_item, a_descendents_grid_item, a_total_grid_item, a_percentage_grid_item: EV_GRID_LABEL_ITEM) is
			-- Assign grid items to `Current' for retrieval later. This prevents us from having to constantly rebuild grid items as when rebuilding
			-- the grid, we can just query them. One or more of these passed grid items may be Void if the corresponding column is not displayed.
		do
			feature_grid_item := a_features_grid_item
				-- Assign `Current' to data of `feature_grid' to enable picking from an item in the grid.
				-- We will need to return to `Current' in order to determine the type of object being picked.
			feature_grid_item.set_data (Current)
			calls_grid_item := a_calls_grid_item
			self_grid_item := a_self_grid_item
			descendents_grid_item := a_descendents_grid_item
			total_grid_item := a_total_grid_item
			percentage_grid_item := a_percentage_grid_item
		end

	set_display_agent (a_display_agent: PROCEDURE [ANY, TUPLE[]]) is
			-- Assign `a_display_agent' to `Current'.
		require
			a_display_agent_not_void: a_display_agent /= Void
		do
			display_agent := a_display_agent
		ensure
			display_agent_set: display_agent = a_display_agent
		end

	set_upper (an_upper: INTEGER) is
			-- Assign `an_upper' to `child_node_upper_index'.
		do
			child_node_upper_index := an_upper
		ensure
			upper_set: child_node_upper_index = an_upper
		end
		
	set_values (a_calls: INTEGER a_self, a_descendents, a_total, a_percentage: REAL) is
			-- Assign `a_calls' to `calls', `a_self' to `self', `a_descendents' to `descendents',
			-- `a_total' to `total' and `a_percentage' to `percentage'.
		do
			calls := a_calls
			self := a_self
			descendents := a_descendents
			total := a_total
			percentage := a_percentage
		ensure
			values_set: calls = a_calls and self = a_self and total = a_total and
				descendents = a_descendents and percentage = a_percentage
		end
		
	increase_values (a_calls: INTEGER a_self, a_descendents, a_total, a_percentage: REAL) is
			-- Increase `calls' by `a_calls', `self' by `a_self', `descendents' by `a_descendents',
			-- `total' by `a_total' and `percentage' by `a_percentage'.
		do
			calls := calls + a_calls
			self := self + a_self
			descendents := descendents + a_descendents
			total := total + a_total
			percentage := percentage + a_percentage
		ensure
			values_increased: calls = old calls + a_calls and self = old self + a_self and total = old total + a_total and
				descendents = old descendents + a_descendents and percentage = old percentage + a_percentage
		end
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
