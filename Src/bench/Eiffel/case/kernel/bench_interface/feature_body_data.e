indexing

	description: 
		"Feature body (locals + do/once-end + rescue) or constant. %
		%Should be split in two classes (for routines and constant %
		%attribute). And shouldn't inherit from FREE_TEXT_INFO. %
		%This would greatly improve this implementation's quality. %
		%But this is uneasy, because of the way we keep backward %
		%compatibility.";
	date: "$Date$";
	revision: "$Revision$"

class 
	FEATURE_BODY_DATA

inherit

	FEATURE_ELEMENT_DATA
		redefine
			generate
		end;

	FREE_TEXT_INFO
			--%%%% for backward compatibility...
		rename
			make as make_list
		redefine
			format, generate, make_from_storer, copy, is_equal, focus
		select
			copy, is_equal, 
			focus
		end

	FREE_TEXT_INFO
		rename
			make as make_list, copy as copy_list, 
			is_equal as is_equal_list,
			focus as focus_list
		undefine
			format, generate, make_from_storer
		end

creation
	make_constant, make, make_from_storer, make_empty

feature -- Initialization

	make is 
			-- Creates a `do' body without instruction
		do
			make_list
			extend (Do_keyword) 
			do_line := 1
		ensure
			is_do: is_do
		end

	make_constant is
			-- Create a body for constant attribute
		do
			make_list
			extend (Default_constant_value)
		end

	make_empty( feat : FEATURE_DATA ) is
			-- Create an empty body ( case of deferred & once for ex. )
		do
			make_list
			if feat.is_deferred then
				extend(deferred_keyword)
			end
			if feat.is_once then
				extend(once_keyword)
			end
			if not feat.is_once and not feat.is_deferred then
				extend(do_keyword)
			end
		end

	make_from_storer (storer: S_FREE_TEXT_DATA) is
			-- Retrieve information from `storer'.
		local
			si: like item
			line_num: INTEGER
			look_for_do: BOOLEAN
			s : STRING
		do
			!! s.make ( 20 )
			if storer/= Void then
			make_list;
			from
				storer.start
				do_line := -1
				look_for_do := True
				line_num := 1
			until
				storer.after
			loop
				si := storer.item
				if si/= Void then
					s.append ( si )
					s.append ("%N")
					if look_for_do then
						if si.is_equal (Do_keyword) or else
								si.is_equal (Once_keyword) or else
								si.is_equal (Deferred_keyword) then
								do_line := line_num
								look_for_do := False
							end
						end
						extend (si)
						line_num := line_num + 1
					end
					storer.forth
				end
			end

			s := deep_clone (indentation ( s ))

			wipe_out
			extend(s)
		end

feature -- Properties

	is_constant: BOOLEAN is
			-- Is Current attached to a constant attribute?
		do
			Result := (do_line = 0)
		end

	is_deferred: BOOLEAN is
			-- Is Current body attached to a deferred feature?
		do
			Result := not is_constant and then
					i_th (do_line).is_equal (Deferred_keyword)
		end

	is_do: BOOLEAN is
			-- Is Current body attached to an effective feature?
		do
			Result := not is_constant and then
					i_th (do_line).is_equal (Do_keyword)
		end

	is_once: BOOLEAN is
			-- Is Current body attached to an effective feature?
		do
			Result := not is_constant and then
					i_th (do_line).is_equal (Once_keyword)
		end

	destroy_command (a_data: FEATURE_DATA): DESTROY is --FEATURE_SET_ATTRIBUTE_U is
			-- Destroy command for Current data
			--| because attribute <=> not routine
		do
		--	!! Result.make_with_container (a_data)
		end
	
	stone_type: INTEGER is
			-- Stone type of Current
		do
			Result := Stone_types.feature_type --%%% any/text?
		end

feature -- Comparison

	copy (other: like Current) is
		do
			do_line := other.do_line
			copy_list (other)
		end

	is_equal (other: like Current): BOOLEAN is
		do
			Result := (do_line = other.do_line) and then 
					is_equal_list (other)
		end

feature -- Access

	is_valid_for (data: DATA): BOOLEAN is
		local
			fd: FEATURE_DATA
		do
			fd ?= data
			Result := fd /= Void and then fd.has_body and then
						fd.body = Current
		end

feature -- Setting

	set_deferred is
			-- Mark Current body as part of a deferred feature
		do
			wipe_out
			extend (Deferred_keyword)
			do_line := 1
		ensure
			deferred_set: is_deferred
		end

	set_do is
			-- Mark Current body as part of an effective feature
		do
			go_set_type (Do_keyword)
		ensure
			do_set: is_do
		end

	set_once is
			-- Mark Current body as part of an effective feature
		do
			go_set_type (Once_keyword)
		ensure
			once_set: is_once
		end

feature -- Element change

	format (text: STRING) is
			-- Format description from `text'.
		local
			line: STRING;
			i, first_char, line_num: INTEGER;
			c: CHARACTER;
			look_for_do: BOOLEAN
			k,l,m,n : INTEGER
			old_body: like Current 
			text_indent	: STRING
		do
			old_body := clone (Current)
			if text.count>0 then
					wipe_out

					text_indent	:= indentation	( text	)

					text.head	( 0	)
					text.append	( text_indent	)

			end
			if text.count>0 then
				extend ( text )
			end
		end

	insert_before (data_cont: FEATURE_DATA a_data: like Current) is
			-- Insert Current before `a_data'
		do
		end


	indentation ( text : STRING ) : STRING is
	local
		indent	: STRING
		lines	: LINKED_LIST	[ STRING	]
		line_begin	: INTEGER
		line_end	: INTEGER

		line	: STRING

		tab: STRING
	
		end_of_string	: boolean

		error	: BOOLEAN
	do

		if	not error
		then
			if	text.count	> 0
			then
				line_begin	:= 1
				line_end	:= 1			
				end_of_string	:= false

				!! lines.make

				from	
				until
					end_of_string
				loop
					
					if line_begin <= text.count
					then
						line_end	:= text.substring_index	( "%N"	, line_begin	) 

						if line_end = 0
						then
							line_end	:= text.count
							end_of_string	:= true
						end
	
						lines.extend	( text.substring	( line_begin	, line_end	) )
	
						line_begin	:= line_end	+ 1
					else
						end_of_string	:= true
					end
				end
				
				indent	:= "%T%T%T"	
				
				from
					lines.start
				until
					lines.after
				loop
	
					clean	( lines.item	)
					line	:= deep_clone	( lines.item	)
					line.to_lower
	
					if	line.count	> 0
					then
	
						-- End of a Part
						-- So the Indentation Decrease
						if	find_word	( "do"	, line	) = 1 or
							find_word	( "end"	, line	) = 1 or
							find_word	( "else"	, line	) = 1 or
							find_word	( "external"	, line	) = 1 or
							find_word	( "alias"	, line	) = 1 or
							find_word	( "until"	, line	) = 1 or
							find_word	( "loop"	, line	) = 1 
						then
							if	indent.count	> 0
							then
								indent.tail	( indent.count	- 1	)
							end
						end
	
						lines.item.insert	( indent	, 1	)
	
						
						-- Beggining of a Part
						-- The Indentation Increase
						if	find_word	( "local"	, line	) = 1 or
							find_word	( "do"	, line	) = 1 or
							find_word	( "once"	, line	) = 1 or
							find_word	( "external"	, line	) = 1 or
							find_word	( "alias"	, line	) = 1 or
							find_word	( "then"	, line	) /= 0 or
							find_word	( "else"	, line	) = 1 or
							find_word	( "from"	, line	) = 1 or
							find_word	( "until"	, line	) = 1 or
							find_word	( "loop"	, line	) = 1 
						then
							indent.append	( "%T"	)
						end
	
					end

					lines.forth
				end	
	
				-- The namer Window Text is put as the same level as require so
				-- the first %T must be remove
				
				lines.start
				if	lines.item.count	> 0
				then
					if lines.item.item	( 1	) = '%T'
					then
						lines.item.tail	( lines.item.count - 1	)
					end
					if lines.item.item	( 1	) = '%T'
					then
						lines.item.tail	( lines.item.count - 1	)
					end
				end
			
				!! tab.make (resources.tab_length)
				tab.fill_blank

				from
					lines.start
				until
					lines.after
				loop
					lines.item.replace_substring_all ("%T", tab)
					lines.forth
				end
	
				!! result.make	( 0	)
	
				from
					lines.start
				until
					lines.after
				loop
					result.append	( lines.item	)				
					lines.forth
				end
	
			end

		else
			result	:= text
		end

	rescue
		error	:= true
		retry
	
	end

	find_word ( word : STRING ; s : STRING ) : INTEGER is
	local
		index_begin	: INTEGER
		index_before	: INTEGER
		index_after	: INTEGER

		ok_before	: BOOLEAN
		ok_after	: BOOLEAN

	do
		if	s /= void	and then
			s.count	/= 0	and
			word	/= void	and then
			word.count	/= 0
		then
			index_begin	:= s.substring_index	( word	, 1	) 

			if	index_begin	/= 0
			then
				index_before	:= index_begin - 1
				index_after	:= index_begin + word.count

				ok_before	:= false
				ok_after	:= false

				if	index_before	= 0	or
					s.item	( index_before	) = ' '	or
					s.item	( index_before	) = '%T'	or
					s.item	( index_before	) = '%N'
				then
					ok_before	:= true
				end

				if	index_after	> s.count	or
					s.item	( index_after	) = ' '	or
					s.item	( index_after	) = '%T'	or
					s.item	( index_after	) = '%N'	
				then
					ok_after	:= true
				end

				if	ok_before	and
					ok_after
				then
					result	:= index_begin
				end
			else
				result	:= 0
			end
		else
			result	:= 0
		end
	end

	clean ( s : STRING ) is
	do
		if	s.count	> 0
		then
			from
			until
				s.item	( 1	) /= ' '	and
				s.item	( 1	) /= '%T'
			loop
				if	s.count	> 0
				then
					s.tail	( s.count - 1	)
				end
			end
		end
	end

	focus: STRING is "Feature Body"

feature -- Output

	generate (text_area: TEXT_AREA; data: FEATURE_DATA ) is
			-- Generate Current to `text_area'	
		local
			s: STRING
			ind: INTEGER
			cl: CLASS_DATA
		do
		    -- pascalf, temporary solution
		if  not data.is_attribute    
		then
			if ( count>0 ) then

				text_area.start_body

				from
					start
					cl := data.class_container
				until
					after
				loop
					if item/= Void then
						-- We check the problem linked to the genericity "generic #n"
						-- automatically generated by EiffelBench instaed of G,H, etc ...
						if cl.generics/= Void and then cl.generics.count>0 and then item.count>1 then
							if cl.generics /= Void then
								item.replace_substring_all("Generic #1",cl.generics.i_th(1).name)
								if cl.generics.count>1 then
									item.replace_substring_all("Generic #2",cl.generics.i_th(2).name)
								end
								if cl.generics.count>2 then
									item.replace_substring_all("Generic #3",cl.generics.i_th(3).name)
								end
							end
						end
						if item.has('%/255/') then
							item.replace_substring_all("%/255/","%%/255/")
						end
						text_area.append_string (item)
						text_area.new_line
					end
					forth
				end
				text_area.end_body (stone (data))
			else
				text_area.start_body
				if is_deferred then
					text_area.append_string(Deferred_keyword)
				end
				if is_once then
					text_area.append_string(Once_keyword)
				end
				if not is_once and not is_deferred then
					text_area.append_string(Do_keyword)
				end
				text_area.new_line
				text_area.end_body ( stone(data) )
			end
		end	
	end


	generate_c (text_area: TEXT_AREA; data: FEATURE_DATA) is
            -- Generate Current to `text_area'      
		
		do          					
            text_area.start_body
			from
    			start            
            until
                after
            loop             	  
					if not item.is_equal(do_keyword) then	
						 text_area.append_string (item)
                	end
					text_area.new_line
                
				forth
            end
            text_area.end_body (stone (data))
        end

feature {FEATURE_BODY_DATA} -- Implementation properties

	do_line: INTEGER
			-- Line number where the "do" (or "deferred" or "once") is in 
			-- a routine (-1 correspond to an invalid body);
			-- 0 for a constant attribute

	Default_constant_value: STRING is "<constant_value>"
	Do_keyword: STRING is "do"
	Deferred_keyword: STRING is "deferred"
	Local_keyword: STRING is "local"
	Once_keyword: STRING is "once"
	Rescue_keyword: STRING is "rescue"

feature {NONE} -- Implementation

	go_set_type (t: like item) is
			-- Set the type of body (deferred/do/once)
		local
			p: like cursor
		do
			p := cursor
			go_i_th (do_line)
			replace (t)
			go_to (p)
		end

invariant
	not_empty: not empty
	do_line_zero_for_constant: is_constant = (do_line = 0)
	do_line_exists_in_routine: (is_deferred or else is_once or else is_do) implies (do_line > 0)

end -- class FEATURE_BODY_DATA
