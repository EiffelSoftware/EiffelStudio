indexing

	description:
		"Deferred Class to make the window size savable";
	date: "$Date$";
	revision: "$Revision$"

deferred	class SIZE_SAVABLE

	inherit

		CONSTANTS

		ONCES

feature -- command
		
		save_size	is
			-- command that save the size of Current
			-- ( Current is called back by save_size_com )
		local
--			height_name	: STRING
--			width_name	: STRING
--		
--			f_n	: FILE_NAME
--			f_n2	: FILE_NAME
--			source	: PLAIN_TEXT_FILE
--			temporary	: PLAIN_TEXT_FILE
--			destination	: PLAIN_TEXT_FILE
--		
--			height_found	: BOOLEAN
--			width_found	: BOOLEAN
--			index_size	: INTEGER
--			index_colon	: INTEGER
--
--			work_string	: STRING
--
--			compo : COMPOSITE
--			err : BOOLEAN
--
--			root_cluster	: CLUSTER_DATA
--			root_cluster_name	: STRING

		do
			
--			if not err then
--				height_name	:= get_height_name
--				width_name	:= get_width_name
--
--				height_found	:= false
--				width_found	:= false
--
--				!! f_n.make
--				f_n.extend	(environment.preference_file_name)
--
--				!! source.make	( f_n	)
--
--				if	not source.exists or source.empty
--				then
--					!! f_n.make_from_string	( environment.eiffel_directory	)
--					f_n.extend	( "eifinit"	)
--					f_n.extend	( "case"	)
--					f_n.extend	( "general"	)
--					!! source.make	( f_n	)
--				end 
--
--				!! f_n2.make_from_string	( environment.project_directory	)
--				f_n2.extend ("save_size.tmp")
--
--				!! temporary.make_create_read_write	(f_n2)
--
--				if	source.exists
--				then
--					source.open_read		
--					from
--						source.start
--					until
--						source.after	
--					loop
--						source.read_line
--						work_string	:= clone	( source.last_string	)
--						if	work_string.count > 0
--						then
--
--							index_size	:= work_string.substring_index	( height_name	, 1	)
--							if	index_size	= 1	and 
--								(	work_string.item	( index_size + height_name.count	) = ' '	or
--									work_string.item	( index_size + height_name.count	) = ':'
--								)	
--							then
--								height_found	:= true
--								index_colon	:= work_string.substring_index	( ":"	, 1	)
--								if	index_colon	/= 0
--								then	
----									work_string.replace_substring	( height.out	, index_colon + 1	, work_string.count	)
--								end					
--							end
--
--							index_size	:= work_string.substring_index	( width_name	, 1	)
--							if	index_size	= 1	and
--								(	work_string.item	( index_size + width_name.count	) = ' '	or
--									work_string.item	( index_size + width_name.count	) = ':'
--								)	
--							then
--								width_found	:= true
--								index_colon	:= work_string.substring_index	( ":"	, 1	)
--								if	index_colon	/= 0
--								then
--									work_string.replace_substring	( width.out	, index_colon + 1	, work_string.count	)
--								end					
--							end
--
--							temporary.put_string	( work_string	)
--							temporary.new_line	
--						end
--					end
--				end
--				if	not height_found
--				then
--					temporary.put_string	( height_name	)
--					temporary.put_string	( " : "	)
--					temporary.put_string	( height.out	)
--					temporary.new_line
--				end
--				if	not width_found
--				then
--					temporary.put_string	( width_name	)
--					temporary.put_string	( " : "	)
--					temporary.put_string	( width.out	)
--					temporary.new_line
--				end
--				source.close			
--				temporary.close
--				!! temporary.make	( f_n2	)
--		
--				!! f_n.make
--				f_n.extend	(environment.preference_file_name)
--				temporary.change_name	( f_n	)
--			else
--				Windows.message(Windows.main_graph_window, "Mg", "")
--			end	
--		rescue
--			Windows.add_message("save_size of size_savable failed",1)
--			err := TRUE
--			retry
	end
	
	save_dimensions(args: EV_ARGUMENT; data: EV_EVENT_DATA)	is
			-- command that save the size of Current
			-- ( Current is called back by save_size_com )
		local
--			height_name	: STRING
--			width_name	: STRING
--		
--			f_n	: FILE_NAME
--			f_n2	: FILE_NAME
--			source	: PLAIN_TEXT_FILE
--			temporary	: PLAIN_TEXT_FILE
--			destination	: PLAIN_TEXT_FILE
--		
--			height_found	: BOOLEAN
--			width_found	: BOOLEAN
--			index_size	: INTEGER
--			index_colon	: INTEGER
--
--			work_string	: STRING
--
--			compo : COMPOSITE
--			err : BOOLEAN
--
--			root_cluster	: CLUSTER_DATA
--			root_cluster_name	: STRING

		do
			
--			if not err then
--				if environment.preference_file_name /= Void then
--					height_name	:= get_height_name
--					width_name	:= get_width_name
--	
--					height_found	:= false
--					width_found	:= false
--	
--					!! f_n.make
--					f_n.extend	(environment.preference_file_name)
--	
--					!! source.make	( f_n	)
--	
--					if	not source.exists or source.empty
--					then
--						!! f_n.make_from_string	( environment.eiffel_directory	)
--						f_n.extend	( "eifinit"	)
--						f_n.extend	( "case"	)
--						f_n.extend	( "general"	)
--						!! source.make	( f_n	)
--					end 
--	
--					!! f_n2.make_from_string	( environment.project_directory	)
--					f_n2.extend ("save_size.tmp")
--	
--					!! temporary.make_create_read_write	(f_n2)
--	
--					if	source.exists
--					then
--						source.open_read		
--						from
--							source.start
--						until
--							source.after	
--						loop
--							source.read_line
--							work_string	:= clone	( source.last_string	)
--							if	work_string.count > 0
--							then
--	
--								index_size	:= work_string.substring_index	( height_name	, 1	)
--								if	index_size	= 1	and 
--									(	work_string.item	( index_size + height_name.count	) = ' '	or
--										work_string.item	( index_size + height_name.count	) = ':'
--									)	
--								then
--									height_found	:= true
--									index_colon	:= work_string.substring_index	( ":"	, 1	)
--									if	index_colon	/= 0
----									then	
--										work_string.replace_substring	( height.out	, index_colon + 1	, work_string.count	)
--									end					
--								end
--	
--								index_size	:= work_string.substring_index	( width_name	, 1	)
--								if	index_size	= 1	and
--									(	work_string.item	( index_size + width_name.count	) = ' '	or
--											work_string.item	( index_size + width_name.count	) = ':'
--								)	
--								then
--									width_found	:= true
--									index_colon	:= work_string.substring_index	( ":"	, 1	)
--									if	index_colon	/= 0
--									then
--									work_string.replace_substring	( width.out	, index_colon + 1	, work_string.count	)
--									end				
--								end
--	
--								temporary.put_string	( work_string	)
--								temporary.new_line	
--							end
--						end
--					end
--					if	not height_found
--					then	
--						temporary.put_string	( height_name	)
--						temporary.put_string	( " : "	)
--						temporary.put_string	( height.out	)
--						temporary.new_line
--					end
--					if	not width_found
--					then
--						temporary.put_string	( width_name	)
--						temporary.put_string	( " : "	)
--						temporary.put_string	( width.out	)
--						temporary.new_line
--					end	
--					source.close			
--					temporary.close
--					!! temporary.make	( f_n2	)
--			
--					!! f_n.make
--					f_n.extend	(environment.preference_file_name)
--					temporary.change_name	( f_n	)
--				end
--			else
--				Windows.message(Windows.main_graph_window, "Mg", "")
--			end	
--		rescue
--		--	Windows_manager.popup_message(Void, "save_size of size_savable failed",)
--			err := TRUE
--			retry
	end
	


feature	-- attributes
		height	: INTEGER	is
		deferred
		end

		width	: INTEGER	is
		deferred
		end


feature	-- Names of the variables

		get_height_name	: STRING	is
		deferred
		end

		get_width_name	: STRING	is
		deferred
		end



end -- class SIZE_SAVABLE
