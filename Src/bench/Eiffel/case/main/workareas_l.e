indexing

	description: 
		"List of drawing areas. Collection of%
		%routines updating graphical entities.";
	date: "$Date$";
	revision: "$Revision $" 

-- List of drawing areas
-- Collection of routines updating graphical entities 

class WORKAREAS_L 

inherit

	LINKED_LIST [WORKAREA]
		rename
			wipe_out as ll_wipe_out,
			make as old_make
		end
	ONCES

creation

	make

feature -- Update

	make is
		do
			old_make
		--	!! bitmap_printer.make
		--	bitmap_printer.hide
		--	bitmap_printer.realize
		end

	wipe_out is
			-- Clean all workareas.
		do
			from
				start
			until
				after
			loop
			--	item.analysis_window.clear;
				forth
			end;
		end;

	selected_figures: LINKED_LIST[GRAPH_FORM] is
		-- Return the selected graphs.
		do
			!! Result.make
			from
				start
			until
				after
			loop
				Result.append(item.selected_figures)
				forth
			end
		ensure
			list_exists: Result /= Void
		end

	unselect_all is
		-- Unselect all the entities.
		do
			from
				start
			until
				after
			loop
				item.unselect_all
				forth
			end
		end

	set_insensitive(b: BOOLEAN) is
			-- Set items sensitive regarding the value of b.
		do
			from
				start
			until
				after
			loop
				item.scrollable_area.set_insensitive(b)
				forth
			end
		end

feature -- Window management

	graph_window (a_data: CLUSTER_DATA): MAIN_WINDOW is
			-- Graph window editing `a_data'
		require
			has_data: a_data /= Void
		do
			from
				start
			until
				after or else (Result /= Void)
			loop
				if (item.data = a_data) then
			--		Result := item.analysis_window;
				end;
				forth
			end;
		ensure
			found: Result /= Void
		end 

feature -- Class management

	new_class (a_class: CLASS_DATA) is
			-- Update workareas after the apparition of a new class
		require
			a_class /= void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.new_class (a_class);
				end;
				forth
			end
		end; -- new_class

	destroy_class (old_class: CLASS_DATA) is
			-- Update workareas after the suppression of an old class
		require
			old_class /= void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.destroy_class (old_class);
				end;
				forth
			end
		end -- destroy_class

feature -- Cluster management

	new_cluster (a_cluster: CLUSTER_DATA) is
			-- Update workareas after the apparition of a new cluster
		require
			a_cluster /= void
		do
			--Windows.set_watch_cursor;
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.new_cluster (a_cluster);
				end;
				forth
			end;
			--Windows.restore_cursor;
		end; -- new_cluster

	destroy_cluster (old_cluster: CLUSTER_DATA) is
			-- Update workareas after the suppression of an old cluster
		require
			old_cluster /= void
		do
		--	Windows.set_watch_cursor;
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.destroy_cluster (old_cluster);
				end;
				forth
			end;
		--	Windows.restore_cursor;
		end; -- destroy_cluster

	iconify_cluster (a_cluster: CLUSTER_DATA) is
			-- Update workareas after a cluster has been iconified.
		require
			a_cluster /= void
		do
--			Windows.set_watch_cursor;
--			from
--				start
--			until
--				after
--			loop
--				if item.data /= Void then
--					item.iconify_cluster (a_cluster);
--				end;
--				forth
			--end;
		--	Windows.restore_cursor;
		end; -- iconify_cluster

	uniconify_cluster (a_cluster: CLUSTER_DATA) is
			-- Update workareas after a cluster has been iconified.
		require
			a_cluster /= void
		do
--			Windows.set_watch_cursor;
--			from
--				start
--			until
--				after
--			loop
--				if item.data /= Void then
--					item.uniconify_cluster (a_cluster);
--				end;
--				forth
--			end;
--			Windows.restore_cursor;
		end; -- uniconify_cluster

feature -- Client-Supplier relation management

	new_reference, new_client (a_reference: CLI_SUP_DATA) is
			-- Update workareas after the apparition of a new client link
		require
			a_reference /= void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.new_reference (a_reference);
				end;
				forth
			end
		end; -- new_reference, new_client

	destroy_reference, destroy_client (old_reference: CLI_SUP_DATA) is
			-- Update workareas after the suppression of an old client link
		require
			old_reference /= void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.destroy_reference (old_reference);
				end;
				forth
			end
		end; -- destroy_reference, destroy_client

	new_reflexive (a_reference: CLI_SUP_DATA) is
			-- Update workareas after the apparition of a new reflexive link
		require
			a_reference /= Void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.new_reflexive (a_reference);
				end;
				forth
			end
		end; -- new_reflexive

	destroy_reflexive (old_reference: CLI_SUP_DATA) is
			-- Update workareas after the suppression of an old reflexive link
		require
			old_reference /= Void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.destroy_reflexive (old_reference);
				end;
				forth
			end
		end; -- destroy_reflexive

	new_aggregation, new_aggreg (an_aggregation: CLI_SUP_DATA) is
			-- Update workareas after the apparition of a new aggregation link
		require
			an_aggregation /= void;
			an_aggregation.is_aggregation
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.new_aggregation (an_aggregation);
				end;
				forth
			end
		end; -- new_aggregation, new_aggreg

	destroy_aggregation, destroy_aggreg (old_aggregation: CLI_SUP_DATA) is
			-- Update workareas after the suppression of an 
			-- old aggregation link
		require
			old_aggregation /= void;
			old_aggregation.is_aggregation
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.destroy_aggregation (old_aggregation);
				end;
				forth
			end
		end; -- destroy_aggregation, destroy_aggreg

	add_reverse_link (a_client_link: CLI_SUP_DATA) is
			-- Update workareas after the addition of a reverse link
			-- to 'a_client_link'
		require
			has_client_link: a_client_link /= Void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.add_reverse_link (a_client_link);
				end;
				forth
			end
		end; -- add_reverse_link

	remove_reverse_link (a_client_link: CLI_SUP_DATA) is
			-- Update workareas after the suppression of a reverse link
			-- to 'a_client_link'
		require
			has_client_link: a_client_link /= Void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.remove_reverse_link (a_client_link);
				end;
				forth
			end
		end; -- remove_reverse_link

	add_shared (a_client_link: CLI_SUP_DATA; reverse: BOOLEAN) is
			-- Update workareas after the addition of shared specification
			-- to 'a_client_link'
		require
			has_client_link: a_client_link /= Void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.add_shared (a_client_link, reverse);
				end;
				forth
			end
		end; -- add_shared

	remove_shared (a_client_link: CLI_SUP_DATA; reverse: BOOLEAN) is
			-- Update workareas after the suppression of
			-- the shared specification of 'a_client_link'
		require
			has_client_link: a_client_link /= Void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.remove_shared (a_client_link, reverse);
				end;
				forth
			end
		end; -- remove_shared

	add_multiplicity (a_client_link: CLI_SUP_DATA; reverse: BOOLEAN) is
			-- Update workareas after the addition of
			-- multiplicity specification to 'a_client_link'
		require
			has_client_link: a_client_link /= Void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.add_multiplicity (a_client_link, reverse);
				end;
				forth
			end
		end; -- add_multiplicity

	remove_multiplicity (a_client_link: CLI_SUP_DATA; reverse: BOOLEAN) is
			-- Update workareas after the suppression of
			-- the multiplicity specification of 'a_client_link'
		require
			has_client_link: a_client_link /= Void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.remove_multiplicity (a_client_link, reverse);
				end;
				forth
			end
		end; -- remove_multiplicity

	change_multiplicity (a_client_link: CLI_SUP_DATA; reverse: BOOLEAN) is
			-- Update workareas after the modification of multiplicity value
			-- of 'a_client_link'
		require
			has_client_link: a_client_link /= Void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.change_multiplicity (a_client_link, reverse);
				end;
				forth
			end
		end -- change_multiplicity


feature -- Inheritance relation management

	new_inherit (a_inherit: INHERIT_DATA) is
			-- Update workareas after the apparition of a new inherit link
		require
			a_inherit /= void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.new_inherit (a_inherit);
				end;
				forth
			end
		end; -- new_inherit

	destroy_inherit (old_inherit: INHERIT_DATA) is
			-- Update workareas after the suppression of an old inherit link
		require
			old_inherit /= void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.destroy_inherit (old_inherit);
				end;
				forth
			end
		end -- destroy_inherit


feature -- Links management

	change_label (a_link: RELATION_DATA; reverse: BOOLEAN) is
			-- Update workareas after the change of label's name
		require
			has_link: a_link /= Void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.change_label (a_link, reverse);
				end;
				forth
			end
		end; -- change_label

	change_label_position (a_link: RELATION_DATA; reverse: BOOLEAN) is
			-- Update workareas after the change of label's position
			-- of 'a_link' 
		require
			has_link: a_link /= Void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.change_label_position (a_link, reverse);
				end;
				forth
			end
		end; -- change_label_position

	change_label_orientation (a_link: RELATION_DATA; reverse: BOOLEAN) is
			-- Update workareas after the change of label's orientation
			-- of 'a_link' 
		require
			has_link: a_link /= Void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.change_label_orientation (a_link, reverse);
				end;
				forth
			end
		end -- change_label_orientation


feature -- Handles management

	move_handle (handle: HANDLE_DATA) is
			-- Display 'handle' in workareas according to the 'mode'
		require
			handle /= void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.move_handle (handle);
				end;
				forth
			end
		end; -- move_handle

feature -- Drawing

	refresh is
			-- Call refresh on workareas.
		do
			from
				start
			until
				after
			loop
				item.refresh;
				forth
			end
		end; -- refresh

	group_to_refresh (data_list: LINKED_LIST [DATA]) is
			-- Call group_to_refresh on workareas.
		do
			from
				start
			until
				after
			loop
				item.group_to_refresh (data_list)
				forth
			end
		end; -- group_to_refresh

	refresh_all is
			-- Call refresh_all on workareas.
		do
			from
				start
			until
				after
			loop
				item.refresh_all
				forth
			end
		end -- refresh_all

feature 

	update_drawing is
			-- Update all windows associated with workarea
		do
			from
				start
			until
				after 
			loop
				if item.data /= Void then
					item.set_cluster (item.data)	
				end;
				forth
			end
		end;

	active_workarea: WORKAREA is
			-- Active workarea (i.e. the one which contains the 
			-- active entity)
		do
			from
				start
			until
				after
			loop
				if item.active_entity /= Void then
					Result := item
					finish
				end
				forth
			end
		end;

	active_entity: GRAPH_FORM is
			-- Active entity (i.e. data being transported)
		do
			from
				start
			until
				after or else Result /= Void
			loop
				Result := item.active_entity
				forth
			end
		end;

feature -- Setting

	set_inheritance_visibility (b: BOOLEAN) is
		do
			from
				start
			until
				after
			loop
		--		item.analysis_window.set_inheritance_visibility (b)
				forth
			end
		end;

	set_aggreg_visibility (b: BOOLEAN) is
		do
			from
				start
			until
				after
			loop
			--	item.analysis_window.set_aggreg_visibility (b)
				forth
			end
		end;

	set_label_visibility (b: BOOLEAN) is
		do
			from
				start
			until
				after
			loop
			--	item.analysis_window.set_label_visibility (b)
				forth
			end
		end;

	set_client_visibility (b: BOOLEAN) is
		do
			from
				start
			until
				after
			loop
			--	item.analysis_window.set_client_visibility (b)
				forth
			end
		end;

feature {WORKAREA_MOVE_DATA_COM} -- Implementation

	setup_inverted_painter is
		do
			from
				start
			until
				after
			loop
				item.setup_inverted_painter;
				forth
			end
		end;

feature {NAME_DATA} -- Implementation

	update_title (data: CLUSTER_DATA) is
			-- Update workareas after a modification of a data's aspect
		require
			data /= void
		do
			from
				start
			until
				after
			loop
				if item.data = data then
			--		item.analysis_window.set_cluster_name (data.name);
				end;
				forth
			end
		end; -- change_data

feature {MOVE_CLUSTER_TAG_U} -- Implementation

	change_cluster_tag (data: CLUSTER_DATA) is
			-- Update workareas after a modification of a data's aspect
		require
			data /= void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.change_cluster_tag (data)
				end
				forth
			end
		end

feature -- Implementation

	change_data (data: DATA) is
			-- Update workareas after a modification of a data's aspect
		require
			data /= void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.change_data (data);
				end;
				forth
			end
		end;

	change_color_data (data: COLORABLE) is
			-- Update workareas after a modification of a data's color.
		require
			data /= void
		do
			from
				start
			until
				after
			loop
				if item.data /= Void then
					item.change_color_data (data);
				end;
				forth
			end
		end; -- change_data

feature {LINKABLE_DATA, DESTROY, ADD_ENTITY, MOVE_U} -- clearing

	clear (data: CLUSTER_DATA) is
			-- Clear all workareas currently editing `data'
		do
			from
				start
			until
				after
			loop
				if item.data = data then
			--		item.analysis_window.clear;
				end;
				forth
			end
		end -- refresh_all

	update_cluster_chart (data: CLUSTER_DATA; s_type: INTEGER) is
			-- Update all cluster currently editing `data'
		local
			c: CURSOR
		do
		--	Windows.set_watch_cursor;
		--	c := cursor;
		--	from
		--		start
		--	until
		--		after
		--	loop
		--	--	item.analysis_window.update_cluster_chart (s_type);
		--		forth
		--	end;
		--	go_to (c);
		--	Windows.restore_cursor;
		end -- refresh_all

feature -- printing out a bitmap

	--bitmap_printer : BITMAP_PRINTER

end -- class WORKAREAS_L
