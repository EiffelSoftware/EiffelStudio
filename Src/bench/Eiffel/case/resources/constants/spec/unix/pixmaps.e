indexing



	description: 

		"Pixmaps used to build EiffelCase interface.";
	date: "$Date$";
	revision: "$Revision$"



class PIXMAPS



inherit

	ONCES

	CONSTANTS



feature -- Access

	check_validity_pixmaps is
		local
			i: INTEGER
			s : STRING
			fake : PIXMAP
		do
			!! s.make (5)
			i:=0
			fake := abstract_entity_pixmap
			i:=1
			fake := aggreg_pixmap
			i:=2
			fake := annotations_pixmap
			i:=3
			fake := apply_pixmap
			i:=4
			fake := argument_pixmap
			i:=5
			fake := arrow_bottom
			i:=6
			fake := arrow_down
			i:= 7
			fake := arrow_top
			i:=8
			fake := arrow_up
			i:=9
			fake := case_pixmap
			--fake := chart_pixmap
			fake := choose_whole_left_text
			fake := choose_whole_right_text
			fake := circle_pixmap
			fake := class_diff_stats
			fake := class_diff_text
			fake := class_edit_pixmap
			fake := client_pixmap
			fake := cluster_edit_pixmap
			fake := cluster_pixmap
			fake := color_invert_pixmap
			fake := color_pixmap
			fake := command_pixmap
			fake := comp_inherit_pixmap
			fake := comp_link_hole_pixmap
			fake := component_pixmap
			fake := constraint_pixmap
			fake := create_pixmap
			fake := description_pixmap
			fake := detailed_class_diff_stats
			fake := dictionary_pixmap
			fake := documentation_pixmap
			fake := down_arrow_pixmap
		-- apparently not used	fake := east_arrow_pixmap
	-- appparently not used		fake := east_bracket_pixmap
			fake := edit_pixmap
			fake := end_arrow_pixmap
			--fake := feature_clause
			fake := feature_clause_cursor
			fake := feature_clause_edit
			fake := feature_edit_pixmap
			--fake := feature_pixmap
			fake := features_pixmap
			fake := ff_help_pixmap
			fake := file_pixmap
			fake := forget_all_changes
			fake := forget_last_changes

			fake := generate_pixmap
			fake:= generic_pixmap
				fake:=graphics_pixmap
			fake:=gray50
			fake:=green
		fake:=grey
		fake:=hidden_aggreg_pixmap
		fake:=hidden_client_pixmap
		fake:=hidden_comp_inherit_pixmap
		fake:=hidden_inherit_pixmap
		fake:=hidden_label_pixmap
		fake:=iconize_pixmap
		fake:=index_pixmap
		fake:=inherit_pixmap
		fake:=integrate_case_version
		fake:=integrate_code_version
		fake:=invariant_pixmap
		fake:=label_pixmap
		fake:=left_arrow_pixmap
		fake:=left_down_arrow_pixmap
		fake:=left_up_arrow_pixmap
		fake:=magenta
		fake:=marker_pixmap
		fake:=merging_pixmap
		fake:=middle_pixmap
		fake:=modified_class_pixmap
		fake:=namer_pixmap
		fake:=navy
		fake:=next_arrow_pixmap
		fake:=normal_class_pixmap
		fake:=normal_cluster_pixmap
		fake:=north_arrow_pixmap
		fake:=north_bracket_pixmap
	--	fake:=null_pixmap
		fake:=open_pixmap
		fake:=plus_pixmap
		fake:=postcondition_pixmap
		fake:=precondition_pixmap
		fake:=present_w
		fake:=previous_arrow_pixmap
		fake:=printer_pixmap
		fake:=query_pixmap
		fake:=quit_pixmap
		fake:=rainbow
		fake:=red
		fake:=redo_pixmap
		fake:=relation_edit_pixmap
		fake:=relation_pixmap
		--fake:=relations_pixmap
		fake:=remove_handles_pixmap
		fake:=remove_relation_pixmap
		fake:=remove_reverse_link_pixmap
		fake:=rew_help_pixmap
		fake:=right_arrow_pixmap
		fake:=right_down_arrow_pixmap
		fake:=right_up_arrow_pixmap
		fake:=save_as_pixmap
		fake:=save_pixmap
		fake:=selected_aggreg_pixmap
		fake:=selected_annotations_pixmap
		fake:=selected_chart_pixmap
		fake:=selected_class_diff_stats
		fake:=selected_class_diff_text
		fake:=selected_client_pixmap
	-- bitmap does not exists, but is used
	-- apparently, not dynamically...	fake:=selected_comp_aggreg_pixmap
		fake:=selected_comp_client_pixmap
		fake:=selected_comp_inherit_pixmap
		fake:=selected_component_pixmap
		fake:=selected_detailed_class_diff_stats
		fake:=selected_dictionary_pixmap
		fake:=selected_documentation_pixmap
		fake:=selected_features_pixmap
		fake:=selected_file_pixmap
		fake:=selected_generate_pixmap
		fake:=selected_graphics_pixmap
		fake:=selected_inherit_pixmap
		fake:=selected_label_pixmap
		fake:=selected_marker_pixmap
		fake:=selected_modified_class_pixmap
		fake:=selected_printer_pixmap
		fake:=selected_relations_pixmap
		--fake:=selected_show_eiffel_code_pixmap
		fake:=selected_specification_pixmap
		fake:=show_eiffel_code_pixmap
		fake:=sort_hierarchy_pixmap
		fake:=sort_pixmap
		fake:=south_arrow_pixmap
		fake:=south_bracket_pixmap
		--fake:=specification_pixmap
		fake:=square_pixmap
	-- not used anymore	fake:=srch_help_pixmap
		fake:=star_pixmap
		fake:=start_arrow_pixmap
		fake:=toc_help_pixmap
		--fake:=trash_pixmap
		fake:=triangle_pixmap
		fake:=unapply_pixmap
		fake:=undo_pixmap
		fake:=unsave_pixmap
		fake:=unzoom_pixmap
		fake:=up_arrow_pixmap
		fake:=up_help_pixmap
		fake:=view_pixmap
		fake:=west_arrow_pixmap
		fake:=west_bracket_pixmap
		fake:=yellow

		rescue
			Windows.add_message("%NError in loading the pixmaps, code :",1)
			Windows.add_message	( i.out	, 1	)
		end
			
			

	abstract_entity_pixmap: PIXMAP is

			-- Pixmap representing an abstract class hole

		once

			Result := read_pixmap ("abst_ent.xpm")

		end;

    add_attr_clone (p: EV_PIXMAPABLE): EV_PIXMAP is
            -- Pixmap representing an addition of an attribute(clone)
        once
            Result := load_pixmap ("add_attr_clone.xpm", p)
        end
    
    add_func_clone (p: EV_PIXMAPABLE): EV_PIXMAP is
            -- Pixmap representing an addition of an attribute(clone)
        once
            Result := load_pixmap ("add_func_clone.xpm", p)
        end
    
    add_com_clone (p: EV_PIXMAPABLE): EV_PIXMAP is
            -- Pixmap representing an addition of an attribute(clone)
        once
            Result := load_pixmap ("add_com_clone.xpm", p)
        end
	


	aggreg_pixmap: PIXMAP is

			-- Pixmap representing an aggregation relationship creation

		once

			Result := read_pixmap ("aggreg.xpm")

		end; 



	annotations_pixmap: PIXMAP is

			-- Pixmap representing an annotations format

		once

			Result := read_pixmap ("annotats.xpm")

		end; 



	apply_pixmap: PIXMAP is

			-- Pixmap representing the apply function (ok tick)

		once

			Result := read_pixmap ("apply.xpm")

		end; 



	argument_pixmap: PIXMAP is

			-- Pixmap representing an argument 

		once

			Result := read_pixmap ("argument.xpm")

		end; 



	arrow_bottom: PIXMAP is

			-- Pixmap representing an go to bottom arrow

		once

			Result := read_pixmap ("1st_down.xpm")

		end; 



	arrow_down: PIXMAP is

			-- Pixmap representing an go down arrow

		once

			Result := read_pixmap ("go_down.xpm")

		end; 



	arrow_top: PIXMAP is

			-- Pixmap representing an go to top arrow

		once

			Result := read_pixmap ("1st_up.xpm")

		end; 



	arrow_up: PIXMAP is

			-- Pixmap representing an go up arrow

		once

			Result := read_pixmap ("go_up.xpm")

		end; 



	case_pixmap: PIXMAP is

			-- Pixmap representing EiffelCase

		once

			Result := read_pixmap ("case.xpm")

		end; -- chart_pixmap



	chart_pixmap (p: EV_PIXMAPABLE): EV_PIXMAP is

			-- Pixmap representing a class chart

		once

			Result := load_pixmap ("chart.xpm", p)

		end; -- chart_pixmap



	choose_whole_left_text: PIXMAP is

			-- Pixmap representing a left text and 

			-- a cancel cross on its right side

		once

			Result := read_pixmap ("lefttxt.xpm")

		end

	present_w : PIXMAP is
		once
			--Result := read_pixmap ("casse.xpm")
		end



	choose_whole_right_text: PIXMAP is

			-- Pixmap representing a right text and 

			-- a cancel cross on its left side

		once

			Result := read_pixmap ("righttxt.xpm")

		end



	class_diff_stats: PIXMAP is

			-- Pixmap representing class diffs statistics format

		once

			Result := read_pixmap ("stats.xpm")

		end



	class_diff_text: PIXMAP is

			-- Pixmap representing two class texts with differences

		once

			Result := read_pixmap ("diffs.xpm")

		end



	class_pixmap (c: EV_PIXMAPABLE) : EV_PIXMAP is

			-- Pixmap representing a class

		once

			Result := load_pixmap ("class_hole.xpm", c)

		end;



	class_edit_pixmap: PIXMAP is

			-- Pixmap representing a class being edited

		once

			Result := read_pixmap ("clas_dot.xpm");

		end;



	circle_pixmap: PIXMAP is

			-- Circle icon

		once

			Result := read_pixmap ("circle.xpm")

		end; -- circle_pixmap



	client_pixmap: PIXMAP is

			-- Pixmap representing a client/supplier relationship creation

		once

			Result := read_pixmap ("client.xpm")

		end;



	cluster_pixmap: PIXMAP is

			-- Pixmap representing a cluster

		once

			Result := read_pixmap ("cluster_hole.xpm")

		end;



	cluster_edit_pixmap: PIXMAP is

			-- Pixmap representing a cluster being edited

		once

			Result := read_pixmap ("clus_dot.xpm")

		end;



	color_pixmap: PIXMAP is

			-- Pixmap representing a color window 

		once

			Result := read_pixmap ("color.xpm")

		end;

	color_invert_pixmap: PIXMAP is
			-- Pixmap representing the reversed of
			-- color_pixmap
		once
			Result := read_pixmap ("color2.xpm")
		end;


	command_pixmap: PIXMAP is

			-- Pixmap representing commands 

		once

			Result := read_pixmap ("command.xpm")

		end;



	component_pixmap: PIXMAP is

			-- Pixmap representing system components 

		once

			Result := read_pixmap ("cmponent.xpm")

		end;



	comp_inherit_pixmap: PIXMAP is

			-- Pixmap representing a compressed inherit link

		once

			Result := read_pixmap ("compinh.xpm")

		end; 



	comp_link_hole_pixmap: PIXMAP is

			-- Pixmap representing a compressed link hole

		once

			Result := read_pixmap ("complink.xpm")

		end; 



	constraint_pixmap: PIXMAP is

			-- Pixmap representing constraints 

		once

			Result := read_pixmap ("constr.xpm")

		end;



	create_pixmap: PIXMAP is

			-- Pixmap representing a cluster

		once

			Result := read_pixmap ("create.xpm")

		end;



	description_pixmap: PIXMAP is

			-- Pixmap representing descriptions

		once

			Result := read_pixmap ("descript.xpm")

		end;



	detailed_class_diff_stats: PIXMAP is

			-- Pixmap representing class diffs statistics format

		once

			Result := read_pixmap ("dstats.xpm")

		end



	dictionary_pixmap: PIXMAP is

		once

			Result := read_pixmap ("dictiony.xpm")

		end;



	documentation_pixmap: PIXMAP is

			-- Pixmap representing documentation output

		once

			Result := read_pixmap ("document.xpm")

		end;



	down_arrow_pixmap: PIXMAP is

			-- Pixmap representing a down arrow

		once

			Result := read_pixmap ("downarrw.xpm")

		end;



	east_arrow_pixmap: PIXMAP is

			-- East arrow pixmap

		once

			Result := read_pixmap ("e_arrow.xpm")

		end; -- east_arrow_pixmap



	east_bracket_pixmap: PIXMAP is

			-- East bracket pixmap

		once

			Result := read_pixmap ("e_bracket.xpm")

		end; -- east_bracket_pixmap

	echo_on_graph: PIXMAP is
			-- Echo On Graph
		once
			Result := read_pixmap ("echo_on_graph.xpm"	)
		end;	-- Echo On Graph

	edit_pixmap: PIXMAP is
			-- for the external editors
		once
			Result := read_pixmap ("editors.xpm")
		end

	



	end_arrow_pixmap: PIXMAP is

			-- Goto end pixmap

		once

			Result := read_pixmap ("endarrow.xpm")

		end; -- end_arrow_pixmap



	feature_pixmap (p: EV_PIXMAPABLE): EV_PIXMAP is

			-- Feature pixmap

		once

			Result := load_pixmap ("feature.xpm", p)

		end; -- feature_pixmap



	feature_clause (p: EV_PIXMAPABLE) : EV_PIXMAP is

			-- Pixmap representing a feature clause

		once

			Result := load_pixmap ("featclau.xpm", p)

		end;



	feature_clause_cursor: PIXMAP is

			-- Pixmap representing a feature clause cursor

		once

			Result := read_pixmap ("featclau.xpm")

		end;



	feature_clause_edit: PIXMAP is

			-- Pixmap representing a feature clause being edited

		once

			Result := read_pixmap ("featcled.xpm")

		end;



	feature_edit_pixmap: PIXMAP is

			-- Pixmap representing a feature being edited

		once

			Result := read_pixmap ("feat_dot.xpm");

		end;



	features_pixmap: PIXMAP is

			-- Feature pixmap

		once

			Result := read_pixmap ("features.xpm")

		end; -- feature_pixmap



	ff_help_pixmap: PIXMAP is

			-- Pixmap representing a book whose right page is being turned

		once

			Result := read_pixmap ("ff_help.xpm")

		end; -- ff_help_pixmap



	file_pixmap: PIXMAP is

			-- Pixmap representing a file

		once

			Result := read_pixmap ("file.xpm")

		end -- file_pixmap



	forget_all_changes: PIXMAP is

			-- Pixmap representing an arrow comming from a disk symbol.

		once

			Result := read_pixmap ("fromdisk.xpm")

		end



	forget_last_changes: PIXMAP is

			-- Pixmap representing the cancel cross.

		once

			Result := read_pixmap ("cancel.xpm")

		end



	generate_pixmap: PIXMAP is

			-- Pixmap representing Eiffel Code generation

		once

			Result := read_pixmap ("generate.xpm")

		end;



	generic_pixmap: PIXMAP is

			-- Generic pixmap

		once

			Result := read_pixmap ("generic.xpm")

		end; -- generic_pixmap



	graphics_pixmap: PIXMAP is

			-- Pixmap representing graphical output

		once

			Result := read_pixmap ("graphics.xpm")

		end; -- generic_pixmap



	hidden_client_pixmap: PIXMAP is

		once

			Result := read_pixmap ("hdclient.xpm")

		end; 



	hidden_aggreg_pixmap: PIXMAP is

		once

			Result := read_pixmap ("hdaggreg.xpm")

		end; 



	hidden_inherit_pixmap: PIXMAP is

		once

			Result := read_pixmap ("hdinher.xpm")

		end; 



	hidden_label_pixmap: PIXMAP is

		once

			Result := read_pixmap ("hdlabel.xpm")

		end; 



	hidden_comp_inherit_pixmap: PIXMAP is

		once

			Result := read_pixmap ("hdcomp.xpm")

		end; 



	iconize_pixmap: PIXMAP is

			-- Pixmap representing iconization of clusters

		once

			Result := read_pixmap ("iconize.xpm")

		end; 



	index_pixmap: PIXMAP is

			-- Pixmap representing indexes

		once

			Result := read_pixmap ("index.xpm")

		end; 



	inherit_pixmap: PIXMAP is

			-- Pixmap representing an inheritance link

		once

			Result := read_pixmap ("inherit.xpm")

		end; 



	integrate_case_version: PIXMAP is

			-- Pixmap to integrate the case version of a diff

		once

			Result := read_pixmap ("irightd.xpm")

		end; 



	integrate_code_version: PIXMAP is

			-- Pixmap to integrate the code version of a diff

		once

			Result := read_pixmap ("ileftd.xpm")

		end; 



	invariant_pixmap: PIXMAP is

			-- Pixmap representing a invariant format 

		once

			Result := read_pixmap ("invarnt.xpm")

		end; 



	label_pixmap: PIXMAP is

			-- Pixmap representing a label format

		once

			Result := read_pixmap ("label.xpm")

		end; 



	left_arrow_pixmap: PIXMAP is

			-- Pixmap representing a left arrow

		once

			Result := read_pixmap ("leftarrw.xpm")

		end; 



	left_down_arrow_pixmap: PIXMAP is

			-- Pixmap representing an arrow pointing to the lower left corner

		once

			Result := read_pixmap ("leftdwna.xpm")

		end

    left_handle : PIXMAP is
        once
            Result := read_pixmap ("left_handle.xpm")
        end

	left_up_arrow_pixmap: PIXMAP is

			-- Pixmap representing an arrow pointing to the upper left corner

		once

			Result := read_pixmap ("leftupa.xpm")

		end



	marker_pixmap: PIXMAP is

			-- Pixmap representing relation markers

		once

			Result := read_pixmap ("marker.xpm")

		end; 



	merging_pixmap: PIXMAP is

			-- Pixmap representing two texts merging

		once

			Result := read_pixmap ("merging.xpm")

		end;



	middle_pixmap: PIXMAP is

			-- Pixmap representing a middle

		once

			Result := read_pixmap ("midpoint.xpm")

		end; 



	modified_class_pixmap: PIXMAP is

			-- Pixmap representing modification since last R.E. 

		once

			Result := read_pixmap ("modified.xpm")

		end;



	namer_pixmap: PIXMAP is

		once

			Result := read_pixmap ("namer.xpm")

		end; 



	next_arrow_pixmap: PIXMAP is

			-- Goto next page pixmap

		once

			Result := read_pixmap ("nxtarrow.xpm")

		end; -- next_arrow_pixmap



	normal_class_pixmap: PIXMAP is

			-- Pixmap representing a normal class

		once

			Result := read_pixmap ("class.xpm")

		end;

    selected_class_pixmap : PIXMAP is
            -- Pixmap representing a selected class for creation
        once    
            Result := read_pixmap ("class_selec.xpm")
        end     
   

	normal_cluster_pixmap: PIXMAP is

			-- Pixmap representing a normal cluster

		once

			Result := read_pixmap ("cluster.xpm")

		end;


    selected_cluster_pixmap : PIXMAP is
            -- Pixmap representing a selected cluster for creation
        once    
            Result := read_pixmap ("cluster_selec.xpm")
        end     

	north_bracket_pixmap: PIXMAP is

			-- North bracket pixmap

		once

			Result := read_pixmap ("nbracket.xpm")

		end; -- north_bracket_pixmap



	north_arrow_pixmap: PIXMAP is

			-- North arrow pixmap

		once

			Result := read_pixmap ("n_arrow.xpm")

		end; -- north_arrow_pixmap



	--null_pixmap: PIXMAP is

			-- White pixmap

	--	once

	--		Result := read_pixmap ("null.xpm")

	--	end; -- null_pixmap



	open_pixmap: PIXMAP is

			-- Open pixmap

		once

			Result := read_pixmap ("open.xpm")

		end;



	plus_pixmap: PIXMAP is

			-- Plus icon

		once

			Result := read_pixmap ("plus.xpm")

		end; -- plus_pixmap



	postcondition_pixmap: PIXMAP is

			-- Pixmap representing a postcondition

		once

			Result := read_pixmap ("postcond.xpm")

		end;



	precondition_pixmap: PIXMAP is

			-- Pixmap representing a precondition

		once

			Result := read_pixmap ("precond.xpm")

		end;



	previous_arrow_pixmap: PIXMAP is

			-- Goto previous page pixmap

		once

			Result := read_pixmap ("prevarrw.xpm")

		end;



	printer_pixmap: PIXMAP is

			-- Pixmap representing a printer

		once

			Result := read_pixmap ("printer.xpm")

		end;



	query_pixmap: PIXMAP is

			-- Pixmap representing a query

		once

			Result := read_pixmap ("query.xpm")

		end; 



	quit_pixmap: PIXMAP is

			-- Pixmap representing an exit door

		once

			Result := read_pixmap ("quit.xpm")

		end; -- quit_pixmap



	redo_pixmap: PIXMAP is

			-- Pixmap representing an redo history button

		once

			Result := read_pixmap ("redo.xpm")

		end; 



	relation_pixmap: PIXMAP is

			-- Pixmap representing a relation

		once

			Result := read_pixmap ("relation.xpm")

		end;



	relation_edit_pixmap: PIXMAP is

			-- Pixmap representing a relation being edited

		once

			Result := read_pixmap ("rela_dot.xpm")

		end;



	relations_pixmap (p: EV_PIXMAPABLE): EV_PIXMAP is

			-- Pixmap representing a relation format

		once

			Result := load_pixmap ("relatns.xpm", p)

		end;



	remove_handles_pixmap: PIXMAP is

			-- Pixmap representing removed handles hole

		once

			Result := read_pixmap ("rmhandls.xpm")

		end;



	remove_relation_pixmap: PIXMAP is

			-- Pixmap representing a removed relation hole

		once

			Result := read_pixmap ("remrelat.xpm")

		end;



	remove_reverse_link_pixmap: PIXMAP is

			-- Pixmap representing a removed relation hole

		once

			Result := read_pixmap ("remrevrs.xpm")

		end;



	rew_help_pixmap: PIXMAP is

			-- Pixmap representing a book whose left page is being turned

		once

			Result := read_pixmap ("rew_help.xpm")

		end;



	right_arrow_pixmap: PIXMAP is

			-- Pixmap representing a right arrow

		once

			Result := read_pixmap ("rghtarrw.xpm")

		end;



	right_down_arrow_pixmap: PIXMAP is

			-- Pixmap representing an arrow pointing to the lower right corner

		once

			Result := read_pixmap ("rghtdwna.xpm")

		end;

    right_handle: PIXMAP is
        once
            Result := read_pixmap ("right_handle.xpm")
        end


	right_up_arrow_pixmap: PIXMAP is

			-- Pixmap representing an arrow pointing to the upper right corner

		once

			Result := read_pixmap ("rghtupa.xpm")

		end;



	save_as_pixmap: PIXMAP is

			-- Save as pixmap

		once

			Result := read_pixmap ("save_as.xpm")

		end;



	save_pixmap: PIXMAP is

			-- Save pixmap

		once

			Result := read_pixmap ("save.xpm")

		end;

	select_browsing: PIXMAP is

			-- Pixmap representing a selected aggregation format

		once

			Result := read_pixmap ("select_browsing.xpm")

		end; 

	selected_aggreg_pixmap: PIXMAP is

			-- Pixmap representing a selected aggregation format

		once

			Result := read_pixmap ("saggreg.xpm")

		end; 



	selected_annotations_pixmap: PIXMAP is

			-- Pixmap representing a selected annotations format

		once

			Result := read_pixmap ("sannotat.xpm")

		end; 



	selected_chart_pixmap: PIXMAP is

			-- Pixmap representing a selected chart format

		once

			Result := read_pixmap ("schart.xpm")

		end; 



	selected_class_diff_stats: PIXMAP is

			-- Pixmap representing selected class diffs statistics format

		once

			Result := read_pixmap ("sstats.xpm")

		end



	selected_class_diff_text: PIXMAP is

			-- Pixmap representing two class texts with differences, when

			-- button is selected

		once

			Result := read_pixmap ("sdiffs.xpm")

		end



	selected_client_pixmap: PIXMAP is

			-- Pixmap representing a selected client format

		once

			Result := read_pixmap ("sclient.xpm")

		end; 



	selected_component_pixmap: PIXMAP is

			-- Pixmap representing a selected component format

		once

			Result := read_pixmap ("scompon.xpm")

		end; 



	selected_detailed_class_diff_stats: PIXMAP is

			-- Pixmap representing selected class diffs statistics format

		once

			Result := read_pixmap ("sdstats.xpm")

		end



	selected_dictionary_pixmap: PIXMAP is

			-- Pixmap representing a selected dictionary format

		once

			Result := read_pixmap ("sdiction.xpm")

		end; 



	selected_documentation_pixmap: PIXMAP is

			-- Pixmap representing a selected documentation format

		once

			Result := read_pixmap ("sdocumnt.xpm")

		end;

	selected_echo_on_graph: PIXMAP is
			-- Echo on Graph Selected
		once
			Result := read_pixmap ("selected_echo_on_graph.xpm")
		end;



	selected_show_eiffel_code_pixmap (p: EV_PIXMAPABLE): EV_PIXMAP is

			-- Pixmap representing Eiffel Code 

		once

			Result := load_pixmap ("sshw_eif.xpm", p)

		end;



	selected_features_pixmap: PIXMAP is

			-- Pixmap representing a selected features format

		once

			Result := read_pixmap ("sfeaturs.xpm")

		end; 



	selected_file_pixmap: PIXMAP is

			-- Pixmap representing a selected files format

		once

			Result := read_pixmap ("sfile.xpm")

		end; 



	selected_graphics_pixmap: PIXMAP is

			-- Pixmap representing a selected graphics format

		once

			Result := read_pixmap ("sgraphic.xpm")

		end;



	selected_inherit_pixmap: PIXMAP is

			-- Pixmap representing a selected features format

		once

			Result := read_pixmap ("sinherit.xpm")

		end; 



	selected_generate_pixmap: PIXMAP is

			-- Pixmap representing a selected Eiffel generation

		once

			Result := read_pixmap ("sgenerat.xpm")

		end; 



	selected_label_pixmap: PIXMAP is

			-- Pixmap representing a selected label marker

		once

			Result := read_pixmap ("slabel.xpm")

		end; 



	selected_marker_pixmap: PIXMAP is

			-- Pixmap representing a selected relation markers

		once

			Result := read_pixmap ("smarker.xpm")

		end; 



	selected_modified_class_pixmap: PIXMAP is

			-- Pixmap representing a selected modified classes format

		once

			Result := read_pixmap ("smodif.xpm")

		end; 



	selected_printer_pixmap: PIXMAP is

			-- Pixmap representing a selected printer format

		once

			Result := read_pixmap ("sprinter.xpm")

		end; 



	selected_relations_pixmap: PIXMAP is

			-- Pixmap representing a selected relation format

		once

			Result := read_pixmap ("srelatns.xpm")

		end;



	selected_comp_client_pixmap: PIXMAP is

			-- Pixmap representing a selected spec 

		once

			Result := read_pixmap ("scompcli.xpm")

		end; 



	selected_comp_aggreg_pixmap: PIXMAP is

			-- Pixmap representing a selected spec 

		once

			Result := read_pixmap ("sel_comp_aggreg.xpm")

		end; 



	selected_comp_inherit_pixmap: PIXMAP is

			-- Pixmap representing a selected spec 

		once

			Result := read_pixmap ("scompinh.xpm")

		end; 



	selected_specification_pixmap: PIXMAP is

			-- Pixmap representing a selected spec 

		once

			Result := read_pixmap ("sspecif.xpm")

		end; 

    show_inherit_pixmap : PIXMAP is 
            -- Pixmap which indicates that inheritance links are showed
        once
            Result := read_pixmap ("inher_show.xpm")
        end

    show_aggreg_pixmap : PIXMAP is
            -- Pixmap which indicates that aggreg links are showed
        once    
            Result := read_pixmap ("aggreg_show.xpm")
        end     

    show_client_pixmap : PIXMAP is
            -- Pixmap which indicates that aggreg links are showed
        once    
            Result := read_pixmap ("client_show.xpm")
        end     

	show_eiffel_code_pixmap: PIXMAP is

			-- Pixmap representing Eiffel Code 

		once

			Result := read_pixmap ("shw_eif.xpm")

		end;



	sort_pixmap: PIXMAP is

			-- Sort pixmap

		once

			Result := read_pixmap ("sort.xpm")

		end;



	sort_hierarchy_pixmap: PIXMAP is

			-- Sort pixmap

		once

			Result := read_pixmap ("sorthier.xpm")

		end;



	south_arrow_pixmap: PIXMAP is

			-- South arrow pixmap

		once

			Result := read_pixmap ("s_arrow.xpm")

		end; -- south_arrow_pixmap



	south_bracket_pixmap: PIXMAP is

			-- South bracket pixmap

		once

			Result := read_pixmap ("sbracket.xpm")

		end; -- south_bracket_pixmap



	specification_pixmap (p: EV_PIXMAPABLE): EV_PIXMAP is

			-- Specification pixmap

		once

			Result := load_pixmap ("specific.xpm", p)

		end; 



	srch_help_pixmap: PIXMAP is

			-- Pixmap representing a...

		once

			Result := read_pixmap ("srch_help.xpm")

		end; -- srch_help_pixmap



	star_pixmap: PIXMAP is

			-- Star icon

		once

			Result := read_pixmap ("star.xpm")

		end; -- star_pixmap



	start_arrow_pixmap: PIXMAP is

			-- Goto begin pixmap

		once

			Result := read_pixmap ("startarw.xpm")

		end;



	square_pixmap: PIXMAP is

			-- Square icon

		once

			Result := read_pixmap ("square.xpm")

		end; -- square_pixmap



	toc_help_pixmap: PIXMAP is

			-- Pixmap representing toc 

		once

			Result := read_pixmap ("toc_help.xpm")

		end; 



	trash_pixmap (p: EV_PIXMAPABLE): EV_PIXMAP is

			-- Pixmap representing a trash

		once

			Result := load_pixmap ("trash.xpm", p)

		end; -- trash_pixmap



	triangle_pixmap: PIXMAP is

			-- Triangle icon

		once

			Result := read_pixmap ("triangle.xpm")

		end; -- triangle_pixmap



	undo_pixmap: PIXMAP is

			-- Pixmap representing an undo history button

		once

			Result := read_pixmap ("undo.xpm")

		end; 



	unzoom_pixmap: PIXMAP is

			-- Pixmap representing an arrow from the a) to the I)

		once

			Result := read_pixmap ("unzoom.xpm")

		end; 


	unapply_pixmap: PIXMAP is
			-- Pixmap representing the fact that apply is cancelled
		once
			Result := read_pixmap ("unapply.xpm")
		end;

	unsave_pixmap: PIXMAP is

			-- Pixmap representing an unsaved project

		once

			Result := read_pixmap ("unsave.xpm")

		end; -- up_help_pixmap



	up_arrow_pixmap: PIXMAP is

			-- Pixmap representing an up arrow 

		once

			Result := read_pixmap ("up_arrow.xpm")

		end;



	up_help_pixmap: PIXMAP is

			-- Pixmap representing an arrow from the a) to the I)

		once

			Result := read_pixmap ("up_help.xpm")

		end; -- up_help_pixmap



	view_pixmap: PIXMAP is

			-- Pixmap representing views 

		once

			Result := read_pixmap ("view.xpm")

		end; 



	west_arrow_pixmap: PIXMAP is

			-- West arrow pixmap

		once

			Result := read_pixmap ("w_arrow.xpm")

		end; -- west_arrow_pixmap



	west_bracket_pixmap: PIXMAP is

			-- West bracket pixmap

		once

			Result := read_pixmap ("wbracket.xpm")

		end; -- west_bracket_pixmap



--FIXME: Jacques

	rainbow: PIXMAP is

		once

			Result := read_pixmap ("rainbow.xpm")

		end;

	blue: PIXMAP is

		once

			Result := read_pixmap ("blue.xpm")

		end;

	navy: PIXMAP is

		once

			Result := read_pixmap ("navy.xpm")

		end;

	gray50: PIXMAP is

		once

			Result := read_pixmap ("gray50.xpm")

		end;

	green: PIXMAP is

		once

			Result := read_pixmap ("green.xpm")

		end;

	grey: PIXMAP is

		once

			Result := read_pixmap ("grey.xpm")

		end;

	magenta: PIXMAP is

		once

			Result := read_pixmap ("magenta.xpm")

		end;


	red: PIXMAP is

		once

			Result := read_pixmap ("red.xpm")

		end;

	yellow: PIXMAP is

		once

			Result := read_pixmap ("yellow.xpm")

		end;



--

feature {NONE} -- Implementation



	read_pixmap (file_name: STRING): PIXMAP is

			-- Pixmap in `file_name'

		require

			file_name_exists: file_name /= void

		local

			full_name: FILE_NAME;

		do

			!! full_name.make_from_string (Environment.bitmap_directory);

			full_name.set_file_name (file_name);

			!!Result.make;

			Result.read_from_file (full_name);

			if not Result.is_valid then

				io.error.putstring ("EiffelCase: Can not read bitmap file%N");

				io.error.putstring (full_name);

				io.error.putstring (".%N");

			end

		end; -- read_pixmap


	load_pixmap (file_name: STRING; p: EV_PIXMAPABLE): EV_PIXMAP is

			-- Pixmap in `file_name'

		require

			file_name_exists: file_name /= void

		local

			full_name: FILE_NAME;

		do

			!! full_name.make_from_string (Environment.bitmap_directory);

			full_name.set_file_name (file_name);

			!!Result.make (p)

			Result.read_from_file (full_name);

		end; -- read_pixmap



end -- PIXMAPS

