indexing
	description: "Glossary generated in html format, following the BON not."
	date: "$Date$"
	revision: "$Revision$"

class
	DICO_HTML

inherit
	COMMENTS_HTML

	MODEL_HTML

	LINKABLE_HTML

creation
	make

feature -- Initialization

	make is
			-- Creation routine
		do
			load_model("dico_html")
		end

feature -- generation

	generate ( sys : SYSTEM_DATA )is
		-- research of the "..." and launch html generations instead of them
		require
			model_not_void : model/= Void
		local
			st : LINKED_LIST [ STRING ]
			fi : RAW_FILE
			file_n : FILE_NAME
			str : STRING
		do
--			if not error then
--			from
--				model.start
--				!! st.make 
--			until
--				model.item.has('.') or model.after
--			loop
--				st.extend(clone(model.item))
--				st.extend("%N")
--				model.forth
--			end
--			if not model.after then
--				generate_classes(sys, st, model.item )
--			end
--			model.forth
--
--			from
--			until
--				model.item.is_equal("...") or model.after
--			loop
--				st.extend(clone(model.item))
--				st.extend("%N")
--				model.forth
--			end
--			generate_relational (sys.root_cluster, st, TRUE ,FALSE)
--			st.extend("System Chart Format</A>")
--			model.forth
--		
--			from
--			until
--				model.item.is_equal("...") or model.after
--			loop
--				st.extend(clone(model.item))
--				st.extend("%N")
--				model.forth
--			end
--			generate_relational (sys.root_cluster, st, FALSE,FALSE )
--			st.extend("System Relational Format</A>")
--			model.forth
--
--			-- end of the generation
--			from
--			until
--				model.after
--			loop
--				st.extend(clone(model.item))
--				st.extend("%N")
--				model.forth
--			end
--
--			-- generation into a file
--			if not error then
--			!! file_n.make
--			file_n.extend (Environment.html_directory)
--			file_n.extend (sys.root_cluster.name)
--			!! str.make(20)
--			str.append ("glossary")
--			file_n.extend (str)
--			file_n.add_extension("html")
--			!! fi.make (file_n)
--			fi.open_write
--			from
--				st.start
--			until
--				st.after
--			loop
--				fi.put_string(st.item)
--				st.forth
--			end
--			fi.close
			
--			end
--			end
--			rescue
--				Windows.add_message ("problem in Dico_html, for the generation",1)
--				if not error then
--					error := TRUE
--					retry
--			end
		end

	error : BOOLEAN
		-- has an error occured ?

			
	generate_classes ( sys : SYSTEM_DATA;
				st : LINKED_LIST [ STRING ] ; 
				line : STRING ) is
		-- html generation for each classes
		require
			system_not_void : sys/= Void
			line_not_void : line /= Void
		local
			li : LINKED_LIST [ CLASS_DATA ]
			i,i2 : INTEGER -- index of the ...
			stl,str,s0 : STRING
			fi : FILE_NAME
		do
			if sys.classes_in_system/= Void or error then
				from
					li := sys.classes_in_system
					li.start
					!! stl.make (20 )
				until
					li.after
				loop
				--	stl:= deep_clone (line )
					i := line.substring_index ("...", 0 )
					!! str.make ( 20 )
					!! s0.make (20)
					s0.append("../")
					s0.append(li.item.parent_cluster.name)
					s0.append("/")
					s0.append(li.item.name)
					str.append("<A HREF=%"")
					str.append(s0)
					str.append("_chart_cas.html")
					str.append("%">")			
					str.append(li.item.name)
					str.append("</A>")
					st.extend ( line.substring(1, i-1 ))
					st.extend( "%N")
					st.extend(str)
					i2 := line.substring_index ("...", i+3 )
					stl := line.substring(i+3, i2-1) 
					st.extend((line.substring(i+3, i2-1) ))
					st.extend("%N")
					generate_description ( li.item.description, st )
					i := line.substring_index ("...", i2+3 )
					st.extend((line.substring(i2+3, i-1)))
					st.extend("<BR>")
					generate_parent_cluster(li.item, st, TRUE )
					st.extend(line.substring (i+3, line.count ))
					st.extend("%N")
					li.forth
				end
			end
			rescue
				error := TRUE 
				retry
		end

end -- class DICO_HTML
