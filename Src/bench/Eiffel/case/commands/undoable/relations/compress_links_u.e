indexing

	description: 
		"Undoable command that compresses links for a cluster.";
	date: "$Date$";
	revision: "$Revision $"

class COMPRESS_LINKS_U

inherit

	UNDOABLE_EFC

creation

	make

feature -- Initilization

	make (clust: CLUSTER_DATA; is_def: BOOLEAN) is
			-- Compress links in cluster
		require
			valid_cluster: clust /= void;
		local
			cli_sup: CLI_SUP_DATA
			comp_heir: COMP_INHERIT_DATA
			comp_client: COMP_CLI_SUP_DATA
			to_inherit_comp: COMP_INHERIT_DATA
			inherit_data: INHERIT_DATA
		do
			is_system_defined := is_def
			!! comp_heir_list.make
			comp_heir_list.compare_objects
			!! comp_client_list.make
			comp_client_list.compare_objects
			cluster := clust
			client_list := cluster.recursive_cli_sup_links	
			from
				client_list.start
			until
				client_list.after
			loop
				cli_sup := client_list.item
				if cli_sup.is_in_compressed_link or else
					cli_sup.contains_linkable (cluster) 
				then
					client_list.remove
				else
					if cluster.contains_linkable (cli_sup.client) then
						!! comp_client.make_ref (cluster, 
									cli_sup.supplier)
					else
						!! comp_client.make_ref (cli_sup.client, 
									cluster)
					end;
					comp_client_list.start
					comp_client_list.search (comp_client)
					if comp_client_list.after then
						comp_client_list.extend (comp_client)
					else
						comp_client := comp_client_list.item
					end
					comp_client.add_relation (cli_sup.key)
						-- (Above sets is_in_compress_link to true)
						-- We have not determine whether it will
						-- be in the link.
					cli_sup.set_is_in_compressed_link (False)
					client_list.forth
				end
			end;
			heir_list := cluster.recursive_inherit_links	
			from
				heir_list.start
			until
				heir_list.after
			loop
				inherit_data := heir_list.item
				if inherit_data.is_in_compressed_link or else
					inherit_data.contains_linkable (cluster) 
				then
					heir_list.remove
				else
					if cluster.contains_linkable (inherit_data.heir) then
						!! comp_heir.make (cluster, 
									inherit_data.parent)
					else
						!! comp_heir.make (inherit_data.heir, 
									cluster)
					end
					comp_heir_list.start
					comp_heir_list.search (comp_heir)
					if comp_heir_list.after then
						comp_heir_list.extend (comp_heir)
					else
						comp_heir := comp_heir_list.item
					end
					comp_heir.add_relation (inherit_data.key)
						-- (Above sets is_in_compress_link to true)
						-- We have not determine whether it will
						-- be in the link.
					inherit_data.set_is_in_compressed_link (False)
					heir_list.forth
				end
			end;
			filter_compressed_lists;
			if not comp_client_list.empty or else 
				not comp_heir_list.empty or else
				not client_list.empty or else
				not heir_list.empty 
			then
				if not is_system_defined then
					set_watch_cursor;
					record;
					redo;
					restore_cursor;
				end;
			end;
		end

feature -- Property

	name: STRING is 
		do
			Result := "Compress links"
		end

feature -- Update

	update is
		do
			workareas.refresh;
			System.set_is_modified
		end; -- update

	redo is
			-- Re-execute command (after it was undone).
		do
			compress_client_links;
			compress_heir_links;
			if not is_system_defined then
				update
			end
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			uncompress_client_links;
			uncompress_heir_links;
			if not is_system_defined then
				update
			end;
		end; -- undo

feature {NONE} -- Implementation

	uncompress_client_links is
		local
			comp_cli_sup: COMP_CLI_SUP_DATA;
			cli_sup: CLI_SUP_DATA
		do
			from
				comp_client_list.start
			until
				comp_client_list.after
			loop
				comp_cli_sup := comp_client_list.item;
				comp_cli_sup.remove_relation_from_system;
				workareas.destroy_reference (comp_cli_sup);
				comp_cli_sup.set_is_system_defined (False);
				from
					comp_cli_sup.start
				until
					comp_cli_sup.after
				loop
					cli_sup := comp_cli_sup.item.data;
					cli_sup.set_is_in_compressed_link (False);
					workareas.change_data (cli_sup);
					comp_cli_sup.forth
				end;
				comp_client_list.forth
			end;
			from
				client_list.start
			until
				client_list.after
			loop
				cli_sup := client_list.item;
				cli_sup.set_is_system_defined (False);
				if cluster.contains_linkable (cli_sup.client) then
					comp_cli_sup ?= cluster.client_link_of 
							(cli_sup.supplier)
				else
					comp_cli_sup ?= cli_sup.client.client_link_of 
						(cluster)
					if comp_cli_sup = Void then
						comp_cli_sup ?= cluster.client_link_of (cli_sup.client);
						if comp_cli_sup /= Void and then not comp_cli_sup.is_reverse_link then
							comp_cli_sup := Void
						end;
					end;
				end;
				if comp_cli_sup /= Void then
					comp_cli_sup.remove_relation (cli_sup);
					workareas.change_data (cli_sup);
					comp_cli_sup.update_editor;
				end;
				client_list.forth
			end;
		end;

	uncompress_heir_links is
		local
			comp_heir: COMP_INHERIT_DATA;
			inh: INHERIT_DATA
		do
			from
				comp_heir_list.start
			until
				comp_heir_list.after
			loop
				comp_heir := comp_heir_list.item;
				comp_heir.remove_relation_from_system;
				comp_heir.set_is_system_defined (False);
				workareas.destroy_inherit (comp_heir);
				from
					comp_heir.start
				until
					comp_heir.after
				loop
					inh := comp_heir.item.data;
					inh.set_is_in_compressed_link (False);
					workareas.change_data (inh);
					comp_heir.forth
				end;
				comp_heir_list.forth
			end;
			from
				heir_list.start
			until
				heir_list.after
			loop
				inh := heir_list.item;
				inh.set_is_system_defined (False);
				workareas.change_data (inh);
				if cluster.contains_linkable (inh.heir) then
					comp_heir ?= cluster.heir_link_of 
							(inh.parent)
				else
					comp_heir ?= inh.heir.heir_link_of 
							(cluster)
				end;
				comp_heir.remove_relation (inh);
				comp_heir.update_editor;
				heir_list.forth
			end;
		end;

	compress_client_links is
		local
			comp_cli_sup: COMP_CLI_SUP_DATA;
			cli_sup: CLI_SUP_DATA
		do
			from
				comp_client_list.start
			until
				comp_client_list.after
			loop
				comp_cli_sup := comp_client_list.item;
				comp_cli_sup.put_relation_in_system;
				comp_cli_sup.set_is_system_defined (is_system_defined);
				workareas.change_data (comp_cli_sup);
				from
					comp_cli_sup.start
				until
					comp_cli_sup.after
				loop
					cli_sup := comp_cli_sup.item.data;
						-- Now set `is_in_compressd_lin' to True.
					cli_sup.set_is_in_compressed_link (True);
					if cli_sup.is_aggregation then
						workareas.destroy_aggreg (cli_sup)
					else
						workareas.destroy_reference (cli_sup)
					end;
					comp_cli_sup.forth
				end;
				comp_client_list.forth
			end;
			from
				client_list.start
			until
				client_list.after
			loop
				cli_sup := client_list.item;
				cli_sup.set_is_system_defined (is_system_defined);
				if cli_sup.is_aggregation then
					workareas.destroy_aggreg (cli_sup)
				else
					workareas.destroy_reference (cli_sup)
				end;
				if cluster.contains_linkable (cli_sup.client) then
					comp_cli_sup ?= cluster.client_link_of 
							(cli_sup.supplier)
				else
					comp_cli_sup ?= cli_sup.client.client_link_of 
							(cluster)
					if comp_cli_sup = Void then
						comp_cli_sup ?= cluster.client_link_of (cli_sup.client);
						if comp_cli_sup /= Void and then not comp_cli_sup.is_reverse_link then
							comp_cli_sup := Void
						end;
					end;
				end;
debug ("COMPRESS_LINKS_U")
	io.error.putstring ("compress client link: cluster = ");
	io.error.putstring (cluster.name);
	io.error.putstring (", cli_sup.client = ");
	io.error.putstring (cli_sup.client.name);
	io.error.putstring (", cli_sup.supplier = ");
	io.error.putstring (cli_sup.supplier.name);
	io.error.new_line;
end
				if comp_cli_sup /= Void then
					comp_cli_sup.add_relation (cli_sup.key);
					comp_cli_sup.update_editor;
				end;
				client_list.forth
			end;
		end;

	compress_heir_links is
		local
			comp_inherit: COMP_INHERIT_DATA;
			inh: INHERIT_DATA
		do
			from
				comp_heir_list.start
			until
				comp_heir_list.after
			loop
				comp_inherit := comp_heir_list.item;
				comp_inherit.put_relation_in_system;
				comp_inherit.set_is_system_defined (is_system_defined);
				workareas.change_data (comp_inherit);
				from
					comp_inherit.start
				until
					comp_inherit.after
				loop
					inh := comp_inherit.item.data;
						-- Now set `is_in_compressd_lin' to True.
					inh.set_is_in_compressed_link (True);
					workareas.destroy_inherit (inh);
					comp_inherit.forth
				end;
				comp_heir_list.forth
			end;
			from
				heir_list.start
			until
				heir_list.after
			loop
				inh := heir_list.item;
				inh.set_is_system_defined (is_system_defined);
				workareas.destroy_inherit (inh);
				if cluster.contains_linkable (inh.heir) then
					comp_inherit ?= cluster.heir_link_of (inh.parent)
				else
					comp_inherit ?= inh.heir.heir_link_of (cluster)
				end;
				comp_inherit.add_relation (inh.key);
				comp_inherit.update_editor;
				heir_list.forth
			end;
		end;

feature {NONE} -- Implementation

	cluster: CLUSTER_DATA;

	comp_heir_list: LINKED_LIST [COMP_INHERIT_DATA];

	comp_client_list: LINKED_LIST [COMP_CLI_SUP_DATA];

	client_list: LINKED_LIST [CLI_SUP_DATA];

	heir_list: LINKED_LIST [INHERIT_DATA];

	is_system_defined: BOOLEAN

feature {NONE}

	filter_compressed_lists is
			-- Filter compressed list by removing compressed links
			-- that already exists in the system
		local
			comp_cli_sup: COMP_CLI_SUP_DATA;
			comp_heir: COMP_INHERIT_DATA;
			cli_sup: CLI_SUP_DATA;
			inh: INHERIT_DATA
		do
			client_list.wipe_out;
			from
				comp_client_list.start
			until
				comp_client_list.after
			loop
				comp_cli_sup := comp_client_list.item;
				if comp_cli_sup.already_in_system then
						-- This is already defined in the 
						-- system.
					from
						comp_cli_sup.start
					until
						comp_cli_sup.after
					loop
						cli_sup := comp_cli_sup.item.data;
							-- If a compressed link has already been
							-- made then skip it
						if not (cli_sup.is_compressed and then
							cli_sup.client = comp_cli_sup.client and then
							cli_sup.supplier = comp_cli_sup.supplier)
						then
							cli_sup.set_is_in_compressed_link (False);
							client_list.put_front (cli_sup);
						end;
						comp_cli_sup.forth
					end;
					comp_client_list.remove
				else
					comp_client_list.forth
				end;
			end
			heir_list.wipe_out;
			from
				comp_heir_list.start
			until
				comp_heir_list.after
			loop
				comp_heir := comp_heir_list.item;
				if comp_heir.already_in_system then
					from
						comp_heir.start
					until
						comp_heir.after
					loop
						inh := comp_heir.item.data;
						if not (inh.is_compressed and then
							inh.heir = comp_heir.heir and then
							inh.parent = comp_heir.parent)
						then
							inh.set_is_in_compressed_link (False);
							heir_list.put_front (inh);
						end;
						comp_heir.forth
					end;
					comp_heir_list.remove
				else
					comp_heir_list.forth
				end;
			end
		end;

end -- class COMPRESS_LINKS_U
