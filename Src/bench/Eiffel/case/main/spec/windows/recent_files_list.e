indexing
	description: "Open recent project command"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	RECENT_FILES_LIST

inherit
		LINKED_LIST [ STRING ]
			rename 
				make as old_make
			end

		ONCES

		CONSTANTS
creation
	make, 
	add_project, add_project_name

feature -- Initialization

	make (m: like main_window; a_parent : like parent_menu) is
			-- init
		do
			old_make

			main_window:= m
			parent_menu := a_parent
			fill_list
			create_menus
		end

	add_project is
		do
			old_make
			fill_list
			add_item
		end

	add_project_name ( s : STRING ) is
	do
		old_make
		fill_list
		add_item_name	( s	)
	end

	add_item_name ( new_project : STRING ) is
		local
			al_found : BOOLEAN	
			tmp : LINKED_LIST [ STRING ]	
			s : STRING
			i : INTEGER
			exec : EXECUTION_ENVIRONMENT	
			fi : FILE_NAME	
	do
			!! tmp.make
			from
				start
			until
				after 	
			loop
				if not Environment.project_directory.is_equal(
					extract_directory (item )) then
					tmp.extend(item)
				end
				forth	
			end	
			-- now we rebuild Current
			wipe_out
			extend(new_project)
			from
				tmp.start
				i:= 0
			until
				tmp.after		
				or i=5 
			loop
				extend(tmp.item)
				tmp.forth
				i := i+1	
			end
			-- LEt's insert it now
			!! s.make ( 20 )
			from
				start
			until
				after
			loop
				if s.count>1 then
					s.append(";")
				end
				s.append(item)
				forth
			end	
			!! exec
			exec.put(s,"projectslist")	
		extend	( s	)
	end

feature -- New/Old project loaded

	add_item is
		local
			al_found : BOOLEAN	
			tmp : LINKED_LIST [ STRING ]	
			s : STRING
			i : INTEGER
			exec : EXECUTION_ENVIRONMENT	
			fi : FILE_NAME	
		do
			!! tmp.make
			from
				start
			until
				after 	
			loop
				if not Environment.project_directory.is_equal(
					extract_directory (item )) then
					tmp.extend(item)
				end
				forth	
			end	
			-- now we rebuild Current
			wipe_out
			!! fi.make	
			fi.extend(Environment.project_directory)
			fi.extend(Environment.size_window_name)	
			fi.add_extension("ecr")
			extend(fi)
			from
				tmp.start
				i:= 0
			until
				tmp.after		
				or i=5 
			loop
				extend(tmp.item)
				tmp.forth
				i := i+1	
			end
			-- LEt's insert it now
			!! s.make ( 20 )
			from
				start
			until
				after
			loop
				if s.count>1 then
					s.append(";")
				end
				s.append(item)
				forth
			end	
			!! exec
			exec.put(s,"projectslist")	
		end


feature -- Attributes
	main_window: MAIN_WINDOW
	parent_menu : EV_MENU_ITEM_HOLDER

feature -- Extraction

	extract_directory ( s : STRING ): STRING is
		-- extract the directory where s is contained
	local
		ind1,ind : INTEGER
	do
		!! Result.make(20)
		from
			ind1:=0
			ind:=1
		until
			ind=0
		loop
			ind := s.index_of('/',ind1+1)
			if ind=0 then
				ind:=s.index_of('\',ind1+1)
			end
			if ind>0 then
				ind1:=ind
			end
		end
		-- the last position of '/' orr '\' is contained in ind1
		if ind1>0  then
			-- no problemo
			Result.append(s.substring(1,ind1-1))
		end
	end

	fill_list is
		local
			exec : EXECUTION_ENVIRONMENT
			s : STRING
		do
		--	!! exec
		--	s:= exec.get("projectslist")
		--	if s/= Void then
		--		extract ( s )
		--	end 
		end

	extract ( s:STRING ) is
		-- extract elements from s
		local
			ind, ind1  : INTEGER
			err : BOOLEAN
		do
			if not err then
				from
					ind1:=0
					ind:=1
				until
					ind=0
				loop
					ind := s.index_of(';',ind1+1)
					if ind>1 then
						extend( s.substring(ind1+1, ind-1 ))	
						ind1:=ind
					else
						extend(s.substring(ind1+1, s.count))
					end
				end
			end	
		rescue
			err := TRUE
			retry	
		end

feature -- creation of menus

	create_menus is
		local
			m: EV_MENU_ITEM
			load_recent_com : RETRIEVE_PROJECT
		do
			from
				start
			until
				after
			loop
				!! load_recent_com.make_recent (main_window, item)
				!! m.make_with_text (parent_menu, item)
				m.add_select_command(load_recent_com, Void )
				forth
			end
		end

end -- class RECENT_FILES_LIST
