indexing

	description: 
		"Command to generate documentation.";
	date: "$Date$";
	revision: "$Revision $"

class DOCUMENT_GENERATION

inherit

	TOOL_COMMAND;
	WARNER_CALLBACKS

creation
	make_paste, 
	make_copy, 
	make_cut

feature {NONE} -- Initialization

	make_flat is
			-- Initialize document generation to flat.
		do
			format_type := flat_type;
		end;
 
	make_flat_short is
			-- Initialize document generation to flat_short.
		do
			format_type := flat_short_type;
		end;
 
	make_text is
			-- Initialize document generation to text.
		do
			format_type := text_type;
		end;
 
	make_short is
			-- Initialize document generation to text.
		do
			format_type := short_type;
		end;

feature -- Warner processing

	execute_warner_help is
		do
			do_parents := False
		end;
 
	execute_warner_ok is
		do
			do_parents := True
		end;
 
feature -- Status report
 
	do_parents: BOOLEAN
			-- Print the parents as well?
 
	name: STRING is
			-- Name of editor operations
		do
			inspect
				format_type
			when flat_type then
				Result := Interface_names.f_flat_doc
			when flat_short_type then
				Result := Interface_names.f_flat_short_doc
			when text_type then
				Result := Interface_names.f_text_doc
			when short_type then
				Result := Interface_names.f_short_doc
			end
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			inspect
				format_type
			when flat_type then
				Result := Interface_names.m_flat_doc
			when flat_short_type then
				Result := Interface_names.m_flat_short_doc
			when text_type then
				Result := Interface_names.m_text_doc
			when short_type then
				Result := Interface_names.m_short_doc
			end
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

feature -- Execution

	work (argument: ANY) is
			-- Perform edit operations.
		do
			if argument = tool then
				if filter_window = Void then
					!! filter_window.make (Current)
				end;
				filter_window.call
			elseif argument = Current then
					-- Comes from filter window
				if filter_window.position /= 0 then
					filter_name := filter_window.selected_filter
					warner (associated_command.popup_parent).call 
						(Warning_messages.w_Include_parents, " Yes ", " No ", Void)
				end
			end
		end;

feature {NONE} -- Implementation

	filter_window: FILTER_W;
			-- Filter window

	filter_name: STRING
			-- Filter name
 
	format_type: INTEGER;
			-- Format type
 
	flat_short_type, short_type, flat_type, text_type: INTEGER is unique
			-- Output type
 
end -- class DOCUMENT_GENERATION
