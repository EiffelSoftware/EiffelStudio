indexing
	description: "IDispatch interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ANALYZER_DISPATCH

inherit
	EOLE_DISPINTERFACE
		rename
			make as disp_make
		redefine
			on_invoke
		end

	ANALYZER_DISPID
		export
			{NONE} all
		end
		
creation
	make
				
feature -- Initialization

	make (serv: EOLE_LOCAL_AUTOMATION_SERVER) is
			-- Initialize OLE interface and associated 
			-- server.
		do
			disp_make
			server ?= serv
		end
	
feature -- Access

	server: ANALYZER_SERVER
			-- Associated server.
			
	text: STRING
			-- Text analyzed

	word_count: INTEGER
			-- Word count in `text'

	line_count: INTEGER
			-- Line count in `text'

	sentence_count: INTEGER
			-- Sentence count in `text'
				
feature {EOLE_CALL_DISPATCHER} -- Callback

	on_invoke (dispid, flags: INTEGER; params: EOLE_DISPPARAMS; res: EOLE_VARIANT; exception: EOLE_EXCEPINFO) is
			-- Invoke method or property with `dispid' and arguments 
			-- `params' according to `flags'. Result is stored in 
			-- `res' and exception (if any) in `exception'.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		local
			txt: STRING
			occ: INTEGER
			bstr: EOLE_BSTR
		do
			if flags = Dispatch_method then
				inspect
					dispid
				when Dispid_word_count then
					server.main_window.add_line ("Word count:", word_count)
					res.set_integer2 (word_count)
				when Dispid_line_count then
					server.main_window.add_line ("Line count:", line_count)
					res.set_integer2 (line_count)
				when Dispid_sentence_count then
					server.main_window.add_line ("Sentence count:", sentence_count)
					res.set_integer2 (sentence_count)
				when Dispid_occurrences then
					occ := occurrences (params.argument (0).bstr.to_string)
					!! txt.make (200)
					txt.append ("Number of occurrences(s) of ")
					txt.append (params.argument (0).bstr.to_string)
					txt.append (":")
					server.main_window.add_line (txt, occ)
					res.set_integer2 (occ)
				when Dispid_show then
					server.main_window.show
				when Dispid_hide then
					server.main_window.hide
				when Dispid_terminate then
					server.main_window.destroy
				else
					exception.set_ole_error_code (Disp_e_membernotfound)
				end
			elseif flags = Dispatch_propertyget then
				if dispid = Dispid_text then
					!! bstr.adapt (text)
					res.set_bstr (bstr)
				else
					exception.set_ole_error_code (Disp_e_membernotfound)
				end
			elseif flags = Dispatch_propertyput then
				if dispid = Dispid_text then
					text := params.argument (0).bstr.to_string
					update_statistics
				else
					exception.set_ole_error_code (Disp_e_membernotfound)
				end
			end
		end
	
feature {NONE} -- Implementation
				
	occurrences (txt: STRING): INTEGER is
			-- Number of ocuurences of `txt' in `text'.
		local
			pos: INTEGER
		do
			if text.count > 0 then
				from
					pos := text.substring_index (txt, 1)
				until
					pos = 0
				loop
					Result := Result + 1
					if pos + txt.count <= text.count then
						pos := text.substring_index (txt, pos + txt.count)
					else
						pos := 0
					end
				end
			end
		end
			
	update_statistics is
			-- Update `word_count', `line_count' and `sentence_count'
		local
			index: INTEGER
			was_point, was_space, was_return: BOOLEAN
			read: CHARACTER
		do
			from
				index := 1
				word_count := 0
				line_count := 1
				sentence_count := 0
				was_return := True
			until
				index = text.count + 1
			loop
				read := text.item (index)
				if read = '.' and not was_point then
					sentence_count := sentence_count + 1
					was_point := True
					was_space := False
					was_return := False
				elseif read = ' ' then
					was_space := True
					was_point := False
					was_return := False
				elseif read = '%N' then
					line_count := line_count + 1
					was_return := True
				elseif read.code /= 13 and (was_space or was_point or was_return) then
					word_count := word_count + 1
					was_space := False
					was_point := False
					was_return := False
				end
				index := index + 1
			end
		end
				
end -- class ANALYZER_DISPATCH

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
