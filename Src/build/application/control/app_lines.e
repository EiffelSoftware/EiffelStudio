indexing
	description: "List of state lines (transitions)."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class APP_LINES 

inherit
	EB_DRAWING_BOX [STATE_LINE]
		rename
			element as line,
			selected_element as selected_line
		redefine
			remove, has, append, select_figure
		end
	
creation
	make

feature -- Access

	append (l: like selected_line) is
			-- Append `l' to `Current'. If `l' already exists (i.e. 
			-- its source and destination are defined by another line) 
			-- set found to true. If found, do not add to the list. Set 
			-- bi_direction of lines if there are lines going in both directions. 
		do
			from
				found := False
				start
			until
				after or found
			loop
				if l.source = line.destination 
				and l.destination = line.source
				then
					l.set_bi_directional (True)
					line.set_bi_directional (True)
					line.calculate
				end
				if l.source = line.source 
				and l.destination = line.destination
				then
					found := True
				else
					forth
				end
			end
			if not found then
				Precursor (l)
			end
		end


	deselect_selected_line is
		do
			selected_line.deselect
			selected_line := Void
			found := False
		end

	has (l: like line): BOOLEAN is
			-- Does a line with figures sources and dest as
			-- its connection points ?
		do
			from
				start
			until
				after or else (Result = True)
			loop
				if l.source = line.source
				and l.destination = line.destination
				then
					Result := True
				else
					forth
				end
			end
		end 

	remove is
			-- Remove the current line in Current. If line is bi_directional
			-- find the other line and reset flag.
		local
			a_line: STATE_LINE
			line_found: BOOLEAN
			pos: INTEGER
		do
			if line.bi_directional then
				line.set_bi_directional (False)
				a_line := line
				pos := index --mark
				from
					start
				until	
					after or line_found
				loop
					if a_line.source = line.destination
					and a_line.destination = line.source
					then
						line.set_bi_directional (False)
						line.calculate
						line_found := True
					else
						forth
					end
				end
				go_i_th (pos) -- return
			end
			Precursor
		end 

	select_figure (lx, ly: INTEGER) is
			-- Callback routine when a figure is selected.
			-- (By default do nothing). 
		do
		end

	update (figure: APP_FIGURE) is
			-- Update the points (i.e. recalculate) for the
			-- lines that has `figure' as the source or
			-- destination.
		do
			from
				start
			until
				after
			loop
				if line.source = figure
				or line.destination = figure
				then
					line.calculate
				end
				forth
			end
		end

end -- class APP_LINES

