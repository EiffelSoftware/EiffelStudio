indexing

	description: 
		"Postscript header generator. Generate postscript arrays%
		%describing entities (class, cluster, relations)";
	date: "$Date$";
	revision: "$Revision $"

class PS_HEADER

inherit

	BASIC_ROUTINES
	ONCES
	CONSTANTS
	WARNING_CALLER

feature -- Tool to print with colors

	--translation_colors:COLOR_NAMES_WINDOWS

	rgb: EC_RGB_TRIPLE

feature -- Functionality responsible for knowing if the converter has a rotation stuff

	ok_action is 
		do
		end

	cancel_action is 
		do
		end


feature -- Output

	write_postscript_header (file: FILE; a_cluster: CLUSTER_DATA) is
			-- Write postscript header in `file' for `root_cluster'
		require
			has_file: file /= void;
			file_writable: file.is_open_write;
			has_root_cluster: a_cluster /= void
		do
--			!! translation_colors
--			if not System.generation_html then
--				file.putstring ("%%!%N");
--				file.putstring ("/Times-Bold findfont 20 scalefont setfont%N");
--				file.putstring ("28.34 794.42 moveto (Cluster: ");
--				file.putstring (a_cluster.name);
--				file.putstring (") show%N");
--			end
--			if a_cluster.width > a_cluster.height then
--				file.putstring ("28.34 28.34 translate 90 rotate%N");
--				if ((a_cluster.width) / (a_cluster.height) > 760/538)
--				then
--					file.putstring ("760 ");
--					file.putint (a_cluster.width)
--				else
--					file.putstring ("538.58 ");
--					file.putint (a_cluster.height)
--				end
--			else
--				file.putstring ("28.34 784.42 translate%N");
--				if ((a_cluster.height) / (a_cluster.width) > 760/538)
--				then
--					file.putstring ("760 ");
--					file.putint (a_cluster.height)
--				else
--					file.putstring ("538.58 ");
--					file.putint (a_cluster.width)
--				end
--			end;
--			file.putstring (" div dup scale%N");
--			root_cluster := a_cluster;
--			!!class_list.make;
--			!!cluster_list.make;
--			!!icon_list.make;
--			!!inherit_list.make;
--			!!refer_list.make;
--			!!aggreg_list.make;
--			add_cluster (root_cluster, void);
--			file.putstring ("/classes [%N");
--			from
--				class_list.start
--			until
--				class_list.after
--			loop
--				write_class (file, class_list.item);
--				class_list.forth
--			end;
--			file.putstring ("] def%N");
--			file.putstring ("/clusters [%N");
--			from
--				cluster_list.start
--			until
--				cluster_list.after
--			loop
--				if cluster_list.item.data /= root_cluster then
--					write_cluster (file, cluster_list.item)
--				end;
--				cluster_list.forth
--			end;
--			file.putstring ("] def%N");
--			file.putstring ("/icons [%N");
--			from
--				icon_list.start
--			until
--				icon_list.after
--			loop
--				write_icon (file, icon_list.item);
--				icon_list.forth
--			end;
--			file.putstring ("] def%N");
--			file.putstring ("/inherits [%N");
--			from
--				inherit_list.start
--			until
--				inherit_list.after
--			loop
--				write_inherit_link (file, inherit_list.item);
--				inherit_list.forth
--			end;
--			file.putstring ("]def%N");
--			file.putstring ("/clisups [%N");
--			from
--				refer_list.start
--			until
--				refer_list.after
--			loop
--				write_clisup_link (file, refer_list.item);
--				refer_list.forth
--			end;
--			from
--				aggreg_list.start
--			until
--				aggreg_list.after
--			loop
--				write_clisup_link (file, aggreg_list.item);
--				aggreg_list.forth
--			end;
--			file.putstring ("] def%N")
--			if System.generation_html and then
--				System.convert_has_a_rotate_function=0 and System.has_converter then
--					Windows.warning (Windows.main_graph_window, "Wac", "", Current )
--					System.set_convert_has_a_rotate_function ( 1 )
--			end	
		end; 

feature {NONE} -- Implementation properties

	class_list: LINKED_LIST [CLASS_DATA];

	cluster_list: PS_CLUSTER_LIST;

	icon_list: LINKED_LIST [CLUSTER_DATA];

	inherit_list: LINKED_LIST [INHERIT_DATA];

	refer_list: LINKED_LIST [CLI_SUP_DATA];

	aggreg_list: LINKED_LIST [CLI_SUP_DATA];
			-- Lists of entities to print

	root_cluster: CLUSTER_DATA
			-- Cluster printed

feature {NONE} -- Implementation

	write_class (file: FILE; a_class: CLASS_DATA) is
			-- Write PostScript description of `a_class'
		require
			has_file: file /= void;
			file_writable: file.is_open_write;
			class_exists: a_class /= void
		local
			ps_cluster: PS_CLUSTER
			a_color: EV_COLOR
			black_color : BOOLEAN
		do
--			black_color := FALSE
--			ps_cluster := cluster_list.find_cluster (a_class.parent_cluster);
--			check
--				parent_has_ps_cluster_associated: ps_cluster /= void
--			end;
--			file.putstring ("[(");
--			file.putstring (a_class.name);
--			file.putstring (") ");
--			file.putbool (a_class.is_persistent);
--			file.putstring (" ");
--			file.putbool (a_class.is_deferred);
--			file.putstring (" ");
--			file.putbool (a_class.is_interfaced);
--			file.putstring (" ");
--			file.putbool (a_class.is_effective);
--			file.putstring (" ");
--			file.putbool (a_class.is_root);
--			file.putstring (" ");
--			file.putbool (a_class.is_reused);
--			file.putstring (" (");
--			if not a_class.generics.empty then
--				file.putstring (a_class.generic_string_name)
--			end
--			file.putstring (") ");
--			file.putint (ps_cluster.x+a_class.x);
--			file.putstring (" ");
--			file.putint (-ps_cluster.y-a_class.y);
--		--Pascalf
--			--file.putstring (" 0 0]%N")
--			file.putstring(" 0 0 ") --louison
--			if a_class.color_name= Void then
--				a_class.set_color_name("LightSeaGreen")
--			else
--				if a_class.color_name.is_equal("White") or 
--					a_class.color_name.is_equal("white") then
--					black_color := TRUE
--				end
--			end
--			if black_color then
--				rgb := translation_colors.names.item ("black")
--			else
--				rgb := translation_colors.names.item (clone(a_class.color_name))
--			end
--			file.putreal((rgb.red)/255)
--			--file.put_string("0.5")
--			file.putstring(" ")
--			--file.put_string("0")
--			file.putreal((rgb.green)/255)
--			file.putstring(" ")
--			--file.put_string("0.5")
--			file.putreal((rgb.blue)/255)
--			file.putstring("]%N")
--			rescue
--				Windows.add_message("write_class of ps_header is bad",1)
--				Windows.add_message("more precisely, class:",1)
--				if a_class/= Void then
--					Windows.add_message(a_class.name,1)
--				else
--					Windows.add_message("class not defined ",1)
--			end
		--
		end; 

	write_cluster (file: FILE; a_cluster: PS_CLUSTER) is
			-- Write PostScript description of `a_cluster'.
		require
			has_file: file /= void;
			file_writable: file.is_open_write;
			cluster_exists: a_cluster /= void
		local
			a_color:EV_COLOR
		do
--			!!a_color.make;
--			file.putstring ("[(");
--			file.putstring (a_cluster.data.name);
--			file.putstring (") ");
--			file.putint (a_cluster.x);
--			file.putstring (" ");
--			file.putint (-a_cluster.y-a_cluster.data.height);
--			file.putstring (" ");
--			file.putint (a_cluster.data.width);
--			file.putstring (" ");
--			file.putint (a_cluster.data.height);
--			file.putstring (" ");
--			file.putbool (a_cluster.data.tag_is_south);
--			file.putstring (" ");
--			file.putint (a_cluster.data.tag_relative_x);
--			--file.putstring ("]%N")
--	-- Pascalf
--			file.putstring(" ")
--			if a_cluster.data.color_name= Void then
--				a_color.set_name("red")
--			else
--				a_color.set_name(clone(a_cluster.data.color_name))
--			end
--			rgb := translation_colors.names.item (clone(a_color.name))
--			file.putreal((rgb.red)/255)
--			file.put_string(" ")
--			file.putreal((rgb.green)/255)
--			file.putstring(" ")
--			file.putreal((rgb.blue)/255)
--			file.put_string("]%N")
	--		
--			rescue
--				Windows.add_message("write_cluster of ps_header",1)
--				Windows.add_message(a_cluster.data.name,1)
			end	

	write_icon (file: FILE; an_icon: CLUSTER_DATA) is
			-- Write PostScript description of `an_icon'.
		require
			has_file: file /= void;
			file_writable: file.is_open_write;
			icon_exists: an_icon /= void
		local
			ps_cluster: PS_CLUSTER
		do
--			ps_cluster := cluster_list.find_cluster (an_icon.parent_cluster);
--			check
--				parent_has_ps_cluster_associated: ps_cluster /= void
--			end;
--			file.putstring ("[(");
--			file.putstring (an_icon.name);
--			file.putstring (") ");
--			file.putint (an_icon.x+ps_cluster.x);
--			file.putstring (" ");
--			file.putint (-an_icon.y-ps_cluster.y);
--			file.putstring (" 0 0]%N")
--		rescue
--			Windows.add_message("write_icon of ps-header",1)
		end; 

	write_linkable_type (file: FILE; linkable: LINKABLE_DATA) is
		require
			file_exists: file /= void;
			file_writable: file.is_open_write;
			linkable_exists: linkable /= void
		local
			cluster: CLUSTER_DATA;
			a_class: CLASS_DATA;
			ps_cluster: PS_CLUSTER
			fi_error : BOOLEAN
		do
--			if not fi_error then
--			cluster ?= linkable;
--			if cluster /= void then
--				if cluster.is_icon then
--					file.putstring ("1 ");
--					file.putint (icon_list.index_of (cluster, 1) - 1)
--				else
--					ps_cluster := cluster_list.find_cluster (cluster);
--					file.putstring ("2 ");
--					file.putint (cluster_list.index_of (ps_cluster, 1) - 1)
--				end
--			else
--				a_class ?= linkable;
--				check
--					to_a_class_or_a_cluster: a_class /= void
--				end;
--				file.putstring ("0 ");
--				file.putint (class_list.index_of (a_class, 1) - 1)
--			end
--			else
--				Windows.error(Windows.main_graph_window, "E47", "")
--			end
--		rescue
--			if not fi_error then
--				fi_error := TRUE
--				Windows.add_message("link corrupted between",1)
--			end
		end;

	write_inherit_link (file: FILE; link: INHERIT_DATA) is
			-- Write PostScript description of inheritance `link'.
		require
			has_file: file /= void;
			file_writable: file.is_open_write;
			link_exists: link /= void;
			to_entity_is_visible:
					link.parent.visible_descendant_of (root_cluster);
			from_entity_is_visible:
					link.heir.visible_descendant_of (root_cluster)
		local
			ps_cluster: PS_CLUSTER
			fi_error : BOOLEAN
		do
--			if not fi_error then
--			file.putstring ("[");
--			write_linkable_type (file, link.heir);
--			file.putstring (" ");
--			write_linkable_type (file, link.parent);
--			file.putstring ("() [");
--			from
--				link.break_points.start
--			until
--				link.break_points.after
--			loop
--				ps_cluster := cluster_list.find_cluster
--					(link.break_points.item.parent_cluster);
--				check
--					has_parent_visible: ps_cluster /= void
--				end;
--				file.putint (ps_cluster.x+link.break_points.item.x);
--				file.putstring (" ");
--				file.putint (-ps_cluster.y-link.break_points.item.y);
--				file.putstring (" ");
--				link.break_points.forth
--			end;
--			file.putstring ("] 0 0");
--			file.putstring (" false false -1 -1 () false false -1 -1");
--			file.putstring (" false false false []");
--			file.putstring ("0 1 0") -- mettre ici des couleurs ... pascal
--			if link.color_name = Void then
--				rgb:= translation_colors.names.item("black")
--			else
--				rgb:=translation_colors.names.item(clone(link.color_name))
--			end
--			file.put_string(" ")
--			file.putreal((rgb.red)/255)
--			file.put_string(" ")
--			file.putreal((rgb.green)/255)
--			file.put_string(" ")
--			file.putreal((rgb.blue)/255)	
--			file.putstring ("]%N")
--			else
--				Windows.error(Windows.main_graph_window, "E47", "")
--			end
--		rescue
--			if not fi_error then
--				fi_error := TRUE
--				Windows.add_message("inherit link corrupted between",1)
--				retry
--			end

		end; 

	write_clisup_link (file: FILE; link: CLI_SUP_DATA) is
			-- Write PostScript description of `link'.
		require
			has_file: file /= void;
			file_writable: file.is_open_write;
			link_exists: link /= void;
			to_entity_is_visible:
				link.supplier.visible_descendant_of (root_cluster);
			from_entity_is_visible:
				link.client.visible_descendant_of (root_cluster)
		local
			ps_cluster: PS_CLUSTER;
			bp: LINKED_LIST [HANDLE_DATA]
			fi_error : BOOLEAN
		do
--			if not fi_error then
--			file.putstring ("[");
--			write_linkable_type (file, link.client);
--			file.putstring (" ");
--			write_linkable_type (file, link.supplier);
--			file.putstring (" (");
--			if not System.is_label_hidden then
--				file.putstring (link.label.output_value);
--			end;
--			file.putstring (") [");
--			from
--				bp := link.break_points;
--				bp.start
--			until
--				bp.after
--			loop
--				ps_cluster := cluster_list.find_cluster
--					(bp.item.parent_cluster);
--				check
--					has_parent_visible: ps_cluster /= void
--				end;
--				file.putint (ps_cluster.x+bp.item.x);
--				file.putstring (" ");
--				file.putint (-ps_cluster.y-bp.item.y);
--				file.putstring (" ");
--				bp.forth
--			end;
--			file.putstring ("] ");
--			if link.is_reverse_link then
--				if link.is_reverse_aggregation then
--					file.putint (2)
--				else
--					file.putint (1)
--				end
--			else
--				file.putint (0)
--			end;
--			file.putstring (" ");
--			if link.is_aggregation then
--				file.putint (2)
--			else
--				file.putint (1)
--			end;
--			if link.shared > 0 or link.reverse_shared > 0 then
--				file.putstring (" true ");
--				if link.shared > 0 and link.reverse_shared > 0 then
--					file.putstring ("true ");
--					file.putint (link.shared);
--					file.putstring (" ");
--					file.putint (link.reverse_shared)
--				else
--					if link.is_reverse_link then
--						file.putstring ("true ")
--					else
--						file.putstring ("false ")
--					end;
--					if link.shared > 0 then
--						file.putint (link.shared);
--						file.putstring (" -1")
--					else
--						file.putstring ("-1 ");
--						file.putint (link.reverse_shared)
--					end
--				end
--			else
--				file.putstring (" false false -1 -1")
--			end;
--			file.putstring (" ");
--			file.putstring ("(");
--			if not System.is_label_hidden and then 
--				link.reverse_label /= Void 
--			then
--				file.putstring (link.reverse_label.output_value);
--			end;
--			file.putstring (")");
--			-- Multiple
--			if link.multiplicity > 0 or link.reverse_multiplicity > 0 then
--				file.putstring (" true ");
--				if link.multiplicity > 0 and link.reverse_multiplicity > 0
--				then
--					file.putstring ("true ");
--					write_multiplicity (file, link.multiplicity)
--					file.put_character (' ')
--					write_multiplicity (file, link.reverse_multiplicity)
--				else
--					if link.is_reverse_link then
--						file.putstring ("true ")
--					else
--						file.putstring ("false ")
--					end;
--					if link.multiplicity > 0 then
--						write_multiplicity (file, link.multiplicity)
--						file.putstring (" -1")
--					else
--						file.putstring ("-1 ");
--						write_multiplicity (file, link.reverse_multiplicity)
--					end
--				end
--			else
--				file.putstring (" false false -1 -1")
--			end;
--			-- left position
--			if link.is_left_position or else
--				link.is_reflexive
--			then
--				file.putstring (" true ")
--			else
--				file.putstring (" false ")
--			end;
--			if link.is_reverse_left_position then
--				file.putstring ("true")
--			else
--				file.putstring ("false")
--			end;
--				-- Verticality of label
--			if link.is_vertical_text then
--				file.putstring (" true");
--				file.putstring (" [");
--				write_words (file, link.label.words);
--				file.putstring ("]")
--			else
--				file.putstring (" false []")
--			end;
--			if link.is_reverse_vertical_text then
--				file.putstring (" true");
--				file.putstring (" [");
--				write_words (file, link.reverse_label.words);
--				file.putstring ("]")
--			else
--				file.putstring (" false []")
--			end;
--			-- For label positioning
--			if link.is_reflexive then
--				file.putstring (" [-1 0 0 ");
--				file.putint (link.label.x_offset);
--				file.putchar (' ');
--				file.putint (link.label.y_offset);
--				file.putchar (']')
--			elseif not link.label.empty then
--				write_clisup_link_label (file, link, false);
--			else
--				file.put_string (" [0 0 0 0 0]")
--			end;
--			-- For reverse label positioning
--			if link.is_reverse_link and then
--				link.reverse_label /= Void
--			then
--				write_clisup_link_label (file, link, True);
--			else
--				file.put_string (" [0 0 0 0 0]")
--			end
---- Pascalf... colors
--			if link.color_name = Void
--				then link.set_color_name("black")
--			end
--			rgb := translation_colors.names.item (clone(link.color_name))
--			file.putstring(" ")
--			file.putreal((rgb.red)/255)
--			file.putstring(" ")
--			file.putreal((rgb.green)/255)
--			file.putstring(" ")
--			file.putreal((rgb.blue)/255)
--			file.putstring ("]%N")
--			else
--				Windows.error(Windows.main_graph_window, "E47", "")
--			end
--		rescue
--			if not fi_error then
--				fi_error := TRUE
--				Windows.add_message("cli_sup_link corrupted between",1)
--				retry
--			end
		end; 

	write_clisup_link_label (file: FILE; link: CLI_SUP_DATA; is_reverse: BOOLEAN) is
			-- Write PostScript label description of client `link'.
			-- `is_reverse' indicates reverse label.
		require
			has_file: file /= void;
			file_writable: file.is_open_write;
			link_exists: link /= void;
		local
			source, target: COORD_XY_DATA;
			ps_source_cluster, ps_target_cluster: PS_CLUSTER;
			from_h_nbr, to_h_nbr: INTEGER;
			source_x, source_y, target_x, target_y: INTEGER;
			source_center, target_center: EC_COORD_XY;
			label_x, label_y: INTEGER;
			rel_x, rel_y, x_offset, y_offset: INTEGER
			ratio: REAL;
			orientation: INTEGER;
			bp: LINKED_LIST [HANDLE_DATA];
			tmp_link: like link;
			cluster: CLUSTER_DATA;
			fi_error : BOOLEAN
		do
--			if not fi_error then
--			bp := link.break_points;
--			if is_reverse then
--				tmp_link := link.reverse_link;
--				from_h_nbr := link.reverse_from_handle_nbr;
--				to_h_nbr := link.reverse_to_handle_nbr;
--				x_offset := link.reverse_label.x_offset;
--				y_offset := link.reverse_label.y_offset;
--				ratio := link.reverse_label.from_ratio;
--			else
--				tmp_link := link
--				from_h_nbr := link.label.from_handle_nbr;
--				to_h_nbr := link.label.to_handle_nbr;
--				x_offset := link.label.x_offset;
--				y_offset := link.label.y_offset;
--				ratio := link.label.from_ratio;
--			end;
--			if bp.empty then
--				source := tmp_link.client;
--				target := tmp_link.supplier;
--			else
--				if is_reverse then
--					if to_h_nbr = 1 then
--						source := bp.i_th (1)
--						target := tmp_link.supplier
--					elseif from_h_nbr = bp.count + 2 then
--						source := tmp_link.client;
--						target := bp.last
--					else
--						source := bp.i_th (from_h_nbr - 1);
--						target := bp.i_th (to_h_nbr - 1)
--					end
--				elseif from_h_nbr = 1 then
--					source := tmp_link.client;
--					target := bp.i_th (1)
--				elseif to_h_nbr = bp.count + 2 then
--					source := bp.i_th (bp.count);
--					target := tmp_link.supplier
--				else
--					source := bp.i_th (from_h_nbr - 1);
--					target := bp.i_th (to_h_nbr - 1)
--				end
--			end;
--			ps_source_cluster := cluster_list.find_cluster (source.parent_cluster)
--			ps_target_cluster := cluster_list.find_cluster (target.parent_cluster)
--			source_center := source.relative_center (ps_source_cluster);
--			target_center := target.relative_center (ps_target_cluster);
--			cluster ?= source;
--			if cluster /= Void then
--				source_center := cluster.handle_to (ps_source_cluster, target_center)
--			end;
--			source_x := source_center.x;
--			source_y := source_center.y;
--			cluster ?= target;
--			if cluster /= Void then
--				target_center := cluster.handle_to (ps_target_cluster, source_center)
--			end;
--			target_x := target_center.x;
--			target_y := target_center.y;
--			rel_x := target_x - source_x;
--			rel_y := target_y - source_y;
--			label_x := source_x + (rel_x * ratio).truncated_to_integer;
--			label_y := source_y + (rel_y * ratio).truncated_to_integer;
--					-- Ordered as:
--					-- 4th / 1st
--					-- 3rd / 2nd (Quadrants
--			if (rel_x > 0) and (rel_y < 0) then
--					-- 1st quad
--				orientation := 2
--			elseif (rel_x > 0) and (rel_y > 0) then
--					-- 2nd quad
--				orientation := 4
--			elseif (rel_x < 0) and (rel_y > 0) then
--					-- 3rd quad
--				orientation := 6
--			elseif (rel_x < 0) and (rel_y < 0) then
--					-- 4th quad
--				orientation := 8
--			elseif (rel_x = 0) then
--					-- Vertical
--				if rel_y < 0 then
--					-- top side
--					orientation := 1
--				else
--					-- bottom side
--					orientation := 5
--				end
--			elseif (rel_y = 0) then
--				if rel_x > 0 then
--						-- right side
--					orientation := 3
--				else
--						-- left side
--					orientation := 7
--				end
--			end
--			file.putstring (" [");
--			file.putint (orientation);
--			file.putchar (' ');
--			file.putint (label_x);
--			file.putchar (' ');
--			file.putint (-label_y);
--			file.putchar (' ');
--			file.putint (x_offset);
--			file.putchar (' ');
--			file.putint (y_offset);
--			file.putchar (']');
--			else
--				Windows.error(Windows.main_graph_window, "E47", "")
--			end
--		rescue
--			if not fi_error then
--				fi_error := TRUE
--				Windows.add_message("label corrupted between",1)
--				retry
--			end

		end;

	write_multiplicity (file: FILE; multiplicity: INTEGER) is
			-- If `multiplicity' if ok, write it to `file',
			-- else write the "i" multiplicity for client links
		do
			if multiplicity <= Resources.Multiplicity_max_value then
				file.putint (multiplicity);
			else
				file.put_string ("(i)")
			end
		end

	write_words (file: FILE; link_label_words: LINKED_LIST [STRING]) is
		require
			has_words: link_label_words /= Void
		do
			if not System.is_label_hidden then
				from
					link_label_words.start
				until
					link_label_words.after
				loop
					file.putstring ("(");
					file.putstring (link_label_words.item);
					file.putstring (")");
					link_label_words.forth
				end
			end
		end; 

	add_inherit (linkable: LINKABLE_DATA; list: LIST [INHERIT_DATA]) is
			-- Add relations in `list' if it is visible.
			-- All these relations must be linked to `linkable'.
		require
			linkable_exists: linkable /= void;
			list_exists: list /= void;
		local
			inherit_data: INHERIT_DATA
		do
			if not System.is_inheritance_hidden then
				from
					list.start
				until
					list.after
				loop
					inherit_data := list.item;
					if System.show_all_relations or else
						not inherit_data.is_implementation and then
						inherit_data.is_visible
					then
						if inherit_data.parent /= Void then 
							-- Added by pascalf
						if inherit_data.heir = linkable then
							if inherit_data.parent.visible_descendant_of
											(root_cluster) 
							then
								inherit_list.put_front (inherit_data)
							end
						else
							check
								items_must_be_linked_to_linkable:
									list.item.parent = linkable
							end;
							if inherit_data.heir.visible_descendant_of
											(root_cluster)
							then
								inherit_list.put_front (inherit_data)
							end
						end
						end -- pascalf
					end
					list.forth
				end
			end
		end; -- add_inherit

	add_cli_sup (linkable: LINKABLE_DATA; list: LINKED_LIST [CLI_SUP_DATA]) is
			-- Add relations in `list' if it is visible.
			-- All these relations must be linked to `linkable'.
		require
			linkable_exists: linkable /= void;
			list_exists: list /= void
		local
			cli_sup: CLI_SUP_DATA
		do
			from
				list.start
			until
				list.after
			loop
				cli_sup := list.item;
				if System.show_all_relations or else
					not cli_sup.is_implementation and then
					cli_sup.is_visible
				then
					if cli_sup.client = linkable then
						if cli_sup.supplier /= Void then
							-- pascalf
						if cli_sup.supplier.visible_descendant_of 
								(root_cluster)
						then
							if cli_sup.is_aggregation then
								if not System.is_aggreg_hidden then
									aggreg_list.put_front (cli_sup)
								end;
							elseif not System.is_client_hidden then
								refer_list.put_front (cli_sup)
							end
						end
						end -- pascalf
					else
						check
							items_must_be_linked_to_linkable:
								cli_sup.supplier=linkable
						end;
						if cli_sup.client /= Void then
							-- Pascalf
						if cli_sup.client.visible_descendant_of
										(root_cluster)
						then
							if cli_sup.is_aggregation then
								if not System.is_aggreg_hidden then
									aggreg_list.put_front (cli_sup)
								end
							elseif  not System.is_client_hidden then
								refer_list.put_front (cli_sup)
							end
						end
						end -- pascalf
					end;
				end;
				list.forth
			end
		end; 

	add_cluster (cluster: CLUSTER_DATA; ps_cluster_parent: PS_CLUSTER) is
			-- Add `cluster' content in temporary lists.
		require
			cluster_exists: cluster /= void;
			only_root_cluster_as_no_parent:
				(ps_cluster_parent = void) = (cluster = root_cluster);
			ps_cluster_parent_is_same_parent:
				(ps_cluster_parent /= void) implies
					(ps_cluster_parent.data = cluster.parent_cluster)
		local
			classes: LINKED_LIST [CLASS_DATA]
			clusters: LINKED_LIST [CLUSTER_DATA]
			clust: CLUSTER_DATA
			c_lass: CLASS_DATA
			ps_cluster: PS_CLUSTER
		do
			if ps_cluster_parent /= void then
				!!ps_cluster.make (cluster, ps_cluster_parent.x+cluster.x,
						ps_cluster_parent.y+cluster.y)
			else
				check
					cluster_list.empty
				end;
				!!ps_cluster.make (cluster, 0, 0)
			end;
			cluster_list.put_front (ps_cluster);
			classes := cluster.classes;
			from
				classes.start
			until
				classes.after
			loop
				c_lass := classes.item;
				if not c_lass.is_hidden then
					class_list.put_front (c_lass);
					if c_lass.heir_links /= void then
						add_inherit (c_lass, c_lass.heir_links)
					end;
					if c_lass.client_links /= void then
						add_cli_sup (c_lass, c_lass.client_links)
					end;
				end;
				classes.forth
			end;
			classes := Void;
			clusters := cluster.clusters;
			from
				clusters.start
			until
				clusters.after
			loop
				clust := clusters.item;
				if not clust.is_hidden then
					if clust.is_icon then
						icon_list.put_front (clust)
					else
						add_cluster (clust, ps_cluster)
					end;
					if clust.heir_links /= void then
						add_inherit (clust, clust.heir_links)
					end;
					if clust.client_links /= void then
						add_cli_sup (clust, clust.client_links)
					end;
				end;
				clusters.forth
			end
		end 

end -- class PS_HEADER
