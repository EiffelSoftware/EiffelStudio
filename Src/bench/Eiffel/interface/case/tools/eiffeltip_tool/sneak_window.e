indexing
	description: "Sneak Window in which the basic info of a class is contained"
	author: pascalf
	components : EiffelCase
	date: "$Date$"
	revision: "$Revision$"

class
	SNEAK_WINDOW

inherit
	
	FORM_D
		rename 
			make as formd_make
		end

	ONCES

	CONSTANTS

creation
	make

feature -- Initialization

	make is
			-- Creation routine
		do
		--	formd_make("Sneak Window",Windows.main_graph_window)
			create_window
			realize
		end

feature -- Drawing attributes

	--s_text : SNEAK_TEXT

	feature -- Attributes

	separator1: THREE_D_SEPARATOR
	separator2: THREE_D_SEPARATOR
	separator3: THREE_D_SEPARATOR
	separator4: THREE_D_SEPARATOR
	separator5: THREE_D_SEPARATOR
	separator6: THREE_D_SEPARATOR

	label1: LABEL
			-- Type of object

	label2: LABEL
			-- Indexing

	label3: LABEL
			-- Inherit from

	label4: LABEL
			-- queries

	label5: LABEL
			-- Commands

	label6: LABEL
			-- Constraints

	text_desc 	: SCROLLED_T
	text_index	: SCROLLED_T
	text_inh	: SCROLLED_T
	text_quer	: SCROLLED_T
	text_com	: SCROLLED_T
	text_constr	: SCROLLED_T

	object_form	: FORM
	indexing_form	: FORM
	

feature -- building

	create_window is
	local
		format: WIDGET_ATTRIBUTES
	do
			-- Creation of the Main Forms

			!!object_form.make	( "Object Form"	, current	)
			!!indexing_form.make	( "Indexing Form"	, current	)

			!! separator1.make ("separator1", Current)
			!! separator2.make ("separator2", Current)
			!! separator3.make ("separator3", Current)
			!! separator4.make ("separator4", Current)
			!! separator5.make ("separator5", Current)
			!! separator6.make ("separator6", Current)

			!! label1.make	( "label1"	, object_form	)
			!! label2.make	( "label2"	, indexing_form	)
			!! label3.make ("label3", Current)
			!! label4.make ("label4", Current)
			!! label5.make ("label5", Current)
			!! label6.make ("label6", Current)

			!! text_desc.make	( "text_desc"	, object_form	)
			!! text_index.make	( "text_index"	, indexing_form	)
			!! text_inh.make ("text_inh", Current)
			!! text_quer.make ("text_quer", Current)
			!! text_com.make ("text_com", Current)
			!! text_constr.make ("text_constr", Current)
		
			!! format.set_composite (Current)

			set_values
	end

	set_values is
		do

			-- Separator Settings 	
			separator1.set_double_line
			separator1.set_horizontal	( false	)
			separator2.set_single_line
			separator2.set_horizontal	( true	)
			separator3.set_single_line	
			separator3.set_horizontal	( false	)
			separator4.set_single_line
			separator4.set_horizontal	( true	)
			separator5.set_single_line
			separator5.set_horizontal	( true	)
			separator6.set_single_line
			separator6.set_horizontal	( true	)

			current.set_fraction_base	( 100	)
			object_form.set_fraction_base	( 100	)
			indexing_form.set_fraction_base	( 100	)
			
			--label1.set_text ("Type of object")
			label1.set_text ("Description")
			label2.set_text ("Indexing")
			label3.set_text ("Inherit from")
			label4.set_text ("Queries")
			label5.set_text ("Commands")
			label6.set_text ("Constraints")

			-- Separator Positions
			current.attach_top	( separator1	, 0	)
			current.attach_bottom_position	( separator1	, 20	)	
			current.attach_left_position	( separator1	, 50	)

			current.attach_top_widget	( separator1	, separator2	, 0	)
			current.attach_left	( separator2	, 0	)
			current.attach_right	( separator2	, 0	)
		
			current.attach_top_widget	( separator2	, separator3	, 0	)
			current.attach_bottom	( separator3	, 0	)
			current.attach_left_position	( separator3	, 25	)

			current.attach_top_position	( separator4	, 40	)
			current.attach_left	( separator4	, 0	)
			current.attach_right	( separator4	, 0	)

			current.attach_top_position	( separator5	, 60	)
			current.attach_left	( separator5	, 0	)
			current.attach_right	( separator5	, 0	)

			current.attach_top_position	( separator6	, 80	)
			current.attach_left	( separator6	, 0	)
			current.attach_right	( separator6	, 0	)


			-- Main Forms attachments

			current.attach_top	( object_form	, 0	)
			current.attach_bottom_widget	( separator2	, object_form	, 0	)
			current.attach_left	( object_form	, 0	)
			current.attach_right_widget	( separator1	, object_form	, 0	)
			
			current.attach_top	( indexing_form	, 0	)
			current.attach_bottom_widget	( separator2	, indexing_form	, 0	)
			current.attach_left_widget	( separator1	, indexing_form	, 0	)
			current.attach_right	( indexing_form	, 0	)

			current.attach_top_position	( label3	, 30	)
			current.attach_left	( label3	, 5	)

			current.attach_top_position	( label4	, 50	)
			current.attach_left	( label4	, 5	)

			current.attach_top_position	( label5	, 70	)
			current.attach_left	( label5	, 5	)

			current.attach_top_position	( label6	, 90	)
			current.attach_left	( label6	, 5	)

			current.attach_top_widget	( separator2	, text_inh	, 0	)
			current.attach_bottom_widget	( separator4	, text_inh	, 0	)
			current.attach_left_widget	( separator3	, text_inh	, 0	)
			current.attach_right	( text_inh	, 0	)

			current.attach_top_widget	( separator4	, text_quer	, 0	)
			current.attach_bottom_widget	( separator5	, text_quer	, 0	)
			current.attach_left_widget	( separator3	, text_quer	, 0	)
			current.attach_right	( text_quer	, 0	)

			current.attach_top_widget	( separator5	, text_com	, 0	)
			current.attach_bottom_widget	( separator6	, text_com	, 0	)
			current.attach_left_widget	( separator3	, text_com	, 0	)
			current.attach_right	( text_com	, 0	)

			current.attach_top_widget	( separator6	, text_constr	, 0	)
			current.attach_bottom	( text_constr	, 0	)
			current.attach_left_widget	( separator3	, text_constr	, 0	)
			current.attach_right	( text_constr	, 0	)


			-- Object_form Attachments
			object_form.attach_top	( label1	, 5	)
			object_form.attach_left	( label1	, 10	)

			object_form.attach_top	( text_desc	, 20	)
			object_form.attach_bottom	( text_desc	, 0	)
			object_form.attach_left	( text_desc	, 0	)
			object_form.attach_right	( text_desc	, 0	)

			-- Index_form Attachments			

			indexing_form.attach_top	( label2	, 5	)
			indexing_form.attach_left	( label2	, 10	)

			indexing_form.attach_top	( text_index	, 20	)
			indexing_form.attach_bottom	( text_index	, 0	)
			indexing_form.attach_left	( text_index	, 0	)
			indexing_form.attach_right	( text_index	, 0	)

			
--			text_desc.set_background_color ( Resources.background_color )
			text_desc.hide_horizontal_scrollbar
			text_desc.set_multi_line_mode 
			text_desc.hide_vertical_scrollbar
			text_desc.set_read_only
		
--			text_index.set_background_color ( Resources.background_color )
			text_index.hide_horizontal_scrollbar
			text_index.set_multi_line_mode 
			text_index.hide_vertical_scrollbar
			text_index.set_read_only

--			text_inh.set_background_color ( Resources.background_color )
			text_inh.hide_vertical_scrollbar
			text_inh.hide_horizontal_scrollbar
			text_inh.set_read_only
			
--			text_quer.set_background_color ( Resources.background_color )
			text_quer.hide_vertical_scrollbar
			text_quer.hide_horizontal_scrollbar
			text_quer.set_read_only

--			text_com.set_background_color ( Resources.background_color )	
			text_com.hide_vertical_scrollbar
			text_com.hide_horizontal_scrollbar
			text_com.set_read_only

--			text_constr.set_background_color ( Resources.background_color )
			text_constr.hide_vertical_scrollbar
			text_constr.hide_horizontal_scrollbar
			text_constr.set_read_only

			set_size ( resources.sneak_window_width	, resources.sneak_window_height	)
		end

feature -- popping

	set_coord ( xx: INTEGER; yy : INTEGER ) is
		-- set the coords for popping
		do
			set_x_y (xx, yy )
		end

	class_data : CLASS_DATA 

	set_class ( cl : CLASS_DATA ) is
		-- set the class_data field
		require
			class_not_void : cl/= Void 
		do
			set_sensitive
			set_title ( cl.name )
			class_data := cl
			put_description
			put_indexing
			put_inh
			put_queries
			put_commands
			put_constraints
			--set_insensitive
			popup
		end

	cursor_position (text_area : TEXT) : INTEGER is
	local
		coordonnee : COORD_XY
	do
		coordonnee := text_area.coordinate (text_area.cursor_position)
		Result := coordonnee.x
	end

		put_description is 
		local
			s : STRING
			description : DESCRIPTION_DATA
			description_element : STRING
			i : INTEGER
			coordonnee : COORD_XY
			position : INTEGER
			line : INTEGER
			length : INTEGER
			fin : BOOLEAN
		do
			if class_data.description/= Void and then class_data.description.count>0 then
					--!! s.make ( 30 )
					--s.append ( class_data.description.i_th (1 ) )
					--if class_data.description.count>1 then
					--	s.append("%N")
					--	s.append(class_data.description.i_th ( 2 ))
					--end
					--s.append("%N")
					--if class_data.description.count>2 then
					--	s.append (class_data.description.i_th(3))
					--end
					--if class_data.description.count>3 then
					--	s.append (" ... " )
					--end
					--if not s.is_equal("<<description>>%N") then
					--	text_desc.set_text (s)
					--end

				text_desc.clear
				length := text_desc.width - 15
				!! s.make (0)
				description := class_data.description
				line := 1
				fin := false
				from
					description.start
				until
					description.after
				loop
					description_element := description.item
					from
						i := 1
					until
						i > description_element.count
					loop
						position := cursor_position (text_desc)
						if line = text_desc.rows and position > length - 20 and not fin then
							text_desc.append ("...")
							fin := true
						end
						position := cursor_position (text_desc)
						if position > length then
							if line < text_desc.rows then
								if description_element.item (i) /= ' ' and description_element.item (i-1) /= ' ' then
									text_desc.append ("-")
								end
								text_desc.append ("%N")							
							end
							line := line + 1
						end
						if line <= text_desc.rows and not fin then
							s.wipe_out
							s.extend (description_element.item (i))
							text_desc.append (s)
						end
						i := i + 1
					end								
					description.forth
					if line < text_desc.rows then
						text_desc.append ("%N")							
					end
					line := line + 1
				end
			end
		end


		put_indexing is 
			-- fill and update the text_index field ...
		local
			ind : ELEMENT_LIST [ INDEX_DATA ]
			index_element : INDEX_DATA
			index_element_string : STRING
			s : STRING
			i : INTEGER
			position : INTEGER
			line : INTEGER
			length : INTEGER
			coordonnee : COORD_XY
			fin : BOOLEAN
		do
			text_index.clear
			class_data.request_for_information
			if class_data.content/= Void and then 
			   class_data.content.chart/= Void and then
			   class_data.content.chart.indexes/= Void and then
			   class_data.content.chart.indexes.count >0 then
					-- this is not a nice way to proceed. Yet, it is safe and allows
					-- to use simply only one variable : ind.
					ind := class_data.content.chart.indexes
					--!! s.make ( 30 )
					--from
					--	ind.start
					--	i := 1
					--until
					--	ind.after	or
					--	i = 4 
					--loop
					--	s.append ( ind.item.clickable_string )
					--	if i/= 3 then
					--		s.append ("%R%N")
					--	end
					--	ind.forth
					--	i:= i+1
					--end	
					--text_index.set_text ( s )

				!! s.make (0)
				length := text_index.width - 15
				line := 1
				from
					ind.start
				until
					ind.after
				loop
					index_element := ind.item
					index_element_string := index_element.clickable_string
					from
						i := 1
					until
						i > index_element_string.count
					loop
						position := cursor_position (text_index)
						if line = text_index.rows and position > length - 20 and not fin then
							text_index.append ("...")
							fin := true
						end
						position := cursor_position (text_index)
						if position > length then
							if line < text_index.rows then
								if index_element_string.item (i) /= ' ' and index_element_string.item (i-1) /= ' ' then
									text_index.append ("-")
								end
								text_index.append ("%N")							
							end
							line := line + 1
						end
						if line <= text_index.rows and not fin then
							s.wipe_out
							s.extend (index_element_string.item (i))
							--if not s.has ('%"') then
								text_index.append (s)
							--end
						end
						i := i + 1
					end								
					ind.forth
					if line < text_index.rows then
						text_index.append ("%N")							
					end
					line := line + 1
				end
			end											
		end

		put_inh is
			-- fill and update the text_inh field ...
		local
			l : LINKED_LIST [ INHERIT_DATA ]
			s : STRING
			i : INTEGER
			inherit_element	: INHERIT_DATA
			name : STRING
			position : INTEGER
			line : INTEGER
			length : INTEGER
			coordonnee : COORD_XY
			fin : BOOLEAN
		do
			text_inh.clear
			if class_data.heir_links/= Void and then
			   class_data.heir_links.count >0 then
					l := class_data.heir_links
					--!! s.make ( 30 )
					--from
					--	l.start
					--	i := 1
					--until
					--	l.after
					--loop
					--	if	l.item.parent	/= void
					--	then
					--		s.append (l.item.parent.name )
					--	else
					--		if	l.item.t_o_name	/= void
					--		then
					--			s.append	( l.item.t_o_name	)
					--		end
					--	end
					--	if i=3 then 
					--		s.append("%R%N")
					--		i := 0
					--	else
					--		s.append (", ")
					--	end
					--	i := i +1
					--	l.forth
					--end
					--text_inh.set_text ( s )
				!! s.make (0)
				length := text_inh.width - 15
				line := 1
				fin := false
				from
					l.start
				until
					l.after
				loop
					inherit_element := l.item
					!! name.make (0)
					if l.item.parent /= void
					then
						name.append (l.item.parent.name )
					else
						if l.item.t_o_name /= void
						then
							name.append ( l.item.t_o_name	)
						end
					end
					from
						i := 1
					until
						i > name.count
					loop
						position := cursor_position (text_inh)
						if line = text_inh.rows and position > length - 20 and not fin then
							text_inh.append ("...")
							fin := true
						end
						position := cursor_position (text_inh)
						if position > length then
							if line<text_inh.rows then
								if name.item (i) /= ' ' and name.item (i-1) /= ' ' then
									text_inh.append ("-")
								end
								text_inh.append ("%N")							
							end
							line := line + 1
						end
						if line <= text_inh.rows and not fin then
							s.wipe_out
							s.extend (name.item (i))
							text_inh.append ( s )
						end

						i := i + 1
					end								
					l.forth
					if not l.after and not fin then
						if line <= text_inh.rows then
							text_inh.append (", ")							
						end
					end
				end
			end
		end

		put_queries is
			-- fill and update the text_inh field ...
		local
			quer : FEATURE_LIST
			s : STRING
			tmp : STRING
			i : INTEGER
			query_element : FEATURE_DATA
			name : STRING
			position : INTEGER
			line : INTEGER
			length : INTEGER
			coordonnee : COORD_XY
			need_coma : BOOLEAN
			fin : BOOLEAN
			first : BOOLEAN
		do
			first	:= true
			need_coma := false
			text_quer.clear
			if class_data.features/= Void then
				quer := class_data.features
				--!! s.make ( 30 )
				--from
				--	quer.start
				--	i := 0
				--until
				--	quer.after
				--loop
				--	!! tmp.make ( 20 )
				--	if quer.item.has_result then
				--		tmp.append (quer.item.name)
				--		if i=3 then 
				--			s.append("%R%N")
				--			i := 0
				--		else
				--			if i>0 then
				--				s.append(", ")
				--			end
				--		end
				--	end
				--	s.append ( tmp )
				--	quer.forth
				--	if tmp.count>0 then
				--		i := i +1
				--	end
				--end
				--text_quer.set_text ( s )

				!! s.make (0)
				length := text_quer.width - 15
				line := 1
				from
					quer.start
				until
					quer.after
				loop
					query_element := quer.item
					if query_element.has_result
					then
						if	not first	and
							need_coma	and
							line <= text_quer.rows
						then
							text_quer.append (", ")							
						end

						first	:= false
						need_coma := false
					
						!! name.make (0)
						name.append (query_element.name)
						from
							i := 1
						until
							i > name.count
						loop
							position := cursor_position (text_quer)
							if line = text_quer.rows and position > length - 20 and not fin then
								text_quer.append ("...")
								fin := true
							end
							position := cursor_position (text_quer)
							if position > length then
								if line<text_quer.rows then
									if name.item (i) /= ' ' and name.item (i-1) /= ' ' then
										text_quer.append ("-")
									end
									text_quer.append ("%N")				
								end
								line := line + 1
							end
							if line <= text_quer.rows and not fin then
								s.wipe_out
								s.extend (name.item (i))
								text_quer.append ( s )
							end
							i := i + 1
						end
						need_coma := true
					end
					quer.forth
				end		

			end
		end


		put_commands is
			-- fill and update the text_inh field ...
		local
			quer : FEATURE_LIST
			s : STRING
			tmp : STRING
			i : INTEGER
			query_element : FEATURE_DATA
			name : STRING
			position : INTEGER
			line : INTEGER
			length : INTEGER
			coordonnee : COORD_XY
			need_coma : BOOLEAN
			fin : BOOLEAN
			first	: BOOLEAN
		do
			first	:= true
			text_com.clear
			if class_data.features/= Void then
				quer := class_data.features
				!! s.make (0)
				length := text_com.width - 15
				line := 1
				fin := false
				from
					quer.start
				until
					quer.after
				loop
					query_element := quer.item
					if not query_element.has_result
					then
						if	not first	and
							need_coma	and
							line <= text_com.rows
						then
							text_com.append (", ")							
						end

						first	:= false
						need_coma := false

						!! name.make (0)
						name.append (query_element.name)
						from
							i := 1
						until
							i > name.count
						loop
							position := cursor_position (text_com)
							if line = text_com.rows and position = length - 20 and not fin then
								text_com.append ("...")
								fin := true
							end
							position := cursor_position (text_com)
							if position > length then
								if line < text_com.rows then
									if name.item (i) /= ' ' and name.item (i-1) /= ' ' then
										text_com.append ("-")
									end
									text_com.append ("%N")							
								end
								line := line + 1
							end
							if line <= text_com.rows and not fin then
								s.wipe_out
								s.extend (name.item (i))
								text_com.append ( s )
							end
							i := i + 1
						end
						need_coma := true
					end
					quer.forth
				end		
			end
		end


		put_constraints is 
		local
			invar : ELEMENT_LIST [ INVARIANT_DATA ]
			s : STRING
			i : INTEGER
			invariant_element : INVARIANT_DATA
			clause : STRING
			position : INTEGER
			line : INTEGER
			length : INTEGER
			coordonnee : COORD_XY
			fin : BOOLEAN
		do
			text_constr.clear
			if class_data.content/= Void and then
				class_data.content.invariants/= Void and then
			 	class_data.content.invariants.count>0 then
						invar := class_data.content.invariants
						if invar.count>0 then
							--!! s.make ( 30 )
							--s.append ( invar.i_th(1).assertion_clause )
							--if invar.count>1 then
							--	s.append ("%R%N")
							--	s.append ( invar.i_th(2).assertion_clause )
							--end
							--if invar.count>2 then
							--	s.append (" ... ")
							--end
							--text_constr.set_text ( s )
				!! s.make (0)
				length := text_constr.width - 15
				line := 1
				fin := false
				from
					invar.start
				until
					invar.after
				loop
					invariant_element := invar.item
					!! clause.make (0)
					clause.append (invariant_element.assertion_clause)
					from
						i := 1
					until
						i > clause.count
					loop
						position := cursor_position (text_constr)
						if line = text_constr.rows and position > length - 20 and not fin then
							text_constr.append ("...")
							fin := true
						end
						position := cursor_position (text_constr)
						if position > length then
							if line<text_constr.rows then
								if clause.item (i) /= ' ' and clause.item (i-1) /= ' ' then
									text_constr.append ("-")
								end
								text_constr.append ("%N")							
							end
							line := line + 1
						end
						if line <= text_constr.rows and not fin then
							s.wipe_out
							s.extend (clause.item (i))
							text_constr.append (s)
						end
						i := i + 1
					end
					invar.forth
					if not invar.after then
						if line <= text_constr.rows and not fin then
							text_constr.append (", ")							
						end
					end
				end		
			end
		end
	end

end -- class SNEAK_WINDOW
