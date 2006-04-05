indexing
	description: "Common functionality for all views of ES_CLUSTERs"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_CLUSTER_FIGURE
	
inherit
	EG_RESIZABLE_CLUSTER_FIGURE
		redefine
			default_create,
			initialize,
			model,
			world,
			on_linkable_add,
			on_handle_start,
			on_handle_end,
			recycle
		end
		
	EB_CONSTANTS
		undefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create an CLUSTER_FIGURE.
		do
			Precursor {EG_RESIZABLE_CLUSTER_FIGURE}
			
			set_accept_cursor (cursors.cur_cluster)
			set_deny_cursor (cursors.cur_x_cluster)
			
			start_actions.extend (agent save_position)
			end_actions.extend (agent extend_history)
			move_actions.extend (agent on_move)
		end
		
	initialize is
			-- Initialize `Current' with `model'.
		do
			Precursor {EG_RESIZABLE_CLUSTER_FIGURE}
			pebble_function := agent on_pebble_request
			model.needed_on_diagram_changed_actions.extend (agent on_needed_on_diagram_changed)
		end

feature -- Status report

	is_iconified: BOOLEAN
			-- Is `Current' iconified.
		
feature -- Access

	model: ES_CLUSTER
			-- Model for `Current'.
			
	world: EIFFEL_WORLD is
			-- World `Current' is part of.
		do
			Result ?= Precursor {EG_RESIZABLE_CLUSTER_FIGURE}
		end
		
feature -- Element change

	recycle is
			-- Free `Current's resources.
		do
			Precursor {EG_RESIZABLE_CLUSTER_FIGURE}
			start_actions.prune_all (agent save_position)
			end_actions.prune_all (agent extend_history)
			move_actions.prune_all (agent on_move)
			if model /= Void then
				model.needed_on_diagram_changed_actions.prune_all (agent on_needed_on_diagram_changed)
			end
		end
		
		
	apply_right_angles is
			-- Apply right angles to all links in `links' and all elements in `Current'.
		local
			l_item: EIFFEL_LINK_FIGURE
			l_links: like links
			i, nb: INTEGER
			clu: EIFFEL_CLUSTER_FIGURE
			cla: EIFFEL_CLASS_FIGURE
		do
			from
				l_links := links
				i := 1
				nb := l_links.count
			until
				i > nb
			loop
				l_item ?= l_links.i_th (i)
				if l_item /= Void then
					l_item.apply_right_angles
				end
				i := i + 1
			end
			from
				start
			until
				after
			loop
				clu ?= item
				if clu /= Void then
					clu.apply_right_angles
				else
					cla ?= item
					if cla /= Void then
						cla.apply_right_angles
					end
				end
				forth
			end
		end

feature {EG_LAYOUT} -- Layouting

	set_to_minimum_size is
			-- Set `Current's to `minimum_size'.
		deferred
		end
		
feature {EIFFEL_WORLD} -- Show/Hide

	disable_shown is
			-- Hide `Current'.
		deferred
		ensure
			set: not is_shown
		end
		
	enable_shown is
			-- Show `Current'.
		deferred
		ensure
			set: is_shown
		end
		
	is_shown: BOOLEAN
			-- Is `Current' shown?
		
feature {EIFFEL_CLUSTER_FIGURE} -- Expand/Collapse

	collapse is
			-- Hide all elements in `Current' and minimize `Current'.
		local
			linkable_figure: EG_LINKABLE_FIGURE
			cluster_figure: EIFFEL_CLUSTER_FIGURE
			l_links: ARRAYED_LIST [EG_LINK_FIGURE]
			l_item: EG_LINK_FIGURE
			i, nb: INTEGER
		do
			from
				start
			until
				after
			loop
				linkable_figure ?= item			
				if linkable_figure /= Void then
					if linkable_figure.is_show_requested then
						linkable_figure.hide
						linkable_figure.disable_sensitive
						from
							l_links := linkable_figure.links
							i := 1
							nb := l_links.count
						until
							i > nb
						loop
							l_item := l_links.i_th (i)
							l_item.hide
							l_item.disable_sensitive
							i := i + 1
						end
						cluster_figure ?= linkable_figure
						if cluster_figure /= Void and then not cluster_figure.is_iconified then
							cluster_figure.collapse
						end
					end
				end
				forth
			end
			resizer_top_left.disable_sensitive
			resizer_top_right.disable_sensitive
			resizer_bottom_right.disable_sensitive
			resizer_bottom_left.disable_sensitive
		end
		
	expand is
			-- Show all not iconified elements in `Current'.
		local
			linkable_figure: EG_LINKABLE_FIGURE
			l_other: EG_LINKABLE_FIGURE
			l_link: EG_LINK_FIGURE
			cluster_figure: EIFFEL_CLUSTER_FIGURE
			e_item: ES_ITEM
			l_links: ARRAYED_LIST [EG_LINK_FIGURE]
			i, nb: INTEGER
		do
			from
				start
			until
				after
			loop
				linkable_figure ?= item
				if linkable_figure /= Void then
					e_item ?= linkable_figure.model
					if e_item = Void or else e_item.is_needed_on_diagram then
						linkable_figure.show
						linkable_figure.enable_sensitive
						from
							l_links := linkable_figure.links
							i := 1
							nb := l_links.count
						until
							i > nb
						loop
							l_link := l_links.i_th (i)
							if l_link.source = linkable_figure then
								l_other := l_link.target
							else
								l_other := l_link.source
							end
							if l_other.is_show_requested  then
								l_link.show
								l_link.enable_sensitive
							end
							i := i + 1
						end
						cluster_figure ?= linkable_figure
						if cluster_figure /= Void and then not cluster_figure.is_iconified then
							cluster_figure.expand
						end
					end
				end
				forth
			end
			resizer_top_left.enable_sensitive
			resizer_top_right.enable_sensitive
			resizer_bottom_right.enable_sensitive
			resizer_bottom_left.enable_sensitive
		end
		
feature {NONE} -- Implementation

	on_needed_on_diagram_changed is
			-- `model'.`is_needed_on_diagram' changed.
		do
			if model.is_needed_on_diagram then
				show
				enable_sensitive
			else
				hide
				disable_sensitive
			end
			request_update
		end

	save_position is
			-- Make a backup of current coordinates.
		do
			saved_x := port_x
			saved_y := port_y
			
		end
		
	saved_x, saved_y: INTEGER
			-- Saved positions.
			
	on_move (ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Cluster is moving.
		do
			world.context_editor.restart_force_directed
			if world.is_right_angles then
				apply_right_angles
			end
		end

	extend_history is
			-- Register move in the history.
		local
			ce: EB_CONTEXT_EDITOR
		do
			ce := world.context_editor
			world.context_editor.history.do_named_undoable (
					interface_names.t_Diagram_move_cluster_cmd (model.name),
					[<<agent set_port_position (port_x, port_y), agent ce.restart_force_directed>>],
					[<<agent set_port_position (saved_x, saved_y), agent ce.restart_force_directed>>])
			if world.context_editor.is_force_directed_used then
				set_is_fixed (True)
			end
		end
		
	on_linkable_add (a_linkable: EG_LINKABLE) is
			-- `a_linkable' was added to the cluster.
		local
			l_world: like world
			linkable_fig: EG_LINKABLE_FIGURE
			link_fig: EG_LINK_FIGURE
			scsc: EG_CLUSTER_FIGURE
			e_item: ES_ITEM
			cs_link: EIFFEL_CLIENT_SUPPLIER_FIGURE
			i_link: EIFFEL_INHERITANCE_FIGURE
			c_fig: EG_LINKABLE_FIGURE
		do
			l_world := world
			if l_world /= Void then
				linkable_fig ?= l_world.items_to_figure_lookup_table.item (a_linkable)
				check
					linkable_fig_is_in_view_but_not_in_cluster: linkable_fig /= Void not has (linkable_fig)
				end
				extend (linkable_fig)
				linkable_fig.set_cluster (Current)
				
				from
					l_world.links.start
				until
					l_world.links.after
				loop
					link_fig := l_world.links.item
					if link_fig.source /= Void and then link_fig.target /= Void then
						e_item ?= link_fig.model
						if e_item = Void or else e_item.is_needed_on_diagram then
							scsc := world.smallest_common_supercluster (link_fig.source, link_fig.target)
							if scsc /= Void and then not scsc.has (link_fig) then
								scsc.go_i_th (scsc.number_of_figures)
								cs_link ?= link_fig
								if cs_link /= Void or else scsc.index = scsc.count then
									scsc.put_right (link_fig)
								else
									from
										i_link := Void
										c_fig := Void
									until
										i_link /= Void or else c_fig /= Void
									loop
										scsc.forth
										i_link ?= scsc.item
										c_fig ?= scsc.item
									end
									scsc.put_left (link_fig)
								end
							end
						end
					end
					l_world.links.forth
				end
			end
			request_update
		end
		
	on_handle_start is
			-- User started to move `Current'.
		do
			was_fixed := is_fixed
			if world.context_editor.is_force_directed_used then
				set_is_fixed (True)
			end
		end
		
	on_handle_end is
			-- User ended to move `Current'.
		do
			set_is_fixed (was_fixed)
		end

	update_links is
			-- Update all links in `Current'.
		local
			i, nb: INTEGER
			l_link: EG_LINK_FIGURE
		do
			from
				i := 1
			until
				i > nb
			loop
				l_link ?= i_th (i)
				if l_link /= Void then
					l_link.update
				end
				i := i + 1
			end
		end
		
	on_pebble_request: CLUSTER_STONE is
			-- Pebble request.
		do
			if model /= Void then
				create Result.make (model.cluster_i)
			end
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

end -- class EIFFEL_CLUSTER_FIGURE
