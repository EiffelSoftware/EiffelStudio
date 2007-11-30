///////////////////////////////////////////////////////////////////
//
// Basic Ajax like functionality.
// Allows to load and display the content of a page in a container.
//


// Send a HTTP request to load content of `url' in control with ID `container_id'
function load_content (url, container_id, link_id, message_id)
{
	var el = document.getElementById(link_id)
	el.parentNode.removeChild(el)
	var page_request = false
	if (window.XMLHttpRequest) // if Mozilla, Safari etc
		page_request = new XMLHttpRequest()
	else if (window.ActiveXObject) // if IE
	{
		try
		{
			page_request = new ActiveXObject ("Msxml2.XMLHTTP")
		}
		catch (e)
		{
			try
			{
				page_request = new ActiveXObject ("Microsoft.XMLHTTP")
			}
			catch (e)
			{
				document.getElementById(message_id).innerHTML='Your browser does not support loading the page dynamically.'
				return false
			}
		}
	}
	else
		return false
	document.getElementById(message_id).innerHTML='Loading sample...';
	page_request.onreadystatechange = function(){load_page(page_request, container_id, message_id)}
	page_request.open ('GET', url, true)
	page_request.send (null)
}

// Load response of `page_request' into control with ID `container_id'
function load_page (page_request, container_id, message_id)
{
	if (page_request.readyState == 4 && (page_request.status==200 || window.location.href.indexOf("http") == -1))
	{
		document.getElementById(container_id).innerHTML=page_request.responseText
		var el = document.getElementById(message_id)
		el.parentNode.removeChild(el)
	}
}

//<!--
//--+--------------------------------------------------------------------
//--| Eiffel for ASP.NET 5.6
//--| copyright (c) 2005 eiffel software
//--|
//--| Eiffel Software
//--| 356 storke road, goleta, ca 93117 usa
//--| http://www.eiffel.com
//--+--------------------------------------------------------------------
//-->
