<%@ Page Language="eiffel" debug=true aspcompat=true %>
<html>
<title> ASP.NET Code Generation Sample </title>
<body>


<h2>ASP.NET Code Generation Sample</h2>

This page tests all the different types of code generation required by ASP.NET.

<script runat=server>
inherit
	WEB_PAGE
		rename
			on_load as my_on_load
		redefine
			my_on_load
		end
</script>


<script runat=server>

	-- Uncomment to force a compile error and see generated code

	-- This is server script block, which is injected verbatim into the page class as a
	-- CodeSnippetMember
feature -- Basic Operations

	my_on_load (e: EVENT_ARGS) is
			-- redefinition of on_load feature.
		local
			jap_cal: JAPANESE_CALENDAR
			data_source: ICOLLECTION
		do
			Precursor {WEB_PAGE}(e)

			lbl_output.set_text (("OnLoad called.").to_cil)

			-- This reference relies on an import statement, which is an optional feature, not
			-- required by the generated ASP.NET Code
			create jap_cal.make

			-- Do databind
			if is_post_back then
				data_source := create_data_source
				repeater_1.set_data_source (data_source)
				repeater_1.data_bind
			end
		end

	page_prerender is
			-- This is an autohookup method.
		do
			lbl_output.set_Text (feature {SYSTEM_STRING}.concat_string_string (lbl_output.text, ("<br>PreRender called").to_cil))
		end

	create_data_source: ICOLLECTION is
			-- create the data source.
		local
			i: INTEGER
			table: DATA_DATA_TABLE
			row: DATA_DATA_ROW
			dv: DATA_DATA_VIEW
			dummy: SYSTEM_OBJECT
		do
			create table.make

			dummy := table.columns.add_string (("DataColumn1").to_cil)
			dummy := table.columns.add_string (("DataColumn2").to_cil)

			from
				i := 1
			Until
				i = 7
			loop
				row := table.new_row
				
				row.set_item_integer_object (1, i - 1)
				row.set_item_integer_object (2, ("Item ").to_cil)
	
				table.rows.add_data_row (row)
				
				i := i + 1
			end

			create dv.make_from_table (table)
			Result := dv
		end

	selected_date_changed (source: SYSTEM_OBJECT; e: EVENT_ARGS) is
			-- Method called when date selected change.
		local
			i: INTEGER
		do
			response.write_string (("Selection Changed").to_cil)
			from
				i := 0
			Until
				i = cal.selected_dates.count
			loop
				lbl_2.set_text ((("").to_cil).concat_string_string_string (lbl_2.text, cal.selected_dates.item (i).to_short_date_string, ("<br>").to_cil))
				--lbl_2.set_text (("<br>").to_cil)
				i := i + 1
			end
			
		end

</script>

<form runat="server">
	<hr>
	Control changed in server script block: <br>
	<asp:Label runat=server id=lbl_output />

	<hr>
	<asp:Label runat=server text="date" id=lbl_2 />

	<hr>
	Control with properties and sub-properties: <br>
	<asp:Calendar id=cal runat=server SelectionMode=DayWeekMonth OnSelectionChanged=selected_date_changed>
		<WeekendDayStyle ForeColor=Green BackColor="#E8E8E8" />

	</asp:Calendar>

	<hr>
	The following loop uses &lt;%% %%&gt and &lt;%%= %%&gt blocks: <br>

	<!-- Snippet statement : -->
	<%local i: INTEGER %>
	<%from i := 0 until i = 5	loop %>
		Writing Number: <%= i %> <br>
	<%i := i + 1 end %>

	<hr>
	This is a data bound templated control: <br>

	<asp:Repeater id="repeater1" runat="server">
		<HeaderTemplate>
			<table cellspacing=0 cellpadding=1 style="font-family:verdana;font-size:8pt;border-collapse:collapse">
		</HeaderTemplate>
		<ItemTemplate>
			<tr>
			  <td>
				<asp:Label runat="server" id="label1" text='<%#feature {WEB_DATA_BINDER}.eval_object_string_string (Container, ("DataItem.DataColumn1").to_cil, ("{0}").to_cil)%>'></asp:Label>
				:&nbsp;
				<asp:TextBox runat="server" id="textBox1" text='<%#feature {WEB_DATA_BINDER}.eval (Container, ("DataItem.DataColumn2").to_cil) %>'></asp:TextBox>
			  </td>
			</tr>
		</ItemTemplate>
		<FooterTemplate>
			</table>
		</FooterTemplate>
	</asp:Repeater>

</form>
</body>
</html>

