indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	CLASS_HTML

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
		load_model("html_class")
	end


feature -- generation

	generate ( class_data : CLASS_DATA ) is
	local
		st : LINKED_LIST[STRING]
		str : STRING
		file_n : FILE_NAME
		fi : RAW_FILE
		error_fi : BOOLEAN
	do
--		if not error_fi and then model /= Void  then
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
--		-- generation of the title
--		st.extend(clone(class_data.name))
--		if class_data.has_generics then
--			generate_generics (class_data, st )
--		end
--		st.extend("%N")
--		st.extend("<BR>")
--		st.extend("%N")
--		st.extend("<BR>")
--		model.forth
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		-- generation of the title
--		st.extend("Class ")
--		st.extend(clone(class_data.name))
--		if class_data.has_generics then
--			generate_generics ( class_data, st)
--		end
--		generate_properties ( class_data, st )
--		model.forth
--		
----		-- generation of inheir
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		generate_inh ( class_data.heir_links, st )
--		model.forth
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		generate_hei ( class_data.parent_links, st)
--		model.forth
--	
--		-- generation of clients
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		generate_cli ( class_data.client_links, st)
--		model.forth
--
--		-- generation of suppliers
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		generate_sup ( class_data.supplier_links, st )
--		model.forth
--
--		-- link 0
--		from
--		until
--			model.item.is_equal("...") or model.after
--		loop
--			st.extend(clone(model.item))
--			st.extend("%N")
--			model.forth
--		end
--		model.forth
--		generate_relational ( class_data, st, FALSE,FALSE )
--		st.extend("Chart Format</A>")
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
--		-- link1
--		generate_parent_cluster( class_data, st, FALSE)
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
--		-- end
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
--		-- generation to a file
--	--	!! dir.make ( Environment.html_directory)
--	--	if dir.exists then
--			!! file_n.make
--			file_n.extend (Environment.html_directory)
--			!! str.make(20)
--			file_n.extend(class_data.parent_cluster.name)
--			str.append (class_data.name)
--			str.append ("_cas")
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
--	--	end
--		fi.close
--		end
--		rescue
----			Windows.add_message ("problem in Class_HTML, for the generation",
--						1)
--			if not error_fi then
--				error_fi := TRUE
--				retry
--			end
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
			if desc.item.is_equal("<<description>>") then
				s.extend("Not available")
			else 
				s.extend(desc.item)
			end
			s.extend("<BR>")
			desc.forth
		end
		end
	end

generate_inh ( l : SORTED_TWO_WAY_LIST[INHERIT_DATA]; 
				s : LINKED_LIST[STRING] ) is
		local
			str,s0 : STRING
			file_name : FILE_NAME
		do
		s.extend("<ul>")
		if l /= Void then
		from
			l.start
		until
			l.after
		loop
			if l.item.parent=Void then
				-- the parent is not in our system ...
				if l.item.t_o_name/= Void and then l.item.t_o_name.count>0 then
					s.extend(l.item.t_o_name)
					s.extend("<BR>")
				end		
			else
				if	l.item.parent.is_class then
					
					!! str.make (20)
					!! s0.make(20) 
					s0.append("../")
					s0.append (l.item.parent.parent_cluster.name)
					s0.append("/")
					s0.append(l.item.parent.name)
		
					str.append("<A HREF=%"")
					str.append(s0)
					str.append("_cas.html%">")
					s.extend(clone(str))
					!! str.make (20)
					str.append(l.item.parent.name)
					str.append(l.item.gene_generics)
					s.extend(str)
					s.extend("</A><BR>")
				end
			end
			l.forth
		end
		else
			s.extend("None")
		end
	end

generate_cli ( l : SORTED_TWO_WAY_LIST[CLI_SUP_DATA]; 
			s : LINKED_LIST[STRING] ) is
	local
		str,s0 : STRING
		file_name : FILE_NAME
	do
		s.extend("<ul>")
		if l /= Void then
		from
			l.start
		until
			l.after
		loop
			if l.item.supplier /= Void and then not l.item.supplier.is_cluster then
				!! str.make (20)
				!! s0.make(20)
				s0.append("../")
				s0.append (l.item.supplier.parent_cluster.name)
				s0.append("/")
				s0.append(l.item.supplier.name)
				str.append("<A HREF=%"")
				str.append(s0)
				str.append("_cas.html%">")
				s.extend(clone(str))
				!! str.make (20)
				str.append(l.item.supplier.name)
				str.append(l.item.gene_generics)
				s.extend(str)
				s.extend("</A><BR>")
			elseif l.item.t_o_name/= Void and then not l.item.t_o_name.empty then
				!! str.make (20)
				str.append(l.item.t_o_name)
				s.extend(str)
				s.extend("<BR>")
			end
			l.forth
		end
		else
			s.extend("None")
		end
		s.extend("</ul>")
	end

generate_hei( l : LINKED_LIST[INHERIT_DATA]; 
			s : LINKED_LIST[STRING] ) is
	local
		str,s0 : STRING
		file_name : FILE_NAME
	do
		s.extend("<ul>")
		if l /= Void then
		from
			l.start
		until
			l.after
		loop
			if not l.item.heir.is_cluster then
			--	s.extend("<li>")
				!! str.make (20)
				!! s0.make(20)
				s0.append ("../")
				s0.append (l.item.heir.parent_cluster.name)
				s0.append("/")
				s0.append(l.item.heir.name)
				str.append("<A HREF=%"")
				str.append(s0)
				str.append("_cas.html%">")
				s.extend(clone(str))
				!! str.make (20)
				str.append(l.item.heir.name)
				str.append(l.item.gene_generics)
				s.extend(str)
				s.extend("</A><BR>")
		elseif l.item.f_rom_name/= Void and then not l.item.f_rom_name.empty then
				!! str.make (20)
				str.append(l.item.f_rom_name)
				s.extend(str)
				s.extend("<BR>")
			end
			l.forth
		end
		else
			s.extend("None")
		end
	end

generate_sup ( l : LINKED_LIST[CLI_SUP_DATA]; 
			s : LINKED_LIST[STRING] ) is
	local
		str,s0 : STRING
		file_name : FILE_NAME
	do
		s.extend("<ul>")
		if l /= Void then
		from
			l.start
		until
			l.after
		loop
			if l.item.client.is_class then
			--	s.extend("<li>")
				!! str.make (20)
				!! s0.make(20)
			--	file_name.extend (Environment.html_directory)
				s0.append ("../")
				s0.append (l.item.client.parent_cluster.name)
				s0.append("/")
				s0.append (l.item.client.name)
				str.append("<A HREF=%"")
				str.append(s0)
				str.append("_cas.html%">")
				s.extend(clone(str))
				!! str.make (20)
				str.append(l.item.client.name)
				str.append(l.item.gene_generics)
				s.extend(str)
				s.extend("</A><BR>")
			elseif l.item.f_rom_name/= Void and then not l.item.f_rom_name.empty then
				!! str.make (20)
				str.append(l.item.f_rom_name)
				s.extend(str)
				s.extend("<BR>")

			end
			l.forth
		end
		else
			s.extend("None")
		end
		--s.extend("</ul>")
	end

generate_generics ( cl: CLASS_DATA; st : LINKED_LIST [ STRING ] ) is
	local
		str : STRING
	do
		!! str.make ( 20)
		str.append(cl.generic_string_name)
		st.extend(str)
	end
	

generate_properties ( cl : CLASS_DATA; st : LINKED_LIST[ STRING] ) is
	local
		boobool : BOOLEAN
	do
		if cl.is_deferred or cl.is_effective or
		   cl.is_interfaced or cl.is_persistent or
		   cl.is_reused then boobool := TRUE
		   st.extend("<BR>(")
		end
		if cl.is_deferred then st.extend("deferred ") end
		if cl.is_effective then st.extend("effective") end
		if cl.is_interfaced then st.extend("interfaced ") end
		if cl.is_persistent then st.extend("persitent ") end
		if cl.is_reused then st.extend("reused") end
		if boobool then st.extend(")") end
	end
	  
end -- class CLASS_HTML
