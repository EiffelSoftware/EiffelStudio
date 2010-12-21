note
	description: "Container to hold attachments for forms"
	legal: "See notice at end of class.";
	status: "See notice at end of class."; 
	date: "$Date$";
	revision: "$Revision$" 
 
class
	ATTACHMENT_LIST_WINDOWS
 
inherit 
	LINKED_LIST [ATTACHMENT_WINDOWS]

create
	make 

feature -- Access

	find_widget (w: WIDGET_IMP): ATTACHMENT_WINDOWS
			-- Find the attachment that contains widget `w'
		require
			non_void: w /= Void
		local
			c: CURSOR
		do
			from
				c := cursor
				start
			variant
				count + 1 - index
			until
				after or item.widget = w
			loop
				forth
			end
			if not after then
				Result := item
			end
			go_to (c)
		end


feature -- Status setting

	add (w: WIDGET_IMP)
		local
			a: ATTACHMENT_WINDOWS
		do
			a := find_widget (w)
			if a = Void then
				create a.make (w)
				extend (a)
			end
		end

	attach_left (w,l : WIDGET_IMP; pos: INTEGER;
			relative: BOOLEAN)
			-- Attach the left of `w' to `l' separated by `pos' 
			-- which is `relative'
		local
			a : ATTACHMENT_WINDOWS
		do
			a := find_widget (w)
			if a = Void then 
				create a.make (w)
				extend (a)
			end
			a.attach_left (l, pos, relative);
		end

	attach_right (w,r : WIDGET_IMP; pos: INTEGER;
			relative: BOOLEAN)
			-- Attach the right of `w' to `l' separated by `pos' 
			-- which is `relative'
		local
			a : ATTACHMENT_WINDOWS
		do
			a := find_widget (w)
			if a = Void then 
				create a.make (w)
				extend (a)
			end
			a.attach_right (r, pos, relative);
		end

	attach_top (w,t : WIDGET_IMP; pos: INTEGER;
			relative: BOOLEAN)
			-- Attach the top of `w' to `l' separated by `pos' 
			-- which is `relative'
		local
			a : ATTACHMENT_WINDOWS
		do
			a := find_widget (w)
			if a = Void then 
				create a.make (w)
				extend (a)
			end
			a.attach_top (t, pos, relative);
		end

	attach_bottom (w,b : WIDGET_IMP; pos: INTEGER; relative: BOOLEAN)
			-- Attach the bottom of `w' to `l' separated by `pos' 
			-- which is `relative'
		local
			a : ATTACHMENT_WINDOWS
		do
			a := find_widget (w)
			if a = Void then 
				create a.make (w)
				extend (a)
			end
			a.attach_bottom (b, pos, relative);
		end

	clear_all
			-- Set all processing flags to false
		local
			c: CURSOR
		do
			c := cursor
			from
				start
			variant
				count + 1 - index
			until
				after
			loop
				item.reset
				forth
			end
			go_to (c)
		end

	height (form: FORM_IMP): INTEGER
			-- Height of all the widgets in this
			-- list, includes sizing based on positioning
		local
			child_list: ARRAYED_LIST [WIDGET_IMP] 
			c: CURSOR
		do
			if count > 0 then
				from
					c := cursor
					clear_all
					start
					Result := item.height (form)
					forth
				variant
					count + 1 - index
				until
					after
				loop
					Result := Result.max (item.height (form))
					forth
				end
				go_to (c)
			else
				child_list := form.children_list
				from
					child_list.start
				until
					child_list.after
				loop
					Result := (Result).max (child_list.item.y + child_list.item.height)
					child_list.forth
				end
			end
		end

	width (form: FORM_IMP): INTEGER
			-- Width of all the widgets in this
			-- list, includes sizing based on positioning
		local
			child_list: ARRAYED_LIST [WIDGET_IMP] 
			c: CURSOR
		do
			if count > 0 then
				from
					c := cursor
					clear_all
					start
					Result := item.width (form)
					forth
				variant
					count + 1 - index
				until
					after
				loop
					Result := Result.max (item.width (form))
					forth
				end
				go_to (c)
			else
				child_list := form.children_list
				from
					child_list.start
				until
					child_list.after
				loop
					Result := (Result).max (child_list.item.x + child_list.item.width)
					child_list.forth
				end
			end
		end

	process (form: FORM_IMP)
			-- Position each widget in the list
			-- If more than 100 passes are required 
			-- we presume there is a circularity
		local
			i: INTEGER
			processing: BOOLEAN
			c : CURSOR
		do
			from
				c := cursor
				processing := true
			variant
				100 + 1 - i
			until
				i > 100 or not processing
			loop
				from
					start
					processing := false
				variant
					count + 1 - index
				until
					after
				loop
					if not item.processed then
						processing := true
						item.process (form)
					end
					forth
				end
				i := i + 1
			end
			if processing then
				io.error.putstring ("Unable to process all form attachments%N")
			end
			go_to (c)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ATTACHMENT_LIST_WINDOWS

