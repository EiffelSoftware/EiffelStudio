indexing
	description: "Set of colors that allows the user to pick %
				% a color and associate it with a context."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class COLOR_SET 

inherit

	CONSTANTS

	FORM
		rename
			make as form_create
		end

creation

	make

feature 

	make (a_name: STRING a_parent: COMPOSITE ed: CONTEXT_EDITOR) is
		do
			form_create (a_name, a_parent)
			load_colors (ed)
		end

feature {NONE}

	number_by_line: INTEGER is 8

	load_colors (ed: CONTEXT_EDITOR) is
		local
			eb_color: COLOR_STONE
			position, i, j: INTEGER
			file: PLAIN_TEXT_FILE
			temp: FILE_NAME
			top_widget, left_widget: COLOR_STONE
			row_array: ARRAY [ARRAY [COLOR_STONE]]
			column_array: ARRAY [COLOR_STONE]
		do
			!! row_array.make (1, 1)
			!! column_array.make (1, number_by_line)
			row_array.put (column_array, 1)
			temp := Environment.color_names_file
			!! file.make (temp)
			i := 1
			j := 1
			if file.exists and then 
				file.is_readable and then
				not file.empty 
			then
				! DEFAULT_VALUE ! eb_color.make (Current, ed)
				column_array.put (eb_color, j)
				j := j + 1
				from
					file.open_read
					file.readline
				until
					file.end_of_file
				loop
					!! eb_color.make (file.laststring, Current, ed)
					column_array.put (eb_color, j)
-- 					last_line.extend (eb_color)
-- 					if (top_widget = Void) then
-- 						attach_top (eb_color, 2)
-- 					else
-- 						attach_top_widget (top_widget, eb_color, 0)
-- 					end
-- 					if (left_widget = Void) then
-- 						attach_left (eb_color, 2)
-- 					else
-- 						attach_left_widget (left_widget, eb_color, 0)
-- 					end
					if j = number_by_line then
						j := 1
						i := i + 1
						!! column_array.make (1, number_by_line)
						row_array.force (column_array, i)
					else
						j := j + 1
					end
					file.readline
				end
				file.close

					--| Perform attachments
				from
					i := 1
				until
					i > row_array.count
				loop
					column_array := row_array.item (i)
					from
						j := 1
					until
						j > column_array.count or column_array.item (j) = Void
					loop
						eb_color := column_array.item (j)
						if i = 1 then
							attach_top (eb_color, 0)
						else
							attach_top_widget (row_array.item (i - 1).item (j), eb_color, 0)
						end
						if i = row_array.count then
							attach_bottom (eb_color, 0)
						end
						if j = 1 then
							attach_left (eb_color, 0)
						else
							attach_left_widget (row_array.item (i).item (j - 1), eb_color, 0)
						end
						if j = column_array.count then
							attach_right (eb_color, 0)
						end
						j := j + 1
					end
					i := i + 1
				end
			
					--| Set size
				set_size (number_by_line * row_array.item (1).item (1).width, 
							row_array.count * row_array.item (1).item (1).height)
			else
				io.error.putstring ("Warning: cannot read ")
				io.error.putstring (temp)
				io.error.new_line
			end
		end

end -- class COLOR_STONE

