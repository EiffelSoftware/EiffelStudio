indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	CLUSTER_CHART_HTML

inherit

	MODEL_HTML

	COMMENTS_HTML

	LINKABLE_HTML

creation

	make

feature

	make is
	do
		load_model("/html_cluster_chart")
	end

feature 

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
--		model.forth
--		st.extend(clone(cluster_data.name))
--		-- generation of the title
--		from 
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		model.forth
--		if cluster_data.is_root then
--			st.extend("System ")
--		else
--			st.extend("Cluster ")
--		end
--		st.extend(clone(cluster_data.name))
--
--		-- description fields ...
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		model.forth
--		generate_description(cluster_data.description,st)
--		-- indexing fields ...
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		model.forth
--		generate_indexing ( cluster_data, st )
--		-- class/clusters fields ...
--		from
--		until
--			model.item.has('.') or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		generate_items ( cluster_data, st, model.item )
--		model.forth
--
--		-- generation of the parent cluster
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		model.forth
--		generate_parent_cluster ( cluster_data, st, TRUE )
--
--		-- generation of the link for returning to the relational format
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		model.forth
--		generate_relational ( cluster_data, st , TRUE,FALSE)
--		st.extend("Relational Format</A>")
--
--		-- generation of the link to the graph ...
--
--		from
--		until
--			model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--
--
--		-- generation into a file
--		!! file_n.make
--		file_n.extend (Environment.html_directory)
--		file_n.extend (cluster_data.name)
--		!! str.make(20)
--		str.append (cluster_data.name)
--		str.append ("_chart_cas")
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
--		end
--	rescue
--			Windows.add_message ("Generation of cluster html has failed",
--						1)
--			if not error_fi then
--				error_fi := TRUE
--				retry
--			end	
	end

	generate_items ( cl : CLUSTER_DATA ; s : LINKED_LIST [ STRING ] ; line : STRING) is
	do
		generate_classes ( cl, s , line)
	end

	generate_classes ( cl : CLUSTER_DATA; s : LINKED_LIST[STRING]; line : STRING) is
	local
		list : LINKED_LIST [ LINKABLE_DATA ]
		fi : FILE_NAME
		str : STRING
		st,s0 : STRING
		i : INTEGER
	do
		--	if (cl.content /= Void ) and (cl.content.classes/= Void or cl.content.clusters/= Void )then
		--		!! list.make
		--		if cl.content.classes/= Void then
		--			list.append(cl.content.classes)
		--		end
		--		if cl.content.clusters/= Void then
		--			list.append(cl.content.clusters)
		--		end
		--		from 
		--			list.start
		--		until
		--			list.after
		--		loop
		--			!! str.make(20)
		--			!! s0.make(20) 
		--			!! st.make ( 20 )
		--			st := deep_clone ( line )
		--			str.append("<A HREF=%"")
		--			--fi.extend(Environment.html_directory)
		--			s0.append("../")
		--			if list.item.is_cluster then
		--				s0.append(list.item.name)
		--			else
		--				s0.append(list.item.parent_cluster.name)
		--			end
		--			s0.append("/")
		--			s0.append(list.item.name)
		--			str.append(s0)
		--			str.append("_chart_cas.html")
		--			str.append("%">")
		--			if list.item.is_cluster then
		--				str.append("(")
		--			end			
		--			str.append(list.item.name)
		--			if list.item.is_cluster then
		--				str.append(")")
		--			end
		--			str.append("</A>")
		--			i := line.substring_index ("...", 0 )
		--			st.replace_substring(str,i,i+2)
		--			if list.item.description/= Void then
		--				i := st.substring_index ("...", 0 )
		--				str := list.item.description.text_value
		--				if str.is_equal("<<description>>") then
		--					st.replace_substring("?? ", i, i+2 )
		--				else
		--					str.replace_substring_all("%N","<BR>")
		--					st.replace_substring(str, i, i+2)
		--				end
		--			end
		--			s.extend ( st )
		--			list.forth
		--		end
		--end
	end

end -- class CLUSTER_HTML
