indexing
	description: "Command to generate documentation.";
	date: "$Date$";
	revision: "$Revision $"

class DOCUMENT_GENERATION

inherit
	TOOL_COMMAND

	WARNER_CALLBACKS

creation
	make_flat, 
	make_flat_short, 
	make_text,
	make_short

feature {NONE} -- Initialization

	make_flat is
			-- Initialize document generation to flat.
		do
			format_type := flat_type;
			tool := Project_tool
		end;
 
	make_flat_short is
			-- Initialize document generation to flat_short.
		do
			format_type := flat_short_type;
			tool := Project_tool
		end;
 
	make_text is
			-- Initialize document generation to text.
		do
			format_type := text_type;
			tool := Project_tool
		end;
 
	make_short is
			-- Initialize document generation to text.
		do
			format_type := short_type;
			tool := Project_tool
		end;

feature -- Warner processing

	execute_warner_help is
			-- Action executed when help is pressed (do not generate parents).
		do
			generate_documentation (False)
		end;
 
	execute_warner_ok (arg: ANY) is
			-- Action executed when ok is pressed (confirmation of generate parents).
		do
			generate_documentation (True)
		end;

feature -- Generation

	generate_documentation (do_parents: BOOLEAN) is
			-- Generate the documentations.
		local
			cmd: E_GENERATE_DOCUMENTATION
		do
			inspect
				format_type
			when flat_type then
				!! cmd.make_flat (filter_name, Project_tool.progress_dialog)
			when flat_short_type then
				!! cmd.make_flat_short (filter_name, Project_tool.progress_dialog)
			when text_type then
				!! cmd.make_text (filter_name, Project_tool.progress_dialog)
			when short_type then
				!! cmd.make_short (filter_name, Project_tool.progress_dialog)
			end
			if do_parents then
				cmd.set_do_parents
			end;
			cmd.set_error_window (Project_tool.text_window);
			cmd.execute;
		end;
 
feature -- Status report
 
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
			if Project_tool.initialized then
				if argument = tool then
					filter_window.call (Current)
				elseif argument = Current then
						-- Comes from filter window
					filter_name := filter_window.selected_filter
					if filter_name /= Void then
						warner (Project_tool).custom_call 
							(Current, Warning_messages.w_Include_parents, 
								Interface_names.b_Yes, 	
								Interface_names.b_No,
								Void)
					end
				end
			end
		end;

feature {NONE} -- Implementation

	filter_window: FILTER_W is
			-- Filter window
		once
			!! Result.make (Current)
		end;

	filter_name: STRING
			-- Filter name
 
	format_type: INTEGER;
			-- Format type
 
	flat_short_type, short_type, flat_type, text_type: INTEGER is unique
			-- Output type
 
end -- class DOCUMENT_GENERATION
