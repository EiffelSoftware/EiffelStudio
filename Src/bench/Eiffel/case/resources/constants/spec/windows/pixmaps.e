indexing



	description:	"Pixmaps used to build EiffelCase interface.";
	date: "$Date$";
	revision: "$Revision$"


class PIXMAPS

inherit

	ONCES

	CONSTANTS



feature -- Access

	check_validity_pixmaps is
		do
		end			
			
	abstract_entity_pixmap: EV_PIXMAP is
			-- Pixmap representing an abstract class hole
		once
			Result := read_pixmap ("abst_ent.bmp")
		end

    add_attr_clone: EV_PIXMAP is
            -- Pixmap representing an addition of an attribute(clone)
        once
            Result := read_pixmap ("add_attr_clone.bmp")
        end
    
    add_func_clone: EV_PIXMAP is
            -- Pixmap representing an addition of an attribute(clone)
        once
            Result := read_pixmap ("add_func_clone.bmp")
        end
    
    add_com_clone: EV_PIXMAP is
            -- Pixmap representing an addition of an attribute(clone)
        once
            Result := read_pixmap ("add_com_clone.bmp")
        end
	

	aggreg_pixmap:EV_PIXMAP is
			-- Pixmap representing an aggregation relationship creation
		once
			Result := read_pixmap ("aggreg.bmp")
		end

	apply_pixmap: EV_PIXMAP is
			-- Pixmap representing the apply function (ok tick)
		once
			Result := read_pixmap ("apply.bmp")
		end

	arrow_bottom: EV_PIXMAP is
			-- Pixmap representing an go to bottom arrow
		once
			Result := read_pixmap ("lastclass.bmp")
		end

	arrow_down: EV_PIXMAP is
			-- Pixmap representing an go down arrow
		once
			Result := read_pixmap ("nextclass.bmp")
		end

	arrow_top: EV_PIXMAP is
			-- Pixmap representing an go to top arrow
		once
			Result := read_pixmap ("firstclass.bmp")
		end 

	arrow_up: EV_PIXMAP is
			-- Pixmap representing an go up arrow
		once
			Result := read_pixmap ("previousclass.bmp")
		end

	chart_pixmap: EV_PIXMAP is
			-- Pixmap representing a class chart
		once
			Result := read_pixmap ("chart.bmp")
		end -- chart_pixmap

	choose_whole_left_text: EV_PIXMAP is
			-- Pixmap representing a left text and 
			-- a cancel cross on its right side
		once
			Result := read_pixmap ("lefttxt.bmp")
		end

	choose_whole_right_text: EV_PIXMAP is
			-- Pixmap representing a right text and 
			-- a cancel cross on its left side
		once
			Result := read_pixmap ("righttxt.bmp")
		end

	class_diff_stats: EV_PIXMAP is
			-- Pixmap representing class diffs statistics format
		once
			Result := read_pixmap ("stats.bmp")
		end

	class_diff_text: EV_PIXMAP is
			-- Pixmap representing two class texts with differences
		once
			Result := read_pixmap ("diffs.bmp")
		end

	class_pixmap: EV_PIXMAP is

			-- Pixmap representing a class

		once

			Result := read_pixmap ("class_hole.bmp")

		end;


	circle_pixmap : EV_PIXMAP is
			-- Circle icon
		once
			Result := read_pixmap ("circle.bmp")
		end -- circle_pixmap

	client_pixmap: EV_PIXMAP is
			-- Pixmap representing a client/supplier relationship creation
		once
			Result := read_pixmap ("client.bmp")
		end

	cluster_pixmap: EV_PIXMAP is
			-- Pixmap representing a cluster
		once
			Result := read_pixmap ("cluster.bmp")
		end;

	color_pixmap: EV_PIXMAP is
			-- Pixmap representing a color window 
		once
			Result := read_pixmap ("color.bmp")
		end

	color_invert_pixmap: EV_PIXMAP is
			-- Pixmap representing the reversed of
			-- color_pixmap
		once
			Result := read_pixmap ("color2.bmp")
		end;

	component_pixmap: EV_PIXMAP is
			-- Pixmap representing system components 
		once
			Result := read_pixmap ("cmponent.bmp")
		end

	comp_inherit_pixmap: EV_PIXMAP is
			-- Pixmap representing a compressed inherit link
		once
			Result := read_pixmap ("compinh.bmp")
		end; 

	comp_link_hole_pixmap: EV_PIXMAP is
			-- Pixmap representing a compressed link hole
		once
			Result := read_pixmap ("complink.bmp")
		end; 


	create_pixmap: EV_PIXMAP is
			-- Pixmap representing a cluster
		once
			Result := read_pixmap ("create.bmp")
		end


	dictionary_pixmap: EV_PIXMAP is
		once
			Result := read_pixmap ("dictiony.bmp")
		end


	documentation_pixmap: EV_PIXMAP is
			-- Pixmap representing documentation output
		once
			Result := read_pixmap ("document.bmp")
		end

	echo_on_graph: EV_PIXMAP is
			-- Echo On Graph
		once
			Result := read_pixmap ("echo_on_graph.bmp"	)
		end;	-- Echo On Graph

	edit_pixmap: EV_PIXMAP is
			-- for the external editors
		once
			Result := read_pixmap ("editors.bmp")
		end

	
	end_arrow_pixmap: EV_PIXMAP is
			-- Goto end pixmap
		once
			Result := read_pixmap ("endarrow.bmp")
		end -- end_arrow_pixmap


	feature_pixmap: EV_PIXMAP is

			-- Feature pixmap

		once

			Result := read_pixmap ("feature.bmp")

		end; -- feature_pixmap

	feature_clause: EV_PIXMAP is

			-- Pixmap representing a feature clause

		once

			Result := read_pixmap ("featclau.bmp")

		end;


	feature_clause_cursor: EV_PIXMAP is
			-- Pixmap representing a feature clause cursor
		once
			Result := read_pixmap ("featclau.cur")
		end

	features_pixmap: EV_PIXMAP is
			-- Feature pixmap
		once
			Result := read_pixmap ("routine.bmp")
		end; -- feature_pixmap

	file_pixmap: EV_PIXMAP is
			-- Pixmap representing a file
		once
			Result := read_pixmap ("file.bmp")
		end -- file_pixmap

	forget_all_changes: EV_PIXMAP is
			-- Pixmap representing an arrow comming from a disk symbol.
		once
			Result := read_pixmap ("fromdisk.bmp")
		end

	forget_last_changes: EV_PIXMAP is
			-- Pixmap representing the cancel cross.
		once
			Result := read_pixmap ("cancel.bmp")
		end

	graphics_pixmap: EV_PIXMAP is
			-- Pixmap representing graphical output
		once
			Result := read_pixmap ("graphics.bmp")
		end -- generic_pixmap

	hidden_client_pixmap: EV_PIXMAP is
		once
			Result := read_pixmap ("hdclient.bmp")
		end

	hidden_aggreg_pixmap: EV_PIXMAP is
		once
			Result := read_pixmap ("hdaggreg.bmp")
		end 

	hidden_inherit_pixmap: EV_PIXMAP is
		once
			Result := read_pixmap ("hdinher.bmp")
		end 

	hidden_label_pixmap: EV_PIXMAP is
		once
			Result := read_pixmap ("hdlabel.bmp")
		end

	hidden_comp_inherit_pixmap: EV_PIXMAP is
		once
			Result := read_pixmap ("hdcomp.bmp")
		end

	iconize_pixmap: EV_PIXMAP is
			-- Pixmap representing iconization of clusters
		once
			Result := read_pixmap ("iconize.bmp")
		end 


	inherit_pixmap: EV_PIXMAP is
			-- Pixmap representing an inheritance link
		once
			Result := read_pixmap ("inherit.bmp")
		end

	integrate_case_version: EV_PIXMAP is
			-- Pixmap to integrate the case version of a diff
		once
			Result := read_pixmap ("irightd.bmp")
		end 

	integrate_code_version: EV_PIXMAP is
			-- Pixmap to integrate the code version of a diff
		once
			Result := read_pixmap ("ileftd.bmp")
		end 

	label_pixmap: EV_PIXMAP is
			-- Pixmap representing a label format
		once
			Result := read_pixmap ("label.bmp")
		end

	left_handle : EV_PIXMAP is
		once
			Result := read_pixmap ("left_handle.bmp")
		end

	merging_pixmap: EV_PIXMAP is
			-- Pixmap representing two texts merging
		once
			Result := read_pixmap ("merging.bmp")
		end

	modified_class_pixmap: EV_PIXMAP is
			-- Pixmap representing modification since last R.E. 
		once
			Result := read_pixmap ("modified.bmp")
		end;

	namer_pixmap: EV_PIXMAP is
		once
			Result := read_pixmap ("namer.bmp")
		end; 

	next_arrow_pixmap: EV_PIXMAP is
			-- Goto next page pixmap
		once
			Result := read_pixmap ("nxtarrow.bmp")
		end; -- next_arrow_pixmap

	normal_class_pixmap: EV_PIXMAP is
			-- Pixmap representing a normal class
		once
			Result := read_pixmap ("class_quiet.bmp")
		end

	selected_class_pixmap : EV_PIXMAP is
			-- Pixmap representing a selected class for creation
		once
			Result := read_pixmap ("class_selec.bmp")
		end

	normal_cluster_pixmap: EV_PIXMAP is
			-- Pixmap representing a normal cluster
		once
			Result := read_pixmap ("cluster_quiet.bmp")
		end


	selected_cluster_pixmap : EV_PIXMAP is
			-- Pixmap representing a selected cluster for creation
		once
			Result := read_pixmap ("cluster_selec.bmp")
		end

	open_pixmap: EV_PIXMAP is
			-- Open pixmap
		once
			Result := read_pixmap ("open.bmp")
		end

	plus_pixmap: EV_PIXMAP is
			-- Plus icon
		once
			Result := read_pixmap ("plus.bmp")
		end -- plus_pixmap

	previous_arrow_pixmap: EV_PIXMAP is
			-- Goto previous page pixmap
		once

			Result := read_pixmap ("prevarrw.bmp")
		end;


	printer_pixmap: EV_PIXMAP is
			-- Pixmap representing a printer
		once
			Result := read_pixmap ("printer.bmp")
		end

	quit_pixmap: EV_PIXMAP is
			-- Pixmap representing an exit door
		once
			Result := read_pixmap ("quit.bmp")
		end -- quit_pixmap



	redo_pixmap: EV_PIXMAP is
			-- Pixmap representing an redo history button
		once
			Result := read_pixmap ("redo.bmp")
		end 

	relation_pixmap: EV_PIXMAP is
			-- Pixmap representing a relation
		once
			Result := read_pixmap ("relation.bmp")
		end


	relations_pixmap: EV_PIXMAP is

			-- Pixmap representing a relation format

		once

			Result := read_pixmap ("relatns.bmp")

		end;



	remove_handles_pixmap: EV_PIXMAP is
			-- Pixmap representing removed handles hole
		once
			Result := read_pixmap ("rmhandls.bmp")
		end

	remove_relation_pixmap: EV_PIXMAP is
			-- Pixmap representing a removed relation hole
		once
			Result := read_pixmap ("remrelat.bmp")
		end

	right_handle: EV_PIXMAP is
		once
			Result := read_pixmap ("right_handle.bmp")
		end

	save_as_pixmap: EV_PIXMAP is
			-- Save as pixmap
		once
			Result := read_pixmap ("save_as.bmp")
		end

	save_pixmap: EV_PIXMAP is
			-- Save pixmap
		once
			Result := read_pixmap ("save.bmp")
		end

	selected_aggreg_pixmap: EV_PIXMAP is
			-- Pixmap representing a selected aggregation format
		once
			Result := read_pixmap ("saggreg.bmp")

		end; 

	select_browsing: EV_PIXMAP is
			-- Pixmap
		once
			Result := read_pixmap ("select_browsing.bmp")
		end


	selected_chart_pixmap: EV_PIXMAP is
			-- Pixmap representing a selected chart format
		once
			Result := read_pixmap ("schart.bmp")
		end 

	selected_class_diff_stats: EV_PIXMAP is
			-- Pixmap representing selected class diffs statistics format
		once
			Result := read_pixmap ("sstats.bmp")
		end

	selected_class_diff_text: EV_PIXMAP is
			-- Pixmap representing two class texts with differences, when
			-- button is selected
		once
			Result := read_pixmap ("sdiffs.bmp")
		end

	selected_client_pixmap: EV_PIXMAP is
			-- Pixmap representing a selected client format
		once
			Result := read_pixmap ("sclient.bmp")
		end

	selected_component_pixmap: EV_PIXMAP is
			-- Pixmap representing a selected component format
		once
			Result := read_pixmap ("scompon.bmp")
		end


	selected_dictionary_pixmap: EV_PIXMAP is

			-- Pixmap representing a selected dictionary format
		once
			Result := read_pixmap ("sdiction.bmp")
		end

	selected_documentation_pixmap: EV_PIXMAP is
			-- Pixmap representing a selected documentation format
		once
			Result := read_pixmap ("sdocumnt.bmp")
		end

	selected_echo_on_graph: EV_PIXMAP is
			-- Echo on Graph Selected
		once
			Result := read_pixmap ("selected_echo_on_graph.bmp")
		end;

	selected_show_eiffel_code_pixmap: EV_PIXMAP is
			-- Pixmap representing Eiffel Code 
		once
			Result := read_pixmap ("sshw_eif.bmp")
		end



	selected_features_pixmap: EV_PIXMAP is
			-- Pixmap representing a selected features format
		once
			Result := read_pixmap ("sfeaturs.bmp")
		end

	selected_file_pixmap: EV_PIXMAP is
			-- Pixmap representing a selected files format
		once
			Result := read_pixmap ("sfile.bmp")
		end


	selected_graphics_pixmap: EV_PIXMAP is
			-- Pixmap representing a selected graphics format
		once
			Result := read_pixmap ("sgraphic.bmp")
		end

	selected_inherit_pixmap: EV_PIXMAP is
			-- Pixmap representing a selected features format
		once
			Result := read_pixmap ("sinherit.bmp")
		end


	selected_label_pixmap: EV_PIXMAP is
			-- Pixmap representing a selected label marker
		once
			Result := read_pixmap ("slabel.bmp")
		end; 



	selected_modified_class_pixmap: EV_PIXMAP is

			-- Pixmap representing a selected modified classes format
		once
			Result := read_pixmap ("smodif.bmp")
		end; 

	selected_printer_pixmap: EV_PIXMAP is
			-- Pixmap representing a selected printer form
		once
			Result := read_pixmap ("sprinter.bmp")
		end

	selected_relations_pixmap: EV_PIXMAP is
			-- Pixmap representing a selected relation format

		once
			Result := read_pixmap ("srelatns.bmp")
		end

	selected_comp_client_pixmap: EV_PIXMAP is
		-- Pixmap representing a selected spec 
		once
			Result := read_pixmap ("scompcli.bmp")
		end; 



	selected_comp_aggreg_pixmap: EV_PIXMAP is
			-- Pixmap representing a selected spec 
		once
			Result := read_pixmap ("scompagg.bmp")
		end


	selected_comp_inherit_pixmap: EV_PIXMAP is
			-- Pixmap representing a selected spec 
		once
			Result := read_pixmap ("scompinh.bmp")
		end

	selected_specification_pixmap: EV_PIXMAP is
			-- Pixmap representing a selected spec 
		once
			Result := read_pixmap ("sspecif.bmp")
		end; 

	show_inherit_pixmap : EV_PIXMAP is 
			-- Pixmap which indicates that inheritance links are showed
		once
			Result := read_pixmap ("inher_show.bmp")
		end

	show_aggreg_pixmap : EV_PIXMAP is
			-- Pixmap which indicates that aggreg links are showed
		once
			Result := read_pixmap ("aggreg_show.bmp")
		end

	show_client_pixmap : EV_PIXMAP is
			-- Pixmap which indicates that aggreg links are showed
		once
			Result := read_pixmap ("client_show.bmp")
		end

	
	show_eiffel_code_pixmap: EV_PIXMAP is
			-- Pixmap representing Eiffel Code 
		once
			Result := read_pixmap ("shw_eif.bmp")
		end

	specification_pixmap: EV_PIXMAP is
			-- Specification pixmap
		once
			Result := read_pixmap ("specific.bmp")
		end; 

	star_pixmap: EV_PIXMAP is
			-- Star icon
		once
			Result := read_pixmap ("star.bmp")
		end -- star_pixmap


	start_arrow_pixmap: EV_PIXMAP is
			-- Goto begin pixmap
		once
			Result := read_pixmap ("startarw.bmp")
		end

	square_pixmap: EV_PIXMAP is
			-- Square icon
		once
			Result := read_pixmap ("square.bmp")
		end -- square_pixmap

	trash_pixmap: EV_PIXMAP is

			-- Pixmap representing a trash

		once

			Result := read_pixmap ("trash.bmp")

		end; -- trash_pixmap

	triangle_pixmap: EV_PIXMAP is
			-- Triangle icon
		once
			Result := read_pixmap ("triangle.bmp")
		end -- triangle_pixmap

	undo_pixmap: EV_PIXMAP is
			-- Pixmap representing an undo history button
		once
			Result := read_pixmap ("undo.bmp")
		end 

	unzoom_pixmap: EV_PIXMAP is
			-- Pixmap representing an arrow from the a) to the I)
		once
			Result := read_pixmap ("unzoom.bmp")
		end

	unapply_pixmap: EV_PIXMAP is
			-- Pixmap representing the fact that apply is cancelled
		once
			Result := read_pixmap ("unapply.bmp")
		end;

	unsave_pixmap: EV_PIXMAP is
			-- Pixmap representing an unsaved project
		once
			Result := read_pixmap ("unsave.bmp")
		end; -- up_help_pixmap



	unselect_browsing: EV_PIXMAP is
			-- Pixmap representing a selected aggregation format
		once
			Result := read_pixmap ("unselect_browsing.bmp")
		end; 


feature {NONE} -- Implementation



	read_pixmap (file_name: STRING): EV_PIXMAP is

			-- Pixmap in `file_name'

		require

			file_name_exists: file_name /= void

		local

			full_name: FILE_NAME;

		do

			!! full_name.make_from_string (Environment.bitmap_directory);

			full_name.set_file_name (file_name);

			!!Result.make_from_file (full_name)

		end; -- read_pixmap


end -- PIXMAPS

