indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	CLUSTER_HTML

inherit

	ONCES

	CONSTANTS

	LINKABLE_HTML

	MODEL_HTML

creation

	make

feature

	make is
	do
		load_model("html_cluster")
	end

	bad_command : BOOLEAN 
		-- if true, it means that the used external command is bad
		-- it avoids to popup number of warning messages ...
 
	generate ( cluster_data : CLUSTER_DATA ) is
	local
		st : LINKED_LIST[STRING]
		str : STRING
		file_n : FILE_NAME
		fi : RAW_FILE
		dir : DIRECTORY
		error_fi : BOOLEAN
	do
--		if not error_fi and then model/= Void  then
--		!! str.make (20)
--		!! file_n.make
--		file_n.extend(Environment.html_directory)
--		file_n.extend(cluster_data.name)
--		!! dir.make (file_n)
--		if not dir.exists then 
--				dir.create_dir
--		end
--		-- filling st , it takes several steps ...
--		-- title now
--		!! st.make
--		-- genenration of the beginning
--		from 
--			model.start
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		st.extend(clone(cluster_data.name))
--		st.extend("%N")
--		st.extend("<BR>")
--		st.extend("%N")
--		st.extend("<BR>")
--		model.forth
--			from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		-- generation of the title
--		if cluster_data.is_root then
--			st.extend("Relational format : System ")
--		else
--			st.extend("Relational format : Cluster ")
--		end
--		st.extend(clone(cluster_data.name))
--
--		model.forth
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
----			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		generate_parent_cluster (cluster_data, st, FALSE )
--		model.forth
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		generate_heir (cluster_data, st )
--		model.forth
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		generate_class ( cluster_data, st)
--		model.forth
--	
--		-- link with the chart format ...
--		from 
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		generate_relational(cluster_data, st, FALSE,FALSE )
--		st.extend("Chart Format</A>")
--
--		from
--			model.forth
--		until
--			model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--
--		-- generation into a file
--		!! file_n.make
--		file_n.extend (Environment.html_directory)
--		file_n.extend (cluster_data.name)
--		!! str.make(20)
--		str.append (cluster_data.name)
--		str.append ("_cas")
--		file_n.extend (str)
--		file_n.add_extension("html")
--		!! fi.make (file_n)
--		fi.open_write
--		from
--			st.start
--		until
--			st.after
--		loop
--			fi.put_string(st.item)
--			st.forth
--		end
--		generate_graph ( cluster_data )
--		end
--	rescue
--			Windows.add_message ("Generation of cluster html has failed",
--						1)
--			if not error_fi then
--				error_fi := TRUE
--				retry
--			end	
	end

	generate_graph ( cluster_data : CLUSTER_DATA ) is
		local
			str : STRING
			file_n : FILE_NAME
			fi : PLAIN_TEXT_FILE
			print_cluster_diag: PRINT_CLUSTER_DIAGRAM
		do
-- 			!! str.make (20)
-- 			!! file_n.make
-- 			file_n.extend(Environment.html_directory)
-- 			file_n.extend(cluster_data.name)
-- 			!! str.make(20)
-- 			str.append ("graph")
-- 			file_n.extend(str)
-- 			if Environment.is_motif then
-- 				file_n.add_extension("ps")
-- 				!! fi.make (file_n)
-- 				fi.open_write
-- 				!! print_cluster_diag.make ( cluster_data )
-- 				print_cluster_diag.set_color ( TRUE )
-- 				print_cluster_diag.execute ( fi )
-- 				fi.close
-- 				--start the conversion
-- 				--conversion ( cluster_data )
-- 			else
-- 				file_n.add_extension("bmp") 
-- 				!! fi.make(file_n)
-- 				Environment.printer_module.print_graph_to_file ( cluster_data, fi )
-- 			end
-- 			generate_graph_code ( cluster_data )
	end

	generate_graph_code ( cl : CLUSTER_DATA ) is
		local
			str,s0 : STRING
			file_n : FILE_NAME
			fi : PLAIN_TEXT_FILE
			err : BOOLEAN
			graph_model: MODEL_HTML
			graph_gene: LINKED_LIST [ STRING ]
		do
--			if not err then
--				!! graph_model
--				graph_model.load_model("graph_html")
--				!! graph_gene.make
--				from
--					graph_model.model.start
--				until
--					graph_model.model.item.is_equal("...") or graph_model.model.after
--				loop
--					graph_gene.extend(clone(graph_model.model.item))
--					graph_gene.extend("%N")
--					graph_model.model.forth
--				end
--				if not graph_model.model.after then
--					graph_model.model.forth
--				end
--				!! s0.make(20)
--				s0.append("../")
--				s0.append(cl.name)
--				!! str.make(20)
--				str.append(cl.name)
--				str.append("_cas")
--				s0.append("/")
--				s0.append(str)
--				s0.append(".html")
--				!! str.make(20)
--				str.append("<A HREF=%"")
--				str.append(s0)
--				str.append("%">")
--				str.append(cl.name)
--				str.append("</A>")
--				graph_gene.extend(str)
--				graph_gene.extend("%N<BR><BR>")
--				from
--				until
--					graph_model.model.item.is_equal("...") or graph_model.model.after
--				loop
--					graph_gene.extend(clone(graph_model.model.item))
--					graph_gene.extend("%N")
--					graph_model.model.forth
--				end
--				if not graph_model.model.after then
--					graph_model.model.forth
--				end
--				graph_gene.extend("<IMG SRC=%"graph.bmp%" usemap=%"#frontpagemap%">")
--				graph_gene.extend("%N")
--				graph_gene.extend("<MAP NAME=%"frontpagemap%">")
--				graph_gene.extend("%N")	
--				generate_map_classes ( graph_gene, cl )
--				generate_map_clusters ( graph_gene, cl)
--		
--				from
--				until
--					 graph_model.model.after
--				loop
--					graph_gene.extend(clone(graph_model.model.item))
--					graph_gene.extend("%N")
--					graph_model.model.forth
--				end
--
--				!! file_n.make
--				file_n.extend(Environment.html_directory)
--				file_n.extend(cl.name)
--				!! str.make(20)
--				str.append ("graph")
--				file_n.extend(str)
--				file_n.add_extension("html")
--				!! fi.make (file_n)
--				fi.open_write
--					from
--						graph_gene.start
--					until
--						graph_gene.after
--					loop
--						fi.put_string(graph_gene.item)
--						graph_gene.forth
--					end
--				fi.close
--			else
--				Windows.add_message("generate_map of cluster_html: problem",1)
--			end
--			rescue
--				err := TRUE
 --				retry
			end	

		generate_map_classes ( li : LINKED_LIST[ STRING ]; cl : CLUSTER_DATA ) is
			local
				i : INTEGER
				st,str : STRING
				file_n : FILE_NAME
			do
				if cl.content/= VOid and then 
					cl.content.classes/= Void then
					from
						cl.content.classes.start
					until
						cl.content.classes.after
					loop
						if not cl.content.classes.item.is_hidden then
							!! st.make (80)
							st.append("<AREA SHAPE=%"CIRCLE%" COORDS=%"")
							st.append_integer(cl.content.classes.item.x)
							st.append(",")
							st.append_integer(cl.content.classes.item.y)
							st.append(",")
							st.append_integer(20) -- we take 20 by default
							st.append("%"%THREF=%"")
							!! file_n.make
							--file_n.extend(Environment.html_directory)
							file_n.extend("..")
							file_n.extend(cl.name)
							!! str.make(20)
							str.append (cl.content.classes.item.name)
							str.append("_cas")
							file_n.extend(str)
							file_n.add_extension("html")
							st.append(file_n)
							st.append("%">")
							li.extend(st)
							li.extend("%N")
						end
						cl.content.classes.forth
					end
				end
			end

			generate_map_clusters ( li: LINKED_LIST[ STRING ]; cl : CLUSTER_DATA ) is
			local
				st,str : STRING
				file_n : FILE_NAME
			do
				!! st.make (20)
				if cl.content/= Void then
					if cl.content.clusters/= VOid then
						from
							cl.content.clusters.start
						until
							cl.content.clusters.after
						loop
							if not cl.content.clusters.item.is_hidden then
									!! file_n.make
									--file_n.extend(Environment.html_directory)
									--file_n.extend(cl.content.clusters.item.name)
									--!! str.make(20)
									--str.append (cl.content.clusters.item.name)
									--str.append ("_cas")
									file_n.extend("..")
									file_n.extend(cl.content.clusters.item.name)
									file_n.extend("graph")
									file_n.add_extension("html")

									st.append("<AREA SHAPE=%"RECTANGLE%" COORDS=%"")
									st.append_integer(cl.content.clusters.item.x)
									st.append(",")
									st.append_integer(cl.content.clusters.item.y)
									st.append(",")
									if not cl.content.clusters.item.is_icon then
										st.append_integer(cl.content.clusters.item.x+cl.content.clusters.item.width)
										st.append(",")
										st.append_integer(cl.content.clusters.item.y+ cl.content.clusters.item.height)
										st.append("%"")
										st.append("%T HREF=%"")
										st.append(file_n)
										st.append("%">")
										li.extend(st)
										li.extend("%N")
										generate_map_classes ( li,cl.content.clusters.item)
										generate_map_clusters (li,cl.content.clusters.item)
									else
										st.append_integer(cl.content.clusters.item.x+cl.content.clusters.item.icon_width)
										st.append(",")
										st.append_integer(cl.content.clusters.item.y+20+ cl.content.clusters.item.icon_height)
										st.append("%"")
										st.append("%T HREF=%"")
										st.append(file_n)
										st.append("%">")
										li.extend(st)	
										li.extend("%N")
									end
								li.extend("%N")
							end
							cl.content.clusters.forth
						end
					end
				end
			end


	conversion ( cl : CLUSTER_DATA ) is
		local
			st1,st2,st3 : STRING
			f1,f2,f3 : FILE_NAME
			s : STRING
		do
			s:= clone ( Resources.converter )
			if not s.is_equal ("none") then
				!! st1.make (20)
				st1.append(Environment.html_directory)
				!! f1.make_from_string (st1)
				!! f2.make_from_string (st1)
				!! f3.make_from_string (st1)
				f1.extend (cl.name)
				f2.extend (cl.name)
				f3.extend (cl.name)
				f1.extend ("graph")
				f2.extend ("graph")
				f3.extend ("graph")
				f1.add_extension("ps")
				f2.add_extension("gif")
				f3.add_extension("jpeg")

				s.replace_substring_all("name_ps",f1)
				s.replace_substring_all("name_gif",f2)
				s.replace_substring_all("name_jpg",f3)
			
				call_system ( s )
			else
				System.set_converter ( FALSE )
			end
		end

	call_system ( s : STRING ) is
		local
			has_err : BOOLEAN
			exec : EXECUTION_ENVIRONMENT
		do
--			if not has_err and not bad_command then
--				!! exec
--				exec.system(s)
--				if exec.return_code >0 then
--					 bad_command := TRUE
--					Windows.message(Windows.main_graph_window, "Mq", Void )
--					System.set_converter ( FALSE ) 
--				end
--			end
--		rescue
--			has_err := TRUE
--			System.set_converter ( FALSE )
--			retry
		end

	generate_description ( desc : DESCRIPTION_DATA; s : 
		LINKED_LIST[STRING] ) is
	do
		if desc /= Void then
		from
			desc.start
		until
			desc.after
		loop
			s.extend(desc.item)
			s.extend("<BR>")
			desc.forth
		end
		end
	end

	generate_heir ( cl : CLUSTER_DATA; s : LINKED_LIST[STRING]) is
		-- generate heir clusters
	local
		list : CLUSTER_LIST
		fi : FILE_NAME
		str,s0 : STRING
	do
		if cl.content /= Void and then
			cl.content.clusters/= Void then
				s.extend("<ul>")
				list := cl.content.clusters
				from 
					list.start
				until
					list.after
				loop
					!! str.make(20)
					!! s0.make(20) 
					str.append("<A HREF=%"")
					--fi.extend(Environment.html_directory)
					s0.append("../")
					s0.append(list.item.name)
					s0.append("/")
					s0.append(list.item.name)
					str.append(s0)
					str.append("_cas.html")
					str.append("%">")
					s.extend(str)
					s.extend(list.item.name)
					s.extend("</A>")
					list.forth
					s.extend("<BR>")
				end
				if list.count=0 then
					s.extend("None")
					s.extend("%N")
				end	
		else
			s.extend("None")
			s.extend("%N")
		end
	end

	generate_class ( cl : CLUSTER_DATA; s : LINKED_LIST[STRING]) is
	local
		list : CLASS_LIST
		fi : FILE_NAME
		str,s0 : STRING
	
	do
			if cl.content /= Void and then
			cl.content.classes/= Void then
				list := cl.content.classes
				s.extend("<ul>")
				from 
					list.start
				until
					list.after
				loop
				--	s.extend("<li>")
					!! str.make(20)
					!! s0.make(20)
					str.append("<A HREF=%"")
					--fi.extend(Environment.html_directory)
					s0.append("../")
					s0.append(list.item.parent_cluster.name)
					s0.append("/")
					s0.append(list.item.name)
					str.append(s0)
					str.append("_cas.html")
					str.append("%">")
					s.extend(str)			
					s.extend(list.item.name)
					s.extend("</A>")
					list.forth
					s.extend("<BR>")
				end
				if list.count=0 then
					s.extend("None ")
					s.extend("%N")
				end
			else
				s.extend("None ")
				s.extend("%N")
		end
	end

end -- class CLUSTER_HTML
