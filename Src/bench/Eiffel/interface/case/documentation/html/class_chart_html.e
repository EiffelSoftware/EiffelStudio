indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	CLASS_CHART_HTML

inherit

	MODEL_HTML

	COMMENTS_HTML

	LINKABLE_HTML

creation

	make

feature

	make is
	do
		load_model("/html_class_chart")
	end

feature 

	bad_command : BOOLEAN 
		-- if true, it means that the used external command is bad
		-- it avoids to popup number of warning messages ...
 
	generate ( class_data : CLASS_DATA ) is
	local
		st : LINKED_LIST[STRING]
		str : STRING
		file_n : FILE_NAME
		fi : RAW_FILE
		dir : DIRECTORY
		error_fi : BOOLEAN
	do
--		if not error_fi and then model/= Void  then
--
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
--		st.extend(clone(class_data.name))
--	
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
--		st.extend(clone(class_data.name))
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
--		generate_description(class_data.description,st)
--		
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
--		generate_indexing ( class_data, st )
--
--
--		-- inherit from
--		from
--		until
--			model.item.has('.') or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		model.forth
--		generate_inh (class_data, st )
--
--		-- Queries
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		model.forth
--		generate_queries ( class_Data, st )
--
--		-- Commands
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		model.forth
--		generate_commands ( class_data, st )
--
--		-- Constraints
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		model.forth
--		generate_constraints( class_Data, st )
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
--		generate_parent_cluster ( class_data, st, TRUE )
--
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
--		generate_relational ( class_data, st, TRUE,FALSE )
--		st.extend("Relational Format</A>")
--
--		-- link with the code ...
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		model.forth
--		-- link2
--		!! str.make(20)
--		str.append("<A HREF=%"")
--		str.append(class_data.name)
--		str.append(".html%">")
--		st.extend(str)
--		--st.extend(class_data.name)
--		st.extend("Source Code")
--		st.extend("</A>")
--		-- end
--
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		model.forth
--		-- link3
--		!! str.make(20)
--		str.append("<A HREF=%"graph.html%">")
--		str.append("Graph Container")
--		str.append("</A>")
--		st.extend(str)
--
--	
--		-- let's finish the sheet
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
--		file_n.extend (class_data.parent_cluster.name)
--		!! str.make(20)
--		str.append (class_data.name)
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
--		fi.close
--		end
--	rescue
--			Windows.add_message ("Generation of cluster html has failed",
--						1)
--			if not error_fi then
--				error_fi := TRUE
--				retry
--			end	
	end


	generate_link_graph( cl : class_data ; s: LINKED_LIST [ STRING ] ) is
	local
		str: STRING
	do
		!! str.make(20)
		str.append("<A HREF=%"")
		str.append(cl.name)
		str.append("_g.html%">")
		s.extend(str)
		s.extend("Graph")
		s.extend("</A>")
	end

	generate_inh ( cl : class_data ; s: LINKED_LIST [ STRING ] ) is
			-- fill and update the text_inh field ...
		local
			l : LINKED_LIST [ INHERIT_DATA ]
			str : STRING
			i : INTEGER
		do
			if cl.heir_links/= Void and then
			   cl.heir_links.count >0 then
					l := cl.heir_links
					from
						l.start
						i := 1
					until
						l.after
					loop
						-- added by pascalf
						if l.item.parent= Void then
							-- the parent is not in the system ...	
							if l.item.t_o_name/= Void and then l.item.t_o_name.count>0 then
								s.extend(l.item.t_o_name)
								s.extend("<BR>")
							end		
						else
							if l.item.parent.is_cluster then
								-- that is a cluster
								generate_relational(l.item.heir,s,TRUE,TRUE)
							else
								generate_class_spc (l.item.parent, s, TRUE )	
							end
						end	
						l.forth
						!! str.make ( 20 )
						if i=3 then 
							str.append("<BR>")
							i := 0
						else
							if not l.after then
								str.append (", ")
							end
						end
						s.extend(str)
						i := i +1
					end
					s.extend(str)
			else
				s.extend("No parents")
			end
		end

		generate_queries(cl : class_data ; s: LINKED_LIST [ STRING ] ) is
			-- fill and update the text_inh field ...
		local
			quer : FEATURE_LIST 
			str : STRING
			tmp : STRING
			i : INTEGER
		do
		--	if cl.features/= Void then
		--		quer := cl.features
		--		!! str.make ( 30 )
		--		from
		--			quer.start
		--			i := 0
		--		until
		--			quer.after
		--		loop
		--			!! tmp.make ( 20 )
		--			if quer.item.has_result then
		--				tmp.append (quer.item.name)
		--				if i=3 then 
		--					str.append("<BR>")
		--					i := 0
		--				else
		--					if i>0 then
		--						str.append(", ")
		--					end
		--				end
		--			end
		--			str.append ( tmp )
		--			quer.forth
		--			if tmp.count>0 then
		--				i := i +1
		--			end
		--		end
		--		if str.is_equal("") then
		--			s.extend("No queries")
		--		else
		--			s.extend(str)
		--		end
		--	else
		--		s.extend("No queries")
		--	end
		end

	generate_commands(cl : class_data ; s: LINKED_LIST [ STRING ] ) is 
			-- fill and update the text_comfield ...
		local
			quer : FEATURE_LIST 
			str : STRING
			tmp : STRING
			i : INTEGER
		do
			--if cl.features/= Void then
			--	quer := cl.features
			--	!! str.make ( 30 )
			--	from
			--		quer.start
			--		i := 0
			--	until
			--		quer.after
			--	loop
			--		!! tmp.make ( 20 )
			--		if not (quer.item.has_result) then
			--			tmp.append (quer.item.name)
			--			if i=3 then 
			--				str.append("<BR>")
			--				i := 0
			--			else
			--				if i>0 then
			--					str.append(", ")
			--				end
			--			end
			--		end
			--		str.append ( tmp )
			--		quer.forth
			--		if tmp.count>0 then
			--			i := i +1
			--		end
			--	end
			--	if str.is_equal("") then
			--		s.extend("No commands")
			--	else
			--		s.extend(str)
			--	end
			--else
			--	s.extend("No commands")
			--end
		end

		generate_constraints(cl : class_data ; s: LINKED_LIST [ STRING ] ) is 
		local
			invar : ELEMENT_LIST [ INVARIANT_DATA ]
			str : STRING
		do
		--	if cl.content/= Void and then
		--		cl.content.invariants/= Void and then
		--	 	cl.content.invariants.count>0 then
		--				invar := cl.content.invariants
		--				if invar.count>0 then
		--					!! str.make ( 30 )
		--					if invar.i_th(1).assertion_clause/=Void then
		--						str.append ( invar.i_th(1).assertion_clause )
		--						if invar.count>1 then
		--							str.append ("<BR>")
		--							if invar.i_th(2).assertion_clause/= Void then
		--								str.append ( invar.i_th(2).assertion_clause )
		--							end
		--						end
		--					end
		--					if invar.count>2 then
		--						str.append (" ... ")
		--					end
		--					s.extend(str)
		--				end
		--	else
		--		s.extend("No invariants")
		--	end
		end


	

end -- class CLASS_CHART_HTML
