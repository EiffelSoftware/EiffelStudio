indexing
	description: "Presentation Page"
	date: "$Date$"
	revision: "$Revision$"

class
	PRESENT_HTML

inherit
	MODEL_HTML

	LINKABLE_HTML

creation
	make

feature -- Initialization

	make is
			-- Creation routine
		do
			load_model("main_page_html")
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
			str, str2,s0 : STRING
		do
--			if not error and then sys.root_cluster/= Void then
--			-- generation of the name of project ...	
--			from
--				model.start
--				!! st.make 
--			until
--				model.item.is_equal("...") or model.after
--			loop
--				st.extend(clone(model.item))
--				st.extend("%N")
--				model.forth
--			end
--			if not model.after then
--				!! str.make ( 20 )
--				str.append("Project ")
--				str.append(sys.root_cluster.name)
--				st.extend(str)
--			end
--			model.forth
--
--			-- generation of chart info hyperlink
--			from
--			until
--				model.item.is_equal("...") or model.after
--			loop
--				st.extend(clone(model.item))
--				st.extend("%N")
--				model.forth
--			end
--			if not model.after then
--				!! str.make ( 20 )
--				str.append("<A HREF=%"")
--				!! s0.make(20)
--				s0.append(sys.root_cluster.name)
--				!! str2.make ( 20)
--				str2.append(sys.root_cluster.name)
--				str2.append("_chart_cas")
--				s0.append("/")
--				s0.append(str2)
--				s0.append(".html")
--				str.append(s0)
--				str.append("%">")
--				st.extend(str)
--				model.forth
--			end
--	
--			--generation of relational info hyperlink	
--			from
--			until
--				model.item.is_equal("...") or model.after
--			loop
--				st.extend(clone(model.item))
--				st.extend("%N")
--				model.forth
--			end
--			if not model.after then
--				!! str.make ( 20 )
--				str.append("<A HREF=%"")
--				!! s0.make(20)
--				s0.append(sys.root_cluster.name)
--				!! str2.make ( 20)
--				str2.append(sys.root_cluster.name)
--				str2.append("_cas")
--				s0.append("/")
--				s0.append(str2)
--				s0.append(".html")
--				str.append(s0)
--				str.append("%">")
--				st.extend(str)
--			end
--			model.forth
--
--			-- generation of Glossary hyperlink
--			from
--			until
--				model.item.is_equal("...") or model.after 
--			loop
--				st.extend(clone(model.item))
--				st.extend("%N")
--				model.forth
--			end
--			if not model.after then
--				!! str.make ( 20 )
--				str.append("<A HREF=%"")
--				!! s0.make(20) 
--				s0.append(sys.root_cluster.name)
--				s0.append("/")
--				s0.append("glossary.html")
--				str.append(s0)
--				str.append("%">")
--				st.extend(str)
--				model.forth
--			end	
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
--			!! str.make(20)
--			str.append ("index2")
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
--			
--			copy_index_file
--			end
--			end
--			rescue
--				Windows.add_message ("problem in present_html, for the generation",1)
--				if not error then
--					error := TRUE
--					retry
--			end
		end

	error : BOOLEAN
		-- has an error occured ?

	copy_index_file is
			-- Copy the index file from the $CASE directory
		local
			fi: PLAIN_TEXT_FILE		
			file_n: FILE_NAME
			index_model: MODEL_HTML
			st: LINKED_LIST [ STRING ]
			err: BOOLEAN
		do
--			if not err then
--				!! index_model
--				index_model.load_model("index_html")
--		
--				!! file_n.make
--				file_n.extend(Environment.html_directory)
--				file_n.extend("index")
--				file_n.add_extension("html")
--				!! fi.make(file_n)
--				fi.open_write
--				from
--					index_model.model.start
--				until
--					index_model.model.after
--				loop
--					fi.put_string(index_model.model.item)
--					index_model.model.forth
--					fi.put_string("%N")
--				end
--				fi.close
--			end
--		rescue
--				Windows.add_message ("problem in present_html, for the generation",1)
--				if not error then
--					error := TRUE
--					retry
--			end
		end

			
end -- class INDEX_HTML
